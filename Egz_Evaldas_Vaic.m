clc
clear all 
close all

%% Daugiasluoksnis perceptronas

% 1. Duomenys

x1 = [];
x2 = [];
x3 = [];

d1 = [];
d2 = [];

% 2. Struktūra: 3 neuronai paslėptajame sluoksnyje, 2 - išėjimo sluoksnyje
% pirmojo (paslėptojo) sluoksnio svoriai

w11_1= randn(1);
w12_1= randn(1);
w13_1= randn(1);
b1_1= randn(1);

w21_1= randn(1);
w22_1= randn(1);
w23_1= randn(1);
b2_1= randn(1);

w31_1= randn(1);
w32_1= randn(1);
w33_1= randn(1);
b3_1= randn(1);

%antrojo (išėjimo) sluoksnio svoriai

w11_2= randn(1);
w12_2= randn(1);
w13_2= randn(1);
b1_2 = randn(1);

w21_2= randn(1);
w22_2= randn(1);
w23_2= randn(1);
b2_2 = randn(1);

% 3. Tinklo atsakas

n = 0.1; % mokymo žingsnis
y2_2 = 0; % naudojamas y(n-1) pradinėje iteracijoje prilyginamas nuliui 

for j = 1:someNumber
    for i = 1:length(x1) % length(x1) = length(x2) = length(x3) 

        % pirmojo sluoksnio neuronai
        v1_1 = x1(i)*w11_1 + x2(i)*w12_1 + x3(i)*w13_1 + b1_1;
        v2_1 = x1(i)*w21_1 + x2(i)*w22_1 + x3(i)*w23_1 + b2_1;
        v3_1 = x1(i)*w31_1 + x2(i)*w32_1 + x3(i)*w33_1 + b3_1;
        
        %aktyvavimo funkcija
        y1_1 = 1 /  (1 + exp(- v1_1) );
        y2_1 = 1 /  (1 + exp(- v2_1) );
        y3_1 = 1 /  (1 + exp(- v3_1) );

        %antrojo sluoksnio neuronai
        v1_2 = y1_1*w11_2 + y2_1*w12_2 + y3_1*w13_2 + b1_2; 
        v2_2 = y1_1*w21_2 + y2_1*w22_2 + y3_1*w23_2 + y2_2 + b2_2; 
        
        %aktyvavimo funkcija
        y1_2 = v1_2; 
        y2_2 = v2_2;

        y1 = y1_2;
        y2 = y2_2;
        
        % 4. Tinklo mokymas 
        
        %klaida
        e1 = d1(i) - y1;
        e2 = d2(i) - y2;
        
        %Tikslo funkcija
        E = 0.5 * (e1^2 + e2^2);
        
        %klaidos gradientas išėjimo sluoksnio neuronams
        delta1_2 = e1;
        delta2_2 = e2;
        
        %atnaujinami išėjimo sluoksnio svoriai
        w11_2 = w11_2 + n*delta1_2*y1_1;
        w21_2 = w21_2 + n*delta2_2*y1_1;
        w12_2 = w12_2 + n*delta1_2*y2_1;
        w22_2 = w22_2 + n*delta2_2*y2_1;
        w13_2 = w13_2 + n*delta1_2*y3_1;
        w23_2 = w23_2 + n*delta2_2*y3_1;
        b1_2 = b1_2 + n*delta1_2;
        b2_2 = b2_2 + n*delta1_2;
        
        %klaidos gradientas paslėptojo sluoksnio neuronams
        delta1_1 = 1 /  (1 + exp(- v1_1) )*(1 - 1 /  (1 + exp(- v1_1) )) * ( delta1_2 * w11_2 + delta2_2 * w21_2 ) ;
        delta2_1 = 1 /  (1 + exp(- v2_1) )*(1 - 1 /  (1 + exp(- v2_1) )) * ( delta1_2 * w12_2 + delta2_2 * w22_2 ) ;
        delta3_1 = 1 /  (1 + exp(- v3_1) )*(1 - 1 /  (1 + exp(- v3_1) )) * ( delta1_2 * w13_2 + delta2_2 * w23_2 ) ;

        %atnaujinami paslėptojo sluoksnio svoriai
        w11_1 = w11_1 + n*delta1_1*x1(i);
        w21_1 = w21_1 + n*delta2_1*x1(i);
        w31_1 = w31_1 + n*delta3_1*x1(i);
        w12_1 = w12_1 + n*delta1_1*x2(i);
        w22_1 = w22_1 + n*delta2_1*x2(i);
        w32_1 = w32_1 + n*delta3_1*x2(i);
        w13_1 = w13_1 + n*delta1_1*x3(i);
        w23_1 = w23_1 + n*delta2_1*x3(i);
        w33_1 = w33_1 + n*delta3_1*x3(i);
        
        b1_1 = b1_1 + n*delta1_1;
        b2_1 = b2_1 + n*delta2_1;
        b3_1 = b3_1 + n*delta3_1;

    end
end
    
