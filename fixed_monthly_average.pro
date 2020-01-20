PRO monthly_average

;restore, filename='1990-2011_WACCM_OH_lat25S25N_lon171_219.sav'
restore, filename='OH_series_backup_2hPa.sav'
;daily_series = data_all[*,19]
daily_series = output_array[1,*]
monthly_avg = findgen(266)
total = 0
FOR i = 0, 7969 DO BEGIN
   total = total + daily_series[i]
   IF (((i + 1) MOD 30) EQ 0) AND (((i + 1) MOD 30) LT 267) THEN BEGIN
      monthly_avg[FIX((i + 1) / 30)- 1] = total / 30.4
      total = 0
   ENDIF
ENDFOR
time_series = findgen(266)

counter = 0
FOR i = 1990, 2011 DO BEGIN
   FOR j = 1, 12 DO BEGIN
      IF (counter LT 266) THEN BEGIN
         time_series[counter] = i + (FLOAT(j) / 12)
         counter = counter + 1
      ENDIF
   ENDFOR
ENDFOR

monthly_avg = TRANSPOSE(monthly_avg)
time_series = TRANSPOSE(time_series)
output_array = [time_series, monthly_avg]

fname = 'avg_time_series_OH_2hPa.dat'
OPENW,1,fname
PRINTF,1,output_array, FORMAT='(F7.2,1X,E13)'
CLOSE,1

RETURN
END
