//Condensador corrección FP
//Armonicos 2 pregunta 10
L=0.04//bobina henrios
RL=1
w=2*%pi*50;
C=(w*(RL^2+(w*L)^2)^0.5)^-1;
Rlinea=1;
R2=10;
V1=330;
I5=10;
//aplicamos superposición
//I5=0.
ZL2=RL+w*L*%i;
ZC=1/(w*C*%i);
//paralelo del condensador y la bobina
ZCL=ZL2*ZC/(ZL2+ZC);
Zcarga=ZCL*R2/(ZCL+R2);
Ztotal=Rlinea+Zcarga;
Ilinea1=V1/Ztotal;

//La tensión Vac2.
Vac1=V1-Ilinea1*Rlinea;
IL1=Vac1/ZL2;
IR1=Vac1/R2;
IC1=Vac1/ZC;

//aplicamos superposición
//V1=0
ZL5=RL+5*w*L*%i;
ZC5=1/(5*w*C*%i);
//paralelo del condensador y la bobina
ZCL5=ZL5*ZC5/(ZL5+ZC5);
Zcarga5=ZCL5*R2/(ZCL5+R2);
Ztotal5=Zcarga5*Rlinea/(Rlinea+Zcarga5);
//La tensión Vac2.
Vac5=-I5*Ztotal5;
IL5=Vac5/ZL5;
IR5=Vac5/R2;
IC5=Vac5/ZC5;
Ilinea5=Vac5/Rlinea;

//calculamos factor de potencia

//Ilinea rms

[Ilinea1_pico,F]=polar(Ilinea1);
[Ilinea5_pico,F]=polar(Ilinea5);
[Vac1_pico,F]=polar(Vac1);
[Vac5_pico,F]=polar(Vac5);


ILinearms=((Ilinea1_pico^2+Ilinea5_pico^2)*0.5)^0.5;
Vlinearms=((Vac1_pico^2+Vac5_pico^2)*0.5)^0.5;
//Calculamos la potencia en cada componente ya que conocemos
//La corriente y la tensión.
Potencia_1=(real(Vac1*0)+real(Vac1*conj(IL1))+real(Vac1*conj(IR1))+..
real(Vac1*conj(IC1)))/2;
Potencia_5=(real(Vac5*conj(I5))+real(Vac5*conj(IL5))+real(Vac5*conj(IR5))+..
real(Vac5*conj(IC5)))/2;
//La potencia media total es la suma de potencias
Potencia_media=Potencia_1+Potencia_5


//Factor de potencia con armónicos
FPcon=Potencia_media/(ILinearms*Vlinearms)
FPsin=Potencia_1/(Ilinea1_pico*Vac1_pico/2)

mprintf('El factor de potencia teniendo en cuenta los armónicos es %f\n',FPcon);
mprintf('El factor de potencia teniendo debido a la fundamental es %f\n',FPsin);
mprintf('La potencia total consumida por la carga es %f\n',Potencia_media);
mprintf('La corriente de linea es %f\n',ILinearms);
mprintf('la tensión de linea es %f\n',Vlinearms);

//El condensador corrige la energía reactiva debida a la bobina.
