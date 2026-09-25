# Változások, az ügyfél nyelvén

A kiadási lista `valtozasok` mezője ebből a fájlból jön, a verzió címsora alatti pontokból. **Csak olyan mondat kerül ide, ami az ügyfélnél változtat valamit, közérthetően, egy mondat egy változás.** Amit az ügyfél nem vesz észre (kiadási eszköz, README, belső jegyzet), az nem kerül ide. A `/frissites` ezt olvassa fel neki szó szerint.

## 1.1.1

- Az első beszélgetés és a frissítés parancsa mostantól egy külön profilfájlból olvassa a rád szabott adatokat (a neved, az oldalad, a kínálatod), ezért a közös rész frissítése ezekhez soha nem nyúl.
- A frissítés előbb letölti és ellenőrzi az összes fájlt, a régi változatokról mentést készít, és csak utána ír; ha bármi nem stimmel, semmit nem változtat.
- Bekerült egy új tudás-sablon a kínálatnak és az áraknak; a rendszer csak akkor hozza létre, ha nálad még nincs ilyen.
- A házirend egy szakasza megújult: ha a beállítás félbemaradt, a rendszer nem mutatkozik be újra, hanem folytatást ajánl; ha a beállítás előtt szöveget kérsz, megmondja, hogy az még nem a te hangodon készült; és minden beszélgetésben előre szól az angol ablakokról.

## 1.1.0

- Az ismerkedő beszélgetés végén a rendszer készít egy rövid jelentést a Lifelongnak arról, hogy a beállítás lefutott; személyes adat nélkül, és te küldöd el.
- A frissítés parancsa a Lifelong kiadási címéről tölt le, felsorolja a változásokat, és csak a te igened után ír bármit.
