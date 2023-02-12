%boundary layer example

%make a grid for x from 0 to 1 in steps of .0001
x=0:.0001:1;

%XXXXXXXXXXXXXXXXXXXXXXXX
%exact solution
%XXXXXXXXXXXXXXXXXXXXXXXX


%define a function of x for one value of epsilon
epsilon1=.1;
r1=(-1+sqrt(1-2*epsilon1))/epsilon1; 
r2=(-1-sqrt(1-2*epsilon1))/epsilon1;
y_epsilon1_exact=(1/(exp(r1)-exp(r2)))*(exp(r1*x)-exp(r2*x));

%new value of epsilon:
epsilon2=.01;
r1=(-1+sqrt(1-2*epsilon2))/epsilon2; 
r2=(-1-sqrt(1-2*epsilon2))/epsilon2;
y_epsilon2_exact=(1/(exp(r1)-exp(r2)))*(exp(r1*x)-exp(r2*x));

%another value of epsilon:
epsilon3=.001;
r1=(-1+sqrt(1-2*epsilon3))/epsilon3; 
r2=(-1-sqrt(1-2*epsilon3))/epsilon3;
y_epsilon3_exact=(1/(exp(r1)-exp(r2)))*(exp(r1*x)-exp(r2*x));

%plot the exact solutions
figure
plot(x,y_epsilon1_exact,'LineWidth',2)
hold on
plot(x,y_epsilon2_exact,'LineWidth',2)
plot(x,y_epsilon3_exact,'LineWidth',2)
legend(' \epsilon = .1',' \epsilon = .01',' \epsilon = .001')
title('Exact Solutions')
xlabel('x')
ylabel('y')
%the below is just to make the lines and font bigger
ax=gca; %stands for "get current axes"
ax.LineWidth=1;
ax.FontSize=14;



%XXXXXXXXXXXXXXXXXXXXXXXX
%outer solution
%XXXXXXXXXXXXXXXXXXXXXXXX
y_epsilon1_outer=exp(1-x);
y_epsilon2_outer=exp(1-x);
y_epsilon3_outer=exp(1-x);

%XXXXXXXXXXXXXXXXXXXXXXXX
%inner solution
%XXXXXXXXXXXXXXXXXXXXXXXX
A=4;

xbar_epsilon1=x./epsilon1;
xbar_epsilon2=x./epsilon2;
xbar_epsilon3=x./epsilon3;
y_epsilon1_inner=A*(1-exp(-2*xbar_epsilon1));
y_epsilon2_inner=A*(1-exp(-2*xbar_epsilon2));
y_epsilon3_inner=A*(1-exp(-2*xbar_epsilon3));

%plot the inner and outer solution for A=4
figure
semilogx(x,y_epsilon3_inner,'LineWidth',2)
hold on
semilogx(x,y_epsilon3_outer,'LineWidth',2)
legend(' inner',' outer')
xlabel('x')
ylabel('y')
%the below is just to make the lines and font bigger
ax=gca; %stands for "get current axes"
ax.LineWidth=1;
ax.FontSize=14;

A=exp(1);
y_epsilon1_inner=A*(1-exp(-2*xbar_epsilon1));
y_epsilon2_inner=A*(1-exp(-2*xbar_epsilon2));
y_epsilon3_inner=A*(1-exp(-2*xbar_epsilon3));
%plot the inner and outer solution for A=e
figure
semilogx(x,y_epsilon3_inner,'LineWidth',2)
hold on
semilogx(x,y_epsilon3_outer,'LineWidth',2)
legend(' inner',' outer')
xlabel('x')
ylabel('y')
%the below is just to make the lines and font bigger
ax=gca; %stands for "get current axes"
ax.LineWidth=1;
ax.FontSize=14;


%XXXXXXXXXXXXXXXXXXXXXXXX
%composite solution
%XXXXXXXXXXXXXXXXXXXXXXXX
y_epsilon1_composite=exp(1-x)-exp(1-2*x/epsilon1);
y_epsilon2_composite=exp(1-x)-exp(1-2*x/epsilon2);
y_epsilon3_composite=exp(1-x)-exp(1-2*x/epsilon3);


figure
plot(x,y_epsilon1_exact,'LineWidth',2)
hold on
plot(x,y_epsilon1_composite,'LineWidth',2)
title(' \epsilon = .1')
legend(' exact',' composite')
xlabel('x')
ylabel('y')
%the below is just to make the lines and font bigger
ax=gca; %stands for "get current axes"
ax.LineWidth=1;
ax.FontSize=14;

figure
plot(x,y_epsilon2_exact,'LineWidth',2)
hold on
plot(x,y_epsilon2_composite,'LineWidth',2)
title(' \epsilon = .01')
legend(' exact',' composite')
xlabel('x')
ylabel('y')
%the below is just to make the lines and font bigger
ax=gca; %stands for "get current axes"
ax.LineWidth=1;
ax.FontSize=14;

figure
plot(x,y_epsilon3_exact,'LineWidth',2)
hold on
plot(x,y_epsilon3_composite,'LineWidth',2)
title(' \epsilon = .001')
legend(' exact',' composite')
xlabel('x')
ylabel('y')
%the below is just to make the lines and font bigger
ax=gca; %stands for "get current axes"
ax.LineWidth=1;
ax.FontSize=14;

