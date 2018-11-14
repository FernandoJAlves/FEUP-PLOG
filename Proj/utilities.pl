pressEnterToContinue:-
	write('Press <Enter> to continue.'), nl,
	get_char(_), !.

clearConsole:-
	clearConsole(40), !.

clearConsole(0).
clearConsole(N):-
	nl,
	N1 is N-1,
	clearConsole(N1).

readChar(Input):-
	get_char(Input),
	get_char(_).

readPlay(Input) :-
	read(Input),
	get_code(_).


checkCharList([]).
checkCharList([Char|Rest]) :-
	(
		Char @>= '0', Char @=< '9' -> true,checkCharList(Rest);
		write('Invalid Input: After the direction you must choose a number between 1 a 19'),fail
		).


b_pieces(L) :- find_b([], L), !.

find_b(Acc, Loa) :- blackCell(X,Y), uList([X,Y], Acc, AccNew), find_b(AccNew, Loa).
find_b(Acc, Acc).

uList(X, [], [X])  :- !.
uList(H, [H|_], _) :- !, fail.
uList(X, [H|T], [H|Rtn]) :- uList(X, T, Rtn).

w_pieces(L) :- find_w([], L), !.

find_w(Acc, Loa) :- whiteCell(X,Y), uList([X,Y], Acc, AccNew), find_w(AccNew, Loa).
find_w(Acc, Acc).


