format compact
close all
clear

% graph diff between 6 and 8 order butterworth, bessel, chebychev type 1 and 2

fs = 44.1E3
fpass = 18E3
Rp = .1
Rs = 40
n = 6

w = logspace(-1,1,1024);

% Butterworth
[z,p,k] = buttap(n);
[Hn_but, Hd_but] = zp2tf(z,p,k);
[h_but, w_but] = freqs(Hn_but, Hd_but,w);
H_but = tf(Hn_but, Hd_but);

% Chebychev type 1
[z,p,k] = cheb1ap(n, Rp);
[Hn_cheb1, Hd_cheb1] = zp2tf(z,p,k);
[h_cheb1, w_cheb1] = freqs(Hn_cheb1, Hd_cheb1,w);
H_cheb1 = tf(Hn_cheb1, Hd_cheb1);

% Chebychev type 2
[z,p,k] = cheb2ap(n, Rs);
[Hn_cheb2, Hd_cheb2] = zp2tf(z,p,k);
[h_cheb2, w_cheb2] = freqs(Hn_cheb2, Hd_cheb2,w);
H_cheb2 = tf(Hn_cheb2, Hd_cheb2);

% Bessel
[z,p,k] = besselap(n);
[Hn_bes, Hd_bes] = zp2tf(z,p,k);
[h_bes, w_bes] = freqs(Hn_bes, Hd_bes,w);
H_bes = tf(Hn_bes, Hd_bes);


figure;
subplot(2,1,1);
semilogx(w_but,20*log10(abs(h_but)))
hold on
semilogx(w_cheb1,20*log10(abs(h_cheb1)))
semilogx(w_cheb2,20*log10(abs(h_cheb2)))
semilogx(w_cheb2,20*log10(abs(h_bes)))
axis([1E-1 10 -70 0])
grid on
legend('Butterworth', 'Chebychev 1', 'Chebychev 2');

subplot(2,1,2);

groupDelaytf(H_but);
axis([1E-1 10 -2 15])
hold on
groupDelaytf(H_cheb1);
groupDelaytf(H_cheb2);
groupDelaytf(H_bes);

grid on