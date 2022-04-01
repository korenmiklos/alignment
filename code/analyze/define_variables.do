generate lnL = ln(emp)
generate lnR = ln(sales)
generate ln_ceo_wage = ln(ker)
generate byte foreign_owner = fo3

mvencode foreign_owner export, mv(0) override
generate byte exporter = export>0

xtset frame_id_numeric year
egen first_year_expat = min(cond(expat==1, year, .)), by(frame_id_numeric )
egen last_year_expat = max(cond(expat==1, year, .)), by(frame_id_numeric )
egen first_year_local = min(cond(expat==0, year, .)), by(frame_id_numeric )

egen first_year_firm = min(year), by(frame_id_numeric )
egen last_year_firm = max(year), by(frame_id_numeric )

foreach X in expat exporter {
    generate byte enter_`X' = (`X'==1) & (L.`X'==0) if !missing(`X',L.`X')
    generate byte exit_`X' = (`X'==0) & (L.`X'==1) if !missing(`X',L.`X')
}

generate export_share = export/sales
drop if export_share > 1
generate lnX = ln(export)
generate ln_domestic_sales = ln(sales - export)

label variable lnL "Employment (log)"
label variable lnR "Sales (log)"
label variable exporter "Exporter"
label variable foreign_owner "Foreign owned"
label variable expat "Foreign managed"
label variable capimport "Machine importer"
label variable matimport "Material importer"
