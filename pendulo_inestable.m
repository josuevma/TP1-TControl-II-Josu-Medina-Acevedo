clc;clear all;close all;
m=.1;
F=0.1; 
long=0.6;
g=9.8;
M=.5;
dlt_t=0.0001;
tiempo=(10/dlt_t);
t=0:dlt_t:tiempo*dlt_t;

del_pp=0;
phi_pp=0; 
phi_p=0:dlt_t:tiempo*dlt_t;
phi=0:dlt_t:tiempo*dlt_t; 
del=0:dlt_t:tiempo*dlt_t;
del_p=0:dlt_t:tiempo*dlt_t; 
u=linspace(0,0,tiempo+1);

%Condiciones iniciales
phi(1)=pi-0.8; color='r';
del(1)=0; del_p(1)=0; u(1)=0; del(1)=0; i=1;

%Version linealizada en el equilibrio estable
%estado=[del(i); del_p(i); phi(i); phi_p(i)]
Mat_A=[0 1 0 0;0 -F/M -m*g/M 0; 0 0 0 1; 0 F/(long*M) g*(m+M)/(long*M) 0]
Mat_B=[0; 1/M; 0; -1/(long*M) ]
X0=[0 0 0 0]';x=[0 0 phi(1) 0]';

while(i<(tiempo+1))
%Variables del sistema no lineal
estado=[del(i); del_p(i); phi(i); phi_p(i)];
u(i)=0;

%Sistema no lineal
del_pp=(1/(M+m))*(u(i)-m*long*phi_pp*cos(phi(i))+m*long*phi_p(i)^2*sin(phi(i))-F*del_p(i));
phi_pp=(1/long)*(g*sin(phi(i))-del_pp*cos(phi(i)));
del_p(i+1)=del_p(i)+dlt_t*del_pp;
del(i+1)=del(i)+dlt_t*del_p(i);
phi_p(i+1)=phi_p(i)+dlt_t*phi_pp;
phi(i+1)=phi(i)+dlt_t*phi_p(i);

%Variables del sistema lineal
dell(i)=x(1); del_pl(i)=x(2);phil(i)=x(3);phi_pl(i)=x(4);

%Sistema lineal
xp=Mat_A*(x-X0)+Mat_B*u(i);
x=x+dlt_t*xp;
i=i+1;

end

dell(i)=x(1); del_pl(i)=x(2);phil(i)=x(3);phi_pl(i)=x(4);

figure(1);hold on;

subplot(3,2,1); 
plot(t,del,color);grid on;title('Posicion carro');
hold on;plot(t,dell,'k');

subplot(3,2,2);
plot(t,del_p,color);grid on;title('Velocidad carro');
hold on;plot(t,del_pl,'k');

subplot(3,2,3);
plot(t,phi,color);hold on;plot(t,pi*ones(size(t)),'k');plot(t,phil,'k');
grid on;title('Posicion angulo');hold on;

subplot(3,2,4);
plot(t,phi_p,color);grid on; title('Velocidad angulo');
hold on;plot(t,phi_pl,'k');

subplot(3,1,3);
plot(t,u,color);grid on;title('Accion de control');xlabel('Tiempo en Seg.');
hold on;