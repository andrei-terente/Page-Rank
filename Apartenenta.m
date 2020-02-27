function y = Apartenenta(x, val1, val2)
	% consider ca singura precizatie necesara este legata de modul
	% de calculare al parametriilor a si b
	% acestia au fost calculati astfel incat functia y(x) sa fie continua
	% lim la stanga(val1) y(x) = y(val1)
	% lim la dreapta(val2) y(x) = y(val2)
	a = 1 / (val2 - val1);
	b = val1 / (val1 - val2);
	if (x >= 0) && (x < val1)
		y = 0;
		return
	endif	
	if (x >= val1) && (x <= val2)
		y = a * x + b;
		return
	endif		
	if (x > val2) && (x <= 1)
		y = 1;
		return
	endif	

endfunction
