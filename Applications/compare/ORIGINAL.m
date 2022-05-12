

function [Result] = ORIGINAL(time,cycle,alg)
    
    t_high = zeros(time,1);
    distance_high = zeros(time,1);
    
    %% ʵ������
    if (alg == 1)                           %ԭ�ռ�ֱ�Ӿ���
        for i = 1:time
            [t_high(i),distance_high(i)] = High_dim_result();
        end
        AVRtime_high = mean(t_high);        %�ظ�time�ε�ƽ����ά�ռ�����ʱ��
        STDtime_high = std(t_high);         %�ظ�time�εĸ�ά�ռ�����ʱ���׼��
    
        AVRdis_high = mean(distance_high);  %�ظ�time�ε�ƽ����ά�ռ�������
        STDdis_high = std(distance_high);   %�ظ�time�εĸ�ά�ռ��������׼��
        
    elseif (alg == 2)                       %ԭ�ռ���༯��
        for i = 1:time
            [t_high(i),distance_high(i)] = High_dim_result_ensemble(cycle);
        end
        AVRtime_high = mean(t_high);        %�ظ�time�ε�ƽ����ά�ռ�����ʱ��
        STDtime_high = std(t_high);         %�ظ�time�εĸ�ά�ռ�����ʱ���׼��
    
        AVRdis_high = mean(distance_high);  %�ظ�time�ε�ƽ����ά�ռ�������
        STDdis_high = std(distance_high);   %�ظ�time�εĸ�ά�ռ��������׼��
    end    
    
    %% ���չʾ
    
    Result = zeros(4,1);
    Result(1) = AVRtime_high;               %ֱ������ / �ظ�time�ε�����ʱ���ƽ��ֵ
    Result(2) = STDtime_high;               %ֱ������ / �ظ�time�ε�����ʱ�䷽��
    Result(3) = AVRdis_high;                %ֱ������ / �ظ�time�ε�����ʵ���Wasserstein����ƽ��ֵ
    Result(4) = STDdis_high;                %ֱ������ / �ظ�time�ε�����ʵ���Wasserstein���뷽��
    
    
    if (alg == 1)
        X = 'High Dimension Result:';
        disp(X)
    elseif ( alg == 2)
        X = 'High Dimension Ensemble Result:';
        disp(X)
    end
    X = ['����ʱ���ֵ��',num2str(AVRtime_high)];
    disp(X)
    X = ['����ʱ�䷽�',num2str(STDtime_high)];
    disp(X)
    X = ['��ʵ��Wasserstein�����ֵ��',num2str(AVRdis_high)];
    disp(X)
    X = ['��ʵ��Wasserstein���뷽�',num2str(STDdis_high)];
    disp(X)

    % t_high = t_high'
    % distance_high = distance_high'

end