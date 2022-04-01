use "temp/firm-panel.dta", clear
do "code/analyze/define_variables.do"

foreach X in ln_ceo_wage ln_college_wage {
    tempvar mean
    egen `mean' = mean(`X'), by(teaor08_1d year)
    replace `X' = `X' - `mean'
    drop `mean'
}

keep if inrange(year, 1992, 2004)

collapse (mean) ln_ceo_wage ln_college_wage, by(year exporter)
reshape wide ln_ceo_wage ln_college_wage, i(year) j(exporter)
generate wage_difference_ceo = exp(ln_ceo_wage1 - ln_ceo_wage0)*100 - 100
generate wage_difference_college = exp(ln_college_wage1 - ln_college_wage0)*100 - 100

line wage_difference_ceo wage_difference_college year, sort scheme(538w) ytitle("Wage difference at exporters, %") legend(order(1 "CEOs" 2 "Other college graduates"))
graph export "output/figure/exporter_wage_premium.pdf", replace