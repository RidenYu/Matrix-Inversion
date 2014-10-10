function [U,D]=msgr_new_No_w(A,N)
M=A;
I=eye(N);
M2=I;
n=ones(1,N);

for i=1:N-1
    if(M(i,i)==0)
        M(i,1:N)=M(i,1:N);
        M2(i,1:N)=M2(i,1:N);
        n(i)=n(i);
    else
        tem1=M(i,1:N);
        tem11=M2(i,1:N);
        tem2=n(i);
        M(i,1:N)=conj(tem1(i)).*tem1;
        M2(i,1:N)=conj(tem1(i)).*tem11;
        n(i)=conj(tem2)*tem2;
    end
    for j=i+1:N
        P=M(j,1:N);
        P2=M2(j,1:N);
        q=n(j);
        if(M(i,i)==0 && P(i)~=0)
            M_new=conj(P(i)).*P;
            M2_new=conj(P(i)).*P2;
            n_new=conj(q)*q;
            P_new=(-1).*M(i,1:N);
            P2_new=(-1).*M2(i,1:N);
            q_new=n(i);
            
            
            [M2_new,M_new,n_new]=scale_control(M2_new,M_new,n_new);
            [P2_new,P_new,q_new]=scale_control(P2_new,P_new,q_new);
         
            
            M(i,1:N)=M_new;
            M2(i,1:N)=M2_new;
            n(i)=n_new;
            M(j,1:N)=P_new;
            M2(j,1:N)=P2_new;
            n(j)=q_new;
        elseif(M(i,i)==0 && P(i)==0)
            M_new=P;
            M2_new=P2;
            n_new=q;
            P_new=(-1).*M(i,1:N);
            P2_new=(-1).*M2(i,1:N);
            q_new=n(i);
            
            [M2_new,M_new,n_new]=scale_control(M2_new,M_new,n_new);
            [P2_new,P_new,q_new]=scale_control(P2_new,P_new,q_new);
        
            
            M(i,1:N)=M_new;
            M2(i,1:N)=M2_new;
            n(i)=n_new;
            M(j,1:N)=P_new;
            M2(j,1:N)=P2_new;
            n(j)=q_new;
        elseif(M(i,i)~=0 && P(i)~=0)
            M_new=conj(q)*q.*M(i,1:N)+n(i)*conj(P(i)).*P;
            M2_new=conj(q)*q.*M2(i,1:N)+n(i)*conj(P(i)).*P2;
            n_new=n(i)*conj(q)*q;
            P_new=M(i,i).*P-P(i).*M(i,1:N);
            P2_new=M(i,i).*P2-P(i).*M2(i,1:N);
            q_new=q.*M(i,i);
            
            [M2_new,M_new,n_new]=scale_control(M2_new,M_new,n_new);
            [P2_new,P_new,q_new]=scale_control(P2_new,P_new,q_new);


            M(i,1:N)=M_new;
            M2(i,1:N)=M2_new;
            n(i)=n_new;
            M(j,1:N)=P_new;
            M2(j,1:N)=P2_new;
            n(j)=q_new;
        else 
            M(i,1:N)=tem1;
            M2(i,1:N)=tem11;
            n(i)=tem2;
        end
    end 
end
U=ones(N,N);
D=ones(N,N);
temp=U(N,N);
U(N,1:N)=conj(temp).*U(N,1:N);
D(N,1:N)=conj(temp).*D(N,1:N);
for pp=1:N
    U(pp,1:N)=M(pp,1:N)./n(pp);
    D(pp,1:N)=M2(pp,1:N)./n(pp);
end
end
        
    