clc;clear all;close all;
w=2; 
a=0.05;
b=5; 
c=50; 
dlt_t=0.001;
tiempo=(20/dlt_t); 
t=0:dlt_t:tiempo*dlt_t;

alfa=0:dlt_t:tiempo*dlt_t;
phi=0:dlt_t:tiempo*dlt_t;
phi_p=0:dlt_t:tiempo*dlt_t;
h=0:dlt_t:tiempo*dlt_t;
u=linspace(0,dlt_t,tiempo+1);

%condiciones iniciales
alfa(1)=3; phi(1)=0.01; i=1; color='g';
u(1)=0.9; 

%Version linealizada en el equilibrio estable.
Mat_A=[-a a 0 0; 0 0 1 0; w^2 -w^2 0 0; c 0 0 0];
Mat_B=[0;0;b*w^2;0]; 
x0=[0 0 0 0]';
x=[alfa(1);phi(1);phi_p(1);h(1)];

while(i<(tiempo+1))   
%Variables del sistema no lineal
%estado=[alfa(i);phi(i);phi_p(i);h(i)];
u(i)=1;

alfa_p=a*(phi(i)-alfa(i));
phi_pp=-w^2*(phi(i)-alfa(i)-(b*u(i)));
h_p=c*alfa(i);

%Completar las derivadas que faltan 
alfa(i+1)=alfa(i)+dlt_t*alfa_p;
phi_p(i+1)=phi_p(i)+dlt_t*phi_pp;
phi(i+1)=phi(i)+dlt_t*phi_p(i);
h(i+1)=h(i)+dlt_t*h_p;

%Variables del sistema lineal
alfa1(i)=x(1);phi1(i)=x(2);phi_p1(i)=x(3);h1(i)=x(4);

%Sistema lineal
xp=Mat_A*(x-x0)+Mat_B*u(i);
x=x+dlt_t*xp; 
i=i+1;
end

alfa1(i)=x(1); phi1(i)=x(2); phi_p1(i)=x(3); h1(i)=x(4);
figure(1);hold on;

subplot(5,1,1);
plot(t,alfa,color);hold on;plot(t,alfa1,'k');
grid on; title('Angulo de trayectoria de vuelo');hold on;

subplot(5,1,2);
plot(t,phi,color);hold on;plot(t,phi1,'k');
grid on; title('Angulo de cabeceo');hold on;

subplot(5,1,3); 
plot(t,phi_p,color); hold on;plot(t,phi_p1,'k');
grid on; title('Velocidad angulo de cabeceo'); hold on;

subplot(5,1,4);
plot(t,h,'or');hold on;plot(t,h1,'+k');
grid on;title('Altura'); hold on;

subplot(5,1,5);
plot(t,u,color);grid on;title('Accion de control');
xlabel('Tiempo en seg.');hold on;

