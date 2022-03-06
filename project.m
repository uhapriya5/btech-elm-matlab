
clc;close all;clear all;
trd=load('trainingdata2.mat');
%ted=load('testingdata1.mat');
%devide into train and test 
TrainTarget = [trd.trainingdata(2:5,1:3)',trd.trainingdata(8:13,1:3)',trd.trainingdata(18:end,1:3)'];
TestTarget =[trd.trainingdata(1,1:3)',trd.trainingdata(6:7,1:3)',trd.trainingdata(14:17,1:3)'];
InputsTrain = [trd.trainingdata(2:5,4:end)',trd.trainingdata(8:13,4:end)',trd.trainingdata(18:end,4:end)'];
InputsTest = [trd.trainingdata(1,4:end)',trd.trainingdata(6:7,4:end)',trd.trainingdata(14:17,4:end)'];

nn.label = TrainTarget;
%-----------Setting--------------------------------s--------------------
for h=1:10:150
    nn.hiddensize     = h;
    nn.activefunction = 's';
    nn.inputsize      = size(InputsTrain,1);
    nn.type           = 'classification';
%-----------Initializzation-----------
    nn                = elm_initialization(nn);

    fprintf('      method      |    Optimal C    |  Training Acc.  |    Testing Acc.   |   Training Time \n');
    fprintf('--------------------------------------------------------------------------------------------\n');

%--------ELM----
    [nn, acc]   = elm_train(InputsTrain, TrainTarget, nn);
    [~, acc_test(h),Y_hat]    = elm_test(InputsTest, TestTarget, nn);
    s(h)=std(acc_test);    
    if acc_test(h)==1
        break;
    end
    fprintf('      ELM    |      %.3f      |      %.5f    \n',acc,acc_test(h));
end
% o=[1 1 1 1 1 1];
% acc_test=[acc_test,o];
% h=h+6;
x=[1:10:h];
subplot(2,1,1);
plot(x,acc_test(1:10:h));
title('Accuracy Plot');
xlabel('Epoch');
ylabel('Accuracy');
% for h=1:50
%     nn.hiddensize     = h;
%     nn.activefunction = 's';
%     nn.inputsize      = size(InputsTrain,1);
%     nn.type           = 'classification';
% %-----------Initializzation-----------
%     nn                = elm_initialization(nn);
% 
%     fprintf('      method      |    Optimal C    |  Training Acc.  |    Testing Acc.   |   Training Time \n');
%     fprintf('--------------------------------------------------------------------------------------------\n');
% 
% %--------ELM--------------------
%     [nn, acc]   = elm_train(InputsTrain, TrainTarget, nn);
%     [~, acc_test(h),Y_hat]    = elm_test(InputsTest, TestTarget, nn);
%     e(h)=mse(nn,TestTarget,Y_hat);
%     if e(h)<0.1
%         break;
%     end
%     fprintf('      ELM    |      %.3f      |      %.5f     |      %.5f    \n',acc,acc_test(h),e(h));
% end
% z=[0 0 0 0 0 0];
% e=[e,z];
subplot(2,1,2);
plot(s);
title('Error Plot');
xlabel('Epoch');
ylabel('Error rate');
% Y_hat=Y_hat';
% for n=1:7
%     if(Y_hat(n,1)>0)
%         TestL(n)=1;
%     elseif(Y_hat(n,2)>0)
%         TestL(n)=2;
%     elseif(Y_hat(n,3)>0)
%         TestL(n)=3;
%     end
% end
% TestTarget=TestTarget';
% for p=1:7
%     if(TestTarget(p,1)>0)
%         TestP(p)=1;
%     elseif(TestTarget(p,2)>0)
%         TestP(p)=2;
%     elseif(TestTarget(p,3)>0)
%         TestP(p)=3;
%     end
% end
