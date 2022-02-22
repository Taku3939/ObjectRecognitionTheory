% カラーヒストグラム用コード
addpath('.');
dir_a = './imgdir_sushi';
dir_b = './imgdir_oyakodon';

% 5 validation
n = 5;

data_a_list = calcData(dir_a);
data_b_list = calcData(dir_b);
ks = [];
% hist
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
     hist_a = calcHist(data_a);
     hist_b = calcHist(data_b);
     hist_a_test = calcHist(data_a_test);
     hist_b_test = calcHist(data_b_test);

     training_data = [hist_a; hist_b];
     %testing_data = [hist_a_test; hist_b_test];



    % Positiveは，Positiveが最近傍ならOK，Negativeが最近傍ならNG.
    k = 0;
    for i=1:length(data_a_test)
        idx = 1;
        v = sum(abs(training_data(1,:) - hist_a_test(i,:)));
        for j =1:length(training_data)
            m = sum(abs(training_data(j, :) - hist_a_test(i, :)));
            if v > m
                idx = j;
                v = m;
            end
        end

        if idx <= length(data_a)
            k = k + 1;
        end
    end
    for i=1:length(data_b_test)
        idx = 1;
        v = sum(abs(training_data(1,:) - hist_b_test(i,:)));
        for j =1:length(training_data)
            m = sum(abs(training_data(j, :) - hist_b_test(i, :)));
            if v > m
                idx = j;
                v = m;
            end
        end

        if idx > length(data_a)
            k = k + 1;
        end
    end
    k = k / (length(data_a_test) + length(data_b_test));
    ks = [ks k];
end

mean(ks)

