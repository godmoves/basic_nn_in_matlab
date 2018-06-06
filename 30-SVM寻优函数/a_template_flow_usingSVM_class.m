%% a_template_flow_usingSVM_classification
% for classificaton
close all;
clear;
clc;
%% 载入数据
load wine_test;
% load image_seg;
%% 提取数据
% ...
%% 原始数据可视化
figure;
boxplot(train_data,'orientation','horizontal');
grid on;
title('Visualization for original data');
figure;
for i = 1:length(train_data(:,1))
    plot(train_data(i,1),train_data(i,2),'r*');
    hold on;
end
grid on;
title('Visualization for 1st dimension & 2nd dimension of original data');
%% 归一化预处理
[train_final,test_final] = scaleForSVM(train_data,test_data,0,1);
%% 归一化后可视化
figure;
for i = 1:length(train_final(:,1))
    plot(train_final(i,1),train_final(i,2),'r*');
    hold on;
end
grid on;
title('Visualization for 1st dimension & 2nd dimension of scale data');
%% 降维预处理(pca)
[train_final,test_final] = pcaForSVM(train_final,test_final,99);
%% DCT
% [train_final,test_final] = DCTforSVM(train_final,test_final);
%% feature selection
% using GA,...,etc.
%% 参数c和g寻优选择
[bestacc,bestc,bestg] = SVMcgForClass(train_data_labels,train_final,-10,10,-10,10)
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];
%% 分类预测
model = svmtrain(train_data_labels, train_final,cmd);
[ptrain_label, train_accuracy] = svmpredict(train_data_labels, train_final, model);
train_accuracy
[ptest_label, test_accuracy] = svmpredict(test_data_labels, test_final, model);
test_accuracy


