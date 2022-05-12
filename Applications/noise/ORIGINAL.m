

function [AVRtime_high,AVRdis_high] = ORIGINAL(time,disturb,pro)
    % time Ϊʵ��ѭ�����д���    
    % disturb Ϊ�����Ŷ�����
    % pro Ϊÿ��Ԫ���������Ŷ�����

    t_high = zeros(time,1);
    distance_high = zeros(time,1);
    
    %% ʵ������
    for i = 1:time
        [t_high(i),distance_high(i)] = High_dim_result(disturb,pro);
    end
    
    
    %% �����¼
    
    AVRtime_high = mean(t_high);        %�ظ�time�ε�ƽ����ά�ռ�����ʱ��
    AVRdis_high = mean(distance_high);  %�ظ�time�ε�ƽ����ά�ռ�������
    

end