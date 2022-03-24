clear all

use "temp/balance.dta"
merge 1:1 frame_id_numeric year using "temp/import-dummies.dta", nogen keep(match master)
* those not in customs are non-importers
mvencode capimport matimport, mv(0) override

* expat not yet defined
generate byte expat = .
do "code/analyze/define_variables.do"
drop expat

local dummies exporter foreign_owner capimport matimport

keep frame_id_numeric year `dummies'
tempfile firms
save `firms', replace

use "input/ceo-panel/ceo-panel.dta", clear
keep frame_id_numeric person_id year expat first_year_as_ceo

* if no firm data, assume also no experience in that year!
merge m:1 frame_id_numeric year using `firms', nogen keep(match)
mvencode `dummies', mv(0) override

levelsof year, local(ts)
foreach X in `dummies' {
    generate byte past_`X' = 0
    foreach t in `ts' {     
        egen past_ = max(cond(year < `t', `X', 0)), by(person_id)
        replace past_`X' = past_ if year == `t'
        drop past_
    }
}

keep frame_id_numeric person_id year expat first_year_as_ceo past_*
collapse (max) expat past_* (min) first_year_as_ceo, by(person_id year)

save "temp/experience-dummies.dta", replace