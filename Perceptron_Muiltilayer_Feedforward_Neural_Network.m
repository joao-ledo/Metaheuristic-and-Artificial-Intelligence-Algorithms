%_________________________________________________________________________%
%                                                                         %
%                                                                         %
%                         ARTIFICIAL NEURAL NETWORK                       %
%                    (PERCEPTRON - Multilayer Feedforward)                %
%                                                                         %
%                                          Developed by:                  %
%                                                 Joao Augusto Silva Ledo %
%_________________________________________________________________________%

function result = Perceptron_Multicamadas_Feedforward()
    clear all;
    close all
    clc;
    format short;
    result = solvePerceptron_Multicamadas();
end

function result = solvePerceptron_Multicamadas()
        answer = ChoseTraining();
    if(answer == 1)
        delete('Perceptron_Multicamadas_FeedforwardTrainedNeuralNetwork.mat');
        TrainingSet = loadTrainingSet();
        TrainedNeuralNetwork = TrainingPerceptron_Multicamadas(TrainingSet);
        resultado = TrainedNeuralNetwork;
    else
        if(answer == 2)
            TrainedNeuralNetwork = load('Perceptron_Multicamadas_FeedforwardTrainedNeuralNetwork.mat');
            data = loadInputData();
            GraficoTreinamento(TrainedNeuralNetwork.resultado.k, TrainedNeuralNetwork.resultado.Error);
            nntraintool;
            plottrainstate(TrainedNeuralNetwork.resultado.tr);
            plotperform(TrainedNeuralNetwork.resultado.tr);
            resultado = runPerceptron_Multicamadas(TrainedNeuralNetwork.resultado, data, TrainedNeuralNetwork.resultado.k);
        else
            if(answer == 3)
                TrainingSet = loadTrainingSet();
                TrainedNeuralNetwork = TrainingPerceptron_Multicamadas(TrainingSet);
                data = loadInputData();
                resultado = runPerceptron_Multicamadas(TrainedNeuralNetwork, data, TrainedNeuralNetwork.k);
            end
        end
    end
    result = resultado;
end

function result = loadTrainingSet()
    nmr_padroes = 500;
    for(i = 1: nmr_padroes)                              % [x1, x2, x3]  
        inputTrainingList{i}.Value = [pi/2.*rand(), pi/2.*rand(), pi/2.*rand()];
        inputTrainingList{i}.target = 1/3*[sin(inputTrainingList{i}.Value(1))+sin(inputTrainingList{i}.Value(2))+sin(inputTrainingList{i}.Value(3))];  % d        
    end  
    resultado.k = 1;
    resultado.nepta = 0.1;
    resultado.Epslon = 10^-6;
    resultado.NeuroniosCamadaEscondida = 10;
    for(j = 1 : resultado.NeuroniosCamadaEscondida)
       wEscondido{j} = rand(1, length(inputTrainingList{1}.Value)); 
    end
    resultado.w{resultado.k} = {wEscondido, rand(resultado.NeuroniosCamadaEscondida, 1)};
    resultado.w0{resultado.k} = {rand(resultado.NeuroniosCamadaEscondida, 1), rand()};
    resultado.inputTrainingList = inputTrainingList;
    resultado.Security = 10000;
    result = resultado;
end

function result = loadInputData()
    nmr_padroes = 100;    
    for(i = 1: nmr_padroes)
        inputDataList{i}.Value = [pi/2.*rand(), pi/2.*rand(), pi/2.*rand()];
        inputDataList{i}.target = 1/3*[sin(inputDataList{i}.Value(1))+sin(inputDataList{i}.Value(2))+sin(inputDataList{i}.Value(3))];  % d 
    end  
    resultado.inputDataList = inputDataList;
    result = resultado;
end

function result = rand_in_bounds(min, max)
  result = min + ((max-min) * rand());
end

function result = ChoseTraining()
    resultado = input('Choose: \n 1-Training the Artificial Neural Network \n 2-Use the Artificial Neural Network \n 3-Training and Use the Artificial Neural Network \n');
    resultado = VerificaOpcao(resultado);
    result = resultado;
end

function result = VerificaOpcao(answer)
    while((answer ~= 1) && (answer ~= 2) && (answer ~= 3))
       answer = input('Choose carefully: \n 1-Training the Artificial Neural Network \n 2-Use the Artificial Neural Network \n 3-Training and Use the Artificial Neural Network \n');
    end
    if(answer == 2)
        if(~exist('PerceptronTrainedNeuralNetwork.mat', 'file'))
            while((answer ~= 1) && (answer ~= 3))
                answer = input('Please train the Artificial Neural Network first: \n 1-Training the Artificial Neural Network \n 3-Training and Use the Artificial Neural Network \n');
            end
        end
    end            
    result = answer;
end

function result = TrainingPerceptron_Multicamadas(TrainingSet)
    resultado.Nome = 'Trained Perceptron Multilayer Feedforward Artificial Neural Network'; 
    seguranca = TrainingSet.Security;
    NeuroniosCamadaEscondida = TrainingSet.NeuroniosCamadaEscondida;
    k = TrainingSet.k;
    nepta = TrainingSet.nepta;
    Epslon = TrainingSet.Epslon;
    w = TrainingSet.w;
    w0 = TrainingSet.w0;
    inputTrainingList = TrainingSet.inputTrainingList;
    Error(k) = 1;
    Error(k+1) = 0; 
    for(i = 1 : length(inputTrainingList))
        for(j = 1 : length(inputTrainingList{i}.Value))
            x(i,j) = inputTrainingList{i}.Value(j);
        end
        d(i) = inputTrainingList{i}.target;
    end
    net = feedforwardnet([NeuroniosCamadaEscondida, 1], 'trainlm');
    net.trainParam.showWindow = 1;
    net.trainParam.epochs = length(inputTrainingList);
    net.trainParam.goal = Epslon;
    net.trainParam.time = inf;
    net.divideFcn = 'dividerand';
    net.divideParam.trainRatio = 0.4;
    net.divideParam.valRatio = 0.30;
    net.divideParam.testRatio = 0.30;
    [net, tr] = train(net, x', d);     
    for(i = 1 : NeuroniosCamadaEscondida)
        w{1}{i} = net.Iw{1}(i,:);    
    end  
    w{2} = net.Lw{2,1};
    k = tr.num_epochs;
    Error = tr.gradient;
    GraficoTreinamento(k, Error);
    resultado.Lista_de_Treinamento = TrainingSet.inputTrainingList;
    resultado.NeuroniosCamadaEscondida = NeuroniosCamadaEscondida;
    resultado.delta_w = tr.mu;
    resultado.Error = Error;
    resultado.w = w;
    resultado.k = k-1;
    resultado.tr = tr;
    resultado.net = net;
    save('Perceptron_Multicamadas_FeedforwardTrainedNeuralNetwork.mat', 'resultado');
    result = resultado;
end

function GraficoTreinamento(k, Error)
    for(i=1 : k)
        epocas(i) = i;
        erro(i) = abs(Error(i+1)-Error(i));
    end   
     subplot(3,1,1) 
     plot(epocas, erro, 'r');
     title('EQM x EPOCAS');
     ylabel('EQM');
     xlabel('EPOCA');
     grid
end

function result = runPerceptron_Multicamadas(TrainedNeuralNetwork, inputData, k)
    for(i = 1 : length(inputData.inputDataList))
        ClassifiedInputData{i}.InputValue = inputData.inputDataList{i}.Value;
        ClassifiedInputData{i}.TargetValue = inputData.inputDataList{i}.target;
        for(j=1:  TrainedNeuralNetwork.NeuroniosCamadaEscondida)                 
            y{1}(j)=logsig(TrainedNeuralNetwork.w{1}{j}*ClassifiedInputData{i}.InputValue'- TrainedNeuralNetwork.w{2}(j));
        end
        ClassifiedInputData{i}.y_Escondida = y{1};
        ClassifiedInputData{i}.y_Saida = logsig(TrainedNeuralNetwork.w{2}*y{1}');
        y_saida(i) = ClassifiedInputData{i}.y_Saida;
        Erro_teste(i)=(ClassifiedInputData{i}.TargetValue-ClassifiedInputData{i}.y_Saida');
        Erro_Absoluto(i)=abs(ClassifiedInputData{i}.TargetValue-ClassifiedInputData{i}.y_Saida');
        Erro_Relativo(i)=(abs(Erro_Absoluto(i))./ClassifiedInputData{i}.TargetValue);
        Dt(i) = ClassifiedInputData{i}.TargetValue;
    end
    Erro_Relativo_Medio=100*mean(Erro_Relativo);
    DesvioPadrao_Erro_Relativo=100*std(Erro_Relativo);
    Erro_Absoluto_Medio=mean(Erro_Absoluto);
    DesvioPadrao_Erro_Absoluto=std(Erro_Absoluto);    
    GraficoRunning(length(inputData.inputDataList), y_saida, Dt, Erro_teste, Erro_Absoluto, Erro_Relativo_Medio, DesvioPadrao_Erro_Relativo, Erro_Absoluto_Medio, DesvioPadrao_Erro_Absoluto);
    resultado.Nome = 'Perceptron_Multilayer_Feedforward';
    resultado.Treining = TrainedNeuralNetwork;
    resultado.Classification = ClassifiedInputData;
    resultado.Erro_teste = Erro_teste;
    resultado.Erro_Absoluto = Erro_Absoluto;
    resultado.Erro_Relativo = Erro_Relativo;
    resultado.Erro_Relativo_Medio = Erro_Relativo_Medio;
    resultado.DesvioPadrao_Erro_Relativo = DesvioPadrao_Erro_Relativo;
    resultado.Erro_Absoluto_Medio = Erro_Absoluto_Medio;
    resultado.DesvioPadrao_Erro_Absoluto = DesvioPadrao_Erro_Absoluto;
    resultado.tr = TrainedNeuralNetwork.tr;
    resultado.net = TrainedNeuralNetwork.net;
    result = resultado;
end

function GraficoRunning(NumeroTestes, y_saida, Dt, Erro_teste, Erro_Absoluto, Erro_Relativo_Medio, DesvioPadrao_Erro_Relativo, Erro_Absoluto_Medio, DesvioPadrao_Erro_Absoluto)
    subplot(3,1,2) 
    plot(1:NumeroTestes,Dt,'r',1:NumeroTestes,y_saida,'b')
    title('TEST: REAL VALUES (red.) X RNA (blue)');
    ylabel('REAL and RNA');
    xlabel('PATTERNS');
    grid 
    subplot(3,1,3) 
    plot(1:NumeroTestes,Erro_teste)
    title('Validating: ERROR x PATTERN');
    ylabel('ERROR');
    xlabel('PATTERNS');
    grid 
    figure
    eixoX= 1:1:length(Dt);
    plot(eixoX,Dt,eixoX,y_saida)
    grid
    xlabel('Sample Tests','FontWeight','bold','Fontsize',11.5)
    ylabel('Values','FontWeight','bold','Fontsize',11.5)
    legend('Observed Values','Estimated Values')
    title(['Observed Values x Estimated: ERM(%)=', num2str(Erro_Relativo_Medio,3),', DP(%)=', num2str(DesvioPadrao_Erro_Relativo,3)],'FontWeight','bold','Fontsize',11.5)
    figure
    plot(eixoX,Erro_Absoluto)
    grid
    xlabel('Sample Tests','FontWeight','bold','Fontsize',11.5)
    ylabel('Absolute Error','FontWeight','bold','Fontsize',11.5)
    title(['Absolute Errors: EAM(%)=', num2str(Erro_Absoluto_Medio,3),', DPEa(%)=', num2str(DesvioPadrao_Erro_Absoluto,3)],'FontWeight','bold','Fontsize',11.5)
end
