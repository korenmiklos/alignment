keep if year == 2003
keep if teaor == "D"
replace export_share = 100 * export_share

scatter export_share lnR, msize(tiny) scheme(538w) ///
	ytitle(Share of exports in revenue)

graph export ../output/figure/export_share.pdf, replace
