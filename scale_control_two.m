function [num_numerator,num_denominator]=scale_control(a,m)%a and m are complex numbers,a is denominator
a_real=real(a);
a_imag=imag(a);
m_real=real(m);
m_imag=imag(m);
tem=(power(m_real,2)+power(m_imag,2));  
if(tem>4)
    x=floor(log2(floor(tem)))/2;
    a_real=a_real./(power(2,(x)));
    a_imag=a_imag./(power(2,(x)));
    m_real=m_real./(power(2,(x)));
    m_imag=m_imag./(power(2,(x)));
elseif(tem<=0.25)
    x=floor(log2(floor(1/tem)))/2;
    a_real=(2^(x)).*a_real;
    a_imag=(2^(x)).*a_imag;
    m_real=(2^(x)).*m_real;
    m_imag=(2^(x)).*m_imag;
end 
num_numerator=a_real+j*a_imag;%return numerator
num_denominator=m_real+j*m_imag;%return denominatror

