varwant  = 'T'
;varwant  = 'NO2'
;varwant  = 'CO2'
;varwant  = 'O3'
;varwant  = 'OH'
;varwant  = 'HO2'
varwant  = 'H2O'
;**********************************************************
dir      = '/mnt/cidstore1/data1/science_1/var/WACCMSD/h1/'
filebase = 'wa4_cesm1_1_b02_geos5_2x_sim153f.cam2.h1'
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
