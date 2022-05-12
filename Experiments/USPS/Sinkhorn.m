% Sinkhorn distance

function [EMD]=Sinkhorn(A,B,WA,WB)
% inputs:
% A,B: point sets
% WA,WB: weights of A and B

% Squared Euclidean distance matrix
WA=WA/sum(WA);
WB=WB/sum(WB);
disMat=distance1(A,B);
disMat(disMat<0)=0;
% disMat=sqrt(disMat);
lambda=60/median(disMat(:));
K=exp(-lambda*disMat);
U=K.*disMat;
[EMD,~,u,v]=Transport(WA',WB',K,U,lambda);
FM=bsxfun(@times,v',bsxfun(@times,u,K));