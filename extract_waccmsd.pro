yearband = '2012_2013'
varwant  = 'U'
varwant  = 'V'
varwant  = 'T'
varwant  = 'NO'
varwant  = 'NO2'
varwant  = 'N2O'
varwant  = 'HNO3'
varwant  = 'CLO'
varwant  = 'HO2'

varwant  = 'CO'
varwant  = 'O3'
varwant  = 'H2O'
varwant  = 'O'
varwant  = 'H'
;**********************************************************
dir      = '/mnt/cidstore2/stripe/data/var/'+yearband+'/'
filebase = 'FSDW.cam.h1'
filearr  = findfile(dir+filebase+'.*')
nf       = n_elements(filearr)
varx     = varwant+',hyam,hybm,PS,date '

for ff = 0, nf-1 do begin
   chop     = strsplit(filearr[ff],'/', /extract)
   chop     = strsplit(chop[n_elements(chop)-1],'.', /extract)
   fileout  = chop[0]+'.'+chop[1]+'.'+chop[2]+'.'+varwant+'.'+chop[3]+'.nc'
   command  = 'ncks -v '+varx+ filearr[ff]+' '+fileout
   spawn, command
   if (ff mod 20) then print, fileout
endfor
end
