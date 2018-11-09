clear all; close all; clc;
load('p.mat');
% Con la rutina for se pueden ver las imagenes de entrenamiento
% for q=1:30, 
%     imshow(vec2mat(p(:,q),20)','InitialMagnification',500),
%     pause
% end

z=[p;ones(1,30)];%Matriz de entradas
cir = [ones(1,10); -ones(2,10)];%resultados esperados
rec = [-ones(1,10); ones(1,10); -ones(1,10)];%resultados esperados
trig = [-ones(2,10); ones(1,10)];%resultados esperados

t=[cir rec trig;];%Matriz de resultados

%Algoritmo widrow hoff
R=z*z'/30;
H=z*t'/30;
x=pinv(R)*H;%pseudoinverso

%Obtencion de pesos y polarizaciones
w = x(1:400,:)';
b = x(401,:)';

%Se cargan imagenes diferentes de las que se usaron para el entrenamiento.
%Solamente se modificaron algunos pixeles de las imagenes originales, 
%porque fueron muy pocos casos de entrenamiento, sin embargo,
%la red es capaz de identificar las nuevas imagenes.

load ('test.mat');

for n=1:15
    imshow(vec2mat(test(:,n),20)','InitialMagnification',500),
    a = [hardlims((w*test(:,n) + b))];
        if a==[1;-1;-1]
            'circulo'
        elseif a==[-1;1;-1]
            'rectangulo'
        elseif a==[-1;-1;1]
            'triangulo'
        end
        pause
end
