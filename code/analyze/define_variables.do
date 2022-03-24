generate lnL = ln(emp)
generate lnR = ln(sales)
generate byte exporter = export>0 if !missing(export)
generate byte foreign_owner = fo3

mvencode foreign_owner, mv(0) override

generate export_share = export/sales
replace export_share = 0.001 if export_share < 0.001
replace export_share = 0.999 if export_share > 0.999 & !missing(export_share)

generate ln_export = ln(export_share * sales / ppi18)
generate ln_domestic = ln((1-export_share) * sales / ppi18)

label variable lnL "Employment (log)"
label variable lnR "Sales (log)"
label variable exporter "Exporter"
label variable foreign_owner "Foreign owned"
label variable expat "Foreign managed"
label variable capimport "Machine importer"
label variable matimport "Material importer"
label variable ln_export "Exports (log)"
label variable ln_domestic "Domestic sales (log)"