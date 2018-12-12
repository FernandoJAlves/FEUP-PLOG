
save_line([],_,_).
save_line([H|Rest],NLinha,NColuna) :-
    assert(cellContent(H,NLinha, NColuna)),
    NewNColuna is NColuna+1,
    save_line(Rest,NLinha,NewNColuna).

save_board([],_).
save_board([H|Rest],NLinha) :-
    save_line(H,NLinha,1),
    NewNLinha is NLinha+1,
    save_board(Rest,NewNLinha).


print_line([]) :- format("|",[]), nl.
print_line([H|Rest]) :-
    format("| ~w ", [H]),
    print_line(Rest).

print_separator(0) :- write('+'), nl.
print_separator(SizeL) :- 
    format("+---",[]),
    NewSize is SizeL-1,
    print_separator(NewSize).

print_board([H|[]]) :-
    length(H, SizeL),
    print_separator(SizeL),
    print_line(H),
    print_separator(SizeL).
print_board([H|Rest]) :-
    length(H, SizeL),
    print_separator(SizeL),
    print_line(H),
    print_board(Rest).



print_mem :-
    cellContent(Val,X,Y),
    format("Val: ~w  X: ~w  Y: ~w", [Val,X,Y]), nl,
    fail; true.

% If/Else operator
ifElse(C,G,E) :- C, !, G.
ifElse(C,G,E) :- E.

fetch_board(tab1, Tab) :-

    Tab =  [[1,1,2,2,0,0,3,3],
            [4,1,1,2,2,3,3,0],
            [4,4,1,0,2,3,0,0],
            [5,4,4,0,6,6,0,7],
            [5,5,0,6,6,0,7,7],
            [0,5,5,6,0,7,7,0]].       

/*
fetch_board(tab2, Tab) :-
            %1, 2, 3, 4, 5 
    Tab =  [[0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 1, 0, 1, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0]].

fetch_board(tab3, Tab) :-
            %1, 2, 3, 4, 5, 6, 7, 8, 9, 10 
    Tab =  [[0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
            [1, 0, 1, 0, 0, 0, 0, 1, 1, 0],
            [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
            [0, 0, 1, 0, 1, 0, 0, 0, 0, 1],
            [0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
            [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
            [0, 1, 1, 0, 0, 0, 0, 1, 0, 1],
            [0, 0, 1, 1, 1, 0, 1, 0, 1, 0]].
*/



% Sets a piece in a given position
setPeca(1, ElemCol, NewElem, [RowAtTheHead|RemainingRows], [NewRowAtTheHead|RemainingRows]):-
	setPecaLinha(ElemCol, NewElem, RowAtTheHead, NewRowAtTheHead).

setPeca(ElemRow, ElemCol, NewElem, [RowAtTheHead|RemainingRows], [RowAtTheHead|ResultRemainingRows]):-
	ElemRow > 1,
	ElemRow1 is ElemRow-1,
	setPeca(ElemRow1, ElemCol, NewElem, RemainingRows, ResultRemainingRows).

% Sets a piece in a line: 1. position; 2. element to use on replacement; 3. current list; 4. resultant list.
setPecaLinha(1, Elem, [_|L], [Elem|L]).
setPecaLinha(I, Elem, [H|L], [H|ResL]):-
	I > 1,
	I1 is I-1,
	setPecaLinha(I1, Elem, L, ResL).

