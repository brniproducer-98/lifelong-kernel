#!/bin/bash
# Piszkozat-gyár · B8 próba: szerepel-e a Kulcskarikában tárolt jelszó bármelyik chat-naplóban vagy a kísérleti mappában.
# A jelszót nem írja ki; csak a találatos fájlok számát. Kimenet: OK (0 találat) vagy HIBA (n találat).
# Használat: naplo-ellenorzes.sh <gmail-cim>
set -u
EMAIL="${1:?gmail-cim kell}"; SVC="lifelong-piszkozatgyar"
PW=$(/usr/bin/security find-generic-password -a "$EMAIL" -s "$SVC" -w 2>/dev/null) || { echo "HIBA: nincs jelszó"; exit 1; }
N1=$(grep -rlF -- "$PW" "$HOME/.claude/projects" 2>/dev/null | wc -l | tr -d ' ')
N2=$(grep -rlF -- "$PW" "$(cd "$(dirname "$0")/.." && pwd)" 2>/dev/null | wc -l | tr -d ' ')
SPACED=$(printf '%s' "$PW" | sed -E 's/(....)/\1 /g; s/ $//')
N3=$(grep -rlF -- "$SPACED" "$HOME/.claude/projects" 2>/dev/null | wc -l | tr -d ' ')
unset PW SPACED
if [ "$N1" = "0" ] && [ "$N2" = "0" ] && [ "$N3" = "0" ]; then echo "OK: a jelszó egyetlen naplóban és a kísérleti mappában sem szerepel"; else echo "HIBA: találat a naplókban: $N1, szóközös alakban: $N3, a kísérleti mappában: $N2"; exit 1; fi
