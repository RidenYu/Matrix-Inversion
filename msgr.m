function [U,M,d1]=msgr(A,N)
w=ones(1,N);
I=eye(N);
d1=0;
for i=1:N-1
    if(A(i,i)==0)
        u1=w(i).*A(i,1:N);
        u2=w(i).*I(i,1:N);
    else
        u1=w(i).*conj(A(i,i)).*A(i,1:N);
        u2=w(i).*conj(A(i,i)).*I(i,1:N);
    end
    for j=i+1:N
            v1=A(j,1:N);
        if(u1(i)~=0 && v1(i)~=0)  
            v1=A(j,1:N);
            v2=I(j,1:N);
            u1_new=u1+w(j)*conj(v1(i)).*v1;
            v1_new=v1-(v1(i)/u1(i)).*u1;
                       
            u2_new=u2+w(j)*conj(v1(i)).*v2;
            v2_new=v2-(v1(i)/u1(i)).*u2;
            w(j)=w(j)*u1(i)/u1_new(i);
            d1=d1+3;
         elseif (u1(i)==0 && v1(i)~=0)
             v1=A(j,1:N);
             v2=I(j,1:N);
            u1_new=w(j)*conj(v1(i)).*v1;
            v1_new=(-1).*u1;
                        
            u2_new=w(j)*conj(v1(i)).*v2;
            v2_new=(-1).*u2;
            w(j)=w(j);
        elseif (u1(i)==0 && v1(i)==0)
            v1=A(j,1:N);
            v2=I(j,1:N);
            u1_new=w(j).*v1;
            v1_new=(-1).*u1;
            
            u2_new=w(j).*v2;
            v2_new=(-1).*u2;
            w(j)=w(j);
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

