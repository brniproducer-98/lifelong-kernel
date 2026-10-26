#!/bin/bash
# Piszkozat-gyár · IMAP APPEND a Piszkozatok mappába (K31, 2026-10-22; 1.1: fejléc-lekérés válaszlevélhez, 2026-10-26)
# Szerkezeti határ: csak IMAPS (--proto =imaps), csak a \Drafts jelzésű mappa, csak APPEND és keresés; a --fejlec mód csak olvas
# (UID SEARCH X-GM-MSGID és FETCH ENVELOPE, ami nem jelöl olvasottnak).
# Küldés (SMTP), törlés, jelölés nincs ebben a szkriptben. A jelszót a Kulcskarikából olvassa, szabványos bemeneten adja
# a curlnek (-K -), soha nem parancssori argumentumként, és nem írja ki. Kimenet: OK, MAR-VAN vagy HIBA.
# Használat: piszkozat-gyar.sh <gmail-cim> <level.eml> [--mappa-lista]
#           piszkozat-gyar.sh <gmail-cim> <gmail-uzenet-azonosito> --fejlec   (a megválaszolandó levél Message-ID-je és előzménye)
set -u
EMAIL="${1:?gmail-cim kell}"; EML="${2:-}"; MODE="${3:-}"
SVC="lifelong-piszkozatgyar"; HOST="imaps://imap.gmail.com:993"
PW=$(/usr/bin/security find-generic-password -a "$EMAIL" -s "$SVC" -w 2>/dev/null) || { echo "HIBA: nincs jelszó a Kulcskarikában ($SVC)"; exit 1; }
cfg() { printf 'user = "%s:%s"\n' "$EMAIL" "$PW"; }
imap() { cfg | /usr/bin/curl -sS --proto =imaps --max-time 60 -K - "$@" 2>&1; }
# 1. A piszkozat-mappa neve a \Drafts jelzés alapján (a magyar fióknál lehet [Gmail]/Piszkozatok)
LIST=$(imap "$HOST/" -X 'LIST "" "*"')
if [ "$MODE" = "--hibakereses" ]; then unset PW; printf '%s\n' "$LIST" | head -30; exit 0; fi
# Fejléc-lekérés válaszlevélhez (mérve 2026-10-26): a Gmail-összekötő üzenet-azonosítója (16 hexa jegy) a Gmail X-GM-MSGID értéke.
# Az ENVELOPE egy sorban adja az előzmény (In-Reply-To) és a levél Message-ID-jét. Ha a válasz több sorra törik (például különleges
# karakter a tárgyban), a szkript HIBA-t ad, és a válasz a régi úton készül.
if [ "$MODE" = "--fejlec" ]; then
  printf '%s' "$EML" | grep -Eq '^[0-9a-f]{12,16}$' || { unset PW; echo "HIBA: az üzenet-azonosító nem 12-16 hexa jegy"; exit 1; }
  ALL=$(printf '%s\n' "$LIST" | grep -i '\\All' | sed -E 's/.*"\/" "?([^"]*)"?\r?$/\1/' | head -1)
  [ -n "$ALL" ] || { unset PW; echo "HIBA: nem találom az összes levél mappáját"; exit 1; }
  ENCA=$(printf '%s' "$ALL" | sed 's/\[/%5B/g; s/\]/%5D/g; s/ /%20/g; s#/#%2F#g')
  U=$(imap "$HOST/$ENCA" -X "UID SEARCH X-GM-MSGID $(printf '%d' "0x$EML")" | tr -d '\r' | sed -n 's/^\* SEARCH *//p')
  printf '%s' "$U" | grep -Eq '^[0-9]+$' || { unset PW; echo "HIBA: a levél nincs meg, vagy nem egyértelmű ($U)"; exit 1; }
  ENV=$(imap "$HOST/$ENCA" -X "UID FETCH $U (ENVELOPE)" | tr -d '\r' | grep 'ENVELOPE' | head -1)
  unset PW
  T=$(printf '%s' "$ENV" | grep -oE '(NIL|"<[^"<> ]+>") "<[^"<> ]+>"\)\)$')
  [ -n "$T" ] || { echo "HIBA: a fejléc nem olvasható egy sorból; a válasz a régi úton készüljön"; exit 1; }
  MIDV=$(printf '%s' "$T" | grep -oE '"<[^"<> ]+>"\)\)$' | tr -d '"()')
  IRTV=$(printf '%s' "$T" | sed -E 's/^(NIL|"<[^"<> ]+>") .*/\1/' | tr -d '"'); [ "$IRTV" = "NIL" ] && IRTV="-"
  echo "OK: valasz-message-id=$MIDV valasz-references=$IRTV"; exit 0
fi
DRAFTS=$(printf '%s\n' "$LIST" | grep -i '\\Drafts' | sed -E 's/.*"\/" "?([^"]*)"?\r?$/\1/' | head -1)
if [ -z "$DRAFTS" ]; then unset PW; echo "HIBA: nem találom a \\Drafts mappát"; exit 1; fi
if [ "$MODE" = "--mappa-lista" ]; then unset PW; echo "OK: piszkozat-mappa: $DRAFTS"; exit 0; fi
[ -f "$EML" ] || { unset PW; echo "HIBA: nincs levélfájl"; exit 1; }
ENC=$(printf '%s' "$DRAFTS" | sed 's/\[/%5B/g; s/\]/%5D/g; s/ /%20/g; s#/#%2F#g')
# 2. Ugyanaz a levél ne kerüljön be kétszer: keresés a Message-ID fejlécre
MID=$(grep -m1 -i '^Message-ID:' "$EML" | sed -E 's/^[^:]*: *//; s/\r$//')
FOUND=$(imap "$HOST/$ENC" -X "UID SEARCH HEADER Message-ID \"$MID\"" | tr -d '\r' | sed -n 's/^\* SEARCH *//p')
if [ -n "$FOUND" ]; then unset PW; echo "MAR-VAN: $MID (UID $FOUND), nem írom be újra"; exit 0; fi
# 3. APPEND (mérve 2026-10-23: egy 500 KB-os levélnél a szerver beírta, de a visszaigazolás 60 mp-en túl jött; ezért hosszabb
#    türelmi idő, és hiba esetén a Message-ID alapján ellenőrzés, hogy a levél mégis bent van-e)
OUTP=$(cfg | /usr/bin/curl -sS --proto =imaps --max-time 180 -K - "$HOST/$ENC" -T "$EML" 2>&1)
RC=$?
if [ $RC -eq 0 ]; then unset PW; echo "OK: beírva a(z) $DRAFTS mappába ($MID)"; exit 0; fi
sleep 5
FOUND=$(imap "$HOST/$ENC" -X "UID SEARCH HEADER Message-ID \"$MID\"" | tr -d '\r' | sed -n 's/^\* SEARCH *//p')
unset PW
if [ -n "$FOUND" ]; then echo "OK: beírva (a válasz késett, de a levél bent van, UID $FOUND; $MID)"; exit 0; fi
echo "HIBA: az APPEND nem sikerült, és a levél nincs bent: $(printf '%s' "$OUTP" | head -c 200)"; exit 1
