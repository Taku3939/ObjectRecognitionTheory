% webからデータを落とすためのコード
list=textread('input_delicious_sushi.txt','%s');

OUTDIR='imgdir_delicious_sushi';
mkdir(OUTDIR);
for i=1:size(list,1)
  fname=strcat(OUTDIR,'/',num2str(i,'%04d'),'.jpg')
  websave(fname,list{i});
end