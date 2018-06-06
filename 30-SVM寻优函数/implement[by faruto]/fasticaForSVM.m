function [train_ica,test_ica] = fasticaForSVM(train,test)
% fasticaForSVM
% by faruto Email:farutoliyang@gmail.com
% 2009.10.30

%%
[mtrain,ntrain] = size(train);
[mtest,ntest] = size(test);
dataset = [train;test];

[dataset_ica,A,W] = fastica(dataset');
dataset_ica = dataset_ica';

train_ica = dataset_ica(1:mtrain,:);
test_ica = dataset_ica( (mtrain+1):(mtrain+mtest),: );
