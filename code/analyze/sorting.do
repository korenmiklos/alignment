use "temp/firm-panel.dta", clear
do "code/analyze/define_variables.do"

reghdfe ln_domestic_sales enter_expat  if (enter_expat==1 | exit_expat ==1) & inrange(year, 1992, 2014), a(teaor08_2d##year) cluster(frame_id_numeric)
reghdfe L.ln_domestic_sales enter_expat  if (enter_expat==1 | exit_expat ==1) & inrange(year, 1992, 2014), a(teaor08_2d##year) cluster(frame_id_numeric)

generate period = 3*int(year/3)
egen mean_lnD = mean(ln_domestic_sales), by(teaor08_2d year)
egen entrants = mean(ln_domestic_sales - mean_lnD) if enter_expat==1, by(period)
egen exiters = mean(ln_domestic_sales - mean_lnD) if exit_expat ==1, by(period)

label variable entrants "Hiring expat CEOs"
label variable exiters "Leaving expat CEOs"
label variable period "Year"

line entrants exiters period, sort scheme(538w) ytitle("Log domestic revenue relative to industry mean, 3-year MA")
graph export "output/figure/sorting_by_size.pdf", replace