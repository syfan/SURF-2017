% This script will extract data from a .nc file that is specified within
% the program along the latitudes and longitudes specified
clc;
clear;
% this is the file we will extract from.  Change directories as needed
ncfile = 'FSDW.cam.h1.O3.2009-10-01-00000.nc';
ncid = netcdf.open(ncfile, 'NC_WRITE');
% change type of data as needed
type = 'PS';
% specify index of starting lat/lon
data = ncread(ncfile, type, [1 1 1], [Inf Inf Inf], [2 2 2]);
data1 = data(:,:,1);
lats = ncread(ncfile, 'lat');

FFT = fft(data1);
%P = abs(FFT);
surf(abs(FFT))

