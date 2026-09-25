---
description: A rendszer közös részének frissítése a Lifelong kiadási címéről. Megmutatja, mi változna, és csak igen után ír
---

# Frissítés

Ez a parancs a rendszer **közös részét** frissíti: az első beszélgetés parancsát, ezt a parancsot, a tudás-sablonokat és a házirend egyetlen, erre kijelölt szakaszát. {{keresztnév}} saját házirendjének többi részéhez, a `knowledge/` és a `records/` fájlokhoz, és a saját anyagaihoz **soha nem nyúl.** Amit a kiadási jegyzék ezen kívül kérne, azt nem hajtod végre, hanem kimondod.

## 1. Előre szólsz

Egy mondatban: most letöltesz egy jegyzéket a Lifelong kiadási címéről; a gép angolul rákérdezhet, hogy megnyithatod-e a weboldalt, a `Yes` ezt az egyet engedi; ha `No`, nem történik semmi, a rendszer marad a mai állapotában.

## 2. A jegyzék

Töltsd le: `{{MANIFEST_URL}}`. Ez egy `kernel-manifest.json`: verzió, dátum, a változások listája, és a fájlok neve, címe és ellenőrző összege (SHA-256).

Ha a letöltés nem sikerül: mondd ki, és állj meg. Semmit nem írsz.

## 3. Összevetés

Olvasd el a `records/verzio.md`-t. Ha a jegyzék verziója ugyanaz: mondd meg, hogy a rendszer naprakész, és vége. Ha újabb: sorold fel a jegyzék `valtozasok` mezőjét közérthetően, egy mondat változásonként, és kérdezd meg: *„Frissíthetem a közös részt erre a verzióra? A te szabályaidhoz és a rólad írt tudáshoz nem nyúlok."* Igen nélkül vége.

## 4. A frissítés, igen után

1. Csak azokat a fájlokat töltöd le és írod, amelyek a jegyzék `fajlok` listájában `"kozos": true` jelöléssel szerepelnek, pontosan a megadott útvonalra. Ha egy útvonal a `knowledge/`, a `records/`, a saját anyagai vagy a házirend (`CLAUDE.md`) felé mutatna, azt a fájlt **kihagyod és kimondod**; ez a védelem, nem hiba.
2. Minden letöltött fájlnál, ha tudsz ellenőrző összeget számolni (Windows: `Get-FileHash`, Mac: `shasum -a 256`), vesd össze a jegyzékkel; eltérésnél a fájlt nem írod, és kimondod. Ha nem tudsz számolni, mondd ki, hogy az összeget nem ellenőrizted.
3. **A házirend szakasza külön igennel.** Ha a jegyzék `hazirend_szakasz` mezője újabb szöveget ad az `## Az első beszélgetés és a hiányzó tudás` címsor alatti szakaszra, mutasd meg a chatben a régit és az újat, és kérdezd meg külön: *„Kicserélhetem a házirendben ezt az egy szakaszt? A többi sorhoz nem nyúlok."* Csak igen után, és csak a címsortól a következő címsorig (vagy a fájl végéig) cserélsz. A `{{keresztnév}}` helyére az ő keresztneve kerül, ahogy a régi szakaszban is állt.
4. Ha a gép fájlírásnál angolul rákérdez: a te kérésed, a `Yes` azt az egyet engedi; több is jöhet egymás után.

## 5. Zárás

- `records/verzio.md`: az új verzió és a mai dátum.
- `records/naplo.md`: egy sor: mikor, melyik verzióról melyikre, mit hagytál ki és miért.
- A chatben: mi változott, egy mondatban; mi maradt ki; és ha a jegyzék azt kéri, hogy az első beszélgetést érdemes újra átnézni (például új kérdéskör jött), mondd meg, hogy a `/beallitas` a hiányzó részt kérdezi meg, a többit nem.
