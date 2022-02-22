% Bof特徴量を求めるための関数
function bof = calcBof(data)
load('codebook.mat', 'CODEBOOK');
bof = zeros(length(data),500);
for j=1:length(data)
  I=rgb2gray(imread(data{j}));
  p=detectSURFFeatures(I);
  [f,p2]=extractFeatures(I,p);
  for i=1:size(p2,1)
      n1=repmat(f(i,:),size(CODEBOOK,1),1);
      [m,index]=min(sum((CODEBOOK-n1).^2,2));
      bof(j,index)=bof(j,index)+1;
  end
end
bof = bof ./ sum(bof,2);
end

