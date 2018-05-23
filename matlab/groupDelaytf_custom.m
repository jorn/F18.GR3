function groupDelay = groupDelaytf_custom(SYS,varargin)

freqScale = 'rad/s';

if nargin > 2
    disp('Too many input arguments!');
    groupDelay = [];
    return
elseif nargin > 1
    freqScale = varargin{1}; 
end
sk = 2*pi;
if strcmp(freqScale,'Hz') || strcmp(freqScale,'hz')
    sk = 1;
end 

[M,P,w] = bode(SYS);
w = linspace(w(1),w(end),length(w)*1000)/(sk);
[M,P] = bode(SYS,w*2*pi);
P = P(:)';
groupDelay = -gradient(P,w)/360;
grid on
semilogx(w*sk,groupDelay)
  
return