%_________________________________________________________________________%
%                                                                         %
%                                                                         %
%                         ARTIFICIAL NEURAL NETWORK                       %
%                        (PERCEPTRON - Single Layer)                      %
%                                                                         %
%                                          Developed by:                  %
%                                                 Joao Augusto Silva Ledo %
%_________________________________________________________________________%

function result = Perceptron()
    clear all;
    close all
    clc;
    format short;
    result = solvePerceptron();
end

function result = solvePerceptron()
        answer = ChoseTraining();
    if(answer == 1)
        delete('PerceptronTrainedNeuralNetwork.mat');
        TrainingSet = loadTrainingSet();
        TrainedNeuralNetwork = TrainingPerceptron(TrainingSet);
        resultado = TrainedNeuralNetwork;
    else
        if(answer == 2)
            TrainedNeuralNetwork = load('PerceptronTrainedNeuralNetwork.mat');
            data = loadInputData();
            resultado = runPerceptron(TrainedNeuralNetwork.resultado, data, TrainedNeuralNetwork.resultado.k);
        else
            if(answer == 3)
                TrainingSet = loadTrainingSet();
                TrainedNeuralNetwork = TrainingPerceptron(TrainingSet);
                data = loadInputData();
                resultado = runPerceptron(TrainedNeuralNetwork, data, TrainedNeuralNetwork.k);
            end
        end
    end
    result = resultado;
end

function result = loadTrainingSet()
                              % [x0, x1, x2, x3]  
    inputTrainingList{1}.Value = [-1, 0, 1, 1];
    inputTrainingList{1}.target = -1;  % d
    inputTrainingList{2}.Value = [-1, 1, 1, 1];
    inputTrainingList{2}.target = -1;  % d
    inputTrainingList{3}.Value = [-1, 1, 0, 1];
    inputTrainingList{3}.target = -1;  % d
    inputTrainingList{4}.Value = [-1, 1, 1, 0];
    inputTrainingList{4}.target = 1;  % d
    inputTrainingList{5}.Value = [-1, 0, 0, 0];
    inputTrainingList{5}.target = 1;  % d
    resultado.k = 1;
    resultado.nepta = 0.01;
    resultado.Erro = true;
    resultado.w{resultado.k} = [0.07, 0.63, 0.89, 0.27];
    resultado.inputTrainingList = inputTrainingList;    
    result = resultado;
end

function result = loadInputData()
                     % [x0, x1, x2, x3]
    inputDataList{1} = [-1, 0, 1, 0];  % a
    inputDataList{2} = [-1, 1, 0, 0];  % b
    inputDataList{3} = [-1, 0, 0, 1];  % c
    result = inputDataList;
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

function result = TrainingPerceptron(TrainingSet)
    resultado.Nome = 'Rede Neural Artificial Perceptron Treinada';   
    k = TrainingSet.k;
    nepta = TrainingSet.nepta;
    Erro = TrainingSet.Erro;
    w = TrainingSet.w;
    inputTrainingList = TrainingSet.inputTrainingList;  
    while(Erro == true)
        Erro = false;
        for(i = 1 : length(inputTrainingList))
            y{k} = sign(inputTrainingList{i}.Value*w{k}'); % funcao de ativacao
            if(y{k} ~= inputTrainingList{i}.target) %Toda vez que um individuo novo da lista de input for testado e o y for diferente do valor desejado, toda a rede (bias-w) daquela itera??o tem que ser atualizada, e naquela itera??o existe erro pois a rede teve quje ser atualizada
                w{k} = w{k} + nepta * (inputTrainingList{i}.target-y{k}) * inputTrainingList{i}.Value;
                Erro = true;
            end
        end
        w{k+1} = w{k};
        k = k+1;     
    end 
    resultado.w = w;
    resultado.y = y;
    resultado.k = k-1;
    save('PerceptronTrainedNeuralNetwork.mat', 'resultado');    
    result = resultado;
end

function result = runPerceptron(TrainedNeuralNetwork, inputData, k)
    for(i = 1 : length(inputData))
        ClassifiedInputData{i}.InputValue = inputData{i};
        ClassifiedInputData{i}.y = sign(inputData{i}*TrainedNeuralNetwork.w{k+1}');
        if(ClassifiedInputData{i}.y == 1)
            ClassifiedInputData{i}.Class = 'B';
        else
            if(ClassifiedInputData{i}.y == -1)
                ClassifiedInputData{i}.Class = 'A';               
            end
        end
    end
    resultado.Nome = 'PERCEPTRON';
    resultado.Treino = TrainedNeuralNetwork;
    resultado.Classification = ClassifiedInputData;
    result = resultado;
end
