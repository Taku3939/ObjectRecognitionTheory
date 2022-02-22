% codebook作成用コード
dirname_pos = "./imgdir_sushi"
dirname_neg = "./bgimg"
PosList = collect(dirname_pos)
NegList = collect(dirname_neg)

PosList = PosList(1:100);
NegList = NegList(1:100);
Training={PosList{:} NegList{:}};

Features=[];
for i=1:200
  I=rgb2gray(imread(Training{i}));
  p=detectSURFFeatures(I);
  [f,p2]=extractFeatures(I,p);
  Features=[Features; f];
end

[idx,CODEBOOK]=kmeans(Features,500);
save("codebook.mat",'CODEBOOK');

function data = collect(dirname)
data = [];
list = dir(dirname);
for i=3 : length(list)
    data{i - 2} = dirname + "/" + list(i).name;
end
end