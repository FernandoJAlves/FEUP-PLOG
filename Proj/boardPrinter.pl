display_game(Board):-
	length(Board,L),
	print_tab(Board,L),
	write('Black Stones: '),
	printBlackList,
	nl,
	write('White Stones: '),
	printWhiteList,
	nl.

initialBoard([
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,blackStone,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
	[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace]
	]).

exampleBoard([
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,blackStone,whiteStone,blackStone,whiteStone,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,whiteStone,blackStone,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace]
		]).

finalBoard([
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,blackStone,blackStone,blackStone,blackStone,blackStone,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,whiteStone,whiteStone,whiteStone,whiteStone,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace],
		[emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace,emptySpace]
		]).



print_tab(Tab, Size):-
	write('\t  A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S'),
	nl,nl,
	print_grid(Tab,Size,Size),
	write('\t  A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S'),
	nl,nl.

print_grid([],_,_).
print_grid([L|T], Size,Num):-
	write('\t'),
	print_barras(Size), nl,
	write(Num),
	write('\t'),
	Num1 is Num - 1,
	print_line(L),put_code(9549), 
	write('\t\t'),
	write(Num),
	nl,
	print_grid(T, Size,Num1).

print_line([]).
print_line([C|L]):- 
	put_code(9549),
	print_cell(C),
	print_line(L).

print_cell(whiteStone):- put_code(9549),put_code(9898).
print_cell(emptySpace):- put_code(9549), put_code(9547),put_code(9549).
print_cell(blackStone):- put_code(9549),put_code(9899).
print_cell(_):- write('?').

print_barras(0).

print_barras(Size):-
Size > 0, 
write('  '),
put_code(9551),
write(' '),
Size1 is Size - 1,
print_barras(Size1). 

printBlackList :- 
	(blackCell(X,Y),write('('),write(X),write(', '),write(Y), write(')'),write(','),fail;true).

printWhiteList :- 
	(whiteCell(X,Y),write('('),write(X),write(', '),write(Y), write(')'),write(','),fail;true).