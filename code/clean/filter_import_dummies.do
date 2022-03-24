clear all
use "input/import-dummies/import-dummies.dta"
rename id frame_id_numeric
keep if year<=2003 & year>=1992

save "temp/import-dummies.dta", replace
