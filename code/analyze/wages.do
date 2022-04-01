use "temp/firm-panel.dta", clear
do "code/analyze/define_variables.do"

egen mean_ceo_wage = mean(ln_ceo_wage), by(teaor08_1d year)
replace ln_ceo_wage = ln_ceo_wage - mean_ceo_wage

keep if inrange(year, 1992, 2004)

collapse (mean) ln_ceo_wage, by(year exporter)
reshape wide ln_ceo_wage, i(year) j(exporter)
generate wage_difference = exp(ln_ceo_wage1 - ln_ceo_wage0)*100 - 100
label variable wage_difference "Wage premium for CEOs at exporting firms (%)"

line wage_difference year, sort scheme(538w)
graph export "output/figure/exporter_wage_premium.pdf", replace