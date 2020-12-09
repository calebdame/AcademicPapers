clear 
cd "C:\Users\caleb\Desktop\econ484\488"
import delim ldata.csv
egen num_state = group(state)
gen lincome = log(medianincome)

gen cprec = colpremiums / population
gen cexpc = colexposures / population
gen lprec = liabpremiums / population
gen lexpc = liabexposures / population
gen lavpre = liabpremiums / liabexposures

tsset num_state year

tabulate state, generate(dum)
gen changed = (year>=2003) 
gen did = changed*dum1
gen year1  = (year==1994)
gen year2  = (year==1995)
gen year3  = (year==1996)
gen year4  = (year==1997)
gen year5  = (year==1998)
gen year6  = (year==1999)
gen year7  = (year==2000)
gen year8  = (year==2001)
gen year9  = (year==2002)
gen year10  = (year==2003)
gen year11 = (year==2004)
gen year12  = (year==2005)
gen year13  = (year==2006)
gen year14  = (year==2007)
gen year15  = (year==2008)
gen year16  = (year==2009)
gen year17  = (year==2010)
gen year18 = (year==2011)
gen year19  = (year==2012)
gen year20  = (year==2013)
gen year21  = (year==2014)
gen year22  = (year==2015)


// all 4 regressions
// all prem
reg liabpremiums did changed lim1 lim2 lim3 population medianincome lincome dum1 dum2 dum3 dum4 dum5 dum6 dum7 dum8 dum9 dum10 dum11 dum12 year1 year2 year3 year4 year5 year6 year7 year8 year9 year10 year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22, vce(cluster state)

//remove lincome / lim3
reg liabpremiums did changed lim1 lim2 population medianincome dum1 dum2 dum3 dum4 dum5 dum6 dum7 dum8 dum9 dum10 dum11 dum12 year1 year2 year3 year4 year5 year6 year7 year8 year9 year10 year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22, vce(cluster state)

// all exp
reg liabexposures did changed lim1 lim2 lim3 population medianincome lincome dum1 dum2 dum3 dum4 dum5 dum6 dum7 dum8 dum9 dum10 dum11 dum12 year1 year2 year3 year4 year5 year6 year7 year8 year9 year10 year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22, vce(cluster state)

// remove lincome medianincome and lim3
reg liabexposures did changed lim1 lim2 population dum1 dum2 dum3 dum4 dum5 dum6 dum7 dum8 dum9 dum10 dum11 dum12 year1 year2 year3 year4 year5 year6 year7 year8 year9 year10 year11 year12 year13 year14 year15 year16 year17 year18 year19 year20 year21 year22, vce(cluster state)

//  run synth for model 1
tempfile keepfile1
synth_runner lprec lprec cprec, trunit(1) trperiod(2003) pre_limit_mult(5) trends keep(`keepfile1')
merge 1:1 num_state year using `keepfile1', nogenerate
single_treatment_graphs, trlinediff(-1) raw_gname(lprec) 

// reset
clear 
cd "C:\Users\caleb\Desktop\econ484\488"
import delim ldata.csv
egen num_state = group(state)
gen cprec = colpremiums / population
gen cexpc = colexposures / population
gen lprec = liabpremiums / population
gen lexpc = liabexposures / population
gen lavpre = liabpremiums / liabexposures
tsset num_state year
tabulate state, generate(dum)

//  run synth for model 2
tempfile keepfile2
synth_runner lprec lprec cprec lexpc, trunit(1) trperiod(2003) pre_limit_mult(5) trends keep(`keepfile2')
merge 1:1 num_state year using `keepfile2', nogenerate
single_treatment_graphs, trlinediff(-1) raw_gname(lprec) 

// reset
clear 
cd "C:\Users\caleb\Desktop\econ484\488"
import delim ldata.csv
egen num_state = group(state)
gen cprec = colpremiums / population
gen cexpc = colexposures / population
gen lprec = liabpremiums / population
gen lexpc = liabexposures / population
gen lavpre = liabpremiums / liabexposures
tsset num_state year
tabulate state, generate(dum)

//  run synth for model 3
tempfile keepfile3
synth_runner lexpc lexpc cexpc, trunit(1) trperiod(2003) trends keep(`keepfile3')
merge 1:1 num_state year using `keepfile3', nogenerate
single_treatment_graphs, trlinediff(-1) raw_gname(lprec) 

// reset
clear 
cd "C:\Users\caleb\Desktop\econ484\488"
import delim ldata.csv
egen num_state = group(state)
gen cprec = colpremiums / population
gen cexpc = colexposures / population
gen lprec = liabpremiums / population
gen lexpc = liabexposures / population
gen lavpre = liabpremiums / liabexposures
tsset num_state year
tabulate state, generate(dum)

//  run synth for model 4
tempfile keepfile4
synth_runner lexpc lexpc cexpc lprec, trunit(1) trperiod(2003) pre_limit_mult(5) trends keep(`keepfile4')
merge 1:1 num_state year using `keepfile4', nogenerate
single_treatment_graphs, trlinediff(-1) raw_gname(lprec) 



