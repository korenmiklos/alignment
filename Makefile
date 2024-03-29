all: output/figure/export_share.pdf output/figure/export_share_by_owner.pdf output/figure/global_engagement_slope.pdf
output/figure/export_share.pdf output/figure/export_share_by_owner.pdf&: code/visualize/export_share.do temp/firm-panel.dta
	echo "use temp/firm-panel.dta, clear\ndo code/analyze/define_variables.do" > temp.do
	cat $< >> temp.do
	stata -b do temp.do
	rm temp.do
output/figure/global_engagement_slope.pdf: code/visualize/slope.do temp/firm-panel.dta
	echo "use temp/firm-panel.dta, clear\ndo code/analyze/define_variables.do\ndo code/analyze/cross_section.do" > temp1.do
	cat $< >> temp1.do
	stata -b do temp1.do
	rm temp1.do
temp/firm-panel.dta: code/clean/merge.do temp/balance.dta temp/import-dummies.dta temp/expat.dta
	stata -b do $<
temp/balance.dta: code/clean/filter_balance.do input/merleg-expat/balance-small.dta
	stata -b do $<
temp/expat.dta: code/clean/filter_ceo_panel.do input/ceo-panel/ceo-panel.dta
	stata -b do $<
temp/import-dummies.dta: code/clean/filter_import_dummies.do input/import-dummies/import-dummies.dta
	stata -b do $<
install:
	stata -b ssc install g538schemes