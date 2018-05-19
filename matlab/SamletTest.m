% Målinger med scope af samlet system

% Husk at RETTE ADRESSEN!
M = csvread('/home/jes/Dropbox/A_Elektronik_Ba/4. semester/Projekt/Målinger/Bode100 af hele systemet/Full system analysis_2018-05-09T12_14_21 (copy).csv');
x = M(:,1);
y = M(:,4);
tg = M(:,7);

% Så det bliver i ms i plot. 
for i = 1:numel(tg)
    tg(i) = tg(i) * 10^3;
end

fig1 = figure;
subplot(2,1,1);
semilogx(x,y,'Linewidth',2)
grid on

hold on
%title('Overføringsfunktionen for det samlede system')
ylabel('Amplitude [dB]')
xlabel('Frekvens [Hz]')
hold off

% Plot af gruppeløbtid
subplot(2,1,2);
semilogx(x,tg,'Linewidth',2)
grid on 

hold on 
ylabel('Gruppeløbetid [ms]')
xlabel('Frekvens [Hz]')
hold off

print( fig1, '-dpng', '-r300', 'tf_tg_samletsystem.png')