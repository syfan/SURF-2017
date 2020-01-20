%function MAIN3

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

% Plot the equatorial average
initplot('Teq');  % Prepare the figure space
subplot(2,1,1)
plot(time,Teq);
xlabel('Year');
ylabel('Temperature (K)');
closeplot(0);     % Save the plot as a PDF
% Use Filezilla to download the figure

fileID = fopen('teq.txt', 'w');

A = [time.'; Teq];
fprintf(fileID, '%8s %12s\n', 'time', 'teq');
fprintf(fileID, '%16.12f %12.8f\n', A);
fclose(fileID);

% Arctic average over latitude between 65S and 90N %
Tnp = bndavg3(lat,Tanom,[65,90]);


% Plot the Arctic average
initplot('Tnp');  % Prepare the figure space
subplot(2,1,1)
plot(time,Tnp);
xlabel('Year');
ylabel('Temperature (K)');
closeplot(0);     % Save the plot as a PDF
% Use Filezilla to download the figure

fileID = fopen('tnp.txt', 'w');

A = [time.'; Tnp];
fprintf(fileID, '%8s %12s\n', 'time', 'tnp');
fprintf(fileID, '%16.12f %12.8f\n', A);
fclose(fileID);

