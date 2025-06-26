% ======================================================================= %
%                                                                         %
%                         SCATTER SEARCH ALGORITHM                        %
%                                                                         %
%                                    Developed by Joao Augusto Silva Ledo %
% ======================================================================= %

% Scatter Search Algorithm implemented for the Optimal Power Flow Dispatch problem

function result = ScatterSearch()
  clear all;
  clc;
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
  %                             3 GENERATORS
  % =======================================================================
%       problemSize = 3;  
%       pgiMin=[150.0, 135.0, 73.0] ;
%       pgiMax=[470.0, 460.0, 340.0];
%       ai = [0.00043, 0.00063, 0.00039];
%       bi = [21.60, 21.05,   20.81];
%       ci = [958.20, 1313.6, 604.97];
%       ei = [450, 600, 320];
%       fi = [0.041, 0.036, 0.028];
%       pd = 650;

  % =======================================================================
  %                             13 GENERATORS
  % =======================================================================
%     problemSize = 13;
%     pgiMin = [0.0, 0.0, 0.0, 60.0, 60.0, 60.0, 60.0, 60.0, 60.0, 40.0, 40.0, 55.0, 55.0]; 
%     pgiMax = [680.0, 360.0, 360.0, 180.0, 180.0, 180.0, 180.0, 180.0, 180.0, 120.0, 120.0, 120.0, 120.0];
%     ai = [0.00028, 0.00056, 0.00056, 0.00324, 0.00324, 0.00324, 0.00324, 0.00324, 0.00324, 0.00284, 0.00284, 0.00284, 0.00284];
%     bi = [8.1, 8.1, 8.1, 7.74, 7.74, 7.74, 7.74, 7.74, 7.74, 8.6, 8.6, 8.6, 8.6];
%     ci = [550.0, 309.0, 307.0, 240.0, 240.0, 240.0, 240.0, 240.0, 240.0, 126.0, 126.0, 126.0, 126.0];
%     ei = [300.0, 200.0, 200.0, 150.0, 150.0, 150.0, 150.0, 150.0, 150.0, 100.0, 100.0, 100.0, 100.0];
%     fi = [0.035, 0.042, 0.042, 0.063, 0.063, 0.063, 0.063, 0.063, 0.063, 0.084, 0.084, 0.084, 0.084];
%     pd = 2520 ;

  % =======================================================================
  %                             19 GENERATORS
  % ======================================================================= 
%    problemSize = 19;
%    pgiMin = [100.0000, 120.0000, 100.0000, 8.0000, 50.0000, 150.0000, 50.0000, 100.0000, 200.0000, 15.0000, 50.0000, 25.0000, 50.0000, 0.0, 20.0000, 15.0000, 15.0000, 50.0000, 400.0000];
%    pgiMax = [300.0000, 438.0000, 250.0000, 25.0000, 63.7500, 300.0000, 63.7500, 500.0000, 600.0000, 40.0000, 150.0000, 75.0000, 63.7500, 95.0000, 220.0000, 80.0000, 80.0000, 230.0000, 500.0000];
%    ai = [0.0097, 0.0055, 0.0055, 0.0025, 0.0, 0.0080, 0.0, 0.0075, 0.0085, 0.0090, 0.0045, 0.0025, 0.0, 0.0045, 0.0065, 0.0045, 0.0025, 0.0045, 0.0080];
%    bi = [6.8000, 4.0000, 4.0000, 0.8500, 5.2800, 3.5000, 5.4390, 6.0000, 6.0000, 5.2000, 1.6000, 0.8500, 2.5500, 1.6000, 4.7000, 1.4000, 0.8500, 1.6000, 5.5000];
%    ci = [119.0000, 90.0000, 45.0000, 0.0, 0.8910, 110.0000, 21.0000, 88.0000, 55.0000, 90.0000, 65.0000, 78.0000, 49.0000, 85.0000, 80.0000, 90.0000, 10.0000, 25.0000, 90.0000];
%    ei = [90.0000, 79.0000, 0.0, 0.0, 0.0, 0.0, 0.0, 50.0000, 0.0, 0.0, 0.0, 58.0000, 0.0, 0.0, 92.0000, 0.0, 0.0, 0.0, 0.0];
%    fi = [0.7200, 0.0500, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5200, 0.0, 0.0, 0.0, 0.0200, 0.0, 0.0, 0.7500, 0.0, 0.0, 0.0, 0.0];
%    pd = 2908;
 
  % =======================================================================
  %                             40 GENERATORS
  % =======================================================================
%    problemSize = 40;
%    pgiMin = [36, 36,	60,	80,	47,	68,	110,	135,	135,	130,	94,	94,	125,	125, 125,	125,	220,	220,	242, 242,	254,	254,	254,	254, 254,	254,	10,	10,	10,	47,	60 ,60, 60, 90, 90, 90, 25, 25, 25, 242];
%    pgiMax = [114,	114,	120,	190,	97,	140,	300,	300,	300,	300,	375,	375,	500, 500,	500,	500,	500,	500,	550,	550,	550,	550,	550, 550,	550,	550,	150,	150,	150,	97,	190 ,190, 190, 200, 200, 200, 110, 110, 110, 550];
%    ai = [94.705,	94.705,	309.54,	369.03,	148.89,	222.33,	287.71,	391.98,	455.76,	722.82,	635.2,	654.69,	913.4,	1760.4,	1760.4,	1760.4,	647.85,	649.69,	647.83,	647.81,	785.96,	785.96,	794.53,	794.53,	801.32,	801.32,	1055.1,	1055.1,	1055.1,	148.89,	222.92, 222.920, 222.920, 107.870, 116.580, 116.580, 307.450, 307.450, 307.450, 647.830];
%    bi = [6.73,	6.73,	7.07,	8.18,	5.35,	8.05,	8.03,	6.99,	6.6,	12.9,	12.9,	12.8,	12.5,	8.84,	8.84,	8.84,	7.97,	7.95,	7.97,	7.97,	6.63,	6.63,	6.66,	6.66,	7.1,	7.1,	3.33,	3.33,	3.33,	5.35,	6.43, 6.43, 6.43, 8.95, 8.62, 8.62, 5.88, 5.88, 5.88, 7.97];
%    ci = [0.0069,	0.0069,	0.02028,	0.00942,	0.0114,	0.01142,	0.00357,	0.00492,	0.00573,	0.00605,	0.00515,	0.00569,	0.00421,	0.00752,	0.00752,	0.00752,	0.00313,	0.00313,	0.00313,	0.00313,	0.00298,	0.00298,	0.00284,	0.00284,	0.00277,	0.00277,	0.52124,	0.52124,	0.52124,	0.0114,	0.0016, 0.00160, 0.00160, 0.00010, 0.00010, 0.00010, 0.01610, 0.01610, 0.01610, 0.00313];
%    ei = [100, 100,	100,	150,	120,	100,	200,	200,	200,	200,	200,	200,	300,	300,	300,	300, 300,	300,	300,	300,	300,	300,	300,	300,	300,	300,	120,	120,	120,	120,	150, 150, 150, 200, 200, 200, 80, 80, 80, 300];                         
%    fi = [0.084, 0.084, 0.084, 0.063, 0.077, 0.084, 0.042, 0.042, 0.042, 0.042, 0.042, 0.042, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.035, 0.077, 0.077, 0.077, 0.077, 0.063, 0.063, 0.063, 0.042, 0.042, 0.042, 0.098, 0.098, 0.098, 0.035];
%    pd = 10500;    
  % =======================================================================
  
  for i = 1 : problemSize
          bounds{i}(1) = pgiMin(i);
          bounds{i}(2) = pgiMax(i);
  end
  max_iter = 100;
  step_size = (bounds{1}(2)-bounds{1}(1))*0.005; 
  max_no_improv = 60;
  ref_set_size = 30;
  div_set_size = 600;
  max_elite = 5;
     
    diverse_set = construct_initial_set(bounds, div_set_size, max_no_improv, step_size, ai, bi, ci, ei, pgiMin, pgiMax, pd, fi);    
    ref_set = diversify(diverse_set, max_elite, ref_set_size);
    best = ref_set(1);
    for i = 1 : length(ref_set)
        ref_set(i).novo = true; % ref_set.each{|c| c[:new] = true};
    end
  for inter = 1:max_iter   
    was_change = explore_subsets(bounds, ref_set, max_no_improv, step_size, ai, bi, ci, ei, pgiMin, pgiMax, pd, fi);
    ref_set = ordena(ref_set); % ref_set.sort~{|x,y| x[:cost] <=> y[:cost]}; % Rearranges the reference set according to the smallest to the biggest costs
     if (ref_set(1).objetivo < best.objetivo) % Inportant to the random vector
        best = ref_set(1);
     end
    if (was_change == ~was_change)
        break
    end % When there is no more new values changes in the reference set
    inter
    best.demanda = soma(best.vetor);
     result = best;   
  end
 end

  % =======================================================================
  %                           OBJECTIVE FUNCTION
  % =======================================================================
function result = objective_function(pgi, ai, bi, ci, ei, pgiMin, fi)
  soma = 0;
 for i = 1:length(pgi)
    soma = soma + ai(i) * (pgi(i) ^ 2.0) + bi(i)* pgi(i);
     %soma = soma + ai(i) * (pgi(i) ^ 2.0) + bi(i) * pgi(i) + ci(i) + ei(i) * abs(sin(fi(i) * (pgiMin(i) - pgi(i))));
 end
   result = soma;
end

  % =======================================================================
  %                                SUMMING 
  % =======================================================================
function result=soma(pgi)
        soma = 0;
        for i=1:length(pgi)
            soma = soma + pgi(i);
        end
        result = soma;
end
    
  % =======================================================================
  %        OBJECTIVE FUNCTION WITH OR WITHOUT THE PENALTY TOLERANCE
  % =======================================================================
function result = correcao(vector, ai, bi, ci, ei, pgiMin, fi, pd, pgiMax)
  soma_pd = soma(vector);
  erro = abs(pd - soma_pd);
  for i = 1:length(vector)
    if ((soma_pd ~= pd) || (vector(i) > pgiMax(i)) || (vector(i) < pgiMin(i)))      
      erro = erro * 10000000 + erro;
    end         
  end 
  if erro ~= 0
    correction = objective_function(vector,  ai, bi, ci, ei, pgiMin, fi)+erro;
  else
    correction = objective_function(vector, ai, bi, ci, ei, pgiMin, fi);
  end
  result = correction;
end

  % =======================================================================
  %             RANDOM VALUES IN MINIMUM AND MAXIMUM BOUNDARIES
  % =======================================================================
function result = rand_in_bounds(min, max)
  result = min + ((max-min) * rand());
end

  % =======================================================================
  %                  GENERATES AND ARRAY WITH RANDOM VALUES
  % =======================================================================
function result = random_vector(minmax, pd, pgiMin, pgiMax) % This function has no guarantees that its last values are in min max boundaries, but there is a high chance of that happening, and the upside is that this function respects the Kirchoff law
 % In another words, it creates coherent values!!
  vector = size(minmax);
  for i = 1:length(minmax)
    vector(i) = rand_in_bounds(pgiMin(i), pgiMax(i));
  end
  result = vector;
end

  % =======================================================================
  %               FINDS THE LOWEST VALUE BETWEEN TWO VALUES
  % =======================================================================
function result = min(x,y)
if (x < y)
    minimo = x;
else
    minimo = y;
end
result = minimo;
end

  % =======================================================================
  %                FINDS THE BIGGEST VALUE BETWEEN TWO VALUES
  % =======================================================================
function result = max(x,y)
if (x > y)
    minimo = x;
else
    minimo = y;
end
result = minimo;
end

  % =======================================================================
  %                            TAKEN STEP FUNCTION
  % =======================================================================
function result = take_step(minmax, current, step_size, pd, pgiMin, pgiMax) % Taken steps towards its neighbors. The step size is created based on minmax value, which is a percentage average taken from the neighborhood
  position = size(current);
  vetor = size(size(current));
  cont = 0;
  totalpercent = 100.0;
   for i = 1: length(current)
    if(i == length(minmax)) % If i is pointed to the last position do:
        vetor(i) = pd * (totalpercent/100); % Add up to the percentual of the min and max constraint 
    else
      minimo = max(minmax{i}(1), current(i)-step_size);
      maximo = min(minmax{i}(2), current(i)+step_size); 
      aleatorio = rand_in_bounds((minimo*100.0)/pd, (maximo*100.0)/pd);  % Accountable for randomly choosing convenient values
      totalpercent = totalpercent - aleatorio ;
      vetor(i) = pd * (aleatorio/100);
    end
   end
        position = vetor;
  result = position;
end

  % =======================================================================
  %                          LOCAL SEARCH FUNCTION
  % =======================================================================
function result = local_search(best, bounds, max_no_improv, step_size, ai, bi, ci, ei, pgiMin, pgiMax, pd, fi) % The local search function is made according to the take_step towards its neighbors
  % Instead of using take_step, the local search could be a metaheuristic search such as Tabu Search
  count = 0;
  while (count < max_no_improv)
    vetor = size(best.vetor);
   % candidate{1,1} = size(best); % <------ Pay attention here
    vetor = take_step(bounds, best.vetor, step_size, pd, pgiMin, pgiMax);
    for i = 1:length(vetor)
      candidate.vetor = vetor;
    end
    candidate.objetivo = correcao(candidate.vetor, ai, bi, ci, ei, pgiMin, fi, pd, pgiMax);
    if (candidate.objetivo > best.objetivo)
        count = count + 1;
    end
    if (candidate.objetivo < best.objetivo) 
        best = candidate;
    end
  end
  result = best;
end

  % =======================================================================
  %                         CREATES THE INITIAL SET
  % =======================================================================
function result = construct_initial_set(bounds, set_size, max_no_improv, step_size, ai, bi, ci, ei, pgiMin, pgiMax, pd, fi) % Diversification Generation Method
  diverse_set = {};
   count = 1;
  while (length(diverse_set) < set_size )     
     cand(count).vetor = random_vector(bounds, pd, pgiMin, pgiMax);
     cand(count).objetivo = correcao(cand(count).vetor, ai, bi, ci, ei, pgiMin, fi, pd, pgiMax); 
     cand(count) = local_search(cand(count), bounds, max_no_improv, step_size, ai, bi, ci, ei, pgiMin, pgiMax, pd, fi);  % Selects through a local search the best results to fill in the diverse_set     
     diverse_set = cand;  
     count = count + 1;
  end 
  result = diverse_set;
end

  % =======================================================================
  %              FINDS THE EUCLIDIAN DISTANCE BETWEEN TWO VALUES
  % =======================================================================
function result = euclidean_distance(c1, c2) % Finds the Euclidian distance
  sum = 0.0; 
  for i = 1: length(c1)
      sum = sum + (c1(i)-c2(i))^2.0;
  end
  result = sqrt(sum);
end

  % =======================================================================
  %               FINDS THE DISTANCE BETWEEN AN ARRAY AND A SET
  % =======================================================================
function result = distance(v, set)
soma = 0.0;
for i = 1 : length(set)
    soma = soma + set(i).vetor + euclidean_distance(v, set(i).vetor); % set.inject(0){|s,x| s + euclidean_distance(v, x[:vector])} # retorns the Euclidian distance between two values
% Sometimes the set(i) is not necessary
end
  result = soma;
end

  % =======================================================================
  %           SORT FROM THE SMALLEST TO THE BIGGEST OBJECTIVE VALUE 
  % =======================================================================
function result = ordena(estrutura)
  for i = 2 : length(estrutura)
    x = estrutura(i);
    j = i-1;
    while(j>=1) && (estrutura(j).objetivo > x.objetivo) 
      estrutura(j+1) = estrutura(j);
      j = j - 1;
    end
    estrutura(j+1) = x;
  end
result = estrutura;
end

  % =======================================================================
  %          SORT FROM THE SMALLEST TO THE BIGGEST DISTANCE VALUES 
  % =======================================================================
function result = ordenaDistancia(estrutura)
  for i = 2 : length(estrutura)
    x = estrutura(i);
    j = i-1;
    while(j>=1) && (estrutura(j).distancia < x.distancia) 
      estrutura(j+1) = estrutura(j);
      j = j - 1;
    end
    estrutura(j+1) = x;
  end
result = estrutura;
end

  % =======================================================================
  %                      CREATES AN EMPTY STRUCT
  % =======================================================================
function resultStruct = CreateEmptySruct(tamanho)
    resultStruct.vetor = zeros(1,tamanho);
    resultStruct.objetivo = 0  ;
    resultStruct.distancia  = 0;
    resultStruct.novo = false;
end

  % =======================================================================
  %                   CREATES THE FIRST REFERENCE SET
  % =======================================================================
function result = diversify(diverse_set, num_elite, ref_set_size) % Cria o Reference Set
  diverse_set = ordena(diverse_set); % diverse_set.sort {|x,y| x[:cost] <=> y[:cost]} % Reference Set Update Method , reorganiza o diverse set dos que tem os menores custos para os maiores
  for i = 1 : num_elite
      ref_set(i) = diverse_set(i); % pega os primeiros valores do diverse set
  end
  count = 1;
  while count <= (length(diverse_set)-length(ref_set))
%for j = 1 :(length(diverse_set)-length(ref_set))
      for k =  length(ref_set)+1 : length(diverse_set) 
         remainder(count) = diverse_set(k);  % vai me lembrar quem n?o pertence j? ao reference set
     count = count + 1;
      end
  end
for c = 1 : length(remainder)
  remainder(c).distancia = soma(distance(remainder(c).vetor, ref_set)); % remainder.each{|c| c[:dist] = } % pego o reference set e tiro a distancia euclidiana entre cada objeto do reminder e o reference set
end
  remainder = ordenaDistancia(remainder); % remainder.sort {|x,y| y[:dist]<=>x[:dist]} % organizo o remainder em fun??o da maior para a menor distancia euclidiana 
  for l = 1 : num_elite
       ref_set(l).distancia = 0;
  end
  ref_set = [ref_set,remainder(1:num_elite)];
 % ref_set = [ref_set , remainder{0:(ref_set_size - ref_set.size)}];  % adiciona o primeiro valor do reminder cujo qual possui a maior distancia assim portanto tenho os cinco melhores valores do diverse_set + cinco valores que est?o mais distantes desses cinco melhores valores que est?o no reminder
  result = ref_set; % retorna o reference set e o melhor valor do reference set
end

  % =======================================================================
  %                 FUNCAO DE SELECAO DOS SUBCONJUNTOS
  % =======================================================================
function result = select_subsets(ref_set) % Subset Generation Method
for i = 1 : length(ref_set)
    if ref_set(i).novo == true
        additions(i) = ref_set(i); % valores true do ref_set
    end
end %ref_set.select{|c| c[:new]} % recebe os objetos do reference set cujos quais s?o novos (true)
for j = 1 : length(additions)
    remainder(j) = CreateEmptySruct (length(ref_set(1).vetor)) ;
end
for k = 1 : length(ref_set)
    if ref_set(k).novo == false
        remainder(k) = ref_set(k); % valores false do ref_set
    end
end % remainder = ref_set - additions; % vai me lembrar quais n?o s?o novos (false)
  if (remainder(1).objetivo ~= 0) % remainder = additions if remainder.nil? or remainder.empty? 
     remainder = additions;
  end
      subsets{1,1} = additions;
      subsets{1,2} = remainder;
  %additions.each do |a| 
  %  remainder.each{|r| subsets << [a,r] if a!=r && !subsets.include?([r,a])} % cria dois subsets com valores diferentes entre si e os preenche
  %end
  % os subsets s?o frutos de uma combina??o entre o aditions e o reminder 
  result = subsets; % aqui tem-se duas colunas subsets[0][1] na qual cada coluna ? um subset, ou seja no subsetS existem dois subset do reminder!
end

  % =======================================================================
  %                   RECOMBINA PARA GERAR FILHOS
  % =======================================================================
function result = recombine(subset,x, y, minmax, ai, bi, ci, ei, pgiMin, pgiMax, pd, fi) 
  a = x;
  b = y;
  for i = 1 : length(pgiMin)
    d(i) = ((b.vetor(i) - a.vetor(i))/2); % d = Array.new(a[:vector].size) {|i|(b[:vector][i]-a[:vector][i])/2.0} % distancia m?dia entre o subset a e o subset b
  end
  children = [];
  directions = 0;
  for p=1:length(x)
      r = rand();      
      if (r<0.5)
        directions = directions + 1;
      else
          directions = directions - 1;
      end % direction, r = ((rand<0.5) ? +1.0 : -1.0), rand % se True (valor novo) retorne +1 se n?o houver valores novos (false) retorne -1      
      for i = 1 : length(pgiMin)
         vetor{1,1}.vetor(i) = subset{1,1}(p).vetor(i) + directions * r * d(i); % vetor = Array.new(minmax.size) {|j| p[:vector][j] + (direction * r * d[j])} % soma valores novos, retira se n?o for 
         vetor{1,2}.vetor(i) = subset{1,2}(p).vetor(i) + directions * r * d(i);
      end   
    for i = 1 : length(pgiMin)
        for j = 1 : length(vetor)
            child{1,j}.vetor = vetor{1,j}.vetor;
            if child{1,j}.vetor(i) < minmax{1,i}(1)
                child{1,j}.vetor(i) = minmax{1,i}(1);
            end
            if child{1,j}.vetor(i) > minmax{1,i}(2)
                child{1,j}.vetor(i) = minmax{1,i}(2);
            end
        end
    end       
    child{1,1}.objetivo = correcao(child{1,1}.vetor, ai, bi, ci, ei, pgiMin, fi, pd, pgiMax);
    child{1,2}.objetivo = correcao(child{1,2}.vetor, ai, bi, ci, ei, pgiMin, fi, pd, pgiMax);
    children = [children,child];
  end
  result = children;
end

  % =======================================================================
  %                      EXPLORA OS SUBCONJUNTOS
  % =======================================================================
function result = explore_subsets(bounds, ref_set, max_no_improv, step_size, ai, bi, ci, ei, pgiMin, pgiMax, pd, fi) % Solution Combination Method
  % Explora um poss?vel candidatos melhorado de filhos gerados de subsets para atualizar o reference_set
  was_change = false;
  subsets = select_subsets(ref_set);
  for i = 1 :length(ref_set)
    ref_set(i).novo = false; % ref_set.each{|c| c[:new] = false}
  end
    for subset = 1 : length(subsets)
           x = subsets{1,1}(subset);
           y = subsets{1,2}(subset);
           candidates = recombine(subsets, x, y, bounds, ai, bi, ci, ei, pgiMin, pgiMax, pd, fi);
       for i = 1 : length(candidates) % improved = Array.new(candidates.size) do |i|  % improved ? feito nesse algoritimo de acordo com uma busca local dos candidatos recombinados dos subsets (os filhos dos subsets)
          improved{1,i} = local_search(candidates{1,i}, bounds, max_no_improv, step_size, ai, bi, ci, ei, pgiMin, pgiMax, pd, fi); % faz uma busca local 
          improved{1,i}.distancia = 0;
          improved{1,i}.novo = true;
       end
        for c = 1 : length(ref_set)
            for j = 1 : length(improved)
                if (ref_set(c).vetor ~= improved{1,j}.vetor) %|| (ref_set(c).vetor ~= improved{1,2}.vetor)
                    ref_set(c).novo = true;
                    ref_set = ordena(ref_set);
                    if improved{1,j}.objetivo < ref_set(length(ref_set)).objetivo
                       ref_set(length(ref_set)) = improved{1,j};
                       was_change = true;
                    end
                end
            end 
        end 
    end
      result = was_change; % Retorna se houver novos valores no reference set
end
