clear all
use "input/merleg-expat/balance-small.dta"
keep if year<=2003 & year>=1992

generate long frame_id_numeric = real(substr(frame_id, 3, 8)) if substr(frame_id, 1, 2) == "ft"
keep if !missing(frame_id_numeric, year)

save "temp/balance.dta", replace
