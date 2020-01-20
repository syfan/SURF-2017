%function MAIN2

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
dtime = time(2) - time(1);
nf = 2^nextpow2(numel(time));
newY = fft(Teq, nf);
newTime = 1/dtime*[0:nf/2 (nf/2-1):-1:1]'/nf;
ret = abs(newY);


% Plot the equatorial average
initplot('Teq-FFT');  % Prepare the figure space
subplot(2,1,1)
plot(newTime,ret);
xlabel('Frequency (cycles/year)');
ylabel('|FFT|');
axis([0 2 0 5000]);
closeplot(0);     % Save the plot as a PDF
% Use Filezilla to download the figure

% Arctic average over latitude between 65S and 90N %
Tnp = bndavg3(lat,Tanom,[65,90]);

dtime = time(2) - time(1);
nf = 2^nextpow2(numel(time));
newY = fft(Tnp, nf);
newTime = 1/dtime*[0:nf/2 (nf/2-1):-1:1]'/nf;
ret = abs(newY);

% Plot the Arctic average
initplot('Tnp-FFT');  % Prepare the figure space
subplot(2,1,1)
plot(newTime,ret);
xlabel('Frequency (cycles/year)');
ylabel('|FFT|');
axis([0 2 0 5000]);
closeplot(0);     % Save the plot as a PDF
% Use Filezilla to download the figure

