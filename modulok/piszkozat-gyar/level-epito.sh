#!/bin/bash
# Piszkozat-gyár · levélépítő (K31 próba, 2026-10-22)
# Kész MIME-levelet épít: HTML törzs tiszta linkekkel, opcionálisan beágyazott logó (CID), opcionálisan csatolt PDF.
# Csak gyári eszközök: base64, uuidgen, date. A base64-et a szkript készíti, nem a modell.
# FIGYELEM (mérve 2026-10-22): a beágyazott (CID) logó a telefonos Gmail-appból küldve elvész. A logó webes kép legyen a törzsben
# (<img src="https://…aláírás-kép…">), a logó-paraméter értéke "-". A CID-ág csak összehasonlító próbára maradt.
# Használat: level-epito.sh <felado> <cimzett> <targy> <torzs.html> <kimenet.eml> [logo.png|-] [csatolmany.pdf|-] [message-id|-] [masolat|-]
set -eu
FROM="$1"; TO="$2"; SUBJ="$3"; HTMLF="$4"; OUT="$5"; LOGO="${6:--}"; PDF="${7:--}"; MID="${8:--}"; CC="${9:--}"
[ "$MID" = "-" ] && MID="<$(uuidgen | tr 'A-Z' 'a-z')@piszkozatgyar.lifelong>"
B1="rel_$(uuidgen | tr -d '-')"; B2="mix_$(uuidgen | tr -d '-')"
enc_subj() { printf '=?UTF-8?B?%s?=' "$(printf '%s' "$1" | base64 | tr -d '\n')"; }
DATE=$(LC_ALL=C date '+%a, %d %b %Y %H:%M:%S %z')
{
  printf 'From: %s\r\nTo: %s\r\n' "$FROM" "$TO"
  [ "$CC" != "-" ] && printf 'Cc: %s\r\n' "$CC"
  printf 'Subject: %s\r\nDate: %s\r\nMessage-ID: %s\r\nMIME-Version: 1.0\r\n' "$(enc_subj "$SUBJ")" "$DATE" "$MID"
  if [ "$PDF" != "-" ]; then printf 'Content-Type: multipart/mixed; boundary="%s"\r\n\r\n--%s\r\n' "$B2" "$B2"; fi
  printf 'Content-Type: multipart/related; boundary="%s"\r\n\r\n' "$B1"
  printf -- '--%s\r\nContent-Type: text/html; charset="UTF-8"\r\nContent-Transfer-Encoding: base64\r\n\r\n' "$B1"
  base64 -b 76 -i "$HTMLF" | sed 's/$/\r/'
  if [ "$LOGO" != "-" ]; then
    printf -- '\r\n--%s\r\nContent-Type: image/png; name="logo.png"\r\nContent-Transfer-Encoding: base64\r\nContent-ID: <logo@piszkozatgyar>\r\nContent-Disposition: inline; filename="logo.png"\r\n\r\n' "$B1"
    base64 -b 76 -i "$LOGO" | sed 's/$/\r/'
  fi
  printf -- '\r\n--%s--\r\n' "$B1"
  if [ "$PDF" != "-" ]; then
    FN=$(basename "$PDF")
    printf -- '\r\n--%s\r\nContent-Type: application/pdf; name="%s"\r\nContent-Transfer-Encoding: base64\r\nContent-Disposition: attachment; filename="%s"\r\n\r\n' "$B2" "$FN" "$FN"
    base64 -b 76 -i "$PDF" | sed 's/$/\r/'
    printf -- '\r\n--%s--\r\n' "$B2"
  fi
} > "$OUT"
echo "OK: $OUT ($(wc -c < "$OUT" | tr -d ' ') bájt) $MID"
