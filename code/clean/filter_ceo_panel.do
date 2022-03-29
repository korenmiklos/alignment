clear all
use "input/ceo-panel/ceo-panel.dta"
keep frame_id_numeric year expat

collapse (max) expat, by(frame_id_numeric year)

save "temp/expat.dta", replace
