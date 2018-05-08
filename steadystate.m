function [US,Usvec]=steadystate(N)
% This function calculates the steady state values of U
% Given the inputs:
%     N ~ number of nodes in x and y
% The function will return:
%     US ~ U(x,y) at steady state
%     Usvec ~ vector of interior nodes

%Create Mesh
    Nm1=N-1; 
    h=2*pi/(Nm1); %h=dx=dy 
    x=-pi:h:pi;
   
%Boundary Conditions
    phi=cos(pi.*(x+pi)).*cosh(pi-x); %BC at y=ay=-pi
    psi=(x+pi).^2.*sin(pi.*(x+pi)/(4*pi)); %BC at y=by=pi
    

%Create BCvec
    Nm2=N-2;
    intn=N*Nm2;
    BCvec=zeros(intn,1);
    BCvec(1:N)=phi;
    BCvec(intn-Nm1:intn)=psi;
    
 
%Create S
    S=eye(intn,intn)*4; %major diagonal
        %minor diagonals:
        for i=0:N-3
            m=i*N+1;
            n=N*(i+1);
            S(m,m)=S(m,m)-1; %accounts for ghost node
            S(n,n)=S(n,n)-1; %accounts for ghost node
            for j=1:N-1
                k=i*N+j;
                S(k,k+1)=-1;
                S(k+1,k)=-1;
            end
        end
        B=eye(intn-N,intn-N)*-1;
        S(1:intn-N,N+1:intn)=S(1:intn-N,N+1:intn)+B;
        S(N+1:intn,1:intn-N)=S(N+1:intn,1:intn-N)+B;
        
Usvec=S\BCvec;

US=zeros(N,N);
US(1,:)=phi;
US(N,:)=psi;
    for ii=0:N-3
        k=ii*N+1;
        j=N*(ii+1);
        US(ii+2,:)=Usvec(k:j);
    end