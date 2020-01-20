% This script will extract data from a .nc file that is specified within
% the program along the latitudes and longitudes specified
clc;
clear;
% this is the file we will extract from.  Change directories as needed
ncfile = 'FSDW.cam.h1.O3.2009-10-01-00000.nc';
ncid = netcdf.open(ncfile, 'NC_WRITE');
% change type of data (variable) as needed
type = 'O3';
% specify index of starting lat/lon
latStart = 60;
lonStart = 1;
data = ncread(ncfile, type, [1 1 latStart lonStart], [Inf Inf Inf Inf], [2 2 2 2]);
lats = ncread(ncfile, 'lat');

lats(1:60) = [];
lons = ncread(ncfile, 'lon');
% this is the name of the output file, change as needed
newname = 'output.nc';
% modify the numbers for dimensions as needed
% creating the new variables here
nccreate(newname, type, 'Dimensions', {'time', Inf, 'lev', 88, 'lat', 36, 'lon', 144});
nccreate(newname, 'lat', 'Dimensions', {'lat', 36});
nccreate(newname, 'lon', 'Dimensions', {'lon', 144});
% now writing the data
ncwrite(newname, 'lat', lats);
ncwrite(newname, 'lon', lons);
ncwrite(newname, type, data);
% close the file; we're done
netcdf.close(ncid);
