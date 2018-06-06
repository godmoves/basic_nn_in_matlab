%% psoSVMcgForRegress_test
clear
clc

%%
load wine;
train = [wine(1:30,:);wine(60:95,:);wine(131:153,:)];
train_label = [wine_labels(1:30);wine_labels(60:95);wine_labels(131:153)];
test = [wine(31:59,:);wine(96:130,:);wine(154:178,:)];
test_label = [wine_labels(31:59);wine_labels(96:130);wine_labels(154:178)];

[train,pstrain] = mapminmax(train');
pstrain.ymin = 0;
pstrain.ymax = 1;
[train,pstrain] = mapminmax(train,pstrain);

[test,pstest] = mapminmax(test');
pstest.ymin = 0;
pstest.ymax = 1;
[test,pstest] = mapminmax(test,pstest);

train = train';
test = test';
%%
[bestmse,bestc,bestg] = psoSVMcgForRegress(train_label,train)
cmd = ['-c ',num2str(bestc),' -g ',num2str(bestg),' -s 3 -p 0.1'];
model = svmtrain(train_label,train,cmd);
[pretrain,trainacc] = svmpredict(train_label,train,model);
[pretest,testacc] = svmpredict(test_label,test,model);

