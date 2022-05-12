load('cifar1000_data.mat');


m = 1000;
r = round(10^1);
index = randsample(m,r,true);
C = C(:,:,index);
W = W(:,index);
center = center(:,:,index);




% our alg

time = 30;
k = 10;
W(:,:)=1;
t1=zeros(1,time);
t2=zeros(1,time);
distance=zeros(1,time);
W_new=zeros(10,time);
center_new=zeros(10,10000,time);

alg=1;
R=1;


for i=1:time
    t1(i) = cputime;    
    [W_new(:,i),center_new(:,:,i)] = DBW2(k,C,W,alg,R); 
    t2(i) = cputime-t1(i);
end



%跟ground truth比较
WA = W_new(:,1)';
WB = W_new(:,1)';
for i=1:time
    distance(i) = Sinkhorn(cc',center_new(:,:,i)',WA,WB);  %sinkhorn
end





%跟1000个数据比较
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
a = 1111
s
ss
t2
A(1,:)=mean(distance,2);
AA(1,:)=std(distance);
B(1,:)=mean(t2,2);
BB(1,:)=std(t2);