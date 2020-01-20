%import IMF5 and IMF6 from .dat file before running
figure
%yyaxis left

to_plot = (IMF5 + IMF6) / mean(Raw) * 100;
plot(Time, to_plot)
%axis([1990 2013 -0.5*10e-12 0.5*10e-12])
ylabel('IMF5+6 OH 20hPa (monthly, b% from mean)')

%yyaxis right
%plot(QBO_time, QBO)
%ylabel('QBO')
%axis([1990 2013 -40 30])

xlabel('Year')

%now writing Raw and to_plot to ASCII file
fileID = fopen('OH_25S-25N_IMF5-6_20hPa.txt','w');
A = [Raw.'; to_plot.'];
fprintf(fileID, '%8s %18s\n', 'Raw', 'IMF5_6_Perc');
fprintf(fileID, '%1.5e %16.12f\n', A);
fclose(fileID);