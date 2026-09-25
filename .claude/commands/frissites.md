---
description: A rendszer közös részének frissítése a Lifelong kiadási címéről. Megmutatja, mi változna, és csak igen után ír
---

# Frissítés

Ez a parancs a rendszer **gyári részét** frissíti: az első beszélgetés parancsát, ezt a parancsot, a tudás-sablonokat (csak újat hoz létre) és a házirend egyetlen, erre kijelölt szakaszát. A tulajdonos házirendjének többi részéhez, a `rendszer/profil.md`-hez, a `knowledge/` meglévő fájljaihoz és a saját anyagaihoz **soha nem nyúl.** A `records/` mappában csak a saját nyilvántartásait vezeti (verzió, napló, mentés, ideiglenes letöltés); a kiadás fájlja oda nem kerül. Amit a kiadási lista ezen kívül kérne, azt nem hajtod végre, hanem kimondod.

**Előbb olvasd el a `rendszer/profil.md`-t:** ott áll a tulajdonos keresztneve, a Lifelong címe és a kiadási lista címe („A frissítés kiadási listája"). Ha a profil vagy a cím hiányzik, mondd ki, és állj meg.

**A szavak, amiket felé használsz.** Az első mondatod mindig ez az értelem: *„a rendszer gyári részét frissítem, a rólad szóló részt nem."* „Kiadási lista", nem jegyzék; „ellenőriztem, hogy a fájlok sértetlenek", nem hash; „gyári rész", nem kernel. Fájlnevet és útvonalat csak akkor mondasz, ha ő kérdezi.

## 1. Előre szólsz

Egy mondatban: most letöltöd a Lifelong kiadási listáját, és ha van újabb, a fájlokat; a gép angolul rákérdezhet (weboldal megnyitására, egy letöltő vagy ellenőrző parancs futtatására, fájl írására), több ablak is jöhet egymás után, mindegyik a te kérésed, a `Yes` mindig csak azt az egyet engedi; ha `No`-t nyom az elején, semmi nem változik; ha közben, akkor a mentés-mappából minden visszaállítható (5. pont).

## 2. A kiadási lista

Töltsd le a profilban megadott címről a `kernel-manifest.json`-t, és **csak olvasd**, fájlba nem mented, amíg nincs igen. A cím `https://` legyen; ha nem az, állj meg, és mondd meg, hogy a Lifelongnak kell javítania a profilt. A lista tartalma: verzió, dátum, a változások az ügyfél nyelvén (`valtozasok`), és a fájlok: útvonal, cím, ellenőrző összeg (SHA-256), és egy `mod` mező.

Ha a letöltés nem sikerül: mondd ki, és állj meg. Semmit nem írsz. Ha a lista dátuma régebbi, mint a `records/verzio.md` „Telepítve" dátuma: gyanús kiadás, állj meg, és mondd ki.

## 3. Összevetés

Olvasd el a `records/verzio.md`-t. Ha a lista verziója ugyanaz, vagy a helyi verzió újabb: mondd meg, hogy a gyári rész naprakész, és vége; semmit nem írsz. Ha a lista újabb: olvasd fel a `valtozasok` pontjait szó szerint (azok az ő nyelvén vannak; ha mégis belső szót vagy fájlnevet látsz bennük, mondd egyszerűbben, és jelezd a végén a Lifelongnak), és kérdezd meg: *„Frissíthetem a gyári részt erre a verzióra? A te szabályaidhoz, a rólad írt tudáshoz és a saját anyagaidhoz nem nyúlok."* Igen nélkül vége. Ha a házirend szakasza is változik, mondd meg már itt, hogy arról a végén külön kérdezel.

## 4. A frissítés, igen után

**Először mindent letöltesz és ellenőrzöl, és csak utána írsz bármit.** Ha bármelyik lépés elakad, semmit nem változtatsz, és kimondod.

1. **A `mod` mező dönt** minden fájlnál:
   - `kozos`: felülírod a megadott útvonalon (a parancsok); ha a letöltött fájl bájtra azonos a nálad lévővel, nem írod, és annyit mondasz, hogy az nem változott;
   - `uj_ha_hianyzik`: csak akkor hozod létre, ha nálad még nincs ilyen fájl (a tudás sablonjai); **meglévő `knowledge/` fájlt soha nem írsz felül**, abban az ő élő adata van; a meglévőről annyit mondasz, hogy nem nyúltál hozzá;
   - `hazirend`: nem fájlként írod, hanem a 7. pont szerint a házirend egy szakaszát cseréled vele;
   - `soha`: nem töltöd le, nem írod.
   Ha egy `kozos` vagy `uj_ha_hianyzik` útvonal a `records/`, a `rendszer/`, a saját anyagai vagy a házirend (`CLAUDE.md`) felé mutatna, azt a fájlt **kihagyod és kimondod**; ez a védelem, nem hiba.
2. **Letöltés egy ideiglenes mappába:** `records/frissites-tmp/`. Ha a mappa már létezik (egy korábbi, félbeszakadt futásból), előbb ürítsd ki. Ha tudsz parancsot futtatni, azzal töltsd le (Windows: `Invoke-WebRequest -Uri <cím> -OutFile <fájl>`; Mac: `curl -fsSL -o <fájl> <cím>`), mert így az ellenőrző összeg számolható. Ha csak weboldalt tudsz olvasni, parancsot nem: mondd ki, hogy a sértetlenséget nem tudod ellenőrizni, és kérdezd meg, folytassa-e így; ha igen, a letöltött szöveget írod, a fájl tetején vagy alján semmit nem változtatsz.
3. **Ellenőrzés:** minden letöltött fájl SHA-256 összege egyezzen a listával (Windows: `Get-FileHash`; Mac: `shasum -a 256`). Ha egy fájlnál nem egyezik, **egyik fájlt sem írod be**, a tmp mappát törlöd, és kimondod, melyik fájl volt rossz.
4. **Kitöltetlen mező:** ha egy `kozos` vagy `uj_ha_hianyzik` fájlban dupla kapcsos zárójelbe zárt gyártói mező van (két nyitó és két záró kapcsos zárójel között szöveg), az a fájl sablon, nem kész fájl: **nem írod be**, és kimondod, hogy a kiadás hibás, és ezt a Lifelongnak jelezni kell.
5. **Mentés:** minden fájlról, amit felülírsz, előbb másolatot teszel a `records/frissites-mentes/<mai dátum>-<óra-perc>/` mappába, ugyanazzal az útvonallal. A házirend cserélt szakaszát is ide mented, `CLAUDE-szakasz-regi.md` néven. Ez a visszaút.
6. **Írás:** a `kozos` fájlok a helyükre, az `uj_ha_hianyzik` fájlok csak oda, ahol nincs ilyen. **A letöltött fájlt bájtra másolod, nem írod újra** (PowerShellben `Copy-Item`, ne `Out-File`; különben a kódolás vagy a sorvég változik, és az ellenőrzés elbukik). Írás után minden beírt fájl összegét újra ellenőrzöd a listával; eltérésnél a mentésből visszaállítod, és kimondod.
7. **A házirend szakasza, külön igennel.** A `hazirend` fájlból (a `CLAUDE-BLOKK.md`, a tmp mappából) vedd az `## Az első beszélgetés és a hiányzó tudás` címsortól a fájl végéig tartó szöveget; ennek az összege egyezzen a lista `hazirend_szakasz.sha256` mezőjével. Vesd össze a házirendben ugyanezen címsor alatti szakasszal (a következő címsorig, vagy a fájl végéig). Ha betűre azonos: mondd meg, hogy a házirend szakasza nem változik. Ha eltér: mondd el **három-négy pontban, közérthetően, mi változik a mindennapi munkában**, és ha kéri, mutasd meg a teljes régit és újat; utána kérdezd meg külön: *„Kicserélhetem a házirendben ezt az egy szakaszt? A többi sorhoz nem nyúlok."* Csak igen után, és csak a címsortól a következő címsorig (vagy a fájl végéig) cserélsz; a szöveget betűre veszed át, és a beírt szakasz összegét újra ellenőrzöd. Ha a házirendben nincs ilyen címsor: kérdezd meg, hozzáírhatod-e a végére, és igen után a fájl végére írod.
8. Ha a `frissites.md` maga is frissült, a zárást (az **5. Zárás** szakaszt) még ennek a beszélgetésnek a szabályai szerint végzed; az új parancs a következő futástól él.

## 5. Zárás

- A `records/frissites-tmp/` mappát most törlöd (a 7. pont után, nem előbb).
- `records/verzio.md`: a `Kernel verzió:` sor az új verzió, az `Utolsó frissítés:` sor a mai dátum, a tábla egy új sorral: dátum, régi és új verzió, mi maradt ki (röviden, a tulajdonos szavaival, nem útvonalakkal). Az üres helyőrző-sort az első bejegyzés cseréli.
- `records/naplo.md`: egy sor: mikor, melyik verzióról melyikre, mit hagytál ki és miért, hova került a mentés.
- A chatben: mi változott, egy mondatban; mi maradt ki; és egy mondat arról, hogy ha bármi nem jó, a mai mentésből visszaállítod. **Visszaállítás, ha kéri:** a mentés-mappából minden fájlt visszamásolsz ugyanarra az útvonalra, a `CLAUDE-szakasz-regi.md` tartalmát visszateszed a címsor alá, a verziófájlba a régi verziót írod, a naplóba egy sort; a mentés-mappát nem törlöd.
- Ha bármi kimaradt a védelem vagy hibás kiadás miatt, vagy a változások listája nem volt közérthető: adj egy bemásolható, három mondatos üzenetet a Lifelongnak (a profil „A jelentés címe" pontjára), amit ő küld el, ha akar.
- Ha a lista `valtozasok` pontja azt mondja, hogy az első beszélgetést érdemes újra átnézni (például új kérdéskör jött): mondd meg, hogy a `/beallitas` csak a hiányzó részt kérdezi meg, a többit nem.
- A házirend szerint, ha a beállítás még nem futott le, a válaszod legvégén egy mondatban felajánlod az ismerkedést.
