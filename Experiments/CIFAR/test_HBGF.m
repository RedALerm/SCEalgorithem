load('cifar1000_data.mat');
% 
% cc=zeros(10,11000);
% for i=1:10
%     cc(i,(i-1)*1100+1:i*1100)=1;
% end


% HBGF 
e=[1 2 3 4 5 6 7 8 9 10];
D=zeros(1000,10000);
for j=1:1000
    disp(j);
  D(j,:)=e*C(:,:,j);
end
D=D';
idxs=(1:1000);
k=10;
W_new=ones(10,1);

% t3=cputime;
% E=HBGF_spec(D,idxs,k);
% t4=cputime-t3;
% F=zeros(10,10000);
% for i=1:10000
%     disp(i);
%     F(E(i),i)=1;
% end

time = 10;
t1=zeros(1,time);
t2=zeros(1,time);
distance=zeros(1,time);
center_new=zeros(10,10000,time);
F=zeros(10,10000,time);
% 执行
for i=1:time
    t1(i)=cputime;  
    E = HBGF_spec(D,idxs,k);
    t2(i)=cputime-t1(i);
    
    for j = 1:10000
        disp(j);
        F(E(j),j,i)=1;
    end
end

%跟ground truth比较
WA = W_new(:,1)';
WB = W_new(:,1)';
for i=1:time
    distance(i) = Sinkhorn(cc',F(:,:,i)',WA,WB);  %sinkhorn
end


%跟1000个数据比较
s = zeros(1,1000);
ss = zeros(1,time);
for i=1:time
    WA=W_new(:,1)';
    WB=W_new(:,1)';
    for j=1:1000
        s(j)=Sinkhorn(F(:,:,i)',C(:,:,j)',WA,WB);  %sinkhorn
    end
    ss(i)=sum(s)/1000;
end


% % 跟ground truth比较
% dis=abs(distance1(cc',F')); % 计算X(:,:,i)到b的匈牙利距离
% tt=assignment1(dis);
% distance_hbgf=assignsum(dis); 
% %跟1000个数据相比 10组

% for i=1:1
%     WA=W_new(:,1)';
%     WB=W_new(:,1)';
%     for j=1:100
%         if(alg==1)
%             s(j)=Sinkhorn(F',C(:,:,j)',WA,WB);  %sinkhorn
%         end
%         if(alg==2)
%             D=distance1(F',C(:,:,j)');    %network
%             s(j)=maintest(D,WA/sum(WA),WB/sum(WB));
%         end           
%     end
%     ss(1,i)=sum(s);
% end



% times=1;
% 
% for i=1:1000
%     WA=W_new(:,1)';
%     WB=W_new(:,1)';
%     for j=1:10
%         if(alg==1)
%             s(i)=Sinkhorn(F',C(:,:,i)',WA,WB);  %sinkhorn
%         end
%         if(alg==2)
%             D=distance1(F',C(:,:,i)');    %network
%             s(i)=maintest(D,WA/sum(WA),WB/sum(WB));
%         end   
%     end
% end
% ss(1,times)=sum(s);
% 
