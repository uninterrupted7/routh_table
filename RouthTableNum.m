function RouthTableNum(Gs)

format bank
syms s

p = coeffs(Gs,'All'); %gets coeffs of func
a = length(p); %length of coeefs 
    
m = zeros(a,uint8(a/2)); %creating 0 matrix with lenght value
if mod(a,2) == 1
   
    p(a+1)=0;
    
end

%adding first 2 raw's value from coeefs func
b = 1;
for i=1:1:uint8(a/2)
    
    for j=1:2
       
        m(j,i) = p(b);
        b = b+1;
    end
   
end

%calculating and adding other b,c,... values

for i=3:a
   
    for j=1:uint8(a/2)-1
        
        L = [m(i-2,1) m(i-2,j+1); m(i-1,1) m(i-1,j+1)];
        m(i,j) = det(L) / -m(i-1,1);
        
    end
    
end

%checking stability
unstablePoles = 0;
for i=1:a
    
     if i==a
        break;
    end
    
    if m(i,1) * m(i+1,1) < 0
        
       unstablePoles = unstablePoles +1;
         
    end
    
    
end

b = 1;
%output
for i=a:-1:1
    
    fprintf('\ns^%i  ',i-1);
    fprintf(' %.3f   ',m(b,:));
    b = b+1;
    
end



if unstablePoles > 0 
   
    
    fprintf('\n------system is unstable-------\n\n');
    fprintf('\n--system has %d right side poles--\n\n',unstablePoles);
   
else
    
   fprintf('\n----system is stable------\n\n');
    
end


end

