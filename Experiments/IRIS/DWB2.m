function [W_new,center_new] = DWB2(k,data,W,alg,R)
[m,d,ni]=size(data);
minsum=Inf;
for l=1:3     %l���ظ���ȡѡ��������С��һ��
    e=randi(ni);
    b=data(:,:,e);  %���ѡPi0
    s=zeros(1,ni);
    sum1=0;
    for i=1:ni
        WA=W(:,e)';
        WB=W(:,i)';
        if(alg==1)
            s(i)=Sinkhorn(b',data(:,:,i)',WA,WB);  %sinkhorn
        end
        if(alg==2)
            D=distance1(b',data(:,:,i)');    %network
            s(i)=maintest(D,WA/sum(WA),WB/sum(WB));
        end
    end
    sum1=sum(s);
    if(sum1<minsum)
        mini=e;
        minsum=sum1;  %��¼��С��Ϊcenter(;,;,a),����Ϊy,���ʵ����С�����Ϊminsum
    end
end
center=data(:,:,mini);
times=0;

if (R==1)
    C_s=data;
    W_s=W;
else
    tt0 = cputime;
    [C_s,W_s]=uniformsample(data,R,W);
    tt1 = cputime - tt0;
    %C_s=data;
    %W_s=W;
end



while 1
    times=times+1;
    
    
    [m,d,ni]=size(C_s);
    p=0;
    center_new=zeros(m,d);
    W_new=zeros(k,1);
    for i=1:ni
        dis=abs(distance1(C_s(:,:,i)',center(:,:)'));%����X(:,:,i)��b��end����
        t=assignment1(dis);
        for j=1:m
            center_new(t(j),:)=center_new(t(j),:)+C_s(j,:,i);
            W_new(t(j),1)=W_new(t(j),1)+W_s(j,i);
        end
    end
    center_new(:,:)=center_new(:,:)/ni;
    for i=1:ni
        WA=W(:,1)';
        WB=W(:,1)';
        if(alg==1)
            s(i)=Sinkhorn(center_new',data(:,:,i)',WA,WB);  %sinkhorn
        end
        if(alg==2)
            D=distance1(center_new',data(:,:,i)');    %network
            s(i)=maintest(D,WA/sum(WA),WB/sum(WB));
        end
    end
    ss(times)=sum(s);
    W_new=W_new/ni;
    for i=1:m
        %disp(norm(center_new(i,:)-center(i,:)));
        if (norm(center_new(i,:)-center(i,:))<3)
             p=p+1;
        end
    end
if p==m
     break;
else
     center=center_new;
end
end
end