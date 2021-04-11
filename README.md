# Survival_Analysis (Breast Cancer, GBSG2 Study)
Analiza przeżycia pacjentek poddanych terapii hormonalnej w trakcie leczenia onkologicznego.

1. **Dane** :</br>
Zbiór danych GBSG2 pochodzi z badania Sauerbrei, W., and P. Royston 1999. Zbiór składa się z grupy obserwacji 686 pacjentek, które zostały poddane leczeniu nowotworu piersi.

Zmienne ujęte zbiorze: </br>
  * time – zmienna określająca dzień od rozpoczęcia obserwacji w którym pacjentka umarła lub
jej obserwacja została ucięta
  * cens – zmienna binarna określająca to czy obserwacja została ocenzurowana czy nie – {0,1)
  * age – zmienna ciągła, wiek pacjentki w latach
  * tsize – wielkość guza w [mm]
  * menostat – status pacjentki, przed menopauzą 0, po menopauzie 1
  * pnodes – liczba ognisk nowotworowych
  * tgrade – stopień zaawansowania guza: {1,2,3} – 3 najwyższy stopień
  * progrec – ilość receptorów progesteronowych w [fmol]
  * estrec – ilość receptorów estrogenowych w [fmol]
  * horTh – zmienna binarna oznaczająca bycie poddanym terapii hormonalnej

2. **Cel badawczy** – ocena wpływu czynników na przeżywalność pacjentek poddanych terapii leczenia nowotworu piersi.
3. **Hipotezy badawcze**:
  * Im wyższy wiek pacjentki tym krótszy czas przeżycia podczas terapii nowotworowej.
  * Terapia hormonalna wydłuża czas przeżycia podczas leczenia nowotworu.

<br>**MODELE NIEPARAMETRYCZNE**</br>
4.1. **Estymacja metodą Kaplana-Meiera:** </br>
* Mediana funkcji przeżycia wskazuje, że połowa pacjentów przeżyła do minimum do **1806** dnia badania.
* Prawdopodobieństwo przeżycia do końca obserwacji (t=2700)wyniosło na tym zbiorze **0.34**.

<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Kaplan_Meier_Estimates.png" alt="KM_estimates" width="400" height="400" />

4.2. **Analiza czasu przeżycia pacjentek poddanych i niepoddanych terapii hormonalnej:**
* Pacjentki poddane terapii hormonalnej (horTh=1) miały statystycznie dłuższy czas dożycia okresie obserwacji.
* Przy poziomie istotności 0.05 dla każdego z wykonanych testów (log-rang i Wilcoxona) należy odrzucić hipotezę zerową od braku różnic w grupach.
<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Non-parametric%20horTh.png" alt="KM_estimates" width="400" height="400" />

4.3 **Analiza czasu przeżycia pacjentek w podziale na grupy wiekowe:**
</br>
* Zmienna ciągła age została zdychotomizowana wzdłuż mediany wynoszącej 53. Empiryczny rozkład tej zmiennej przypominający rozkład dwumianowy uzasadnia taki wybór. Pacjentki poniżej 53 roku życia zostały przydzielonej do młodszej grupy wiekowej – 1, pacjentki powyżej 53 roku życia do starszej grupy wiekowej - 2.
* Estymacja nieparametryczna funkcji dożycia w grupach metodą K-M wykazała brak istotności różnic w przeżywalności wyszczególnionych grup dla przyjętego poziomu istotności 0.05.

<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Non_parametric_age.png" alt="KM_estimates" width="400" height="400" />

4.4 **Analiza czasu przeżycia pacjentek w jednoczesnym podziale na grupy wiekowe oraz udział w terapii hormonalnej:**
</br>Wszystkie statystyki testowe nakazują odrzucenie hipotezy zerowej mówiącej o braku różnic w funkcji dożycia pomiędzy 4 rozróżnionymi grupami dla przyjętego poziomu istotności 0.05.
</br>Najbardziej narażoną grupą pacjentek są pacjentki starsze niepoddane terapii hormonalnej a najmniej pacjentki młodsze poddane terapii hormonalnej.
</br> Po przeliczeniu różnic w grupach z uwzględnieniem poprawki Tukeya dla testu Wilcoxona, brak podstaw do odrzucenia hipotezy zerowej o różnicach pomiędzy grupami 1 i 4, 2 i 3 oraz 3 i 4 – co potwierdza zasadność rozróżnienia pomiędzy grupą najbardziej i najmniej narażoną na ryzyko czyli grupą starszych kobiet niepoddanych terapii hormonalnej a grupą młodszych kobiet poddanych tej terapii (grupy 2 i 3).

<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Non_parametric_age_horTh.png" alt="KM_estimates" width="400" height="400" />
<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Tukey_adj_LogRank.png" alt="KM_estimates" width="400" height="200" />

<br>**MODELE PARAMETRYCZNE**</br>

5.1 **Funkcja hazardu wyestymowana z tablic trwania życia:**</br>
<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Empirical_hazard_function.png" alt="KM_estimates" width="400" height="300" />
</br>Niemonotoniczność empirycznej funkcji hazardu nakazuje odrzucenie parametrycznej analizy rozkładem wykładniczym
lub Weibulla.

5.2 **Wygładzona jądrowo funkcja hazardu:** </br>
* Za szerokość pasma przyjęto 570 dni – co oznacza, że obserwacje o takiej rozpiętości przyjęto do obliczania hazardów w
danych momentach czasowych w celu wygładzenia funkcji hazardu. Pasmo nie zostało ręcznie sprecyzowane lecz zostało
zaproponowane przez optymalizator wygładzania. Na wykres naniesiono 95%przedziały ufności.
<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Epanechnikov_smoothing.png" alt="KM_estimates" width="400" height="400" />

5.3 **Ocena graficzna dopasowania modeli:**
<br></br>Wstępnie najlepiej dopasowany zdaje się być model oparty o rozkład Gamma, następnie model log-normalny a na końcu log-logistyczny.
<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Parametric_models.png" alt="KM_estimates" width="1200" height="200" />

5.4 **Wybór właściwego modelu:**
<br></br> W celu wyboru właściwego modelu należy policzyć statystykę -2(LLgamma – Lllog_norm) a następnie przyrównać do wartości krytycznej obszaru wyznaczonego przez rozkład chi-kwadrat o jednym stopniu swobody dla poziomu istotności 0.05 czyli 3.84.
<br></br>-2(LLgamma – LLlog_norm) = 16.62
<br></br>16.62 > 3.84
<br></br>Wniosek: odrzucamy H0 mówiącą o tym, że ograniczenie na parametrach jest prawdziwe.Przyjmujemy zatem model Gamma, który jest istotnie lepiej dopasowany.
<br></br><img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Log_normal_VS_Gamma.png" alt="KM_estimates" width="200" height="300" />


5.5 **Analiza estymacji modelem Gamma:**
* Zmienna age okazała się nieistotna statystycznie w przeciwieństwie do zmiennej horTh.
* Dodatnie oszacowanie parametru zmiennej horTh wskazuje, że pacjentki poddane terapii hormonalnej mają 30% większy oczekiwany czas przeżycia od pacjentek niepoddanych terapii.
* Parametr skali większy od jeden potwierdza, że mamy do czynienia z malejącą funkcją hazardu.
* Parametr kształtu jest różny od 0 i od 1 – wniosek zatem jest taki, że nie mamy do czynienia ani z rozkładem log-normalnym ani Weibulla.
<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Gamma_model.png" alt="KM_estimates" width="400" height="150" />

<br></br>
**MODELE SEMIPARAMETRYCZNE**
<br></br>
Test globalny na istotność zmiennych.
<br></br>
<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Test_istotnos%CC%81c%CC%81_zmiennych.png" alt="KM_estimates" width="250" height="100" />
<br></br>
Wszystkie testy sugerują odrzucenie hipotezy zerowej o nieistotności globalnej zmiennych age oraz horTh a zatem przynajmniej jedna z nich jest istotna.
<br></br>
Interpretacja: bycie poddanym terapii hormonalnej zmniejsza hazard o 34%. Wzrost wieku pacjentki o 1 rok powoduje wzrost hazardu podczas leczenia nowotworu piersi o 29%.
<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Analiza_maksymalnej_wiaryg.png" alt="KM_estimates" width="500" height="120" />

6.1 **Włączenie zmiennych zależnych od czasu:**<br></br>
Globalny test Walda nakazuje odrzucić hipotezę o zbiorowej nieistotnościoszacowań parametrów. Włączenie interakcji z czasem powodujeindywidualną nieistotność oszacowań zmiennych age i horTh.
* Efekt zmiennej agetime po 365 dniach (1
roku) od upłynięcia terapii:
<br></br>
−0.198 + 0.000579 ∗ 365 = 0.013
<br></br>Oznacza, że rosnący wiek pacjentki wystawia ją na większe ryzyko po 1 roku od rozpoczęcia terapii.
<img src="https://github.com/BartekDuplaga/Survival_Analysis/blob/master/images/Semiparam_analysis.png" alt="KM_estimates" width="400" height="200" />

<br></br>
**PODSUMOWANIE**
<br></br>
Weryfikacja postawionych hipotez:
<br></br>
**Hipoteza 1 (obalona):** Im wyższy wiek pacjentki tym krótszy czas przeżycia podczas terapii nowotworowej<br></br>
Zarówno analiza nieparametryczna (test log-rang oraz test Wilcoxona) jak i parametryczna oparta na dwóch grupach wiekowych (starszej i młodszej) wykazały brak istotnych różnic w czasie dożycia w grupach wyszczególnionych ze względu na wiek. Analiza semiparametryczna wskazała istotność zmiennej wiek tylko w połączeniu z czasem (pacjentki leczone ponad 1 rok są istotnie  bardziej narażone na zdarzenie).
<br></br>
**Hipoteza 2 (potwierdzona):** Terapia hormonalna wydłuża czas przeżycia podczas leczenia nowotworu<br></br>
Analiza nieparametryczna i parametryczna potwierdziły, że terapia hormonalna jest skutecznym narzędziem wydłużającym czas życia pacjentek niezależnie od przynależności do grup wiekowych.
<br></br>Model Gamma wykazał, że pacjentki poddane tej terapii mają czas przeżycia o ok. 30% dłuższy od pacjentek, które nie są poddane terapii hormonalnej.


