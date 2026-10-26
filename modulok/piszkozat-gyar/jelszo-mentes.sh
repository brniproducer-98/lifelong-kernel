#!/bin/bash
# Piszkozat-gyár · jelszómentés (K31 próba, 2026-10-22)
# Egy macOS-ablak rejtett mezővel kéri be a Gmail-alkalmazásjelszót, és a Kulcskarikába menti.
# A jelszó nem kerül se a képernyőre, se a kimenetre, se a chatbe. Kimenet: OK vagy HIBA.
# Használat: jelszo-mentes.sh <gmail-cim>
set -u
EMAIL="${1:?gmail-cim kell}"
SVC="lifelong-piszkozatgyar"
PW=$(/usr/bin/osascript <<OSA 2>/dev/null
set r to display dialog "Piszkozat-gyár: írd be a(z) $EMAIL fiók Gmail-alkalmazásjelszavát. Csak a Kulcskarikába kerül, a chatbe nem." default answer "" with hidden answer with title "Lifelong piszkozat-gyár" buttons {"Mégse", "Mentés"} default button "Mentés" giving up after 300
if gave up of r then return ""
return text returned of r
OSA
)
PW="${PW// /}"
if [ -z "$PW" ]; then echo "HIBA: nem jött jelszó (Mégse vagy időtúllépés)"; exit 1; fi
if /usr/bin/security add-generic-password -U -a "$EMAIL" -s "$SVC" -w "$PW" -T /usr/bin/security >/dev/null 2>&1; then
  unset PW; echo "OK: a jelszó a Kulcskarikában ($SVC, $EMAIL)"
else
  unset PW; echo "HIBA: a Kulcskarikába mentés nem sikerült"; exit 1
fi
