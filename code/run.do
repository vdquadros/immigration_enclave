clear
clear matrix
capture log close
set mem 2g
set more off
cd "/Users/victoriadequadros/projects/immigration_enclave/"

/* Need to run read_bartik before doing this. Read_bartik takes time, so I am not including it here.*/
run code/1980/np2.do
run code/1980/allnp2.do
run code/1980/cell1.do
run code/1980/t1.do
run code/1980/supply1.do
run code/1980/imm1.do
run code/1980/indist.do

run code/1990/np2.do
run code/1990/allnp2.do
run code/1990/cell1.do
run code/1990/t1.do
run code/1990/supply1.do
run code/1990/imm1.do
run code/1990/indist.do

run code/2000/np2.do
run code/2000/allnp2.do
run code/2000/cell1.do
run code/2000/t1.do
run code/2000/supply1.do
run code/2000/imm3.do
run code/2000/imm2.do
run code/2000/inflow3.do

do code/table6.do 
