N=20; %number of nodes in x direction, same as number in y
Np1=N+1;
Nm1=N-1;
Np2=N+2;
Nm2=N-2;
h=2*pi/(Nm1); %delta x, delta y
dt=h^2/4; %delta t note: makes sequence converge faster??

x=-pi:h:pi; %there's a better way to do this
y=x;

%Initial Conditions:

phi=cos(pi.*(x+pi)).*cosh(pi-x); %BC at y=by
psi=(x+pi).^2.*sin(pi.*(x+pi)/(4*pi)); %BC at y=ay

UG=zeros(N,Np2,1); %preallocate

UG(1,2:Np1,1)=phi;
UG(N,2:Np1,1)=psi;

%Setting up the explicit method matrix
E_size=Np2*N;
E=zeros(E_size, E_size);

for i=2:Np1
    m=i+Np2*Nm1;
    E(i,i)=1;
    E(m,m)=1;
end

%numbers used to fill in for E
lambda=dt/(h^2);
a=1-4*lambda;

%B matrix will be used to fill in E
B_c=Np2*3;
B=zeros(Np2,B_c);
for i=2:Np1
    B(i,i)=lambda;
    mid=i+Np1;
    B(i,mid:(mid+2))=[lambda,a,lambda];
    B(i,i+2*Np2)=lambda;
end

%Filling in E:
for i=1:Nm2
    er=Np2*i+1;
    ec=er-Np2;
    E(er:er+Np1,ec:ec+3*Np2-1)=B; %ERROR WHEN CHANGING N to something other than 5 !!! FIX!!!!
end
for i=1:Nm2
    ii=i*Np2+1;
    E(ii,ii+1)=1;
    ik=ii+Np1;
    E(ik,ik-1)=1;
end
%Note: go back and use ones() to speed up this process

Uvec=zeros((N*Np2),1); % edit!!
for i=1:N
    Uvec(1+Np2*(i-1):i*Np2)=(UG(i,:));
end

i=1;
Uvec_Dif=1;
Max_Uvec_Dif=1;
ips=round(1/dt);
while Max_Uvec_Dif>0.00001 %stopping criteria
    i=i+1;
    Uvec(:,:,i)=E*Uvec(:,:,i-1);
    if i>ips
    Uvec_Dif=(Uvec(:,:,i)-Uvec(:,:,i-ips))./Uvec(:,:,i);
    Max_Uvec_Dif=abs(max(Uvec_Dif));
    end
end

t_final=i*dt;
UG_final=zeros(N,Np2);
for l=1:N
UG_final(l,:)=Uvec(1+Np2*(l-1):l*Np2,:,i);
end
U_final=UG_final(:,2:Np1);
%assess stopping criteria
%assess mesh size
%ghost node method
%optimize
%vectorize loops
%do the other method
%refine mesh