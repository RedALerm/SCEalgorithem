function clusterid=HBGF_spec(ceresults, idxs,  k)
% clusterid=HBGF_spec(ceresults, idxs,  k)
% ceresults: contains a library of clustering solutions, each column is one solution.
% idxs: contains the indexs of the solutions that are included in the ensemble. 
% If you want to use all the solutions in ceresults, set idxs = length(ceresults, 2)
% k: the number of clusters for the final clustering

sresults = ceresults(:, idxs);
esize = length(idxs);
instnum = size(ceresults,1);
% form the connectivity matrix instnum X totalk
w=formw(sresults, esize, instnum);

% compute the size of each cluster
csize=sum(w);

% normalize the vectors
w = w*diag(1./sqrt(csize));

% u is the eigenvector of normalized S(similarity matrix)
[u,s,v]= svds(w,k);
% normalize the rows
u = u./repmat(sqrt(sum(u.^2,2)), 1, k);
v = v./repmat(sqrt(sum(v.^2,2)), 1, k);

% find a good set of initial centers
idxperm=randperm(instnum);
centers(1,:) = u(idxperm(1),:);

c=zeros(instnum,1);
c(idxperm(1),1) = 2*k; %ensure this point is not to be selected again

for i=2:k

 c=c+abs(u*(centers(i-1,:))');
 [y,m] = min(c);
 centers(i,:) = u(m, :);
 c(m,1) = 2*k;
 
 end

% perform kmeans with the found initial centers
clusterid= kmeans(vertcat(u,v), k, 'start', centers, 'maxiter', 200, 'emptyaction', 'singleton');
%clusterid= kmeans(vertcat(u,v), k, 'maxiter', 200, 'emptyaction', 'singleton', 'rep',5);
clusterid(instnum+1:size(clusterid,1), :) = [];


function w=formw(idxs, r, instnum)
% this function turns a cluster ensemble into a set of new binary features, one for each cluster
% if the object belongs to that cluster, the value is set to 1, and 0 otherwise
site=1;
for i=1:r
  idx = idxs(:,i);
  uniqueks=unique(idx(idx>0)); % 0 is considered to be the unclustered 
  t=zeros(instnum, length(uniqueks));
  t(find(repmat(idx, 1, length(uniqueks)) == repmat(uniqueks', instnum, 1)))=1;
  w(:, site:site+length(uniqueks)-1) = t;
  site=site+length(uniqueks);
end


