Poniżej wersja rozwinięta tak, żeby zachować mocny klimat, ale nie rozdmuchać projektu ponad realny zakres pięciu dni.

# Radar 84

## Elevator pitch

Jest rok 1984. Podczas nocnej zmiany w odizolowanej stacji radarowej wykrywasz sygnał, którego nie powinno tam być.

Według aparatury obiekt znajduje się setki kilometrów dalej, poza granicami kraju. Według mapy nie może być widoczny z twojej pozycji.

Mimo to, gdy odsłaniasz metalową zasłonę i patrzysz przez okno, widzisz na horyzoncie coś ogromnego.

Każdy kolejny pomiar pokazuje, że obiekt się zbliża.

Nie wiadomo jednak, czy przesuwa się on, czy zmienia się sama mapa.

---

## Gatunek

Retro terminal horror z elementami:

* analizy sygnałów,
* prostych zagadek logicznych,
* pracy z mapą,
* podejmowania decyzji pod presją,
* horroru psychologicznego.

Gra trwa około 20–35 minut i rozgrywa się podczas jednej nocnej zmiany.

---

## Główna fantazja gracza

Gracz ma poczuć się jak samotny operator wojskowej stacji radarowej, który posiada bardzo ograniczone narzędzia, ale musi zdecydować, czy wykryty sygnał jest:

* awarią aparatury,
* wrogim samolotem,
* tajnym testem wojskowym,
* zjawiskiem atmosferycznym,
* czymś, czego nie da się opisać wojskowymi procedurami.

Najważniejsze jest poczucie, że gracz obserwuje coś potężnego, ale nie ma nad tym żadnej kontroli.

---

# Fabuła

Gracz wciela się w operatora nocnej zmiany w stacji radarowej „Punkt 84”.

Placówka znajduje się na odludziu, w pobliżu górskiej granicy. Większość personelu została wcześniej odesłana z powodu awarii generatora i problemów z łącznością. Na miejscu pozostał tylko gracz oraz oficer dyżurny znajdujący się w innym pomieszczeniu.

Oficera nie można zobaczyć. Kontakt odbywa się wyłącznie przez terminal komunikacyjny.

O godzinie 02:13 radar wykrywa pierwszy nietypowy sygnał.

Początkowo wygląda on jak słabe echo atmosferyczne. Z każdą kolejną rotacją radaru sygnał staje się jednak większy.

Nie szybszy.

Większy.

---

## Punkt wyjścia

Terminal wyświetla komunikat:

> NIEZIDENTYFIKOWANE ECHO
> AZYMUT: 041
> ODLEGŁOŚĆ: 312 KM
> WYSOKOŚĆ: BRAK DANYCH
> ROZMIAR: BŁĄD POMIARU

Gracz musi sprawdzić urządzenia i potwierdzić odczyt zgodnie z procedurą.

Po wykonaniu testów okazuje się, że radar działa poprawnie.

Na mapie pozycja obiektu wypada daleko poza granicami kraju.

Jednak przez okno widać ciemny kształt stojący na horyzoncie.

---

# Wildcardy

## Mis for Mega

Obiekt jest nieproporcjonalnie wielki.

Na początku wygląda jak odległa góra albo ciężka chmura. Później gracz zauważa, że jego górna część znajduje się ponad warstwą chmur.

Skala obiektu nigdy nie zostaje dokładnie pokazana. Gracz widzi tylko:

* fragment sylwetki,
* światła na ogromnej wysokości,
* linię przypominającą ramię,
* przesuwający się cień,
* zakłócenia radaru odpowiadające jego obecności.

Im mniej szczegółów, tym łatwiejsza realizacja i silniejsze wrażenie ogromu.

## Kartografia

Mapa jest głównym elementem rozgrywki.

Gracz zaznacza na niej kolejne pozycje sygnału, wpisując współrzędne albo klikając w kratki.

Z czasem pojawiają się sprzeczności:

* radar podaje pozycję poza mapą,
* namiar optyczny wskazuje inny kierunek,
* stare mapy pokazują miejscowości, których nie ma,
* granice zaczynają przebiegać inaczej,
* oznaczenie stacji przesuwa się pomiędzy kolejnymi pomiarami.

Mapa przestaje być tylko narzędziem. Staje się częścią zagrożenia.

## Majaczący w oddali

Obiekt przez większość gry znajduje się daleko na horyzoncie.

Gracz może obserwować go przez małe okno lub prosty wizjer. Obraz zmienia się po wykonaniu określonych działań.

Za każdym razem sylwetka jest trochę wyraźniejsza albo większa.

Nigdy nie dochodzi do pełnego pokazania istoty.

---

# Główna pętla rozgrywki

Każdy etap składa się z kilku prostych czynności.

## 1. Odczytaj sygnał

Radar wykonuje obrót, a na ekranie pojawia się echo.

Gracz sprawdza:

* azymut,
* odległość,
* siłę sygnału,
* częstotliwość,
* przybliżony rozmiar.

## 2. Zweryfikuj aparaturę

Gracz wpisuje komendy diagnostyczne, na przykład:

```text
TEST RADAR
CHECK ANTENNA
CALIBRATE RANGE
SCAN 041
FILTER WEATHER
```

Nie trzeba tworzyć rozbudowanego parsera. Wystarczy kilka dostępnych komend oraz proste odpowiedzi systemu.

## 3. Zaznacz pozycję na mapie

Gracz nanosi współrzędne na wojskową mapę.

Może to być:

* kliknięcie odpowiedniego sektora,
* wpisanie numeru kratki,
* przeciągnięcie znacznika,
* połączenie kilku punktów linią.

## 4. Wyślij raport

Gracz wybiera klasyfikację sygnału:

* zakłócenie,
* zjawisko pogodowe,
* samolot,
* nieznany obiekt,
* błąd systemu.

Raport wpływa na odpowiedzi przełożonych i zakończenie.

## 5. Sprawdź horyzont

Po części pomiarów aktywuje się możliwość spojrzenia przez okno.

Każda obserwacja pokazuje zmianę:

* pojawienie się światła,
* przesunięcie sylwetki,
* zniknięcie gwiazd,
* ruch chmur w przeciwnym kierunku,
* gigantyczny cień na ziemi.

Następnie rozpoczyna się kolejny cykl.

---

# Struktura gry

## Etap 1: Rutyna

Gracz otrzymuje krótkie instrukcje nocnej zmiany.

Wykonuje normalne zadania:

* test ekranu,
* sprawdzenie częstotliwości,
* zapisanie pogody,
* oznaczenie cywilnego samolotu.

Ten fragment pełni funkcję samouczka.

Atmosfera jest spokojna, ale terminal sporadycznie wyświetla komunikaty, których nie ma w instrukcji:

```text
BRAK OBIEKTÓW W SEKTORZE 41
BRAK OBIEKTÓW W SEKTORZE 41
BRAK OBIEKTÓW W SEKTORZE 41
```

Radar niczego jeszcze nie pokazuje.

## Etap 2: Pierwsze echo

Pojawia się sygnał w sektorze 41.

Jest słaby i nieregularny.

Oficer dyżurny nakazuje zaklasyfikować go jako zakłócenie pogodowe.

Po spojrzeniu przez okno gracz widzi ciemną plamę przypominającą odległą górę.

Problem polega na tym, że na mapie w tym miejscu nie ma żadnych gór.

## Etap 3: Błędna odległość

Radar wskazuje, że obiekt znajduje się 280 kilometrów od stacji.

Gracz wykonuje pomiar optyczny. Wynik sugeruje 40 kilometrów.

Po ponownej kalibracji radar pokazuje:

```text
ODLEGŁOŚĆ: 264 KM
ODLEGŁOŚĆ OPTYCZNA: 37 KM
RÓŻNICA: DOZWOLONA
```

Instrukcja techniczna mówi, że dopuszczalna różnica wynosi maksymalnie dwa kilometry.

## Etap 4: Niezgodność mapy

Gracz otrzymuje polecenie naniesienia trzech kolejnych pozycji obiektu.

Po połączeniu punktów nie powstaje trasa.

Punkty tworzą ogromny okrąg wokół stacji.

Stacja znajduje się dokładnie w jego środku.

W terminalu pojawia się wiadomość od oficera:

```text
NIE NANOSIĆ KOLEJNYCH POZYCJI.
MAPA JEST NIEAKTUALNA.
```

Chwilę później przychodzi druga:

```text
NIE MAMY OFICERA DYŻURNEGO.
KTO Z TOBĄ ROZMAWIA?
```

## Etap 5: Ruch

Echo zaczyna zajmować coraz większą część ekranu.

System nie potrafi już określić jego rozmiaru.

```text
SZACOWANA DŁUGOŚĆ: 18 KM
SZACOWANA DŁUGOŚĆ: 43 KM
SZACOWANA DŁUGOŚĆ: 112 KM
SZACOWANA DŁUGOŚĆ: STACJA ZNAJDUJE SIĘ WEWNĄTRZ
```

Przez okno obiekt nadal wygląda tak samo.

Nie wydaje się bliżej.

Zmienia się jednak horyzont. Góry, las i anteny zaczynają wyglądać jak niewielkie elementy znajdujące się na powierzchni czegoś większego.

## Etap 6: Ostatnia procedura

Gracz otrzymuje trzy sprzeczne rozkazy:

### Dowództwo

```text
WYŁĄCZYĆ RADAR.
NIE OBSERWOWAĆ OBIEKTU.
OCZEKIWAĆ NA EWAKUACJĘ.
```

### Oficer dyżurny

```text
UTRZYMAĆ ŚLEDZENIE.
OBIEKT MUSI POZOSTAĆ NA EKRANIE.
NIE POZWÓL MU ZNIKNĄĆ.
```

### System radarowy

```text
ODWRÓĆ ANTENĘ W KIERUNKU STACJI.
WYKONAJ POMIAR WŁASNEJ POZYCJI.
```

Gracz wybiera, której instrukcji posłuchać.

---

# Możliwe zakończenia

## Zakończenie 1: Posłuszeństwo

Gracz wyłącza radar zgodnie z rozkazem dowództwa.

Ekran gaśnie.

Przez chwilę słychać tylko buczenie generatora.

Następnie z zewnątrz dochodzi bardzo niski dźwięk, przypominający przesuwanie się metalu po betonie.

Po ponownym uruchomieniu terminal pokazuje:

```text
DATA: 17.10.1984
LOKALIZACJA: NIEZNANA
STACJA 84: POZA GRANICAMI
```

## Zakończenie 2: Obserwator

Gracz utrzymuje śledzenie obiektu.

Sygnał rośnie, aż wypełnia cały radar.

Na ekranie nie ma już pojedynczego punktu. Cały monitor staje się jednym echem.

Ostatni komunikat:

```text
OBIEKT NIE ZBLIŻA SIĘ.
OBIEKT PATRZY.
```

## Zakończenie 3: Pomiar własnej pozycji

Gracz kieruje radar na stację.

System wykonuje skan.

```text
OBIEKT WYKRYTY
AZYMUT: 000
ODLEGŁOŚĆ: 0 KM
ROZMIAR: 618 KM
```

Mapa oddala się i pokazuje, że wszystkie wcześniejsze pomiary były wykonywane wewnątrz zarysu gigantycznej sylwetki.

## Zakończenie 4: Fałszywy raport

Gracz konsekwentnie klasyfikuje wszystkie sygnały jako zakłócenia.

Zmiana kończy się pozornie normalnie.

Pojawia się ekran podsumowania:

```text
LICZBA INCYDENTÓW: 0
LICZBA BŁĘDNYCH ALARMÓW: 0
OPERATOR: GODNY ZAUFANIA
```

Po chwili ostatnia linia zmienia się na:

```text
OPERATOR: NIE ZAUWAŻYŁ PRZENIESIENIA
```

---

# Sterowanie

Gra może być obsługiwana niemal całkowicie myszą i klawiaturą.

## Terminal

Gracz wpisuje krótkie komendy.

Przykładowe polecenia:

```text
HELP
SCAN
SCAN 041
STATUS
TEST
MAP
REPORT
RADIO
WINDOW
LOG
```

Komendy mogą być też dostępne jako lista w instrukcji leżącej obok monitora.

Nie trzeba obsługiwać dowolnych zdań. Parser może rozpoznawać pierwsze słowo i opcjonalny parametr.

## Mapa

Mapa może być osobnym widokiem otwieranym komendą `MAP`.

Gracz:

* wybiera sektor,
* stawia znacznik,
* sprawdza współrzędne,
* łączy ostatnie pomiary,
* porównuje mapę aktualną z archiwalną.

## Okno

Komenda `WINDOW` albo przycisk obok monitora przełącza widok na horyzont.

Scena może być prawie nieruchomym obrazem z kilkoma prostymi warstwami:

* las,
* góry,
* chmury,
* antena,
* sylwetka obiektu,
* śnieg lub szum ekranu.

---

# Styl wizualny

## Główna estetyka

* zielony lub bursztynowy monitor CRT,
* czarne tło,
* monospace,
* zaokrąglone krawędzie ekranu,
* scanlines,
* migotanie,
* zakłócenia,
* lekkie wypalanie obrazu,
* proste wojskowe oznaczenia.

## Radar

Radar może być zrealizowany jako:

* okrągła siatka,
* obracająca się linia,
* kilka nieruchomych punktów,
* duża rozmyta plama symbolizująca obiekt.

Nie jest potrzebna realistyczna symulacja.

Każdy etap gry może korzystać z wcześniej przygotowanego zestawu pozycji i rozmiarów sygnału.

## Obiekt

Najlepiej nie tworzyć pełnej postaci.

Wystarczą:

* wielka ciemna sylwetka,
* dwa lub trzy blade światła,
* fragment kształtu wychodzący poza ekran,
* przesunięcie kilku warstw tła,
* zasłonięcie części nieba.

---

# Dźwięk

Dźwięk będzie bardzo ważny, ale może pozostać prosty.

Potrzebne elementy:

* buczenie transformatora,
* obrót anteny,
* krótkie piknięcie radaru,
* trzask terminala,
* szum radiowy,
* wiatr za oknem,
* odległy niski pomruk.

W kluczowych momentach można wyciszyć prawie wszystkie dźwięki. Cisza przed spojrzeniem przez okno może działać lepiej niż rozbudowana muzyka.

Muzyka nie jest konieczna.

---

# Elementy horroru

Horror powinien wynikać z niezgodności danych, a nie z jumpscare’ów.

Najważniejsze zabiegi:

* odległość nie zgadza się ze skalą,
* mapa pokazuje inne granice,
* wiadomości przychodzą od nieistniejącego pracownika,
* stare raporty opisują bieżące wydarzenia,
* system zna decyzję gracza przed jej podjęciem,
* obiekt pozostaje w tym samym miejscu mimo zmiany współrzędnych,
* radar sugeruje, że stacja znajduje się wewnątrz obiektu.

Można dodać jeden subtelny jumpscare, na przykład nagłe pojawienie się ogromnego echa po ponownym uruchomieniu radaru, ale nie powinien być podstawą gry.

---

# Minimalny zakres na pięć dni

## Elementy konieczne

* jeden ekran terminala,
* jeden ekran radaru,
* jeden ekran mapy,
* jeden widok przez okno,
* około 8–10 komend,
* 5–6 etapów fabularnych,
* 3 decyzje gracza,
* 3 lub 4 zakończenia,
* proste efekty CRT,
* kilka dźwięków otoczenia.

## Elementy, które można wyciąć

* chodzenie po stacji,
* pełny model 3D pomieszczenia,
* rozbudowany parser języka,
* proceduralne sygnały,
* rozbudowane zarządzanie zasobami,
* animowana postać potwora,
* dubbing,
* zapisywanie gry,
* rozbudowane menu ustawień.

---

# Proponowany harmonogram

## Dzień 1

* podstawowy terminal,
* system wpisywania komend,
* przełączanie między radarem, mapą i oknem,
* pierwsza wersja scenariusza.

## Dzień 2

* radar i animacja skanowania,
* system etapów fabularnych,
* komunikaty i odpowiedzi terminala,
* podstawowa mapa.

## Dzień 3

* widok przez okno,
* kolejne wersje sylwetki obiektu,
* decyzje i raportowanie,
* logika zakończeń.

## Dzień 4

* pełna treść gry,
* efekty CRT,
* dźwięki,
* przejścia między etapami,
* poprawki klimatu i tempa.

## Dzień 5

* testowanie,
* usuwanie błędów,
* skrócenie zbyt długich fragmentów,
* dodanie instrukcji,
* przygotowanie builda i strony gry.

---

# Najważniejsza zasada projektowa

Obiekt nie powinien aktywnie atakować gracza.

Najbardziej przerażające jest to, że być może nigdy się nie poruszył.

To stacja, mapa albo cały kraj mogły przez całą noc przesuwać się w jego kierunku.

---

# Hasła promocyjne

**Radar wykrył coś poza granicami kraju. Ty widzisz to przez okno.**

**Na mapie jest trzysta kilometrów stąd. Na horyzoncie zasłania gwiazdy.**

**Nie pozwól sygnałowi zniknąć z ekranu.**

**Obiekt się nie zbliża. Obiekt staje się większy.**

---

# Alternatywne tytuły

* Stacja 84
* Echo 041
* Punkt Radarowy 84
* Sektor 41
* Poza Granicą
* Zasięg
* Nocny Operator
* Echo na Horyzoncie
* Obiekt 84
* Granica Mapy

Najmocniejsza wersja tej gry opierałaby się na 20–25 minutach rozgrywki, jednym pomieszczeniu i stopniowym odkrywaniu, że radar nie mierzy odległości do obiektu, lecz rozmiar obszaru, który obiekt już zajmuje.
