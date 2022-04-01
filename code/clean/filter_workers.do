clear
/* these are the variables we want to keep */
local keepvars "ker nem kor szakm kozepf felsof letszam foreign *suly ujbel vkat"

tempfile append
save  `append', replace emptyok

foreach year in 1992 1993 1994 1995 1996 1997 1998 1999 2000 2001 2002 2003 2004 {
	* use updated datafiles if available
	capture confirm file "input/bertarifa/adatbank/tarifa`year'.dta"
	if (_rc==0) {
		use "input/bertarifa/adatbank/tarifa`year'.dta", clear
	}
	else {
		use "input/bertarifa/tarifa`year'.dta", clear
	}
    di in ye "YEAR = `year'"
	ren feorgen feor

    /* make variable names consistent over time */
    capture confirm variable kra
    if !_rc {
        gen byte foreign = (kra==1)|(kra==2)
    }
    else {
        gen byte foreign = tulaj==3
    }

    /* make sure that all years have ujbel */
    confirm variable ujbel

    /* this is a stata trick. renames either letszama or letszamb to letszam. */
    ren letszam letszam

    if `year'>=2002 {
        ***drop part-timers
        drop if heora<36
    }

    ***basic selection: business sector, has firm id, not in micro-firm***
    keep if vall==1
    keep if tsz!=.
	
    ***drop if basic ind. char. missing***
    drop if missing(nem,kor,feor)
    /* iskev is often missing. */

    codebook feor

    ***drop irrelevant variables***
    keep tsz azon feor ev `keepvars'

    ren ev year
	ren tsz originalid

    append using `append'
    save `append', replace

}

compress

* compute average CEO wage
generate byte ceo = (feor==1311)
keep if ceo | (felsof & int(feor/1000)==2)
collapse (mean) ker, by(originalid year ceo)
reshape wide ker, i(originalid year) j(ceo)

rename ker0 college_wage
rename ker1 ceo_wage
 
save "temp/ceo_wage.dta", replace
