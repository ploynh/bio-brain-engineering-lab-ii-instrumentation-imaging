%% Prelab_4.3.2

f = [2500 4000];
a = [1 0];
dev = [(10^(37/20)/10^(40/20)) 10^(-55/20)];
fs = 10000;

% Parks-McClellan
[n,fo,ao,w] = firpmord(f, a, dev, fs)
b = firpm(n,fo,ao,w);
fvtool(b, 'polezero');

% Kaiser
[n,Wn,beta,ftype] = kaiserord(f, a, dev, fs)
b = fir1(n,Wn,ftype,kaiser(n+1,beta),'noscale');
fvtool(b, 'polezero');