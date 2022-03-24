clear all
use "input/ceo-panel/ceo-panel.dta"
keep frame_id_numeric year expat
keep if year<=2003 & year>=1992

collapse (max) expat, by(frame_id_numeric year)

save "temp/expat.dta", replace
