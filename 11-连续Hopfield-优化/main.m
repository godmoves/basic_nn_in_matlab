%% 连续Hopfield神经网络的优化—旅行商问题优化计算
% function main 解决旅行商问题
%% 清空环境变量、定义全局变量
clear 
clc
global A D
%% 导入城市位置
load cities
%% 计算相互城市间距离
distance=dist(cities,cities');
%% 初始化网络
N=size(cities,1);
A=200;
D=100;
U0=0.1;
step=0.0001;            %步长
delta=2*rand(N,N)-1;
U=U0*log(N-1)+delta;
V=(1+tansig(U/U0))/2;
iter_num=15000;         %迭代次数
E=zeros(1,iter_num);
%% 寻优迭代
for k=1:iter_num  
    % 动态方程计算
    dU=diff_u(V,distance);
    % 输入神经元状态更新
    U=U+dU*step;
    % 输出神经元状态更新
    V=(1+tansig(U/U0))/2;
    % 能量函数计算
    e=energy(V,distance);
    E(k)=e;  
end
 %% 判断路径有效性
[rows,cols]=size(V);
V1=zeros(rows,cols);
[V_max,V_ind]=max(V);
for j=1:cols
    V1(V_ind(j),j)=1;
end
C=sum(V1,1);
R=sum(V1,2);
flag=isequal(C,ones(1,N)) & isequal(R',ones(1,N));
%% 结果显示
if flag==1
   % 计算初始路径长度
   sort_rand=randperm(N);
   cities_rand=cities(sort_rand,:);
   Length_init=dist(cities_rand(1,:),cities_rand(end,:)');
   for i=2:size(cities_rand,1)
       Length_init=Length_init+dist(cities_rand(i-1,:),cities_rand(i,:)');
   end
   % 绘制初始路径
%    figure(1)
%    plot([cities_rand(:,1);cities_rand(1,1)],[cities_rand(:,2);cities_rand(1,2)],'o-')
%    for i=1:length(cities)
%        text(cities(i,1),cities(i,2),['   ' num2str(i)])
%    end
%    text(cities_rand(1,1),cities_rand(1,2),['       起点' ])
%    text(cities_rand(end,1),cities_rand(end,2),['       终点' ])
%    title(['优化前路径(长度：' num2str(Length_init) ')'])
%    axis([0 1 0 1])
%    grid on
%    xlabel('城市位置横坐标')
%    ylabel('城市位置纵坐标')
%    % 计算最优路径长度
   [V1_max,V1_ind]=max(V1);
   cities_end=cities(V1_ind,:);
   Length_end=dist(cities_end(1,:),cities_end(end,:)');
   for i=2:size(cities_end,1)
       Length_end=Length_end+dist(cities_end(i-1,:),cities_end(i,:)');
   end
%    disp('最优路径矩阵');V1_ind
%    % 绘制最优路径
%    figure(2)
%    plot([cities_end(:,1);cities_end(1,1)],...
%        [cities_end(:,2);cities_end(1,2)],'o-')
%    for i=1:length(cities)
%        text(cities(i,1),cities(i,2),['  ' num2str(i)])
%    end
%    text(cities_end(1,1),cities_end(1,2),['       起点' ])
%    text(cities_end(end,1),cities_end(end,2),['       终点' ])
%    title(['优化后路径(长度：' num2str(Length_end) ')'])
%    axis([0 1 0 1])
%    grid on
%    xlabel('城市位置横坐标')
%    ylabel('城市位置纵坐标')
%    % 绘制能量函数变化曲线
%    figure(3)
%    plot(1:iter_num,E);
%    ylim([0 2000])
%    title(['能量函数变化曲线(最优能量：' num2str(E(end)) ')']);
%    xlabel('迭代次数');
%    ylabel('能量函数');
    Length_end
    load best bestl
    if Length_end<bestl
        disp('  新最小值！')
        bestl=Length_end;
        save best bestl iter_num
        figure
        plot([cities_end(:,1);cities_end(1,1)],...
           [cities_end(:,2);cities_end(1,2)],'o-')
        for i=1:length(cities)
           text(cities(i,1),cities(i,2),['  ' num2str(i)])
        end
        text(cities_end(1,1),cities_end(1,2),['       起点' ])
        text(cities_end(end,1),cities_end(end,2),['       终点' ])
        title(['优化后路径(长度：' num2str(Length_end) ')'])
        axis([0 1 0 1])
        grid on
        xlabel('城市位置横坐标')
        ylabel('城市位置纵坐标')
    else
        main
    end
else
   main
end


% %===========================================
% function du=diff_u(V,d)
% global A D
% n=size(V,1);
% sum_x=repmat(sum(V,2)-1,1,n);
% sum_i=repmat(sum(V,1)-1,n,1);
% V_temp=V(:,2:n);
% V_temp=[V_temp V(:,1)];
% sum_d=d*V_temp;
% du=-A*sum_x-A*sum_i-D*sum_d;
% %==========================================
% function E=energy(V,d)
% global A D
% n=size(V,1);
% sum_x=sumsqr(sum(V,2)-1);
% sum_i=sumsqr(sum(V,1)-1);
% V_temp=V(:,2:n);
% V_temp=[V_temp V(:,1)];
% sum_d=d*V_temp;
% sum_d=sum(sum(V.*sum_d));
% E=0.5*(A*sum_x+A*sum_i+D*sum_d);
