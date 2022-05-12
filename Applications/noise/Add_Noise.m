
function [n,data] = Add_Noise(disturb,pro)
    
    load('feat_apascal_train.mat');
    data = full(feat');
    [n,col] = size(data);
    
    %����1�������Ŷ��ĸ�������
    turbulence = disturb * max(max(abs(data)));     %�Ŷ��Ͻ�Ϊ�������ֵ���ֵ��40%
    judge = -1 + 2*rand(n,col);                 %�������������Ϊ�����ж���λ���Ƿ��ܵ������Ŷ�
    %����2��ÿ��Ԫ���ܵ������Ŷ��ĸ���
    % pro = 0.3;                                %�ܵ������Ŷ��ĸ���Ϊ40%
    for i = 1:n
        for j = 1:col
            if ( abs(judge(i,j))<=pro )
                data(i,j) = data(i,j) + judge(i,j)/pro*turbulence;
            end
        end
    end
    
end
