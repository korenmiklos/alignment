clear all
use "input/import-dummies/import-dummies.dta"
rename id tax_id
keep if year<=2003 & year>=1992

save "temp/import-dummies.dta", replace
