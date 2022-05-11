clear all;clc;
X=-[0; 0];i=0;t_etapa=.1e-6;tF=2e-3;
t=0:t_etapa:tF;
u=12;
% u=12*square(2*pi*500*t);
for n=0:t_etapa:tF
    if i*t_etapa>1e-3
        u=-12;
    end
    i=i+1;
    X=modrlc3(t_etapa, X, u);
    x1(i)=X(1);%IL
    x2(i)=X(2);%Vc
    acc(i)=u;
end
subplot(3,1,1);hold on;
plot(t,x1,'g');title('Corriente inductor IL');

subplot(3,1,2);hold on;
plot(t,x2,'g');title('Tension capacitor Vc');
xlabel('Tiempo [Seg.]');

subplot(3,1,3);hold on;
plot(t,acc,'g');title('Tension entrada Vi');