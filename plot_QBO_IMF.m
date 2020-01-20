figure
yyaxis left
plot(Time, IMF4)
%axis([1990 2013 -0.5*10e-12 0.5*10e-12])
ylabel('IMF4 OH 20hPa (monthly)')

yyaxis right
plot(QBO_time, QBO)
ylabel('QBO')
axis([1990 2013 -40 30])

xlabel('Year')