format compact
close all
clear

% Målinger med scope af samlet system

% Husk at RETTE ADRESSEN!
M = csvread('//home/jes/Dropbox/A_Elektronik_Ba/4. semester/Projekt/Målinger/Bode 100 af AA filter/AA_filter_v1 (copy).0.csv');
x = M(:,1);
y = M(:,4);
tg = M(:,7);

fig1 = figure;
semilogx(x,y,'Linewidth',2)
ylim([-100 5]);
grid on

hold on
%title('Amplitude-karakteristik for anti-aliasing filter')
ylabel('Amplitude [dB]')
xlabel('Frekvens [Hz]')
hold off

print(fig1, '-dpng', '-r300', 'tf_AAfilter.png')

% Plot af gruppeløbtid
%semilogx(x,tg)
%grid on 

%hold on 
%ylabel('Gruppeløbetid [ms]')
%xlabel('Frekvens [Hz]')
%hold off