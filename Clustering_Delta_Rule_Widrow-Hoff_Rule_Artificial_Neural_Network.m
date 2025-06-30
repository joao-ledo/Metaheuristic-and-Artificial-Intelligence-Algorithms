%_________________________________________________________________________%
%                                                                         %
%                                                                         %
%                         ARTIFICIAL NEURAL NETWORK                       %
%                  (Clustering Delta Rule (Widrow-Hoff Rule))             %
%                                                                         %
%                                          Developed by:                  %
%                                                 Joao Augusto Silva Ledo %
%_________________________________________________________________________%
function result = ClusteringRegraDelta()
    clear all;
    close all
    clc;
    format short;  
    result = solvePerceptron_Multicamadas();
end

function result = loadInputData()
    resposta.TrainingPercent = 0.8;
    resposta.ValidationPercent = 0.2;
    archive=xlsread('dados_EPC06_RBF.xls');
    [linha, coluna] = size(archive);
    for(i = 1 : linha)
       for(j = 1 : coluna-1)
           input{i}.Value(j) = archive(i,j);
       end
       input{i}.target = archive(i, coluna);
    end    
    QuantidadeTreinamento = resposta.TrainingPercent*length(input);
    QuantidadeValidacao = resposta.ValidationPercent*length(input);
    lista_Treinamento = sorteio(input, QuantidadeTreinamento);
    resposta.inputTrainingList = lista_Treinamento.ListaSorteados;
    l = 1;
    while(l < QuantidadeValidacao)
        for(k = 1 : length(input))
            if(ismember(k,lista_Treinamento.randomic_values_array) == false)
                resposta.inputDataList{l} = input{k};
                l = l + 1;
            end
        end
    end
    resposta.k = 1;
    resposta.nepta = 0.1;
    resposta.Epslon = 10^-7;
    resposta.NeuroniosCamadaEscondida = 2;
    for(j = 1 : resposta.NeuroniosCamadaEscondida)
       wEscondido{j} = rand(1, length(resposta.inputTrainingList{1}.Value)); 
    end
    resposta.w{resposta.k} = {wEscondido, rand(resposta.NeuroniosCamadaEscondida, 1)};
    resposta.w0{resposta.k} = {rand(resposta.NeuroniosCamadaEscondida, 1), rand()};
    resposta.Security = 10000;
    result = resposta;
end

function result = sorteio(valor, quantidade)
    randomic_values_array = 0;
    i = 1;
    flag = false;
    while((i <= quantidade))
        aleatorio = rand_in_bounds(1, quantidade+1);
        if(ismember(aleatorio, randomic_values_array) == false)
            randomic_values_array(i) = aleatorio;
            i = i + 1;
        end
    end    
    for(j = 1 : length(randomic_values_array))
        resposta.ListaSorteados{j} = valor{randomic_values_array(j)};
    end
    resposta.randomic_values_array = randomic_values_array;
    result = resposta;
end

function result = rand_in_bounds(min, max)
  result = floor(min + ((max-min) * rand()));
end

function result = solvePerceptron_Multicamadas()
        answer = ChoseTraining();
    if(answer == 1)
        delete('ClusteringRegraDelta.mat');
        data = loadInputData();
        TrainedNeuralNetwork = TrainingPerceptron_Multicamadas(data);
        resultado = TrainedNeuralNetwork;
    else
        if(answer == 2)
            data = loadInputData();
            TrainedNeuralNetwork = load('ClusteringRegraDelta.mat');
            GraficoTreinamento(TrainedNeuralNetwork.resultado.k, TrainedNeuralNetwork.resultado.Error);
            resultado = runPerceptron_Multicamadas(TrainedNeuralNetwork.resultado, data, TrainedNeuralNetwork.resultado.k);
        else
            if(answer == 3)
                data = loadInputData();
                TrainedNeuralNetwork = TrainingPerceptron_Multicamadas(data);               
                resultado = runPerceptron_Multicamadas(TrainedNeuralNetwork, data, TrainedNeuralNetwork.k);
            end
        end
    end
    result = resultado;
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
    resultado.Nome = 'Trained Clustering Delta Rule Artificial Neural Network'; 
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
                vetor{k}=inputTrainingList{i}.Value - w{k}{2}(j);
                distancia{k}(i,j)=norm(vetor{k});
            end
            grupo(i)=1;                       % inicio do agrupamento
            for(j=1:TrainingSet.NeuroniosCamadaEscondida-1)
                menor_dist{k}=distancia{k}(i,j);
                if(menor_dist{k} > distancia{k}(i, j+1))
                    menor_dist{k} = distancia{k}(i, j+1);
                    grupo(i)=j+1;
                end
            end
        end 
%             for(h = 1 : length(inputTrainingList))
%                 for(g = 1 : length(inputTrainingList{h}.Value))
%                     mat(h, g) =  inputTrainingList{h}.Value(g);
%                 end
%             end
%            plot(mat(:, 1), mat(:, 2),'+', w{1}{1}{1} , w{1}{1}{2},'ro');
            soma=zeros(NeuroniosCamadaEscondida,2);            % inicio do calculo do novo centroide
            elementos_w1=zeros(1,TrainingSet.NeuroniosCamadaEscondida);
            for(i=1:length(inputTrainingList))
                 for(j=1:NeuroniosCamadaEscondida)
                     if(grupo(i) == j)
                         soma(j,:)=soma(j,:)+inputTrainingList{i}.Value;
                         elementos_w1(1,j)=elementos_w1(1,j)+1;
                         w{k}{1}{j} = soma(j,:)/elementos_w1(1,j);
                     end
                 end
            end                                    % fim do calculo do novo centroide
                soma_dif2=zeros(NeuroniosCamadaEscondida,1);
                num_padr=zeros(NeuroniosCamadaEscondida,1);
                for(j=1:NeuroniosCamadaEscondida)
                    for(i=1:length(inputTrainingList))
                        if(grupo(i)==j)
                            soma_dif2(j)=soma_dif2(j)+(inputTrainingList{i}.Value-w{k}{1}{j})*(inputTrainingList{i}.Value-w{k}{1}{j})';
                            num_padr(j)=num_padr(j)+1;
                        end
                    end
                    var(j)=soma_dif2(j)/num_padr(j);
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
        w{k+1}{1} = w{k}{1};
        w{k+1}{2} = w{k}{2};
        w0{k+1}{1} = w0{k}{1};
        w0{k+1}{2} = w0{k}{2};
        k = k+1;
        Error(k+1) = sum(Error_quad{k-1})/length(inputTrainingList);       
    end 
        for(i=1:length(inputTrainingList))
            for(j=1:NeuroniosCamadaEscondida)
                u1(i,j)=exp(-((inputTrainingList{i}.Value-w{k}{1}{j})*(inputTrainingList{i}.Value-w{k}{1}{j})')/(2*var(j)));
            end     
        end
    resultado.Lista_de_Treinamento = TrainingSet.inputTrainingList;
    resultado.NeuroniosCamadaEscondida = NeuroniosCamadaEscondida;
    resultado.delta_w = Delta_W;
    resultado.delta_w0 = Delta_W0;
    resultado.Error = Error;
    resultado.w = w;
    resultado.w0 = w0;
    resultado.k = k-1;
    resultado.grupo = grupo;
    save('ClusteringRegraDelta.mat', 'resultado');
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
    GraficoRunning(length(inputData.inputDataList), y_saida, Dt, Erro_teste, Erro_Absoluto, Erro_Relativo_Medio, DesvioPadrao_Erro_Relativo, Erro_Absoluto_Medio, DesvioPadrao_Erro_Absoluto, TrainedNeuralNetwork);
    resultado.Nome = 'Clustering Regra Delta';
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

function GraficoRunning(NumeroTestes, y_saida, Dt, Erro_teste, Erro_Absoluto, Erro_Relativo_Medio, DesvioPadrao_Erro_Relativo, Erro_Absoluto_Medio, DesvioPadrao_Erro_Absoluto, TrainedNeuralNetwork)
    for(i=1 : TrainedNeuralNetwork.k)
        epocas(i) = i;
        erro(i) = abs(TrainedNeuralNetwork.Error(i+1)-TrainedNeuralNetwork.Error(i));
    end   
    subplot(3,1,1) 
    plot(epocas, erro, 'r');
    title('EQM x EPOCAS');
    ylabel('EQM');
    xlabel('EPOCA');
    grid
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
        for(i=1:length(TrainedNeuralNetwork.Lista_de_Treinamento))
               if(TrainedNeuralNetwork.grupo(i)==1)
                       plot(TrainedNeuralNetwork.Lista_de_Treinamento{i}.Value(1),TrainedNeuralNetwork.Lista_de_Treinamento{i}.Value(2),'ro')
                       hold on
               else
                   if(TrainedNeuralNetwork.grupo(i)==2)
                       plot(TrainedNeuralNetwork.Lista_de_Treinamento{i}.Value(1),TrainedNeuralNetwork.Lista_de_Treinamento{i}.Value(2),'go')
                       hold on
                   else
                       plot(TrainedNeuralNetwork.Lista_de_Treinamento{i}.Value(1),TrainedNeuralNetwork.Lista_de_Treinamento{i}.Value(2),'bo')
                       hold on
                   end
                end
        end
        plot(TrainedNeuralNetwork.w{TrainedNeuralNetwork.k+1}{1}{1}, TrainedNeuralNetwork.w{TrainedNeuralNetwork.k+1}{1}{2},'kx');
        hold off;
end
