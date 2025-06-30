%_________________________________________________________________________%
%                                                                         %
%                                                                         %
%                         ARTIFICIAL NEURAL NETWORK                       %
%                          (ADALINE - Single layer)                       %
%                                                                         %
%                                          Developed by:                  %
%                                                 Joao Augusto Silva Ledo %
%_________________________________________________________________________%

function result = Adaline()
    clear all;
    close all
    clc;
    format short;
    result = solveAdaline();
end

function result = solveAdaline()
        answer = ChoseTraining();
    if(answer == 1)
        delete('AdalineTrainedNeuralNetwork.mat');
        TrainingSet = loadTrainingSet();
        TrainedNeuralNetwork = TrainingAdaline(TrainingSet);
        resultado = TrainedNeuralNetwork;
    else
        if(answer == 2)
            TrainedNeuralNetwork = load('AdalineTrainedNeuralNetwork.mat');
            data = loadInputData();
            Grafico(TrainedNeuralNetwork.resultado.k, TrainedNeuralNetwork.resultado.Error);
            resultado = runAdaline(TrainedNeuralNetwork.resultado, data, TrainedNeuralNetwork.resultado.k);
        else
            if(answer == 3)
                TrainingSet = loadTrainingSet();
                TrainedNeuralNetwork = TrainingAdaline(TrainingSet);
                data = loadInputData();
                resultado = runAdaline(TrainedNeuralNetwork, data, TrainedNeuralNetwork.k);
            end
        end
    end
    result = resultado;
end

function result = loadTrainingSet()
%     mi = 0;
%     delta_quad = 1;
                              % [x0, x1, x2, x3]  
    inputTrainingList{1}.Value = [-1, 0, 1, 1];
    inputTrainingList{1}.target = -1;  % d
    inputTrainingList{2}.Value = [-1, 1, 1, 1];
    inputTrainingList{2}.target = -1;  % d
    inputTrainingList{3}.Value = [-1, 0, 1, 0];
    inputTrainingList{3}.target = 1;  % d
    inputTrainingList{4}.Value = [-1, 1, 1, 0];
    inputTrainingList{4}.target = 1;  % d
    inputTrainingList{5}.Value = [-1, 1, 0, 1];
    inputTrainingList{5}.target = -1;  % d
    inputTrainingList{6}.Value = [-1, 1, 0, 0];
    inputTrainingList{6}.target = 1; % d
    inputTrainingList{7}.Value = [-1, 0, 0, 1];
    inputTrainingList{7}.target = -1;  % d
    inputTrainingList{8}.Value =  [-1, 0, 0, 0];
    inputTrainingList{8}.target = 1; % d
   tamanho = length(inputTrainingList);
%     for(i = tamanho+1 : 2*tamanho)  % Applies the noise from the first 8 positions to the last 8 positions
%         inputTrainingList{i}.Value = Ruido(inputTrainingList{i - tamanho}.Value, mi, delta_quad);
%         inputTrainingList{i}.target = inputTrainingList{i - tamanho}.target;
%     end
    resultado.k = 1;
    resultado.nepta = 0.1;
    resultado.Epslon = 10^-5;
    resultado.w{resultado.k} = rand(1, length(inputTrainingList{1}.Value));
    resultado.inputTrainingList = inputTrainingList;
    resultado.Security = 10000;
    result = resultado;
end

function result = loadInputData()
    mi = 0;
    delta_quad = 1;
                     % [x0, x1, x2, x3]
    inputDataList{1} = [-1, 0, 1, 1];
    inputDataList{2} = [-1, 1, 1, 1];
    inputDataList{3} = [-1, 0, 1, 0];
    inputDataList{4} = [-1, 1, 1, 0];
    inputDataList{5} = [-1, 1, 0, 1];
    inputDataList{6} = [-1, 1, 0, 0];
    inputDataList{7} = [-1, 0, 0, 1];
    inputDataList{8} = [-1, 0, 0, 0];
    for(i = 1 : length(inputDataList))
        ruido{i} = Ruido(inputDataList{i}, mi, delta_quad);
    end
    resultado.Original = inputDataList;
    resultado.Ruido =  ruido;
    result = resultado;
end

function result = Ruido(x, mi, delta_quad)
        for(i = 1 : length(x))
            gama(i) = rand_in_bounds(mi, delta_quad);
            x(i) = x(i) + gama(i)/5;  % Gaussian white noise
        end
    result = x;
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

function result = TrainingAdaline(TrainingSet)
    resultado.Nome = 'Adaline Artificial Neural Network Trained'; 
    seguranca = TrainingSet.Security;
    k = TrainingSet.k;
    nepta = TrainingSet.nepta;
    Epslon = TrainingSet.Epslon;
    w = TrainingSet.w;
    inputTrainingList = TrainingSet.inputTrainingList;
    Error(k) = 1;
    Error(k+1) = 0;    
    while((abs(Error(k+1) - Error(k)) > Epslon) && (k<=seguranca))
        Error(k) = Error(k+1);
        for(i = 1 : length(inputTrainingList))
            u{k}(i) = inputTrainingList{i}.Value*w{k}';
            Delta_W{k}{i} = nepta*(inputTrainingList{i}.target - u{k}(i))*inputTrainingList{i}.Value;
            w{k} = w{k} + Delta_W{k}{i};            
            Error_quad{k} = (inputTrainingList{i}.target - u{k}(i))^2;
        end
        w{k+1} = w{k};
        k = k+1;
        Error(k+1) = sum(Error_quad{k-1})/length(inputTrainingList);       
    end 
    resultado.Lista_de_Treinamento = TrainingSet.inputTrainingList;
    resultado.delta_w = Delta_W;
    resultado.Error = Error;
    resultado.w = w;
    resultado.u = u;
    resultado.k = k-1;
    save('AdalineTrainedNeuralNetwork.mat', 'resultado');
    Grafico(resultado.k, Error);
    result = resultado;
end

function Grafico(k, Error)
    for(i=1 : k)
        epocas(i) = i;
        erro(i) = abs(Error(i+1)-Error(i));
    end
   plot(epocas, erro, 'r');
   title('The Average Quadratic Tolerance Behavior');
   ylabel('The Average Quadratic Tolerance');
   xlabel('Epochs');
   grid;
end

function result = runAdaline(TrainedNeuralNetwork, inputData, k)
    for(i = 1 : length(inputData.Ruido))
        ClassifiedInputData{i}.Sinal_Original = inputData.Original{i};
        ClassifiedInputData{i}.Sinal_Ruido = inputData.Ruido{i};
        ClassifiedInputData{i}.InputValue = inputData.Ruido{i};
        ClassifiedInputData{i}.y = sign(inputData.Ruido{i}*TrainedNeuralNetwork.w{k+1}'); %logsig purelin
        if(ClassifiedInputData{i}.y == 1)
            ClassifiedInputData{i}.Class = 'B';
        else
            if(ClassifiedInputData{i}.y == -1)
                ClassifiedInputData{i}.Class = 'A';               
            end
        end
    end
    resultado.Nome = 'ADALINE';
    resultado.Treining = TrainedNeuralNetwork;
    resultado.Classification = ClassifiedInputData;
    result = resultado;
end
