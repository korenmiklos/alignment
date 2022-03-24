use "temp/firm-panel.dta", clear

do "code/analyze/define_variables.do"

egen p_export = cut(ln_export), group(5) icodes
egen p_domestic = cut(ln_domestic), group(5) icodes

collapse (mean) expat, by(p_domestic p_export year)

twoway contour expat p_export p_domestic if year <= 1995, ccuts(0.02 0.05 0.1 0.15 0.2 0.3 0.4 0.5) heatmap scheme(538w)
twoway contour expat p_export p_domestic if year >= 2000, ccuts(0.02 0.05 0.1 0.15 0.2 0.3 0.4 0.5) heatmap scheme(538w)