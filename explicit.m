function [U,x,y,h,dt]=explicit(N,dt,tf)
% This function uses the explicit method to estimate U(x,y,tf)
% Given the inputs:
%     N ~ number of nodes in x and y
%     dt ~ time step
%     tf ~ time at which U must be approximated
% The function will return:
%     U ~ U(x,y,tf) approximated by model
%     x ~ vector of discretized x
%     y ~ vector of discretized y
%     h ~ dx = dy
%     dt
% Where:
%         du/dt = d^2U/dx^2 + d^2U/dy^2
%         -pi < y < pi
%         -pi < x < pi
%         U(x,y=-pi,t)=phi(x)
%         U(x,y=pi,t)=psi(x)
%         du/dx=0 at x=-pi,pi


%Create Mesh
    Nm1=N-1; 
    h=2*pi/(Nm1); %h=dx=dy 
    x=-pi:h:pi;
    y=x;

    
%Initial Condition of Interior Nodes:
    Nm2=N-2;
    intn=Nm2*N; %number of interior nodes
    Uvec=zeros(intn,1); %vector containing interior nodes of U
    
    
%Boundary Conditions
    phi=cos(pi.*(x+pi)).*cosh(pi-x); %BC at y=ay=-pi
    psi=(x+pi).^2.*sin(pi.*(x+pi)/(4*pi)); %BC at y=by=pi

    
%Create E
    lambda=dt/(h^2);
    a=1-4*lambda;
    E=eye(intn,intn)*a; %major diagonal
        %minor diagonals:
        for i=0:N-3
            for j=1:N-1
                k=i*N+j;
                E(k,k+1)=lambda;
                E(k+1,k)=lambda;
            end
        end
        B=eye(intn-N,intn-N)*lambda;
        E(1:intn-N,N+1:intn)=E(1:intn-N,N+1:intn)+B;
        E(N+1:intn,1:intn-N)=E(N+1:intn,1:intn-N)+B;

        
%Iterate explicit method until tf is reached
    i=1;
    for t=dt:dt:tf
        %Update BCvec
        BCvec=zeros(intn,1);
        BCvec(1:N)=phi;
        BCvec(intn-Nm1:intn)=psi; 
            for ii=0:N-3
                k=ii*N+1;
                j=N*(ii+1);
                BCvec(k)=BCvec(k)+Uvec(k,:,i);
                BCvec(j)=BCvec(j)+Uvec(j,:,i);
            end
        i=i+1;
        %Update Uvec
            Uvec(:,:,i)=E*Uvec(:,:,i-1)+lambda*BCvec;
    end

    
%Output U 
    U=zeros(N,N);
    U(1,:)=phi;
    U(N,:)=psi;
    for ii=0:N-3
        k=ii*N+1;
        j=N*(ii+1);
        U(ii+2,:)=Uvec(k:j,:,i);
    end
    
end