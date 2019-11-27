* rename all variables but x=0,1
rename * Y*
rename Yx x

unab ys : Y*
local n : word count `ys'

forvalues i=1/`n' {
	local connect "`connect' L"
}

tw (scatter `ys' x, connect(`connect')),  scheme(538w) ///
	xscale(noline r(0 1)) xlabel(none)  ///
	xtitle("") ytitle("Share of exporters")

graph export ../output/figure/global_engagement_slope.pdf, replace
