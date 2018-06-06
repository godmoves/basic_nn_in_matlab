function [train_pca,test_pca] = pcaForSVM(train,test,threshold)
% pca pre-process for SVM
% by faruto Email:farutoliyang@gmail.com QQ:516667408
% 2009.10.27

if nargin == 2
    threshold = 90;
end
%%
[mtrain,ntrain] = size(train);
[mtest,ntest] = size(test);
dataset = [train;test];
%%
[dataset_coef,dataset_score,dataset_latent,dataset_t2] = princomp(dataset);
%%
dataset_cumsum = 100*cumsum(dataset_latent)./sum(dataset_latent);
index = find(dataset_cumsum >= threshold);
percent_explained = 100*dataset_latent/sum(dataset_latent);

figure;
pareto(percent_explained);
xlabel('Principal Component');
ylabel('Variance Explained (%)');
grid on;
%% 
train_pca = dataset_score(1:mtrain,:);
test_pca = dataset_score( (mtrain+1):(mtrain+mtest),: );

train_pca = train_pca(:,1:index(1));
test_pca = test_pca(:,1:index(1));
