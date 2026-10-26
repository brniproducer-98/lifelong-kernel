# Piszkozat-gyár · választható modul (1.1)

**Mit old meg.** A Claude Gmail-összekötője a piszkozatba írt linket egy Google-os átirányító címre cseréli, ami a mentés után egy napig él; a képet (logót) kiszedi; nagy csatolmányt nem tud. A piszkozat-gyár a kész levelet IMAP-on teszi a Gmail Piszkozatok mappájába: tiszta linkkel, webes logóval, csatolt PDF-fel, egy lépésben. **Küldeni nem tud:** csak piszkozatot tesz le; a levelet ember küldi el.

**Mit használ.** Csak a macOS gyári eszközeit: `curl` (IMAPS), `security` (Kulcskarika), `base64`, `osascript`. Telepítés nincs.

| Fájl | Mi ez |
|---|---|
| `jelszo-mentes.sh` | egy macOS-ablak rejtett mezővel bekéri a Gmail-alkalmazásjelszót, és a Kulcskarikába menti; a jelszó nem kerül a chatbe és a kimenetre |
| `level-epito.sh` | kész MIME-levelet épít: HTML-törzs, opcionális csatolt PDF, opcionális másolatcímzett, saját Message-ID; válaszlevélnél `In-Reply-To` és `References` fejléc (1.1), így a Gmail a piszkozatot a megválaszolt szálba teszi |
| `piszkozat-gyar.sh` | a levelet a `\Drafts` jelzésű mappába teszi (`--proto =imaps`, csak keresés és APPEND); ugyanazt a Message-ID-t nem írja be kétszer; lassú válasz után ellenőriz; kimenet: OK, MAR-VAN vagy HIBA; `--fejlec` módban (1.1) a megválaszolandó levél Message-ID-jét és előzményét adja, csak olvasva (`FETCH ENVELOPE`, az RFC 3501 szerint nem jelöl olvasottnak) |
| `naplo-ellenorzes.sh` | ellenőrzi, hogy a jelszó egyetlen chat-naplóban sem szerepel; kimenet: OK vagy HIBA |
| `SHA256SUMS` | az ellenőrző összegek; letöltés után `shasum -a 256 -c SHA256SUMS` |

**Mérve (2026-10-22, 23):**
- a Gmailben szerkeszthető piszkozat lesz belőle;
- a link a webes újramentés és a telefonos küldés után is tiszta;
- a PDF telefonról küldve is megmarad;
- zárolt képernyővel, felügyelet nélkül is fut;
- a jelszó a naplókban nem szerepel;
- SMTP-re a curl nem megy;
- **(1.1, 2026-10-24 és 26)** a válasz-piszkozat a megválaszolt szálba kerül, és a piszkozat a Message-ID-jével azonnal megtalálható (Gmail-összekötő, `list_drafts`, `rfc822msgid:`).

**Két korlát:**
- **A beágyazott (CID) logó a telefonos Gmail-appból küldve elvész.** A logó ezért mindig webes kép legyen (a saját Gmail-aláírás képcíme).
- **A Gmail webes újramentése a Message-ID-t lecseréli, a piszkozat azonosítóját nem.** A tartós dupla-védelem ezért a hívó rendszer nyilvántartásában van, a piszkozat azonosítójával, amit a beírás után azonnal le kell kérni.

**Határ.** A szkript csak piszkozatot tesz le. A küldést a hívó rendszerben több fék lassítja: a jelszó kiolvasásának tiltása a modellnek, az összekötő küldőeszközeinek kikapcsolása, a házirend. Egyik sem áthághatatlan. Vészfék: az alkalmazásjelszó törlése a Google-fiókban.

**Telepítés.** Nem a `/frissites` telepíti (nincs a `kernel-manifest.json`-ban). A Lifelong ügyfélenkénti telepítő levele tölti le innen, `curl -fsSL`-lel, és az összegeket a levélben álló értékekkel is összeveti.
