clear all
use "../input/balance-small/balance-small.dta"
keep if year<=2003 & year>=1992

generate long tax_id = real(substr(frame_id, 3, 8)) if substr(frame_id, 1, 2) == "ft"
keep if !missing(tax_id, year)

save "../temp/balance.dta", replace
