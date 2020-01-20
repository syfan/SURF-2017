% This script reads in a matrix of two columns containing
% data for QBO and plots its time series.


% This file is located in the following directory:
% /home/ganesha_rd2/kfl/lib/idl/kfl/atmos/qbo/example/Singapore_U_30hPa.txt
fileID = fopen('Singapore_U_30hPa.txt');
formatSpec = '%f %f';
sizeA = [2 Inf];
% reading in data
QBO = fscanf(fileID, formatSpec, sizeA);
QBO = QBO.';

% cut out data before 1990
QBO([1:443] ,:) = [];

% cut out data after 2012
QBO([277:end], :) = [];

time = QBO(:,1);
QBO = QBO(:,2);

dtime = time(2) - time(1);
nf = 2^nextpow2(numel(time));
newY = fft(QBO, nf);
newTime = 1/dtime*[0:nf/2 (nf/2-1):-1:1]'/nf;
ret = abs(newY);

% Plot the average
initplot('Singapore_QBO_30hPa_FFT');  % Prepare the figure space
figure
subplot(2,1,1)
plot(newTime, ret);
title('Singapore QBO at 30 hPa FFT');
xlabel('Frequency (cycles/year)');
ylabel('|FFT|)');
axis([0 2 0 5000]);

%closeplot(0);     % Save the plot as a PDF
% Use Filezilla to download the figure