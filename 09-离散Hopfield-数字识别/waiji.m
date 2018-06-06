%% Hopfield神经网络的联想记忆——数字识别

%% 清除环境变量
clear
clc 
%% 导入记忆模式
load data2.mat
T=array_two;
%% 外积法计算权系数矩阵
[m,n]=size(T);
w=zeros(m);
for i=1:n
    w=w+T(:,i)*T(:,i)'-eye(m);
end
%% 导入待记忆模式
noisy_array=T;
for i=1:100
    a=rand;
    if a<0.1
       noisy_array(i)=-T(i);
    end
end
%% 迭代计算
v0=noisy_array;
v=zeros(m,n);
for k=1:5
    for i=1:m
        v(i,:)=sign(w(i,:)*v0);
    end
    v0=v;
end
%% 绘图
subplot(3,1,1)
t=imresize(T,20);
imshow(t)
title('标准')
subplot(3,1,2)
Noisy_array=imresize(noisy_array,20);
imshow(Noisy_array)
title('噪声')
subplot(3,1,3)
V=imresize(v,20);
imshow(V)
title('识别')
