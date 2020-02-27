function[R1 R2] = PageRank(nume, d, eps)
	% Calculeaza indicii PageRank pentru cele 3 cerinte
	% Scrie fisierul de iesire nume.out
	fid = fopen(nume);
	n = str2num(fgetl(fid));
	for i = 1 : n
		buff = fgetl(fid);
	endfor
	val1 = str2num(fgetl(fid));
	val2 = str2num(fgetl(fid));
	R1 = Iterative(nume, d, eps);
	R2 = Algebraic(nume, d, eps);
	PR2 = R2;
	n = length(R2);
	perm = [1 : 1 : n]'; %'
	do
		sorted = 1;
		for i = 1 : (n - 1)
			if PR2(i) < PR2(i+1)
				aux = PR2(i);
				aux2 = perm(i);
				PR2(i) = PR2(i+1);
				perm(i) = perm(i+1);
				PR2(i+1) = aux;
				perm(i+1) = aux2;
				sorted = 0;
			endif
		endfor
	until (sorted == 1) 
	numeout = strcat(nume, '.out');
	out = fopen(numeout, 'w');
	fprintf(out, '%d\n', n);
	for i = 1 : n
		fprintf(out, "%0.6f\n", R1(i));
	endfor
	fprintf(out, '\n');
	for i = 1 : n
		fprintf(out, "%0.6f\n", R2(i));
	endfor
	fprintf(out, '\n');
	for i = 1 : n
		fprintf(out, "%d %d %0.6f\n", i, perm(i), Apartenenta(PR2(i), val1, val2));
	endfor

	fclose(out);




endfunction
