

function [Result,Result_avr] = ACCELERATE(time,cycle,rate,dim_method)
    
    t_low = zeros(time,1);
    distance_low = zeros(time,1);
    distance_avr = zeros(time,1);

    %% ʵ������
    % ͶӰά��
    %rate = 0.05;        % ָҪ���͵�ά����ԭά�ȵ�rate       !!�ɵ�����2
    % ��ά������1->JL��2->FS��3->PCA
    % dim_method = 3;     % ��ά����                        !!�ɵ�����3
    for i = 1:time
        [t_low(i),distance_low(i),distance_avr(i)] = Low_dim_result(cycle,rate,dim_method);
    end
    AVRtime_low = mean(t_low);          %�ظ�time�ε�ƽ����ά�ռ�����ʱ��
    STDtime_low = std(t_low);           %�ظ�time�εĵ�ά�ռ�����ʱ���׼��

    AVRdis_low = mean(distance_low);    %�ظ�time�ε�ƽ����ά�ռ�������
    STDdis_low = std(distance_low);     %�ظ�time�εĵ�ά�ռ��������׼��

    AVRavr_low = mean(distance_avr);    %�ظ�time�ε�ƽ��ƽ������
    STDavr_low = std(distance_avr);     %�ظ�time�ε�ƽ������ı�׼��

    %% ���չʾ
    
    Result = zeros(4,1);
    Result_avr = zeros(4,1);
    Result(1) = AVRtime_low;               %ֱ������ / �ظ�time�ε�����ʱ���ƽ��ֵ
    Result(2) = STDtime_low;               %ֱ������ / �ظ�time�ε�����ʱ�䷽��
    Result(3) = AVRdis_low;                %ֱ������ / �ظ�time�ε�����ʵ���Wasserstein����ƽ��ֵ
    Result(4) = STDdis_low;                %ֱ������ / �ظ�time�ε�����ʵ���Wasserstein���뷽��
    
    Result_avr(3) = AVRavr_low;
    Result_avr(4) = STDavr_low;
    
    
    if (dim_method == 1)
        X = 'JL:';
        disp(X)
    elseif ( dim_method == 3)
        X = 'PCA:';
        disp(X)
    end
    X = ['����ʱ���ֵ��',num2str(AVRtime_low)];
    disp(X)
    X = ['����ʱ�䷽�',num2str(STDtime_low)];
    disp(X)
    X = ['��ʵ��Wasserstein�����ֵ��',num2str(AVRdis_low)];
    disp(X)
    X = ['��ʵ��Wasserstein���뷽�',num2str(STDdis_low)];
    disp(X)
    
    % t_low = t_low'
    % distance_low = distance_low'
    % distance_avr = distance_avr';

end