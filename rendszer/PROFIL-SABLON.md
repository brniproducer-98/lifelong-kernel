# A rendszer profilja

A csomag gyártója tölti ki kiküldés előtt, és `rendszer/profil.md` néven kerül az ügyfél mappájába. **Ez az egyetlen hely, ahol a közös parancsok az ügyfélre szabott adatot találják.** A frissítés ehhez a fájlhoz soha nem nyúl; a közös parancsok innen olvasnak. Ügyfeleinek személyes adata ide sem kerül.

## Alapadatok

- **Keresztnév:** {{keresztnév, alanyesetben}}
- **A vállalkozás egy mondatban:** {{ahogy a házirend mondja}}
- **Nyilvános felületek:** {{weboldal, árlista, közösségi oldal; ha nincs, „nincs"}}
- **A saját anyagai a mappán belül:** {{mappák és fájlok, ahol a kitöltött kérdőív, az átirat, a saját szövegek vannak; csak a munkamappán belüli útvonalak}}
- **Ismert kínálat a közös beszélgetésből:** {{a meetingből ismert termékek és szolgáltatások, hogy a rendszer megerősítést kérjen, ne listát; ha nincs, „nincs"}}

## Az első beszélgetés beállításai

- **Kérdéskörök sorrendje:** {{alapból 1, 2, 3, 4, 5, 6; itt lehet kihagyni vagy átrendezni, például „1, 4, 5, 6, 2, 3"}}
- **Érzékeny adat, amiről a rendszer szól, és a vevő dönt:** {{a tudnivaló egy-két mondatban, vagy „nincs"}}
- **Az első valódi munka a beállítás után:** {{a parancs neve, például `/heti`; a fájlnak léteznie kell}}

## Kiegészítő kérdéskörök

{{Ha a csomag kér kiegészítő kérdéskört (számok, csatorna, csapat, projektek, ajánlat), a gyártó a BLOKK-KONYVTAR.md-ből ide másolja a teljes szövegét, kitöltve, a célfájllal együtt. Ha nincs, ez a rész: „nincs".}}

## A Lifelong elérése

- **A jelentés címe:** {{a mi e-mail-címünk}}
- **A frissítés kiadási listája:** {{MANIFEST_URL, a nyilvános kernel-repó `main` ágának `kernel-manifest.json` raw-címe; kötelezően `https://`, különben a `/frissites` megáll}}
