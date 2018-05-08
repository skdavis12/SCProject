function [U,Uexact,x,y,h,dt]=implicit_ms(N,dt,tf)
% This function performs the method of manufactured solutions in order to
% verify the explicit discretization method model for the 2D diffusion equation.
% Given the inputs:
%     N ~ number of nodes in x and y
%     dt ~ time step
%     tf ~ time at which U must be approximated
% The function will return:
%     U ~ U(x,y,tf) approximated by model
%     Uexact ~ analytical solution of U(x,y,tf) 
%     x ~ vector of discretized x
%     y ~ vector of discretized y
%     h ~ dx = dy
%     dt
% Where:
%         U(x,y,t)=e^(-t/2)*( sin(x)+sin(y) ) 
%         -pi < y < pi
%         -pi < x < pi
%         U(x,y,0)=sin(x)+sin(y)
%         A(v,t)=e^(-t/2) *(sin(v)+sin(-pi))
%         U(x,y=-pi,t)=A(x,t)
%         U(x,y=pi,t)=A(x,t)
%         U(x=pi,y,t)=A(y,t)
%         U(x=-pi,y,t)=A(y,t)

Nm1=N-1;
Nm2=N-2;
h=2*pi/(Nm1);
x=-pi:h:pi;
y=x;
[X,Y]=meshgrid(x,y);
%Initial Condition:
U(:,:,1)=sin(X)+sin(Y);

lambda=dt/(h^2);
a=1+4*lambda; %major diagonal
isize=Nm2*Nm2;
I=eye(isize,isize)*a;

%minor diagonals:
for i=0:N-3
    for j=1:N-3
        k=i*Nm2+j;
        I(k,k+1)=-lambda;
        I(k+1,k)=-lambda;
    end
end

B=eye(isize-Nm2,isize-Nm2)*-lambda;
I(1:isize-Nm2,Nm2+1:isize)=I(1:isize-Nm2,Nm2+1:isize)+B;
I(Nm2+1:isize,1:isize-Nm2)=I(Nm2+1:isize,1:isize-Nm2)+B;

Uvec=zeros(isize,1); 
for i=1:Nm2
    Uvec((i-1)*Nm2+1:i*Nm2)=U(i+1,2:Nm1);
end
Fvec=zeros(isize,1);

i=1;
for t=dt:dt:tf
    A=exp(-(t)/2)*(sin(x)+sin(-pi));
    B=exp(-(t)/2)*(sin(x)+sin(pi));
    BCvec=zeros(isize,1);
    BCvec(1:Nm2)=A(2:Nm1);
    BCvec(isize-(N-3):isize)=B(2:Nm1);
    for ii=0:N-3
        k=ii*(Nm2)+1;
        j=Nm2*(ii+1);
        BCvec(k)=BCvec(k)+A(ii+2);
        BCvec(j)=BCvec(j)+B(ii+2);
    end
    F=(-exp(-(t)/2)/2)*(sin(X)+sin(Y))+exp(-(t)/2)*sin(X)+exp(-(t)/2)*sin(Y);
    for ii=1:Nm2
        Fvec((ii-1)*Nm2+1:ii*Nm2)=F(ii+1,2:Nm1);
    end
    i=i+1;
    Uvec(:,:,i)=I\(Uvec(:,:,i-1)+lambda*BCvec+dt*Fvec);
end

Uexact=exp(-t/2)*(sin(X)+sin(Y));
U=Uexact;
for ii=1:Nm2
    U(ii+1,2:Nm1)=Uvec((ii-1)*Nm2+1:ii*Nm2,:,i);
end
end
