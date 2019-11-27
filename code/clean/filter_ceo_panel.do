clear all
use "../input/ceo-panel/ceo_panel.dta"
keep frame_id year person_foreign
keep if year<=2003 & year>=1992

generate long tax_id = real(substr(frame_id, 3, 8)) if substr(frame_id, 1, 2) == "ft"
keep if !missing(tax_id, year)

collapse (max) expat = person_foreign, by(tax_id year)

save "../temp/expat.dta", replace
