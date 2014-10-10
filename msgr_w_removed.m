function [U,M,d1]=msgr_w_removed(A,N)
d1=0;
I=eye(N);
for i=1:N-1
    if(A(i,i)==0)
        u1=A(i,1:N);
        u2=I(i,1:N);
    else
        u1=conj(A(i,i)).*A(i,1:N);
        u2=conj(A(i,i)).*I(i,1:N);
    end
    for j=i+1:N
            v1=A(j,1:N);
        if(u1(i)~=0 && v1(i)~=0)  
            v1=A(j,1:N);
            v2=I(j,1:N);
            u1_new=u1+conj(v1(i)).*v1;
            v1_new=v1-(v1(i)/u1(i)).*u1;
                       
            u2_new=u2+conj(v1(i)).*v2;
            v2_new=v2-(v1(i)/u1(i)).*u2;
            d1=d1+2;
         elseif (u1(i)==0 && v1(i)~=0)
             v1=A(j,1:N);
             v2=I(j,1:N);
            u1_new=conj(v1(i)).*v1;
            v1_new=(-1).*u1;
                        
            u2_new=conj(v1(i)).*v2;
            v2_new=(-1).*u2;
            
        elseif (u1(i)==0 && v1(i)==0)
            v1=A(j,1:N);
            v2=I(j,1:N);
            u1_new=v1;
            v1_new=(-1).*u1;
            
            u2_new=v2;
            v2_new=(-1).*u2;

        else
            v1=A(j,1:N);
            v2=I(j,1:N);
            u1_new=A(i,1:N);
            v1_new=A(j,1:N);
            
            u2_new=I(i,1:N);
            v2_new=I(j,1:N);
        end          
            
        A(i,1:N)=u1_new;
        A(j,1:N)=v1_new;
        u1=u1_new;
        
        I(i,1:N)=u2_new;
        I(j,1:N)=v2_new;
        u2=u2_new;
    end
end
if(i==N-1)
temp=A(N,N);
A(N,1:N)=conj(temp).*A(N,1:N);
I(N,1:N)=conj(temp).*I(N,1:N);
end
U=A;
M=I;

