use "temp/firm-panel.dta", clear
do "code/analyze/define_variables.do"

reghdfe lnR enter_expat  if (enter_expat==1 | exit_expat ==1) & inrange(year, 1992, 2014), a(teaor08_2d##year) cluster(frame_id_numeric)
reghdfe L.lnR enter_expat  if (enter_expat==1 | exit_expat ==1) & inrange(year, 1992, 2014), a(teaor08_2d##year) cluster(frame_id_numeric)

generate period = 3*int(year/3)
egen mean_lnR = mean(lnR), by(teaor08_2d year)
egen entrants = mean(lnR - mean_lnR) if enter_expat==1, by(period)
egen exiters = mean(lnR - mean_lnR) if exit_expat ==1, by(period)

label variable entrants "Hiring expat CEOs"
label variable exiters "Leaving expat CEOs"
label variable period "Year"

line entrants exiters period, sort scheme(538w) ytitle("Log revenue relative to industry mean, 3-year MA")
graph export "output/figure/sorting_by_size.pdf", replace