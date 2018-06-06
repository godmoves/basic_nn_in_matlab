%% 生成随机城市
clear;
load best bestl
bestl=100;
save best bestl
cities=rand(30,2);  % N*2随机矩阵
save cities cities;