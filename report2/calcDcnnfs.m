% Dcnn特徴量を求める関数
function dcnnfs = calcDcnnf(data)
net = alexnet;
dcnnfs = [];

for i=1:length(data)
    img = imread(data{i});
    reimg = imresize(img,net.Layers(1).InputSize(1:2));

    % activationsを利用して中間特徴量を取り出します．
    % 4096次元の'fc7'から特徴抽出します．
    dcnnf = activations(net,reimg,'fc7');

    % squeeze関数で，ベクトル化します．
    dcnnf = squeeze(dcnnf);

    % L2ノルムで割って，L2正規化．
    % 最終的な dcnnf を画像特徴量として利用します．
    dcnnf = dcnnf/norm(dcnnf);
    dcnnf = transpose(dcnnf);
    dcnnfs = [dcnnfs; dcnnf];
end
end

