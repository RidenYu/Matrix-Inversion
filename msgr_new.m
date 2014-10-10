function [U,D]=msgr_new(A,N)
M=A;
I=eye(N);
M2=I;
n=ones(1,N);
s=ones(1,N);
t=ones(1,N);
for i=1:N-1
    if(M(i,i)==0)
        tem1=M(i,1:N);
        tem11=M2(i,1:N);
        tem2=n(i);
        M(i,1:N)=s(i).*M(i,1:N);
        M2(i,1:N)=s(i).*M2(i,1:N);
        n(i)=t(i)*n(i);
    else
        tem1=M(i,1:N);
        tem11=M2(i,1:N);
        tem2=n(i);
        M(i,1:N)=s(i)*conj(tem1(i)).*tem1;
        M2(i,1:N)=s(i)*conj(tem1(i)).*tem11;
        n(i)=t(i)*conj(tem2)*tem2;
    end
    for j=i+1:N
        P=M(j,1:N);
        P2=M2(j,1:N);
        q=n(j);
        if(M(i,i)==0 && P(i)~=0)
            M_new=s(j)*conj(P(i)).*P;
            M2_new=s(j)*conj(P(i)).*P2;
            n_new=t(j)*conj(q)*q;
            P_new=(-1).*M(i,1:N);
            P2_new=(-1).*M2(i,1:N);
            q_new=n(i);
            s(j)=s(j);
            t(j)=t(j);
            

            [s(j),t(j)]=scale_control_two(s(j),t(j));
            [M2_new,M_new,n_new]=scale_control(M2_new,M_new,n_new);
            [P2_new,P_new,q_new]=scale_control(P2_new,P_new,q_new);
            
            M(i,1:N)=M_new;
            M2(i,1:N)=M2_new;
            n(i)=n_new;
            M(j,1:N)=P_new;
            M2(j,1:N)=P2_new;
            n(j)=q_new;
        elseif(M(i,i)==0 && P(i)==0)
            M_new=s(j).*P;
            M2_new=s(j).*P2;
            n_new=t(j)*q;
            P_new=(-1).*M(i,1:N);
            P2_new=(-1).*M2(i,1:N);
            q_new=n(i);
            s(j)=s(j);
            t(j)=t(j);
            
            
            [s(j),t(j)]=scale_control_two(s(j),t(j));
            [M2_new,M_new,n_new]=scale_control(M2_new,M_new,n_new);
            [P2_new,P_new,q_new]=scale_control(P2_new,P_new,q_new);
            
            M(i,1:N)=M_new;
            M2(i,1:N)=M2_new;
            n(i)=n_new;
            M(j,1:N)=P_new;
            M2(j,1:N)=P2_new;
            n(j)=q_new;
        elseif(M(i,i)~=0 && P(i)~=0)                
            M_new=t(j)*conj(q)*q.*M(i,1:N)+n(i)*s(j)*conj(P(i)).*P;
            M2_new=t(j)*conj(q)*q.*M2(i,1:N)+n(i)*s(j)*conj(P(i)).*P2;
            n_new=n(i)*t(j)*conj(q)*q;
            
            P_new=M(i,i).*P-P(i).*M(i,1:N);
            P2_new=M(i,i).*P2-P(i).*M2(i,1:N);
            q_new=q.*M(i,i);
            s(j)=s(j)*M(i,i)*n_new;
            t(j)=t(j)*n(i)*M_new(i);

            [s(j),t(j)]=scale_control_two(s(j),t(j));
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
for pp=1:N
    U(pp,1:N)=M(pp,1:N)./n(pp);
    D(pp,1:N)=M2(pp,1:N)./n(pp);
end
temp=U(N,N);
U(N,1:N)=conj(temp).*U(N,1:N);
D(N,1:N)=conj(temp).*D(N,1:N);
end
        
    