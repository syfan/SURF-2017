%function MAIN

% NetCDF file containing 10-50 hPa mean temperature %
ncfile = '/home/fusi_rd1/kfl/models/clim/waccm/vlimp/preprocessT/limpasuvan_waccm_meanT.nc';

% Display its content using the UNIX tool ncdump %
% You can try the same command in UNIX %
unix(['ncdump -h ' ncfile]);

% Extract the data from the NetCDF file %
lon = ncread(ncfile,'lon');
lat = ncread(ncfile,'lat');
time= ncread(ncfile,'time');
T   = ncread(ncfile,'temperature');

% The dimension of T is [lon, lat, time]
size(T)
size(lon)
size(lat)
size(time)

% Remove the seasonal cycle of temperature %
Tanom = demonth(time,T);

% Equatorial average over latitude between 15S and 15N%
Teq = bndavg3(lat,Tanom,[-15,15]);


% This file is located in the following directory:
% /home/ganesha_rd2/kfl/lib/idl/kfl/atmos/qbo/example/Singapore_U_30hPa.txt
fileID = fopen('Singapore_U_30hPa.txt');
formatSpec = '%f %f';
sizeA = [2 Inf];
% reading in data
QBO = fscanf(fileID, formatSpec, sizeA);
QBO = QBO.';

% cut out QBO data before 1990
QBO([1:443] ,:) = [];

% cut out QBO data after 2012
QBO([277:end], :) = [];


% Plot the equatorial average
initplot('Teq+QBO');  % Prepare the figure space
subplot(2,1,1)
plot(time,Teq, 'b');
xlabel('Year');
ylabel('Temperature (K)');
subplot(2,1,2)
plot(QBO(:,1), QBO(:,2), 'r');
axis([1990 2015 -40 20]);
xlabel('Year');
ylabel('QBO wind speed (m/s)');
closeplot(0);     % Save the plot as a PDF
% Use Filezilla to download the figure

% Arctic average over latitude between 65S and 90N %
Tnp = bndavg3(lat,Tanom,[65,90]);

% Plot the Arctic average
initplot('Tnp+QBO');  % Prepare the figure space
subplot(2,1,1)
plot(time,Tnp, 'b');
xlabel('Year');
ylabel('Temperature (K)');
subplot(2,1,2)
plot(QBO(:,1), QBO(:,2), 'r');
axis([1990 2015 -40 20]);
xlabel('Year');
ylabel('QBO wind speed (m/s)');
closeplot(0);     % Save the plot as a PDF
% Use Filezilla to download the figure

