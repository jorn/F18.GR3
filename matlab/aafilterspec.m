format compact
close all
clear

fs = 44.1E3
fpass = 18E3
Omega_n = 2*pi*fpass
fstop = fs / 2
Kp = 3
Ks = 55
Krip = .1
n=6


[z,p,k] = cheb1ap(n, Krip);
[Hn_cheb1, Hd_cheb1] = zp2tf(z,p,k);
sos_cheb1 = zp2sos(z,p,k)
H_cheb1 = tf(Hn_cheb1, Hd_cheb1);
[h_cheb1, w_cheb1] = freqs(Hn_cheb1, Hd_cheb1,w);

H1 = tf(sos_cheb1(1,1:3),sos_cheb1(1,4:6))
H2 = tf(sos_cheb1(2,1:3),sos_cheb1(2,4:6))
H3 = tf(sos_cheb1(3,1:3),sos_cheb1(3,4:6))

Q1 = sqrt(sos_cheb1(1,6))/sos_cheb1(1,5)
Q2 = sqrt(sos_cheb1(2,6))/sos_cheb1(2,5)
Q3 = sqrt(sos_cheb1(3,6))/sos_cheb1(3,5)

w1 = sqrt(sos_cheb1(1,6))
w2 = sqrt(sos_cheb1(2,6))
w3 = sqrt(sos_cheb1(3,6))

C11_n = 2*Q1/w1
C21_n = 1/(2*Q1*w1)
C12_n = 2*Q2/w2
C22_n = 1/(2*Q2*w2)
C13_n = 2*Q3/w3
C23_n = 1/(2*Q3*w3)

format shortEng
%denormering
Zn = 10E3
C11 = C11_n / (Omega_n * Zn)
C21 = C21_n / (Omega_n * Zn)
C12 = C12_n / (Omega_n * Zn)
C22 = C22_n / (Omega_n * Zn)
C13 = C13_n / (Omega_n * Zn)    
C23 = C23_n / (Omega_n * Zn)
R = Zn

format short

H = H1*H2*H3;

figure;
subplot(2,1,1);
semilogx(w_cheb1*fpass,20*log10(abs(h_cheb1)))
grid on
axis([2E3 2E5 -70 0])

subplot(2,1,2);
groupDelaytf(H_cheb1);
grid;

