format compact
close all
clear

% graph diff between 6 and 8 order butterworth, bessel, chebychev type 1 and 2

fs = 44.1E3
fpass = 18E3
fstop = 22.05E3
Rp = .1
Rs = 40
n = 6

w = logspace(-pi,pi,1024);

% Chebychev type 1
[z,p,k] = cheb1ap(n, Rp)
[Hn_cheb1, Hd_cheb1] = zp2tf(z,p,k)
[h_cheb1, w_cheb1] = freqs(Hn_cheb1, Hd_cheb1,w);
H_cheb1 = tf(Hn_cheb1, Hd_cheb1)

fig1 = figure;
subplot(2,1,1);
semilogx(fpass*w_cheb1,20*log10(abs(h_cheb1)),'Linewidth',2)
axis([1E2 10E4 -60 0])
grid on
xlabel({'f [Hz]'});
ylabel({'|H(f)| [dB]'});
%legend('Butterworth', 'Chebychev I', 'Chebychev II', 'Bessel','Location','southwest');

subplot(2,1,2);
axis([1E2 10E4 -2 15])
gd = groupDelaytf(H_cheb1);
grid on
xlabel({'f [Hz]'});
ylabel({'D(f) [s]'});
%legend('Butterworth', 'Chebychev I', 'Chebychev II', 'Bessel');

print( fig1, '-dpng', '-r300', 'filter_cheb1_denorm.png')

% pkt ved 22.05 kHz
epsi = sqrt( 10^(Rp/10)-1 )
C = cosh(n * acosh( 30E3/fpass ))
H_stop = 1/(sqrt(1+epsi^2*C^2*(30E3/fpass)))