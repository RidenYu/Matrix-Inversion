function [numb,num_numerator,num_denominator]=scale_control(b,a,m)%a and m are complex numbers,a is denominator
b_real=real(b);
b_imag=imag(b);
a_real=real(a);
a_imag=imag(a);
m_real=real(m);
m_imag=imag(m);
tem=(power(m_real,2)+power(m_imag,2));  
if(tem>4)
    x=floor(log2(floor(tem)))/2;
    a_real=a_real./(power(2,(x)));
    a_imag=a_imag./(power(2,(x)));
    b_real=b_real./(power(2,(x)));
    b_imag=b_imag./(power(2,(x)));
    m_real=m_real./(power(2,(x)));
    m_imag=m_imag./(power(2,(x)));
elseif(tem<=0.25)
    x=floor(log2(floor(1/tem)))/2;
    a_real=(2^(x)).*a_real;
    a_imag=(2^(x)).*a_imag;
    b_real=(2^(x)).*b_real;
    b_imag=(2^(x)).*b_imag;
    m_real=(2^(x)).*m_real;
    m_imag=(2^(x)).*m_imag;
end 
numb=b_real+j*b_imag;
num_numerator=a_real+j*a_imag;%return numerator
num_denominator=m_real+j*m_imag;%return denominatror

