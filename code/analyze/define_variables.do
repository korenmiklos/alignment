generate lnL = ln(emp)
generate lnR = ln(sales)
generate byte exporter = export>0 if !missing(export)
generate byte foreign_owner = fo3

mvencode foreign_owner, mv(0) override

generate export_share = export/sales
drop if export_share > 1
generate lnX = ln(export)

label variable lnL "Employment (log)"
label variable lnR "Sales (log)"
label variable exporter "Exporter"
label variable foreign_owner "Foreign owned"
label variable expat "Foreign managed"
label variable capimport "Machine importer"
label variable matimport "Material importer"
