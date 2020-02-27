function [R] = Algebraic(name, d)
	% Functia care calculeaza vectorul PageRank folosind varianta algebrica de
	% calcul.
	% Intrari:
	% -> nume: numele fisierului in care se scrie;
	% -> d: probabilitatea ca un anumit utilizator sa continue navigarea la o pagina
	% urmatoare.
	% Iesiri:
	% -> R: vectorul de PageRank-uri acordat pentru fiecare pagin
	
	% obtinerea datelor de intrare din fisier
	fid = fopen(name);
	n = str2num(fgetl(fid)); 
	% initializarea matricei de adiacenta ca o matrice nula
	A = zeros(n, n);  
	for nr = 1 : n
		buff = fgetl(fid);
		buff = str2num(buff);
		A(1 : length(buff), nr) = buff;
	endfor
	% memorarea nr. de vecini din matricea in care am structurat datele de 
	% intrare; stergem linia corespunzatoare din matrice deoarece nu ne
	% mai este de folos
	outdegrees = A(2, :);
	A(2, :) = [];
	% crearea matricei de adiacenta pe baza datelor de intrare
	AD = zeros(n, n);
	for j = 1 : n
		for i = 2 : (n-1)
			% daca nodul i nu este vecin cu nodul j, nu este nimic de facut
			if A(i, j) == 0
				continue
			endif
			% marcam faptul ca nodul i este vecin cu nodul j in mat. de ad.
			AD(A(1, j), A(i, j)) = 1;
		endfor
	endfor
	% actualizarea mat. de ad. si a vectorului de vecini pt. cazul in
	% care nodul i este vecin cu el insusi
	for i = 1 : n
		if AD(i, i) == 1
			AD(i, i) = 0;
			outdegrees(i) = outdegrees(i) - 1;
		endif
	endfor
	% calculul matricei M(miu) pe baza formulei date	
	M = zeros(n, n);
	one = ones(n, 1);
	% K - mat. diagonala => K^(-1) <=> K^(-1)(i,i) = 1 / K(i,i)
	invoutdegrees = 1 ./ outdegrees;
	K = diag(invoutdegrees);
	M = (K * AD)'; %'

	% calculam inversa folosind algoritmul Gram-Schmiidt modificat
	T = (eye(n) - d*M);
	[Q R] = mgs(T);
	InvT = [];
	I = eye(n);
	% functia SST rezolva sistemul superior triunghiular
	for i = 1 : n
		x = SST(R, Q' * I(:,i));
		InvT = [InvT x];
	endfor
	R = InvT * (1-d)/n * one;

endfunction