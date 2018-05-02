N=10; %number of nodes in x direction, same as number in y
Np1=N+1;
Nm1=N-1;
Np2=N+2;
Nm2=N-2;
h=2*pi/(Nm1); %delta x, delta y
dt=h^2/9; %delta t note: makes explicit sequence converge faster??
%is deltat the right size for convergence with implicit?

x=-pi:h:pi; %there's a better way to do this
y=x;

%Initial Conditions:

phi=cos(pi.*(x+pi)).*cosh(pi-x); %BC at y=by
psi=(x+pi).^2.*sin(pi.*(x+pi)/(4*pi)); %BC at y=ay

UG=zeros(N,Np2,1); %preallocate

UG(1,2:Np1,1)=phi;
UG(N,2:Np1,1)=psi;

%Setting up the implicit method matrix
I_size=Np2*N;
I=eye(I_size, I_size);

%numbers used to fill in for I
lambda=dt/(h^2);
a=1+4*lambda;

I=I*a;

for i=2:(Np2*N)
    I(i-1,i)=-lambda;
    I(i,i-1)=-lambda;
end
for i=1:(Np2*Nm1)
    I(i,i+Np2)=-lambda;
    I(i+Np2,i)=-lambda;
end


%Note: go back and use ones() or diag() to speed up this process

Uvec=zeros((N*Np2),1);
for i=1:N
    Uvec(1+Np2*(i-1):i*Np2)=(UG(i,:));
end

i=1;
Uvec_Dif=1;
Max_Uvec_Dif=1;
ips=round(1/dt);
IAug=I;
while Max_Uvec_Dif>0.00001 %stopping criteria
    i=i+1;
    IAug(:,I_size+1)=Uvec(:,:,i-1);
    IAugR=rref(IAug);
    Uvec(:,:,i)=IAugR(:,I_size+1);
    Uvec(1:Np2,:,i)=Uvec(1:Np2,:,i-1);
    Uvec(Np2*N-Np2:Np2*N,:,i)=Uvec(Np2*N-Np2:Np2*N,:,i-1);
    for j=1:Nm2
        Uvec(j*Np2+1,:,i)=Uvec(j*Np2+2,:,i-1);
        Uvec(Np2*(j+1),:,i)=Uvec(Np2*(j+1)-1,:,i-1);
    end
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