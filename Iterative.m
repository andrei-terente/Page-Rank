function [R0] = Iterative(name, d, eps)
	% Functia care calculeaza matricea R folosind algoritmul iterativ.
	% Intrari:
	% -> nume: numele fisierului din care se citeste;	
	% -> d: coeficentul d, adica probabilitatea ca un anumit navigator sa
	%continue navigarea (0.85 in cele mai multe cazuri)
	% -> eps: eroarea care apare in algoritm.
	% Iesiri:
	% -> R: vectorul de PageRank-uri acordat pentru fiecare pagina.
	% obtinerea datelor din fisierul de intrare, identica celei din
	% algoritmul Agebraic
	fid = fopen(name);
	n = str2num(fgetl(fid)); 
	A = zeros(n, n);  
	for nr = 1 : n
		buff = fgetl(fid);
		buff = str2num(buff);
		A(1 : length(buff), nr) = buff;
	endfor
	outdegrees = A(2, :);
	A(2, :) = [];
	AD = zeros(n, n);
	for j = 1 : n
		for i = 2 : (n-1)
			if A(i, j) == 0
				continue
			endif
			AD(A(1, j), A(i, j)) = 1;
		endfor
	endfor
	% tratarea exceptiilor(cazul in care nodul i este vecin cu el insusi)
	for i = 1 : n
		if AD(i, i) == 1
			AD(i, i) = 0;
			outdegrees(i) = outdegrees(i) - 1;
		endif
	endfor
	% calculul M(miu), R(t+1) pe baza formulelor 
	R0 = rand(n, 1);
	R0(:, :) = 1 / n;
	M = zeros(n, n);
	one = ones(n, 1);
	invoutdegrees = 1 ./ outdegrees;
	K = diag(invoutdegrees);	
	M = (K * AD)'; 
	for step = 1 : 10000
		R = d * M * R0 + ((1 - d) / n) * one;
		if norm(R - R0) < eps
			break
		endif
		R0 = R;
	endfor

	

endfunction

