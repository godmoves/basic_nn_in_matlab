%% test_for_ica_SVM
close all;
clear;
clc;
%%
load wine_test;
% load image_seg
%%
[train_final,test_final] = scaleForSVM(train_data,test_data,0,1);
%%
[train_ica,test_ica] = fasticaForSVM(train_final,test_final);

%%
[bestacc,bestc,bestg] = SVMcgForClass(train_data_labels,train_ica,-10,10,-10,10)
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg)];

model = svmtrain(train_data_labels, train_ica,cmd);
[ptrain_label, train_acc] = svmpredict(train_data_labels, train_ica, model);
[ptest_label, test_acc] = svmpredict(test_data_labels, test_ica, model);




