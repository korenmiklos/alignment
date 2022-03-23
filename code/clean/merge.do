clear all

use "temp/balance.dta"
merge 1:1 tax_id year using "temp/import-dummies.dta", nogen keep(match master)
merge 1:1 tax_id year using "temp/expat.dta", nogen keep(match master)

* keep only manufacturing
keep if teaor03_1d=="D"

* those not in customs are non-importers
mvencode capimport matimport, mv(0) override

* those not in CEO panel are unknown
drop if missing(expat)

save "temp/firm-panel.dta", replace
