%_________________________________________________________________________%
%                                                                         %
%                                                                         %
%                         ARTIFICIAL NEURAL NETWORK                       %
%                          (Perceptron Multilayer)                        %
%                                                                         %
%                                          Developed by:                  %
%                                                 Joao Augusto Silva Ledo %
%_________________________________________________________________________%

function result = Perceptron_Multicamadas()
    clear all;
    close all
    clc;
    format short;
    result = solvePerceptron_Multicamadas();
end

function result = solvePerceptron_Multicamadas()
        answer = ChoseTraining();
    if(answer == 1)
        delete('Perceptron_MulticamadasTrainedNeuralNetwork.mat');
        TrainingSet = loadTrainingSet();
        TrainedNeuralNetwork = TrainingPerceptron_Multicamadas(TrainingSet);
        resultado = TrainedNeuralNetwork;
    else
        if(answer == 2)
            TrainedNeuralNetwork = load('Perceptron_MulticamadasTrainedNeuralNetwork.mat');
            data = loadInputData();
            GraficoTreinamento(TrainedNeuralNetwork.resultado.k, TrainedNeuralNetwork.resultado.Error);
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
    for(i = 1: nmr_padroes)
                              % [x1, x2, x3]  
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
    resultado = input('Escolha: \n 1-Treinar a Rede Neural Artificial \n 2-Utilizar a Rede Neural Artificial \n 3-Treinar e Utilizar a Rede Neural Artificial \n');
    resultado = VerificaOpcao(resultado);
    result = resultado;
end

function result = VerificaOpcao(answer)
    while((answer ~= 1) && (answer ~= 2) && (answer ~= 3))
       answer = input('Favor Escolher corretamente: \n 1-Treinar a Rede Neural Artificial \n 2-Utilizar a Rede Neural Artificial \n 3-Treinar e Utilizar a Rede Neural Artificial \n');
    end
    if(answer == 2)
        if(~exist('PerceptronTrainedNeuralNetwork.mat', 'file'))
            while((answer ~= 1) && (answer ~= 3))
                answer = input('Favor Realizar o procedimento de treinamento da Rede Neural Artificial atraves de: \n 1-Treinar a Rede Neural Artificial \n 3-Treinar e Utilizar a Rede Neural Artificial \n');
            end
        end
    end            
    result = answer;
end

function result = TrainingPerceptron_Multicamadas(TrainingSet)
    resultado.Nome = 'Rede Neural Artificial Perceptron Multicamadas Treinada'; 
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
    while((abs(Error(k+1) - Error(k)) > Epslon) && (k<=seguranca))
        Error(k) = Error(k+1);
        for(i = 1 : length(inputTrainingList))
            for(j=1:NeuroniosCamadaEscondida)                 
                y{k}{1}(j)=logsig(w{k}{1}{j}*inputTrainingList{i}.Value'- w{k}{2}(j) - w0{k}{1}(j));
            end
            y{k}{2}=logsig(w{k}{2}'*y{k}{1}' - w0{k}{2});
            erro{k} = inputTrainingList{i}.target - y{k}{2};
            GradienteSaida{k} = erro{k}*y{k}{2}*(1-y{k}{2});
            Delta_W{k}{2} = nepta*GradienteSaida{k}.*y{k}{1}';
            Delta_W0{k}{2} = nepta*GradienteSaida{k}.*(-1);
            w{k}{2}=w{k}{2}+Delta_W{k}{2};
            w0{k}{2}=w0{k}{2}+Delta_W0{k}{2};       
            Error_quad{k} = 0.5*(erro{k})^2;
            for(j=1:NeuroniosCamadaEscondida) 
                GradienteCamadaEscondida{k}(j) = (y{k}{1}(j))*(1-y{k}{1}(j))*GradienteSaida{k}*w{k}{2}(j);
                Delta_W{k}{1}{j} = nepta*GradienteCamadaEscondida{k}(j).*inputTrainingList{i}.Value;
                Delta_W0{k}{1}(j) = nepta*GradienteCamadaEscondida{k}(j).*(-1);
                w{k}{1}{j}=w{k}{1}{j}+Delta_W{k}{1}{j};                           
                w0{k}{1}(j)=w0{k}{1}(j)+Delta_W0{k}{1}(j);
            end
        end
        w{k+1}{1} = w{k}{1};
        w{k+1}{2} = w{k}{2};
        w0{k+1}{1} = w0{k}{1};
        w0{k+1}{2} = w0{k}{2};
        k = k+1;
        Error(k+1) = sum(Error_quad{k-1})/length(inputTrainingList);       
    end 
    GraficoTreinamento(k, Error);
    resultado.Lista_de_Treinamento = TrainingSet.inputTrainingList;
    resultado.NeuroniosCamadaEscondida = NeuroniosCamadaEscondida;
    resultado.delta_w = Delta_W;
    resultado.delta_w0 = Delta_W0;
    resultado.Error = Error;
    resultado.w = w;
    resultado.w0 = w0;
    resultado.k = k-1;
    save('Perceptron_MulticamadasTrainedNeuralNetwork.mat', 'resultado');
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
            y{1}(j)=logsig(TrainedNeuralNetwork.w{k}{1}{j}*ClassifiedInputData{i}.InputValue'- TrainedNeuralNetwork.w{k}{2}(j) - TrainedNeuralNetwork.w0{k}{1}(j));
        end
        ClassifiedInputData{i}.y_Escondida = y{1};
        ClassifiedInputData{i}.y_Saida = logsig(TrainedNeuralNetwork.w{k}{2}'*y{1}' - TrainedNeuralNetwork.w0{k}{2});
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
    resultado.Nome = 'Perceptron_Multicamadas';
    resultado.Treining = TrainedNeuralNetwork;
    resultado.Classification = ClassifiedInputData;
    resultado.Erro_teste = Erro_teste;
    resultado.Erro_Absoluto = Erro_Absoluto;
    resultado.Erro_Relativo = Erro_Relativo;
    resultado.Erro_Relativo_Medio = Erro_Relativo_Medio;
    resultado.DesvioPadrao_Erro_Relativo = DesvioPadrao_Erro_Relativo;
    resultado.Erro_Absoluto_Medio = Erro_Absoluto_Medio;
    resultado.DesvioPadrao_Erro_Absoluto = DesvioPadrao_Erro_Absoluto;
    result = resultado;
end

function GraficoRunning(NumeroTestes, y_saida, Dt, Erro_teste, Erro_Absoluto, Erro_Relativo_Medio, DesvioPadrao_Erro_Relativo, Erro_Absoluto_Medio, DesvioPadrao_Erro_Absoluto)
    subplot(3,1,2) 
    plot(1:NumeroTestes,Dt,'r',1:NumeroTestes,y_saida,'b')
    title('TESTE: VALORES REAIS (verm.) X RNA (azul)');
    ylabel('REAIS e RNA');
    xlabel('PADROES');
    grid 
    subplot(3,1,3) 
    plot(1:NumeroTestes,Erro_teste)
    title('VALIDACAO: ERRO x PADRAO');
    ylabel('ERRO');
    xlabel('PADROES');
    grid 
    figure
    eixoX= 1:1:length(Dt);
    plot(eixoX,Dt,eixoX,y_saida)
    grid
    xlabel('Amostras de teste','FontWeight','bold','Fontsize',11.5)
    ylabel('Valores','FontWeight','bold','Fontsize',11.5)
    legend('Valores de Observados','Valores Estimados')
    title(['Valores Observadas x Estimadas: ERM(%)=', num2str(Erro_Relativo_Medio,3),', DP(%)=', num2str(DesvioPadrao_Erro_Relativo,3)],'FontWeight','bold','Fontsize',11.5)
    figure
    plot(eixoX,Erro_Absoluto)
    grid
    xlabel('Amostras de teste','FontWeight','bold','Fontsize',11.5)
    ylabel('Erro absoluto','FontWeight','bold','Fontsize',11.5)
    title(['Erros absolutos: EAM(%)=', num2str(Erro_Absoluto_Medio,3),', DPEa(%)=', num2str(DesvioPadrao_Erro_Absoluto,3)],'FontWeight','bold','Fontsize',11.5)
end
