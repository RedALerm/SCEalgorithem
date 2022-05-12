
function [C_bar] = Furthest(C_input)

[k,n,m] = size(C_input);
C = zeros(n,m);
for i = 1:m
    for j = 1:k
        C(:,i) = C(:,i) + j*C_input(j,:,i)';
    end
end

X = zeros(n,n);                     %Distance Matrix
for i_1 = 1:n-1
    for i_2 = i_1+1:n
        count = 0;
        for j = 1:m
            if( C(i_1,j)~=C(i_2,j) )
                count = count+1;
            end
        end
        X(i_1,i_2) = (1/m)*count;
        X(i_2,i_1) = (1/m)*count;
    end
end

for i = 1:n
    X(i,i) = -Inf;
end

dist = zeros(k,1);
center = zeros(k,1);
signal = zeros(n,1);
num = zeros(k,1);
partition = zeros(n,k);
dist(1) = max(max(X));
[row,col] = find( X==dist(1) );
result = unidrnd( length(row) );
 center(1) = row(result);
center(2) = col(result);

for j = 1:n
    if( X(j,center(1))<X(j,center(2)) )
        signal(j) = 1;
        num(1) = num(1)+1;
        partition(num(1),1) = j;
    else
        signal(j) = 2;
        num(2) = num(2)+1;
        partition(num(2),2) = j;
    end 
end
now_clu1 = partition(1:num(1),1);
now_clu2 = partition(1:num(2),2);
CLU1 = X(now_clu1,now_clu1);
CLU2 = X(now_clu2,now_clu2);

dist(1) = max(max(CLU1));
dist(2) = max(max(CLU2));

for i = 3:k
    [~,goal_clu] = max(dist(1:i-1));
    now_clu = partition(1:num(goal_clu),goal_clu);
    Y = X(now_clu,now_clu);
    [a,b] = find( Y == dist(goal_clu) );
    result = unidrnd( length(a) );
    row = partition(a(result),goal_clu);
    col = partition(b(result),goal_clu);
    center(goal_clu) = row;
    center(i) = col;
    
    
    whole = partition(:,goal_clu);
    partition(:,goal_clu) = zeros(n,1);
    count = num(goal_clu);
    num(goal_clu) = 0;
    for j = 1:count
        if( X(j,center(goal_clu))<X(j,center(i)) )
            signal(whole(j)) = goal_clu;
            num(goal_clu) = num(goal_clu)+1;
            partition(num(goal_clu),goal_clu) = whole(j);
        elseif( X(j,center(goal_clu))>X(j,center(i)) )
            signal(whole(j)) = i;
            num(i) = num(i)+1;
            partition(num(i),i) = whole(j);
        else
            v = unidrnd(2);
            if( v==1 )
                signal(whole(j)) = goal_clu;
                num(goal_clu) = num(goal_clu)+1;
                partition(num(goal_clu),goal_clu) = whole(j);
            else
                signal(whole(j)) = i;
                num(i) = num(i)+1;
                partition(num(i),i) = whole(j);
            end
        end 
    end
    now_clu1 = partition(1:num(goal_clu),goal_clu);
    now_clu2 = partition(1:num(i),i);
    CLU1 = X(now_clu1,now_clu1);
    CLU2 = X(now_clu2,now_clu2);
    
    dist(goal_clu) = max(max(CLU1));
    dist(i) = max(max(CLU2));
end

Z = zeros(n,k);

for i = 1:k
    b = find( signal==i );
    Z(b,i) = 1;
end
C_bar = Z';


end