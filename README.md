# Lifelong kernel · az első beszélgetés

Ez a Lifelong Company ügyfélrendszereinek közös része. Egy ügyfél a saját gépén, a saját Claude-előfizetésével futtat egy mappát: házirend, parancsok, és a róla összegyűlt tudás. Ami itt van, az minden ilyen mappában ugyanaz; ami az ügyfélé (a házirendje, a tudás róla, az anyagai), az soha nincs itt.

**Mit csinál.** Az első beszélgetésben a rendszer magától ismerkedik: kérdéskörönként, egyszerre eggyel, előbb elolvassa, ami már megvan, és csak a hiányt kérdezi. Amit megért, azt megmutatja, mielőtt leírja. A végén közösen átolvassák, és két ellenőrző kérdés dönti el, hogy tényleg az ügyfelet ismerte-e meg, vagy az átlagot.

**Mi van benne.**

| Fájl | Mi ez |
|---|---|
| `CLAUDE-BLOKK.md` | három bekezdés az ügyfél házirendjének végére: önindítás, a hiányzó tudás kérdezése, írás-szabály |
| `.claude/commands/beallitas.md` | az első beszélgetés |
| `.claude/commands/frissites.md` | a közös rész frissítése innen; megmutat, csak igen után ír |
| `knowledge/*.md` | a tudás sablonjai, `[KITÖLTENDŐ]` mezőkkel |
| `records/beallitas-allapot.md`, `records/verzio.md` | az állapot és a verzió, a rendszer vezeti |
| `BEALLITAS-PROMPT.md` | ugyanez a beszélgetés böngészős chatben, fájlok nélkül |
| `settings-reszlet.json` | az egyetlen engedély, amit a frissítés kér |
| `kernel-manifest.json` | a kiadási jegyzék: verzió, változások, fájlok és ellenőrző összegek |

**Hogyan frissül egy ügyfélnél.** Az ügyfél Claude-ja a `/frissites` paranccsal letölti a jegyzéket, felsorolja a változásokat, és csak igen után ír. A `main` ág csak elfogadott pull requesttel mozdul; a fájlok címkézett kiadásból jönnek. A rendszer sosem ír az ügyfél házirendjébe, a róla szóló tudásba vagy az anyagaiba; a házirend egyetlen, kijelölt szakaszát külön igennel cseréli.

**Felhasználás.** A tartalom megtekinthető. Felhasználása a Lifelong Company ügyfeleinek szól, a velük kötött megállapodás szerint. *(A pontos jogi szöveg jogi átnézés után kerül ide.)*
