clc;
clear all;
close all

%% data init

A=[53, 4.4, 0.4;
   40, 8,   3.6;
   12, 3,   2  ;
   53, 12,  0.9;
   6,  1.9, 0.3];

Cost=[0.5;0.9;0.1;0.6;0.4];

L=[100;10;0];
U=[1000;100;100];

CostA=0.6*Cost;

CostB=[CostA CostA CostA CostA CostA];
CostB=CostB-eye(length(Cost)).*[Cost Cost Cost Cost Cost];

%% calculation

A_temp=[A'; -A'; -eye(length(Cost));-CostB'];
B_temp=[U;-L;zeros(length(Cost),1);zeros(length(Cost),1)];
C=linprog(Cost, A_temp, B_temp)

C'*Cost



%% new objective

Proteins=[4.4;8;3;12;1.9];
A=[A(:,1),A(:,3),Cost];

L=[100;0;0];
U=[1000;100;2];

A_temp1=[A';-A';-eye(length(Proteins))];
B_temp1=[U;-L;zeros(length(Proteins),1)];

MaxProteins=linprog(-Proteins,A_temp1,B_temp1)

MaxProteins'*Proteins