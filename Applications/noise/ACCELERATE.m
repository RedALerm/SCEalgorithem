

function [AVRtime_low,AVRdis_low,AVRavr_low] = ACCELERATE(time,cycle,rate,disturb,pro,dim_method)
    % time Ϊʵ��ѭ�����д���
    % cycle Ϊ�����������
    % rate Ϊ��ά����
    % disturb Ϊ�����Ŷ�����
    % pro Ϊÿ��Ԫ���������Ŷ�����
    % dim_method Ϊ��ά������1����JL��ά; 3����PCA��ά

    t_low = zeros(time,1);
    distance_low = zeros(time,1);
    distance_avr = zeros(time,1);

    %% ʵ������
    % ͶӰά��
    %rate = 0.05;        % ָҪ���͵�ά����ԭά�ȵ�rate       !!�ɵ�����2
    % ��ά������1->JL��2->FS��3->PCA
    % dim_method = 3;     % ��ά����                        !!�ɵ�����3
    for i = 1:time
        [t_low(i),distance_low(i),distance_avr(i)] = Low_dim_result(cycle,rate,disturb,pro,dim_method);
    end

    %% �����¼
    
    AVRtime_low = mean(t_low);          %�ظ�time�ε�ƽ����ά�ռ�����ʱ��
    AVRdis_low = mean(distance_low);    %�ظ�time�ε�ƽ����ά�ռ�������
    AVRavr_low = mean(distance_avr);    %�ظ�time�ε�ƽ��ƽ������
    
end