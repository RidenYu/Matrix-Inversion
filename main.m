clc
clear all
N=14;
A=rand(14)+j*rand(14);%+j*rand(100);
A(1,1:8)=zeros(1,8);

A(2,1:3)=zeros(1,3);

w_removed=0;
if(det(A)==0)
    error('The Matrix Input Can Not Be Inversed!')
end

tic
switch w_removed
    case 1
         [U,D]=msgr_new_No_w(A,N);%% division free
        %[U1,M,d1]=msgr_w_removed(A,N);%%without w
    case 0
        [U,D]=msgr_new(A,N);%division free
       %[U1,M,d1]=msgr(A,N);
       
end
[U_inversion,d2]=back_substitution(U,N);    % back_substitution to obtain the inversion matrix of U
A_inversion=U_inversion*D;                  % Obtain the inversion matrix of A
offset=A_inversion-inv(A)                   % Compute the deviation of the A_inversion
toc