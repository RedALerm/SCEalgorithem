load('cifar1000_data.mat');
% data1 = reshape(data,[256,11000]);
% data = data1';
% data = double(data);
% m = 1000;
% k = 10;
% [n,d] = size(data);
% C1 = zeros(k,n,m);
% W1 = zeros(k,m);
% center1 = zeros(k,d,m);

%�ظ�1000��usps1000_data
% for i = 1:m  
%     [center(:,:,i),C(:,:,i),W(:,i)] = Kmeans(data,data,k);  %%clustering  m times
% end

% %ground_truth
% cc=zeros(10,11000);
% for i=1:10
%     cc(i,(i-1)*1100+1:i*1100)=1;
% end



% our alg

k=10;

time = 2;
W(:,:)=1;
t1=zeros(1,time);
t2=zeros(1,time);
distance=zeros(1,time);
center_new=zeros(10,10000,time);

R=0.2;


for i = 1:time                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
    t1(i) = cputime;    
    center_new(:,:,i) = Furthest(C); 
    t2(i) = cputime-t1(i);
end

%��ground truth�Ƚ�
W_new=ones(10,1);
WA = W_new(:,1)';
WB = W_new(:,1)';
for i=1:time
    distance(i) = Sinkhorn(cc',center_new(:,:,i)',WA,WB);  %sinkhorn
end

% %��ground truth�Ƚ�
% for i = 1:5
%     dis=abs(distance1(cc',center_new(:,:,i)')); % ����X(:,:,i)��b������������
%     %t(:,i)=assignment1(dis);
%     distance(1,i)=assignsum(dis);           %distence(y)=norm(data(x,:)-center(y,:));%���㵽ÿ����ľ��� 
% end

%��1000�����ݱȽ�
s = zeros(1,1000);
ss = zeros(1,time);
for i=1:time
    WA=W_new(:,1)';
    WB=W_new(:,1)';
    for j=1:1000
        s(j)=Sinkhorn(center_new(:,:,i)',C(:,:,j)',WA,WB);  %sinkhorn
    end
    ss(i)=sum(s)/1000;
end



% 
% % ��1000�����ݱȽ�
% for i=1:5
%     WA=W_new(:,1);
%     WB=W_new(:,1);
%     for j=1:1000
%         s(j)=Sinkhorn(center_new(:,:,i)',C(:,:,j)',WA',WB');  %sinkhorn 
%     end
%     ss(1,i)=sum(s);
% end

