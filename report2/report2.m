% レポート課題2
net = alexnet;
addpath('.');
dir_a = './imgdir_re_delicious_sushi';
dir_b = './bgimg';
dir_c = './imgdir_delicious_sushi';



data_a = calcData2(dir_a);
data_b = calcData2(dir_b);
data_c = calcData2(dir_c);

% dcnnf
dcnnfs_a = calcDcnnfs(data_a);
dcnnfs_b = calcDcnnfs(data_b);
dcnnfs_c = calcDcnnfs(data_c);

training_data = [dcnnfs_a; dcnnfs_b];
testing_data = dcnnfs_c;
training_label = [];
for i=1:length(data_a) + length(data_b)
    if i <= length(data_a)
        training_label(i, 1) = 1;
    else
        training_label(i, 1) = -1;
    end
end

% svm
model = fitcsvm(training_data, training_label,'KernelFunction','linear');

% 分類関数svmpredict
[predicted_label, score] = predict(model, testing_data);

% 降順 ('descent') でソートして，ソートした値とソートインデックスを取得します
[sorted_score,sorted_idx] = sort(score(:,2), 'descend');

% list{:} に画像ファイル名が入っているとして，
% sorted_idxを使って画像ファイル名，さらに
% sorted_score[i](=score[sorted_idx[i],2])の値を出力します．


training_test_label = [];
  
%size = numel(sorted_idx);

FID = fopen('exp.txt','w');


size = 100;
for i=1:size
    img_name = data_c{sorted_idx(i)};
    [X1,map1]=imread(img_name);
    subplot(10, size / 10, i), imshow(X1,map1)
    s1 = sorted_score(i);
    if s1 >= 0  
        training_test_label(i, 1) = 1;
    else
        training_test_label(i, 1) = -1;
    end
    fprintf(FID,'%s %.5f\n',img_name,s1);
    %fprintf('%s %f\n',,sorted_score[i]);
end
k = 0;
for i=1:length(training_test_label)
    if training_test_label(i)==predicted_label(i)
        k = k + 1;
    end
end

fclose(FID);
% 出力
k / length(training_test_label)




function data = calcData2(dirname)
data = [];
list = dir(dirname);
d = length(list);
for i=3 : d
    data{i - 2} = dirname + "/" + list(i).name;
end
end

