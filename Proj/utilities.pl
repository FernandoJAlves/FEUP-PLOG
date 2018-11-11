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
		write('Invalid Input: After the direction you mustc choose a number between 1 a 19'),fail
		).