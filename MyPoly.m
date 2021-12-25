function Z=MyPoly(x,data,X)
Z=0;
% data=xlsread('Rvalue_stu_S2BmyNorm_excelReg_rivMask.xlsx');
% b2= imread('sub2_b2.tif');
% b2= double (b2);
% b2= b2/1000; 
% 
% b3= imread('sub_b3.tif');
% b3= double (b3);
% b3= b3/1000;
% 
% X= b2./b3;
[m,n]= size(data);
for i=1:m
    z(i)= x(1)*X(i)+x(2);
    Z=Z+(data(i,1)-z(i))^2;
    
end
Z=sqrt((Z)/m);
end
