% カラーヒストグラムを求めるための関数
function database = calcHist(data)
database = [];
for i=1:length(data)
    X=imread(data{i});
    RED=X(:,:,1); GREEN=X(:,:,2); BLUE=X(:,:,3);
    X64=floor(double(RED)/64) *4*4 + floor(double(GREEN)/64) *4 + floor(double(BLUE)/64);
    X64_vec=reshape(X64,1,numel(X64));
    hist=histc(X64_vec,[0:63]);
    hist = hist / sum(hist);      
    database=[database; hist];
end
end