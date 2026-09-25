# Beállítás böngészőből · a mesterprompt

**Kinek.** Annak, aki nem Claude Code-ot használ, hanem Claude Projektet vagy sima chatet (az M4-út és a Projekt-változat). Ugyanaz a beszélgetés, mint a `beallitas.md`, fájlok nélkül: a végén a rendszer egy bemásolható kontextus-dokumentumot ad, amit a vevő a Projekt utasításai közé tesz.

**Hogyan használja a vevő.** Az alábbi szöveget egyben bemásolja egy új beszélgetésbe a Projektjében. Ha van kész anyaga (átirat, jegyzet, saját szövegek), a beszélgetés elején feltölti. A `{{ }}` helyeket a csomag gyártója tölti ki kiküldés előtt, a vevő már kész szöveget kap.

---

```
Az első beszélgetésünk következik. A célod, hogy megismerd a vállalkozásomat annyira, hogy utána az én nyelvemen, az én szabályaim szerint dolgozz, ne az átlagból. Így haladunk:

1. Előbb nézd meg, amit feltöltöttem, és amit a nyilvános oldalamról ({{weboldal}}) tudsz. Amit ezekből megtudsz, azt ne kérdezd meg, csak erősítsd meg egy mondatban.

2. Utána kérdéskörönként haladunk, egyszerre egy, azon belül legfeljebb három-négy kérdés. Minden kérdéskör után foglald össze egy mondatban, amit megértettél, és kérdezd meg, jól érted-e. Ha egy válaszom általános, kérj konkrét esetet. Ha azt mondom, nem tudom, írd nyitottként, és menj tovább. Számot soha ne tippelj. Ha aggályt mondok, állj meg.

A kérdéskörök, ebben a sorrendben:
  1. Mi él ma a vállalkozásban: mi fut, honnan jönnek a vevők, mit nem akarok csinálni.
  2. Kik voltak a jó ügyfelek: három-öt valódi eset, egy-két rossz, és a külső jel, amiről előre felismerhetők. Ha nem jön ki három megfigyelhető jel, mondd ki, és kérdezz rá még egyszer.
  3. Hogyan jut el hozzám a vevő: lépésenként, az első érintéstől a fizetésig, és hol veszítem el a legtöbbet.
  4. A hangom: kérj el öt-tíz valódi szövegemet, és olvasd ki belőlük a mondathosszt, a megszólítást, a zárást, és azt, amit soha nem írnék le. Ne jelzőkkel írd le, a minták a kánon.
  5. A határok: mit ne csinálj soha helyettem, kinek ne írj, mit csak én mondhatok ki.
  6. Az eszközeim és a ritmusom: hol vezetem a teendőimet, mik a heti visszatérő munkáim (három, ami tényleg ismétlődik).
  {{a gyártó ide teszi a kiegészítő blokkokat, ha kell}}

3. Bármikor mondhatom, hogy elég mára. Akkor add ide a „Folytatási jegyzet"-et: melyik kérdéskör kész, mi maradt nyitva, és mit kell legközelebb elsőnek megkérdezned. Ezt én a következő beszélgetés elejére bemásolom, és te onnan folytatod, semmit nem kérdezel újra.

4. Amikor minden kérdéskör kész, add ide egyben, egy kódblokkban, a kontextus-dokumentumot, ezekkel a részekkel: Vállalkozás · Ügyfelek · Út a vevőig · Hang (a mintákkal szó szerint) · Határok · Eszközök és ritmus · Nyitott kérdések. Az én szavaimmal, nem értelmezve. Ezt beteszem a Projekt utasításai közé.

5. Utána válaszolj két kérdésre, és én megmondom, igaz-e: mi a dolgod és milyen szabályokat kell betartanod; és mi a fő értékajánlatom, az én saját szavaimmal. Ha a második válaszod bármelyik hasonló vállalkozásra ráillene, mondd ki, hogy a kontextus még nem épült fel, és nézzük meg, melyik kérdéskör hiányos.

Kezdjük az 1. ponttal: mondd el, mit tudtál meg abból, amit feltöltöttem, és mit erősítsek meg.
```

---

**A gyártónak.** A blokkok szövege a `beallitas.md`-vel egyezik; ha ott cserélsz blokkot, itt is cseréld. A vevő itt nem kap állapotfájlt, ezért a „Folytatási jegyzet" a folytathatóság egyetlen eszköze: a kísérő útmutatóban mondd ki, hogy ezt a jegyzetet mentse el, és a következő beszélgetést ezzel kezdje. A kontextus-dokumentum a vevőoldali rekord; átadáskor ezt kérjük el.
