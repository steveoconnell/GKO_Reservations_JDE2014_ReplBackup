version 11.0
dis "$root"
assert "$root" !="" //assert root capture worked for user
global data "$root/1data/"
global do "$root/2progs/"
global figures "$root/3figures/"
global work "$root/4work/"
global intdata "$root/5intdata/"
global finaldata "$root/6finaldata/"
global date=c(current_date)
global time=subinstr(c(current_time),":","",.)
cd "$work" //default directory to put files, although all outputs should be directed via a global macro
set seed 99
set mem 2g, perm

