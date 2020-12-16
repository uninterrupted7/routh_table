function p_controller(TransferFunction,settlingTime, overshoot)

Gs = TransferFunction;
Ts = feedback(Gs,1);

syms s k;

Gss = 1 / (s^2 + 8*s + 15);
Tss = (k*Gss) / (1+k*Gss);
%pretty(simplify(Tss));

%settling time 1 sn
ts = settlingTime;
syms wn;
os = overshoot;
zeta = -log(os) / sqrt(pi^2+log(os)^2) ;
%zeta = 4 / (wn*ts);

[n, d] = numden(Tss);

n = coeffs(n,s,'all');
d = coeffs(d,s,'all');

pds = s^2 + 2*s*wn*zeta + wn^2;
pds = coeffs(pds,s,'all');

prob=d==pds;

sol = solve(d==pds);

kv=double(sol.k);
wnv=double(sol.wn);

Ts = feedback(kv*Gs, 1);
figure(1);
step(Ts)

figure(2);
pzmap(Ts);
sgrid(zeta,[1:wnv]);

figure(3);
rlocus(Gs,0:0.1:kv*1.5);
sgrid(zeta,[1:wnv]);
    

end