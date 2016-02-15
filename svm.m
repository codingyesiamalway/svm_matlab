x_data = [0,0;1,0;0,1; -1,-1];
Y = [1;-1;-1;-1]


%plot data

X_Ones = x_data(find(Y==1),:)
X_NegativeOnes = x_data(find(Y==-1),:) 

hold on
plot(X_NegativeOnes(:,1),X_NegativeOnes(:,2),'+b')
plot(X_Ones(:,1),X_Ones(:,2),'or')



%Optimization
C = 100;

p = size(x_data, 2);
n = size(x_data, 1);

H = [eye(p), zeros(p, n+1); zeros(n+1, p), zeros(n+1, n+1)];
f = C * [zeros(p+1, 1); ones(n,1)]';

A_11 = [x_data, ones(n, 1), zeros(n,n)];
for i = 1 : n
    A_11(i, :) = A_11(i, :) * Y(i, 1);
end
A_11 = A_11+ [zeros(n,p + 1), eye(n)];
A_21 = [zeros(n,p + 1), eye(n)];
A = [A_11; A_21];

b = [ones(n,1); zeros(n,1)];

%x = quadprog(H,f)
x = quadprog(H,f,-A,-b)


%Plot Seperating hyperplane
X1=[-2:2]
w1=x(1,1);
w2=x(2,1);
b=x(3,1);
Y1=-(w1*X1+b)/w2; 
plot(X1,Y1,'k-') 
