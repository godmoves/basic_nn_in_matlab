%% Hopfield神经网络的联想记忆——数字识别

%% 清空环境变量
clc
clear
%% 数据导入
load data1 array_one
load data2 array_two
%% 训练样本（目标向量）
 T=[array_one;array_two]';
%% 创建网络
 net=newhop(T);
%% 数字1和2的带噪声数字点阵（固定法）
%load data1_noisy noisy_array_one
%load data2_noisy noisy_array_two
%% 数字1和2的带噪声数字点阵（随机法）
noisy_array_one=array_one;
noisy_array_two=array_two;
for i=1:100
    a=rand;
    if a<0.1
       noisy_array_one(i)=-array_one(i);
       noisy_array_two(i)=-array_two(i);
    end
end
%% 数字识别
N=15;  %识别次数
noisy_one={(noisy_array_one)'};
identify_one=sim(net,{10,N},{},noisy_one);
noisy_two={(noisy_array_two)'};
identify_two=sim(net,{10,N},{},noisy_two);
%% 结果显示
% Array_one=imresize(array_one,20);
% subplot(3,2,1)
% imshow(Array_one)
% title('标准(数字1)') 
% Array_two=imresize(array_two,20);
% subplot(3,2,2)
% imshow(Array_two)
% title('标准(数字2)') 
% subplot(3,2,3)
% Noisy_array_one=imresize(noisy_array_one,20);
% imshow(Noisy_array_one)
% title('噪声(数字1)') 
% subplot(3,2,4)
% Noisy_array_two=imresize(noisy_array_two,20);
% imshow(Noisy_array_two)
% title('噪声(数字2)')
% subplot(3,2,5)
% imshow(imresize(identify_one{N}',20))
% title('识别(数字1)')
% subplot(3,2,6)
% imshow(imresize(identify_two{N}',20))
% title('识别(数字2)')

%% 识别进程

figure(1)
subplot(1,2,1)
imshow(imresize(identify_one{ceil(N)}',20))
title('识别(数字1)')
subplot(1,2,2)
imshow(imresize(identify_two{ceil(N)}',20))
title('识别(数字2)')

figure(2)
subplot(1,2,1)
imshow(imresize(identify_one{ceil(0.8*N)}',20))
title('识别(数字1)')
subplot(1,2,2)
imshow(imresize(identify_two{ceil(0.8*N)}',20))
title('识别(数字2)')

figure(3)
subplot(1,2,1)
imshow(imresize(identify_one{ceil(0.6*N)}',20))
title('识别(数字1)')
subplot(1,2,2)
imshow(imresize(identify_two{ceil(0.6*N)}',20))
title('识别(数字2)')

figure(4)
subplot(1,2,1)
imshow(imresize(identify_one{ceil(0.4*N)}',20))
title('识别(数字1)')
subplot(1,2,2)
imshow(imresize(identify_two{ceil(0.4*N)}',20))
title('识别(数字2)')

figure(5)
subplot(1,2,1)
imshow(imresize(identify_one{ceil(0.2*N)}',20))
title('识别(数字1)')
subplot(1,2,2)
imshow(imresize(identify_two{ceil(0.2*N)}',20))
title('识别(数字2)')

figure(6)
subplot(1,2,1)
Noisy_array_one=imresize(noisy_array_one,20);
imshow(Noisy_array_one)
title('噪声(数字1)') 
subplot(1,2,2)
Noisy_array_two=imresize(noisy_array_two,20);
imshow(Noisy_array_two)
title('噪声(数字2)')
