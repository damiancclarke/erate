*! worldstat: Visualising the state of world development
*! Version 1.1.0: 2012/12/15
*! Author: Damian C. Clarke 
*! Department of Economics
*! The University of Oxford
*! damian.c.clarke@economics.ox.ac.uk

capture program drop exchange
program define exchange
	vers 10.0
	set more off
********************************************************************************
*** SYNTAX AND PRESERVE (IF NECESSARY)
********************************************************************************	
	syntax anything(id="Exchange rates" name=rates)


********************************************************************************
*** GET EXCHANGE RATES FROM USER COMMAND
********************************************************************************
	tempname exchange_data currency1 currency2 c1
	tokenize `rates'
	local `currency1' "`1'"
	local `currency2' "`2'"

********************************************************************************
*** IMPORT EXCHANGE RATE DATA
********************************************************************************
	tempfile exchange

	capture copy "http://www.google.com/ig/calculator?hl=en&q=``currency1''=?``currency2''" `exchange', replace
	file open `exchange_data' using `exchange', read
	file read `exchange_data' line
*	local answer=subinstr(`"`line'"', "{lhs: ","",1)
*	dis `"`answer'"'
*	local answer=subinstr(`"`answer'"', ",rhs:","=",1)
	dis in yellow `"`line'"'
*	dis in yellow `"`answer'"'


********************************************************************************
*** EXTRACT EXCHANGE RATE DATA
********************************************************************************
	set obs 1
	gen c1=regexs(0) if(regexm(`"`line'"', "([0-9]+)\.([0-9]+)"))
	gen c2=regexs(0) if(regexm(`"`line'"', "([0-9]+)\.([0-9]+)"))
	tab c1 c2
end



********************************************************************************
*** TO DO
********************************************************************************
* make rclass (see simulation code) so that exchange rate can be in rlist
* make option for data in memory
* add time-series data
* learn regular expressions to get the important information
