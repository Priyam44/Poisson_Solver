clear all;

format compact;

% setting grid size
n=300;
dx = 1/(n-1);

% Creating Meshgrid
x = 0:dx:1;
y = x;
[X,Y] = meshgrid(x,y);


Tt = zeros(n);

Tt(1,:) = 1 + x;               % T @ y=0
Tt(:,n) = cos(9*pi*(y)) + 1;   % T @ x=1
Tt(n,:) = 1;                   % T @ y=1
Tt(:,1) = 1;                   % T @ x=0

Tt(1 + int16(0.5/dx),1 + int16(0.5/dx)) = 2.5;    % T @ x,y=0.5
Tt(1 + int16(0.25/dx),1 + int16(0.25/dx)) = -0.5; % T @ x,y=0.25




%Solving Linear System of Equations
iter_max = 70000;

error_ = zeros(iter_max,1);

for iter = 1:iter_max
    Tp = Tt;
    for i = 2:n-1
        for j = 2:n-1
            Tt(i,j) = (Tp(i+1,j) + Tp(i-1,j) + Tp(i,j+1) + Tp(i,j-1))/4;
            
        end
    
    end
    Tt(1 + int16(0.5/dx),1 + int16(0.5/dx)) = 2.5;
    Tt(1 + int16(0.25/dx),1 + int16(0.25/dx)) = -0.5;
    error_(iter,1) = sum(abs(Tt)-abs(Tp))/sum(abs(Tp)); 
    fprintf("n:%i iter:%i error:%f \n",n,iter,error_(iter,1));
   
end

%Plotting Isocontours
figure(1);
Tf = Tt;
contourf(X,Y,Tf,30);
colormap jet;

%Plotting Error
figure(2);
iter = 1:iter_max;
plot(iter,error_(:,1)');
xlabel("Iteration");ylabel("error");









