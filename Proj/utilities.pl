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