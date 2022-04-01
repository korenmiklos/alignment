use "temp/firm-panel.dta", clear
do "code/analyze/define_variables.do"

local sorting_var exporter

reghdfe ln_domestic_sales enter_`sorting_var'  if (enter_`sorting_var'==1 | exit_`sorting_var' ==1) & inrange(year, 1992, 2014), a(teaor08_2d##year) cluster(frame_id_numeric)
reghdfe L.ln_domestic_sales enter_`sorting_var'  if (enter_`sorting_var'==1 | exit_`sorting_var' ==1) & inrange(year, 1992, 2014), a(teaor08_2d##year) cluster(frame_id_numeric)

generate period = 3*int(year/3)
egen mean_lnD = mean(ln_domestic_sales), by(teaor08_2d year)
egen entrants = mean(ln_domestic_sales - mean_lnD) if enter_`sorting_var'==1, by(period)
egen exiters = mean(ln_domestic_sales - mean_lnD) if exit_`sorting_var'==1, by(period)

label variable entrants "Starting to export"
label variable exiters "Stopping to export"
label variable period "Year"

line entrants exiters period, sort scheme(538w) ytitle("Log domestic revenue relative to industry mean, 3-year MA")
graph export "output/figure/sorting_by_size.pdf", replace