function [U,Uexact,x,y,h,dt]=explicit_ms(N,dt,tf)
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


%Create Mesh
    Nm1=N-1; 
    h=2*pi/(Nm1); %h=dx=dy 
    x=-pi:h:pi;
    y=x;
    [X,Y]=meshgrid(x,y);

    
%Initial Condition:
    U(:,:,1)=sin(X)+sin(Y); %t=0
    Nm2=N-2;
    intn=Nm2*Nm2; %number of interior nodes
    Uvec=zeros(intn,1); %vector containing interior nodes of U
    for i=1:Nm2
        Uvec((i-1)*Nm2+1:i*Nm2)=U(i+1,2:Nm1);
    end

    
%Create E
    lambda=dt/(h^2);
    a=1-4*lambda;
    E=eye(intn,intn)*a; %major diagonal
        %minor diagonals:
        for i=0:N-3
            for j=1:N-3
                k=i*Nm2+j;
                E(k,k+1)=lambda;
                E(k+1,k)=lambda;
            end
        end
        B=eye(intn-Nm2,intn-Nm2)*lambda;
        E(1:intn-Nm2,Nm2+1:intn)=E(1:intn-Nm2,Nm2+1:intn)+B;
        E(Nm2+1:intn,1:intn-Nm2)=E(Nm2+1:intn,1:intn-Nm2)+B;

        
%Iterate explicit method until tf is reached
    Fvec=zeros(intn,1); %preallocate
    i=1;
    for t=dt:dt:tf
        %Create BCvec
            A=exp(-(t-dt)/2)*(sin(x)+sin(-pi)); %values at boundary, same for all 4 boundaries
            BCvec=zeros(intn,1);
            BCvec(1:Nm2)=A(2:Nm1);
            BCvec(intn-(N-3):intn)=A(2:Nm1);
            for ii=0:N-3
                k=ii*(Nm2)+1;
                j=Nm2*(ii+1);
                BCvec(k)=BCvec(k)+A(ii+2);
                BCvec(j)=BCvec(j)+A(ii+2);
            end
        %Update F and Fvec
            F=(-exp(-(t-dt)/2)/2)*(sin(X)+sin(Y))+exp(-(t-dt)/2)*sin(X)+exp(-(t-dt)/2)*sin(Y);
            for ii=1:Nm2
                Fvec((ii-1)*Nm2+1:ii*Nm2)=F(ii+1,2:Nm1); %vector of interior nodes of F
            end
        i=i+1;
        %Update Uvec
            Uvec(:,:,i)=E*Uvec(:,:,i-1)+lambda*BCvec+dt*Fvec;
    end

    
%Output U and Uexact at tf
    Uexact=exp(-t/2)*(sin(X)+sin(Y)); %exact solution of U
    U=Uexact; %U at boundaries is known
    for ii=1:Nm2
        U(ii+1,2:Nm1)=Uvec((ii-1)*Nm2+1:ii*Nm2,:,i); %U at interior nodes from method
    end

end