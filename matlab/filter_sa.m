format compact
close all
clear

fs = 44.1E3
fpass = 18E3
fstop = 22.05E3

Rp = .1
Rs = 40
n = 6

f1 = logspace(10,fpass,1024);
%f2 = logspace(fpass,fstop,512);
f2 = 1E3:50:30E3

epsi = sqrt( 10^(Rp/10)-1 )
%C = cosh(n * acosh( f2./fpass ))
H_s = 1./(sqrt(1+epsi^2*(cosh(n * acosh( f2./fpass ))).^2))
H_a = 1./(sqrt(1+epsi^2*(cosh(n * acosh( (fs-f2)./fpass ))).^2))

fig1 = figure(1)
semilogx(f2,20*log10(abs(H_s)),'Linewidth',2)
axis([10E3 30E3 -50 0])
hold on
semilogx(f2,20*log10(abs(H_a)),'Linewidth',2)
legend('|H(f)|','|H(f-f_s)','Location','southeast')
xlabel({'f [Hz]'});
ylabel({'|H(f)| [dB]'});
grid
print( fig1, '-dpng', '-r300', 'filter_f_fs.png')

fig2 = figure(2)
yyaxis left
semilogx(f2, (H_a./H_s)*100,'Linewidth',2)
ylabel({'% aliasing'});
axis([10E3 22.05E3 0 50])
yyaxis right
semilogx(f2, 20*log10(H_a./H_s),'Linewidth',2)
ylabel({'aliasing [dB]'});
axis([10E3 22.05E3 -60 0])
legend('%SA','SA [dB]','Location','northwest')
xlabel({'f [Hz]'});
grid
print( fig2, '-dpng', '-r300', 'filter_sa.png')

