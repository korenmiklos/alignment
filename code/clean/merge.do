clear all

use "temp/balance.dta"
merge 1:1 frame_id_numeric year using "temp/import-dummies.dta", nogen keep(match master)
merge 1:1 frame_id_numeric year using "temp/assignment.dta", nogen keep(match master)
merge 1:1 originalid year using "temp/ceo_wage.dta", nogen keep(match master)

* keep only manufacturing
keep if teaor08_1d=="C"

* those not in customs are non-importers
mvencode capimport matimport, mv(0) override

* those not in CEO panel are unknown
drop if missing(expat)

save "temp/firm-panel.dta", replace
