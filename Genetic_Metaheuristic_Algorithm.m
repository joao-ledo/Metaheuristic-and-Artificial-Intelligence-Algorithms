
% ======================================================================= %
%                                                                         %
%                             GENETIC ALGORITHM                           %
%                                                                         %
%                                    Developed by Joao Augusto Silva Ledo %
% ======================================================================= %

% Genetic Algorithm for Economic Dispatch problem involving objective function with no gradient

function result=genetico()
    clear all;
    clc;
    format long;
  % =======================================================================
  %                       GENETIC ALGORITHM SETTINGS
  % =======================================================================  
    populationSize = 50;
    tamCromossomo = 16;
    taxaCross   = 80;
    taxaMutacao = 10;
    quantidade_de_geracoes = 100;
    
  % =======================================================================
  %                             3 GENERATORS
  % =======================================================================
  problemSize = 3;
  ai = [0.001562, 0.00482, 0.00194];
  bi = [7.92, 7.97, 7.85];
  ci = [561, 78, 310];
  ei = [300, 150, 200];
  fi = [0.0315, 0.063, 0.042];
  pgiMin = [100, 50, 100];
  pgiMax = [600, 200, 400];
  pd = 850; 
    
  % =======================================================================
  %                             13 GENERATORS
  % =======================================================================
%    problemSize = 13;
%    pgiMin = [0.0, 0.0, 0.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 40.0, 40.0, 55.0, 55.0];
%    pgiMax = [680.0, 360.0, 360.0, 180.0, 180.0, 180.0, 180.0, 180.0, 180.0, 120.0, 120.0, 120.0, 120.0];
%    ai = [0.00028, 0.00056, 0.00056, 0.00324, 0.00324, 0.00324, 0.00324, 0.00324, 0.00324, 0.00284, 0.00284 0.00284, 0.00284];
%    bi = [8.1, 8.1, 8.1, 7.74, 7.74, 7.74, 7.74, 7.74, 7.74, 8.6, 8.6, 8.6, 8.6];
%    ci = [550.0, 309.0, 307.0, 240.0, 240.0, 240.0, 240.0, 240.0, 240.0, 126.0, 126.0, 126.0, 126.0];
%    ei = [300.0, 200.0, 200.0, 150.0, 150.0, 150.0, 150.0, 150.0, 150.0, 100.0, 100.0, 100.0, 100.0];
%    fi = [0.035, 0.042, 0.042, 0.063, 0.063, 0.063, 0.063, 0.063, 0.063, 0.084, 0.084, 0.084, 0.084];
%    pd = 2520; 
%    valor_de_checagem = [446.7721022165909, 359.83802812467525, 347.30291732671776, 178.59800026260498, 176.61671799369162, 159.3869283719641, 177.69329124723907, 175.02004266069642, 92.12642942590143, 91.98327862076192, 114.19742611083683, 87.8230263126092, 112.64181132571039];
 %  valor_de_checagem = [335.74828944698515, 329.9885016636184, 312.09664712366066, 178.9963562768947, 179.49083765964065, 178.41229394265716, 179.472315807014, 174.19890950865292, 178.96794196461232, 115.13864931364739, 119.93553693163678, 117.60047338334431, 119.95324697763598];

  % =======================================================================
  %                             3 GENERATORS
  % =======================================================================
    %  problemSize = 3;  
    %  pgiMin=[150.0, 135.0, 73.0] ;
    %  pgiMax=[470.0, 460.0, 340.0];
    %  ai = [0.00043, 0.00063, 0.00039];
    %  bi = [21.60, 21.05,   20.81];
    %  ci = [958.20, 1313.6, 604.97];
    %  ei = [450, 600, 320];
    %  fi = [0.041, 0.036, 0.028];
    %  pd = 650;

   % ======================================================================
   %                             40 GENERATORS
   % ======================================================================
%      problemSize = 40;
%      pgiMin = [36, 36,	60,	80,	47,	68,	110,	135,	135,	130,	94,	94,	125,	125, 125,	125,	220,	220,	242, 242,	254,	254,	254,	254, 254,	254,	10,	10,	10,	47,	60 ,60, 60, 90, 90, 90, 25, 25, 25, 242];
%      pgiMax = [114,	114,	120,	190,	97,	140,	300,	300,	300,	300,	375,	375,	500, 500,	500,	500,	500,	500,	550,	550,	550,	550,	550, 550,	550,	550,	150,	150,	150,	97,	190 ,190, 190, 200, 200, 200, 110, 110, 110, 550];
%      ai = [94.705,	94.705,	309.54,	369.03,	148.89,	222.33,	287.71,	391.98,	455.76,	722.82,	635.2,	654.69,	913.4,	1760.4,	1760.4,	1760.4,	647.85,	649.69,	647.83,	647.81,	785.96,	785.96,	794.53,	794.53,	801.32,	801.32,	1055.1,	1055.1,	1055.1,	148.89,	222.92, 222.920, 222.920, 107.870, 116.580, 116.580, 307.450, 307.450, 307.450, 647.830];
%      bi = [6.73,	6.73,	7.07,	8.18,	5.35,	8.05,	8.03,	6.99,	6.6,	12.9,	12.9,	12.8,	12.5,	8.84,	8.84,	8.84,	7.97,	7.95,	7.97,	7.97,	6.63,	6.63,	6.66,	6.66,	7.1,	7.1,	3.33,	3.33,	3.33,	5.35,	6.43, 6.43, 6.43, 8.95, 8.62, 8.62, 5.88, 5.88, 5.88, 7.97];
%      ci = [0.0069,	0.0069,	0.02028,	0.00942,	0.0114,	0.01142,	0.00357,	0.00492,	0.00573,	0.00605,	0.00515,	0.00569,	0.00421,	0.00752,	0.00752,	0.00752,	0.00313,	0.00313,	0.00313,	0.00313,	0.00298,	0.00298,	0.00284,	0.00284,	0.00277,	0.00277,	0.52124,	0.52124,	0.52124,	0.0114,	0.0016, 0.00160, 0.00160, 0.00010, 0.00010, 0.00010, 0.01610, 0.01610, 0.01610, 0.00313];
%      ei = [100, 100,	100,	150,	120,	100,	200,	200,	200,	200,	200,	200,	300,	300,	300,	300, 300,	300,	300,	300,	300,	300,	300,	300,	300,	300,	120,	120,	120,	120,	150, 150, 150, 200, 200, 200, 80, 80, 80, 300];                         
%      fi = [0.084, 0.084, 0.084, 0.063, 0.077, 0.084, 0.042, 0.042, 0.042, 0.042, 0.042, 0.042, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.077, 0.077, 0.077, 0.077, 0.063, 0.063, 0.063, 0.042, 0.042, 0.042, 0.098, 0.098, 0.098, 0.035];
%      pd = 10500;
%      valor_de_checagem = [114,	114,	120,	190,	97,	140,	300,	300,	300,	300,	375,	375,	500, 500,	500,	500,	500,	500,	550,	405,	255,	255,	255, 255,	255,	255,	150,	150,	150,	97,	190 ,190, 190, 200, 200, 200, 110, 110, 110, 243];
%      valor_de_checagem = [113.81997227639769, 113.96086950240407, 119.7271480296845, 189.373988885039, 96.25494633948203, 139.89824562269555, 299.5588648367807, 298.7538444742643, 297.35724691567543, 299.99063055110815, 368.4645811193757, 366.13605382962254, 463.99969923070046, 470.05222702221914, 461.6969007250843, 462.60691046568326, 471.34414701872055, 476.91572903130265, 507.47533792734225, 388.94323728754165, 275.33939243624565, 268.89150289962595, 280.16251802332374, 282.8610523777999, 278.94259182544175, 289.8422075117647, 149.45482859633145, 149.8949037855257, 149.85779206455027, 96.26569559888561, 189.86806860591054, 189.92720966485228, 189.70314759426083, 199.43637721511797, 199.9103196523829, 199.43066935814832, 109.72189038143304, 109.80553160663155, 109.59696116136752, 374.7567585492781];
   
   % ======================================================================
   %                      CREATING THE FIRST POPULATION
   % ======================================================================
   for j=1:populationSize  - 1
        pgi=random_vector(populationSize, problemSize, pgiMax, pgiMin, ai, bi, ci, ei, fi, pd);
        populacao{j} = pgi;
   end
  
    if(problemSize ~= 3)
         populacao = [populacao,valor_de_checagem];
    end

    [iPopulacao, jPopulacao] = size(populacao);

   % ======================================================================
   %                         STARTING GENERATIONS
   % ======================================================================
    for Geracao_Atual = 1 : quantidade_de_geracoes
        % SELECTS, IN A POPULATION, THE BEST INDIVIDUALS BASED ON ITS FITNESS VALUES
        probSelecao = aptidao(populacao, ai, bi, ci, ei, fi, pgiMin, pgiMax, pd);
        
   % ======================================================================
   %   SELECTING PARENTS AND CROSSING OVER TO CREATE THE FIRST OFFSPRING
   % ======================================================================
        k = 1;
        while (k <= jPopulacao)
            pai1 = selecao(populacao,probSelecao);
            pai2 = selecao(populacao,probSelecao);
            filhos(:,k:k+1) = crossover(pai1, pai2, tamCromossomo, taxaCross, problemSize);
            % COUNTS 2 BECAUSE EACH COUPLE HAS TWO KIDS
            k = k+2;
        end
        
   % ======================================================================
   %                            MUTATION STEP
   % ======================================================================
    filhos = mutacao(filhos, tamCromossomo, taxaMutacao, problemSize);

   % ======================================================================
   %        CREATING NEW POPULATION BY SELECTING THE BEST INDIVIDUALS
   % ======================================================================
        populacao = elitismo(populacao, filhos, pgiMin, pgiMax, ai, bi, ci, ei, fi, pd);
        Geracao_Atual
    end  
    
   % ======================================================================
   %    CALCULATING THE OBJECTIVE FUNCTION AND THE TOTAL POWER SUPPLY 
   %                        TO THE LAST POPPULATION
   % ======================================================================
    for t=1:length(populacao)     
      populacao{2,t} = correcao(populacao{1,t}, pgiMin, pgiMax, ai, bi, ci, ei, fi, pd);
      populacao{3,t} = soma(populacao{1,t});
    end
   % ======================================================================
   %                               OUTCOME
   % ======================================================================


for(u = 1 : length(populacao))
    geradores{u} = populacao{1,u};
    FO{u} = populacao{2,u};
    Demanda{u} = populacao{3,u};
end

%     resultado.Gerador1 = populacao{1,1}(1);
%     resultado.Gerador2 = populacao{1,1}(2);
%     resultado.Gerador3 = populacao{1,1}(3);
%     resultado.Objetivo = populacao{2,1};
%     resultado.Demanda = populacao{3,1};
%     resultado.Geracao = Geracao_Atual;

    resultado.Nome = 'Genetic Algorithm';
    resultado.Geradores = geradores;
    resultado.FO = FO;
    resultado.Demanda = Demanda;
    result = resultado;
end


% =========================================================================
%                        FINDS THE ELITE EDIVIDUALS
% =========================================================================
function result = elitismo(populacao, filhos, pgiMin, pgiMax, ai, bi, ci, ei, fi, pd)   
            for r=1:length(populacao)
                elitePopulacao  = find(min(correcao(populacao{r}, pgiMin, pgiMax, ai, bi, ci, ei, fi, pd)));
                eliteFilhos     = find(min(correcao(filhos{r}, pgiMin, pgiMax, ai, bi, ci, ei, fi, pd)));
                if elitePopulacao > eliteFilhos
                    [nMenor, iMenor] = max(filhos{r});
                    filhos{1,r}(iMenor) = elitePopulacao;
                end
            end 
    result = filhos;
end

%==========================================================================
%               RANDOM IN BOUNDARIES FUNCTION FOR POWER SUPPLY
%==========================================================================
    function result=random_vector(populationSize, problemSize, pgiMax, pgiMin, ai, bi, ci, ei, fi, pd)
        for i=1:problemSize % problemSize-1 for Slack bus (swing bus - refrence bus)
                pgi(i) = (rand() * (pgiMax(i)-pgiMin(i))) + pgiMin(i);      
        end
        result = pgi; %[pgi,abs(pd - soma(pgi))] <--------------Slack Bus (swing bus - refrence bus)
    end
    
%==========================================================================
%                               SUMMING VALUES 
%==========================================================================    
    function result=soma(pgi)
        soma = 0;
        for i=1:length(pgi)
            soma = soma + pgi(i);
        end
        result = soma;
    end
    
    
%==========================================================================
%      CALCULATING THE FITNESS BASED ON THE OBJECTIVE FUNCTION VALUE
%                            OF EACH INDIVIDUAL
%==========================================================================
function result=aptidao(populacao, ai, bi, ci, ei, fi, pgiMin, pgiMax, pd)
    % Total population number
    [iTotal,jTotal] = size(populacao);
    for i=1:iTotal     
        k = 1;    
        for j=1:jTotal  
              f(i,k) = 1/correcao(populacao{1,j}, pgiMin, pgiMax, ai, bi, ci, ei, fi, pd);% MINIMIZING THE OBJECTIVE FUNCTION        
            k = k+1;
        end
    end
    % Calculating the fitness
    apitdao = (f / sum(f)) * 100;
    result = apitdao;
end

%==========================================================================
%                   FINDING THE OBJECTIVE FUNCTION VALUE
%==========================================================================
 function result = objetivo(pgi, ai, bi, ci, ei, fi, pgiMin)
     soma = 0; 
     for i=1 : length(pgi)
         soma = soma + ai(i) * (pgi(i)^2.0) + bi(i) * pgi(i) + ci(i) + ei(i) *  abs(sin(fi(i) * (pgiMin(i) - pgi(i))));   
     end
     result = soma;
 end

%==========================================================================
%                     OBJECTIVE FUNCTION PENALTY TERM
%==========================================================================    
function result = correcao(pgi, pgiMin, pgiMax, ai, bi, ci, ei, fi, pd)
       erro = abs(pd-soma(pgi));
        for i=1:length(pgiMax)
            if ((pgi(i) < pgiMin(i)) || (pgi(i) > pgiMax(i)) || (soma(pgi) ~= pd))
                erro = erro * 10000000 + erro;           
            end         
        end 
        if erro ~= 0
            correction = objetivo(pgi, ai, bi, ci, ei, fi, pgiMin)+erro;
        else
            correction = objetivo(pgi, ai, bi, ci, ei, fi, pgiMin);
        end
        result = correction;
end
 
% =========================================================================
%                          SELECTING WHEEL FUNCTION 
% =========================================================================
function result=roleta(probselec, nJogadas)
% Gap between areas
[lin, nArea] = size(probselec);
min = zeros(lin,nArea);
max = zeros(lin,nArea);
% Ocurrency resulting frequency of each area
y = zeros(lin,nArea);
for i=1:nArea
    if(i == 1)
        min(i) = 1;
        max(i) = probselec(i);
    else
        min(i) = max(i-1) +1;
        max(i) = min(i)+probselec(i) -1;
    end    
end
% Finds the integer portion
min = ceil(min);
max = ceil(max);
% Total amount of played time
for i=1:nJogadas
    rodada = ceil(rand*100);    
    % procurar no vetor de minimos
    for k=1:nArea
        if ((rodada >= min(k)) && (rodada <= max(k)))
            y(k) = (y(k)+1);
        end
    end 
end
result = y;
end

%==========================================================================
%FINDING THE MOST FITTING INDIVIDUALS BY USING THE SELECTING WHEEL FUNCTION
%==========================================================================
function result=selecao(populacao, probSelecao)
    candidato = roleta(probSelecao,1);
    selecionado = find(candidato);
    result = populacao(selecionado);
end

%==========================================================================
%      PARENTS' BINARY CROSSOVER FUNCTION TO CONCEIVE ITS OFFSPRING
%==========================================================================
function result=crossover(pai1,pai2, tamCromossomo, taxaCross, problemSize);
    % Transforms the parents into banary values
    pai1 = dec2bin(pai1{1},tamCromossomo);
    pai2 = dec2bin(pai2{1},tamCromossomo);
    % There is a crossover rate in the population in respect to a percentage of its total value
    crossover = roleta([taxaCross 100-taxaCross], 1); 
    for i=1:problemSize
        if crossover(1,1) == 1 % uses randomly the crossover rate respecting the maximum number of crossover values       
        % trims the chromosome randomly 
            corte = floor(tamCromossomo * rand(1,1))+1;
            % the first n kids related to the size of the problem
                filho1(i, 1:corte) = pai1(i, 1:corte);
                filho1(i, corte+1:tamCromossomo) = pai2(i, corte+1:tamCromossomo);     
                 % the second n kids related to the size of the problem
                 filho2(i, 1:corte) = pai2(i, 1:corte);
                 filho2(i, corte+1:tamCromossomo) = pai1(i, corte+1:tamCromossomo);
                 filhos = {bin2dec(filho1),bin2dec(filho2)}; % Creates the first offspring population already converted its values from binary to decimal                        
        % When there is no crossover, the kids are identical to its parents
        else
            filhos{1} = bin2dec(pai1);
            filhos{2} = bin2dec(pai2);
        end    
    end
    result = filhos;
end

%==========================================================================
%                      MUTATION FUNCTION ON SOME KIDS
%==========================================================================
function result=mutacao(filhos, tamCromossomo, taxaMutacao, problemSize)
% There is a certain number rete regarding to the mutation in a population concerning to its total percentage
    mutacao = roleta([taxaMutacao, 100-taxaMutacao], 1);
    [nJ, nFilhos] = size(filhos);
    for i=1:nFilhos
          filhos{i} =  dec2bin(filhos{i},tamCromossomo);
    end

    % Uses randomly the mutation respecting the total amount of mutation accepted
    if mutacao(1,1) == 1       
        % Targets a kid to mutate
        mutante = floor(nFilhos * rand(1,1))+1;
        % Chooses randomly a number (nBit) that represents a bit to be mutated
        nBit = floor(tamCromossomo * rand(1,1))+1;
        % Selects the kid's bit to mutate based on the nBit chosen number
        bitAtual = filhos{mutante}(1,nBit,1);

        if bitAtual == dec2bin(1) 
            bitMutante = dec2bin(0);
        else
            bitMutante = dec2bin(1);
        end        
        % Implements the mutation into the chosen kid
        filhos{mutante}(nBit) = bitMutante;
    end
    % Converts binary values to decimal
  for j=1:nFilhos
    for s=1:problemSize
        filhotes{j} = bin2dec(filhos{j});
    end
  end
    result = filhotes;

end
