function distM=distance1(A,B)
% inputs:
% A,B: point sets
%
% outputs:
% distM: distance matrix

% Computing the squared Euclidean distance matrix
D=size(A,1);
X2=sum(A.^2,1);
if nargin>=2
    d=size(B,1);
    if D~=d
        error('Both sets of vectors must have same dimensionality!\n');
    end
    Y2=sum(B.^2,1);
    distM=bsxfun(@plus,X2',bsxfun(@plus,Y2,-2*(A'*B)));
else % Computing the squared Euclidean distance matrix of X itself
    distM=bsxfun(@plus,X2',bsxfun(@plus,X2,-2*(A'*A)));
end
end

