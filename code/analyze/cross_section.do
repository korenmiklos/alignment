keep if year == 2003

local outcome exporter
local global_exposure foreign_owner capimport matimport expat
local size_controls lnL lnR

drop *1
foreach X in `global_exposure' {
	regress `outcome' `X'
	generate `X'0 = _b[_cons] * 100
	generate `X'1 = (_b[_cons] + _b[`X']) * 100
	local lbl_`X' : variable label `X'
} 

keep in 1
keep *0 *1

generate byte egy = 1
reshape long `global_exposure', i(egy) j(x)
drop egy

foreach X in `global_exposure' {
	label variable `X' "`lbl_`X''"
} 
