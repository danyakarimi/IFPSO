clc
close
clear
tic
data=xlsread('IHSPC3IHS1.xlsx');
X= data(:,2);
costFunction= @(x) MyPoly(x);
nvar= 2;
varsize= [1, nvar];
npop= 100;
maxiter= 100;
w= 1;
w_rf= 0.99;
c1= 2;
c2=2;
lb= -1;
ub= 1;

emp_par.cost= [];
emp_par.pos= [];
emp_par.vel= [];
emp_par.best.cost= [];
emp_par.best.pos= [];

par= repmat(emp_par, npop, 1);

gbest.cost= inf;

for i= 1: npop
    par(i).pos= unifrnd(lb, ub, varsize);
     par(i).vel= zeros(varsize);
     
     par(i).cost= MyPoly(par(i).pos,data,X);
     
     par(i).best.cost= par(i).cost;
     par(i).best.pos= par(i).pos;

     if par(i).best.cost < gbest.cost
         gbest= par(i).best;
     end 
end

bestCosts= zeros(maxiter, 1);

for iter= 1: maxiter
    for i= 1: npop
        par(i).vel= w* par(i).vel+...
        c1*rand(1, nvar).*(par(i).best.pos- par(i).pos)+...
        c2*rand(1, nvar).*(gbest.pos- par(i).pos);
    
    par(i).pos= par(i).pos+ par(i).vel;
    
    par(i).cost= MyPoly(par(i).pos,data,X);
    
    if par(i).cost < par(i).best.cost
     par(i).best.cost= par(i).cost;
     par(i).best.pos= par(i).pos;
    end
     if par(i).best.cost < gbest.cost
         gbest= par(i).best;
         Pos_best=par(i).pos;
     end 
    end
    
    bestCosts(iter)= gbest.cost;
    w= w*w_rf;
    
end
toc
disp (['Time = ' num2str(toc)]);
disp (['Best Solution =' num2str(gbest.pos)]);
disp (['Best Cost =' num2str(gbest.cost)]);
disp (['Iteration =' num2str(iter)]);

% figure;
% semilogy(bestCosts, 'r')
plot(bestCosts)
xlabel('Iteration')
ylabel ('Best Cost')
title('DRs beforeP-PSO')
