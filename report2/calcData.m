% ディレクトリ化のファイルパスのリストデータを5分割したリストにするための関数
function data = calcData(dirname)
data = [];
list = dir(dirname);
d = int16((length(list) - 2)/ 5);
for i=3 : d
    data_1{i - 2} = dirname + "/" + list(i).name;
    data{1} = data_1;
end

for i=3 + d : 2 + d*2
    data_1{i - 2 - d} = dirname + "/" + list(i).name;
    data{2} = data_1;
end
for i=3 + d *2: 2 + d*3
    data_1{i - 2 - d*2} = dirname + "/" + list(i).name;
    data{3} = data_1;
end
for i=3 + d *3: 2 + d*4
    data_1{i - 2 - d*3} = dirname + "/" + list(i).name;
    data{4} = data_1;
end

for i=3 + d *4: length(list)
    data_1{i - 2 - d*4} = dirname + "/" + list(i).name;
    data{5} = data_1;
end
end