% Bof用コード
net = alexnet;
addpath('.');
dir_a = './imgdir_sushi';
dir_b = './imgdir_oyakodon';

% 5 validation
n = 5;

data_a_list = calcData(dir_a);
data_b_list = calcData(dir_b);
ks = [];
% dcnnf
for i=1:n
    data_a_test = data_a_list{i};
    data_a = [];
    for j = 1:n
        if i ~= j
            data_a = [data_a data_a_list{j}];
        end
    end
    data_b_test = data_b_list{i};
    data_b = [];
    for j = 1:n
        if i ~= j
            data_b = [data_b data_b_list{j}];
        end
    end
     bof_a = calcBof(data_a);
     bof_b = calcBof(data_b);
     bof_a_test = calcBof(data_a_test);
     bof_b_test = calcBof(data_b_test);

     training_data = bof_a;
     testing_data = [bof_a_test; bof_b_test];
     training_label = [];
     for i=1:length(data_a)
         training_label(i, 1) = 1;
     end

     training_test_label = [];
     
     for i=1:length(data_a_test) + length(data_b_test)
         if i <= length(data_a_test)
             training_test_label(i, 1) = 1;
         else
             training_test_label(i, 1) = -1;
         end
     end


     % svm
     model = fitcsvm(training_data,training_label,'KernelFunction','rbf','KernelScale','auto');

     % 分類関数svmpredict
     [predicted_label, scores] = predict(model, testing_data);

     k = 0;
     for i=1:length(training_test_label)
         if training_test_label(i)==predicted_label(i)
             k = k + 1;
         end
     end

     ks = [ks k / length(training_test_label)];
end

mean(ks)

