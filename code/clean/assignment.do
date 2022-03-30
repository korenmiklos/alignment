clear all
use "input/ceo-panel/ceo-panel.dta"

egen fp = tag(frame_id_numeric person_id)
egen Nfirm_p = sum(fp), by(person_id )
summarize Nfirm_p
scalar most = r(max)

egen ceo_index = rank(-expat*(1+most) - Nfirm_p), by(frame_id_numeric year) unique
tabulate ceo_index expat if ceo_index <=10, row

keep if ceo_index==1

keep frame_id_numeric year person_id expat

save "temp/assignment.dta", replace
