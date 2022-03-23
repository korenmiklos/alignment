keep if year == 2003
keep if teaor == "D"
replace export_share = 100 * export_share

* shake so that overlapping dots are visible
replace export_share = export_share + 2 * (uniform() - 0.5)

tw (scatter export_share lnR, msize(tiny)),  scheme(538w) ///
	ytitle(Share of exports in revenue)

graph export "output/figure/export_share.pdf", replace


tw (scatter export_share lnR if foreign_owner == 0, msize(tiny)) ///
	(scatter export_share lnR if foreign_owner == 1, msize(tiny)) ///
	,  scheme(538w) ///
	ytitle(Share of exports in revenue) ///
	legend(order(1 "Domestic owned" 2 "Foreign owned"))

graph export "output/figure/export_share_by_owner.pdf", replace
