pressEnterToContinue:-
	write('Press <Enter> to continue.'), nl,
	get_char(_), !.

clearConsole:-
	%%write('\33\[2J').
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
	read_line(Input).


checkCharList([]).
checkCharList([Char|Rest]) :-
	(
		Char @>= '0', Char @=< '9' -> true,checkCharList(Rest);
		write('Invalid Input: After the direction you must choose a number between 1 a 19'),fail
		).


setrandomness :-
	now(Usec),NewSeed is Usec mod 12345,
	getrand(random(X, Y, Z, _)),
	setrand(random(NewSeed, X, Y, Z)).


uList(X, [], [X])  :- !.
uList(H, [H|_], _) :- !, fail.
uList(X, [H|T], [H|Rtn]) :- uList(X, T, Rtn).


b_pieces(L) :- find_b([], L), !.

find_b(Acc, Loa) :- blackCell(X,Y), uList([X,Y], Acc, AccNew), find_b(AccNew, Loa).
find_b(Acc, Acc).


w_pieces(L) :- find_w([], L), !.

find_w(Acc, Loa) :- whiteCell(X,Y), uList([X,Y], Acc, AccNew), find_w(AccNew, Loa).
find_w(Acc, Acc).



findCopyB :- blackCell(X,Y), storeSim(blackStone,X,Y), fail; true.
findCopyW :- whiteCell(X,Y), storeSim(whiteStone,X,Y), fail; true.


b_piecesSim(L) :- find_bSim([], L), !.

find_bSim(Acc, Loa) :- bSimCell(X,Y), uList([X,Y], Acc, AccNew), find_bSim(AccNew, Loa).
find_bSim(Acc, Acc).

w_piecesSim(L) :- find_wSim([], L), !.

find_wSim(Acc, Loa) :- wSimCell(X,Y), uList([X,Y], Acc, AccNew), find_wSim(AccNew, Loa).
find_wSim(Acc, Acc).



copyDataBase :-
	findCopyB,
	findCopyW.


scoreLine(_,1,OutValue) :- OutValue is 0.
scoreLine(_,2,OutValue) :- OutValue is 0.
scoreLine(_,3,OutValue) :- OutValue is 0.
scoreLine(_,4,OutValue) :- OutValue is 0.
scoreLine(1,0,OutValue) :- OutValue is 1.
scoreLine(2,0,OutValue) :- OutValue is 10.
scoreLine(3,0,OutValue) :- OutValue is 50.
scoreLine(4,0,OutValue) :- OutValue is 100.
scoreLine(5,0,OutValue) :- OutValue is 10000.

ifElse(C,G,E) :- C, !, G.
ifElse(C,G,E) :- E.


setupTestTab(Tab) :-
	storeCell(blackStone,5,2),
	storeCell(blackStone,4,2),
	storeCell(blackStone,5,3),
	storeCell(blackStone,4,3),
	storeCell(blackStone,3,3),
	Tab = [[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
			[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
			[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
			[emptySpace,blackStone,blackStone,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
			[emptySpace,blackStone,blackStone,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
			[emptySpace,emptySpace,blackStone,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
			[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
			[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace]].
