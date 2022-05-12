function [S,WW]=uniformsample(data,R,W)
   
   [~,~,n]=size(data);
   
%    rand=randperm(n);
%    index=rand(1:r);
%    index=sort(index);
%    S=data(:,:,index);
%    St(1:r)=1/n;
%    WW=W(:,index);
   
   r=round(R*n);
   index = randsample(n,r,true);
   S=data(:,:,index);
   WW=W(:,index);
   
   
end