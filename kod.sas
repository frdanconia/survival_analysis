libname ahz "/Users/bartek/Desktop/ProjektAHZ";

data ahz.dane;
infile '/folders/myfolders/SASCrunch/cars.csv'
                 delimiter=','
                 firstobs=1;
input time cens age tsize menostat pnodes tgrade progrec estrec horTh;
run;
 
/*MODULE 1 - Non-parametric models */
ODS GRAPHICS ON;
PROC LIFETEST DATA=ahz.dane PLOTS=S(NOCENSOR ATRISK CL CB=EP);
	TIME time*cens(1);
RUN;
ODS GRAPHICS OFF;

/*Difference in groups - hormonal therapy*/
ODS HTML ;
ODS GRAPHICS ON;
PROC LIFETEST DATA=ahz.dane PLOTS=S(TEST);
	TIME time*cens(1);
	STRATA horTh;
RUN;
ODS GRAPHICS OFF;
ODS HTML CLOSE;

/*Difference in groups - age*/
ODS HTML ;
ODS GRAPHICS ON;
PROC LIFETEST DATA=ahz.dane PLOTS=S(TEST);
	TIME time*cens(1);
	STRATA age;
RUN;
ODS GRAPHICS OFF;

/*Difference in groups - hormonal therapy and age*/
ODS HTML ;
ODS GRAPHICS ON;
PROC LIFETEST DATA=ahz.dane PLOTS=S(TEST);
	TIME time*cens(1);
	STRATA horTh age / TESTS=ALL;
RUN;
ODS GRAPHICS OFF;
ODS HTML CLOSE;

/*Tukey adjustment*/
ODS HTML ;
PROC LIFETEST DATA=ahz.dane;
	TIME time*cens(1);
	STRATA horTh age / ADJUST=TUKEY;
RUN;
ODS HTML CLOSE;

/* MODULE 2 - parametric modeling*/

ODS HTML;
PROC LIFEREG DATA=ahz.dane;
	MODEL time*cens(1)= horTh age
		/ DISTRIBUTION=LNORMAL;
RUN;
ODS HTML CLOSE;

ODS HTML;
PROC LIFEREG DATA=ahz.dane;
	MODEL time*cens(1)= horTh age
		/ DISTRIBUTION=EXPONENTIAL;
RUN;
ODS HTML CLOSE;

ODS HTML;
PROC LIFEREG DATA=ahz.dane;
	MODEL time*cens(1)= horTh age
		/ DISTRIBUTION=WEIBULL;
RUN;
ODS HTML CLOSE;

ODS HTML;
PROC LIFEREG DATA=ahz.dane;
	MODEL time*cens(1)= horTh age
		/ DISTRIBUTION=LLOGISTIC;
RUN;
ODS HTML CLOSE;

ODS HTML;
PROC LIFEREG DATA=ahz.dane;
	MODEL time*cens(1)= horTh age
		/ DISTRIBUTION=GAMMA;
RUN;
ODS HTML CLOSE;
