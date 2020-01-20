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

% Plot the average
initplot('Singapore_QBO_30hPa');  % Prepare the figure space
subplot(2,1,1)
plot(QBO(:,1), QBO(:,2));
title('Singapore QBO at 30 hPa');
xlabel('Year');
ylabel('Zonal wind (m/s)');
closeplot(0);     % Save the plot as a PDF
% Use Filezilla to download the figure