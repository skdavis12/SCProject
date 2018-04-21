N=5; %number of nodes in x direction, same as number in y
h=2*pi/(N-1); %delta x, delta y
dt=h^2/4; %delta t

x=-pi:h:pi;
y=x;

%Initial Conditions:

phi=cos(pi.*(x+pi)).*cosh(pi-x); %BC at y=by
psi=(x+pi).^2.*sin(pi.*(x+pi)/(4*pi)); %BC at y=ay

UG=zeros(5,(N+2),1); %preallocate

UG(1,2:(N+1),1)=phi;
UG(N,2:(N+1),1)=psi;

%first step in t

for i=2:(N-1)
    for j=2:N+1
        UG(i,j,2)=UG(i,j,1)+dt*(UG(i-1,j,1)-2*UG(i,j,1)+UG(i+1,j,1)+UG(i,j+1,1)-2*UG(i,j,1)+UG(i,j-1,1))/(h^2);
    end
end

%Update upper and lower boundaries
UG(1,2:(N+1),2)=phi;
UG(N,2:(N+1),2)=psi;

%Update Ghost Nodes
UG(:,1,2)=UG(:,2,2);
UG(:,(N+2),2)=UG(:,(N+1),2);

%Repeat line 20 onward for each step in t