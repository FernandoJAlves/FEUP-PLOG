
% Prints a line separator
print_separator(0) :- write('+'), nl.
print_separator(SizeL) :- 
    format("+----",[]),
    NewSize is SizeL-1,
    print_separator(NewSize).


% Prints information in memory in a line format
print_mem_line(CurrL, MaxC, MaxC) :-
    cellContent(Val,CurrL,MaxC),
    U_Val is Val mod 35,
    D_Val is Val // 35,
    ifElse(D_Val == 0, format("|  ", []), format("| ~36R", [D_Val])),
    ifElse((D_Val == 0, U_Val == 0), format("  |", []), format("~36R |", [U_Val])),nl.
print_mem_line(CurrL, CurrC, MaxC) :-
    cellContent(Val,CurrL,CurrC),
    U_Val is Val mod 35,
    D_Val is Val // 35,
    ifElse(D_Val == 0, format("|  ", []), format("| ~36R", [D_Val])),
    ifElse((D_Val == 0, U_Val == 0), format("  ", []), format("~36R ", [U_Val])),
    NewC is CurrC+1,
    print_mem_line(CurrL, NewC, MaxC).

% Prints information in memory in a board format
print_mem_board(MaxL, MaxL, MaxC) :-
    print_separator(MaxC),
    print_mem_line(MaxL, 1, MaxC),
    print_separator(MaxC).
print_mem_board(CurrL, MaxL, MaxC) :-
    print_separator(MaxC),
    print_mem_line(CurrL, 1, MaxC),
    NewL is CurrL+1,
    print_mem_board(NewL, MaxL, MaxC).
    

% Prints a line without zeros
print_line([]) :- format("|",[]), nl.
print_line([H|Rest]) :-
    U_Val is H mod 35,
    D_Val is H // 35,
    ifElse(D_Val == 0, format("|  ", []), format("| ~36R", [D_Val])),
    ifElse((D_Val == 0, U_Val == 0), format("  ", []), format("~36R ", [U_Val])),
    print_line(Rest).

% Prints the board without zeros
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


% Prints information in memory in a line format
print_mem_line_final(CurrL, MaxC, MaxC, Vars) :-
    cellContent(Val,CurrL,MaxC),
    U_Val is Val mod 35,
    D_Val is Val // 35,
    ifElse((D_Val == 0; \+ member(Val,Vars)), format("|  ", []), format("| ~36R", [D_Val])),
    ifElse(((D_Val == 0, U_Val == 0); \+ member(Val,Vars)), format("  |", []), format("~36R |", [U_Val])), nl.
print_mem_line_final(CurrL, CurrC, MaxC, Vars) :-
    cellContent(Val,CurrL,CurrC),
    U_Val is Val mod 35,
    D_Val is Val // 35,
    ifElse((D_Val == 0; \+ member(Val,Vars)), format("|  ", []), format("| ~36R", [D_Val])),
    ifElse(((D_Val == 0, U_Val == 0); \+ member(Val,Vars)), format("  ", []), format("~36R ", [U_Val])),
    NewC is CurrC+1,
    print_mem_line_final(CurrL, NewC, MaxC, Vars).

% Prints information in memory in a board format
draw_mem_final(MaxL, MaxL, MaxC, Vars) :-
    print_separator(MaxC),
    print_mem_line_final(MaxL, 1, MaxC, Vars),
    print_separator(MaxC).
draw_mem_final(CurrL, MaxL, MaxC, Vars) :-
    print_separator(MaxC),
    print_mem_line_final(CurrL, 1, MaxC, Vars),
    NewL is CurrL+1,
    draw_mem_final(NewL, MaxL, MaxC, Vars).


% Draw line in final format
print_line_final([],_) :- format("|",[]), nl.
print_line_final([H|Rest], Vars) :-
    U_Val is H mod 35,
    D_Val is H // 35,
    ifElse((D_Val == 0; \+ member(H,Vars)), format("|  ", []), format("| ~36R", [D_Val])),
    ifElse(((D_Val == 0, U_Val == 0); \+ member(H,Vars)), format("  ", []), format("~36R ", [U_Val])),
    print_line_final(Rest, Vars).

% Draw final board 
draw_board_final([H|[]], Vars) :-
    length(H, SizeL),
    print_separator(SizeL),
    print_line_final(H, Vars),
    print_separator(SizeL).
draw_board_final([H|Rest], Vars) :-
    length(H, SizeL),
    print_separator(SizeL),
    print_line_final(H, Vars),
    draw_board_final(Rest, Vars).


% Prints the cellContent in memory
print_mem :-
    cellContent(Val,X,Y),
    format("Val: ~w  X: ~w  Y: ~w", [Val,X,Y]), nl,
    fail; true.

% If/Else operator
ifElse(C,G,E) :- C, !, G.
ifElse(C,G,E) :- E.


% Gets the board specified in its first argument
fetch_board(tab1, Tab) :-

    Tab =  [[1,1,2,2,0,0,3,3],
            [4,1,1,2,2,3,3,0],
            [4,4,1,0,2,3,0,0],
            [5,4,4,0,6,6,0,7],
            [5,5,0,6,6,0,7,7],
            [0,5,5,6,0,7,7,0]].       


fetch_board(tab2, Tab) :-
            %1, 2, 3, 4, 5, 6, 7, 8, 9 
    Tab =  [[0, 1, 1, 0, 0, 0, 0, 0, 0], % 1
            [1, 1, 0, 0, 0, 0, 0, 0, 0], % 2
            [1, 0, 0, 0, 0, 0, 0, 0, 0], % 3
            [0, 0, 2, 0, 0, 0, 0, 0, 0], % 4
            [0, 2, 2, 0, 0, 0, 0, 0, 0], % 5
            [2, 2, 0, 0, 0, 0, 0, 0, 0], % 6
            [3, 0, 0, 0, 4, 4, 0, 0, 5], % 7
            [3, 3, 0, 4, 4, 0, 0, 5, 5], % 8 
            [0, 3, 3, 4, 0, 0, 5, 5, 0]].% 9


fetch_board(tab3, Tab) :-
            % 1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15
    Tab =  [[ 0,11,11, 0, 0,22,22, 0, 0, 0, 8, 8,28,28, 0], % 1
            [11,11,21, 0,22,22,15,15, 0,24, 0, 8, 8,28,28], % 2
            [11, 0,21,21,22, 0, 0,15,15,24,24, 0, 8, 0,28], % 3
            [ 0, 0, 0,21,21, 4, 4, 0,15, 0,24,24,13,13, 0], % 4
            [ 0, 6, 6, 0,16, 0, 4, 4, 0, 0, 0,13,13, 0,12], % 5
            [ 6, 6,17,17,16,16, 0, 4, 0, 3, 0,13, 0,12,12], % 6
            [ 6,17,17, 0,18,16,16, 0, 0, 3, 3, 0,12,12, 0], % 7
            [ 0,17, 0,18,18, 0, 0, 1, 1, 0, 3, 3,29, 0, 0], % 8
            [ 7, 7,18,18, 0,27,23,23, 1, 1, 0,29,29,10, 0], % 9
            [ 0, 7, 7, 2, 2,27,27,23,23, 1,29,29,10,10, 0], % 10
            [ 0, 0, 7, 0, 2, 2,27,27,23,20, 0,10,10, 0, 0], % 11
            [ 0,25,25, 0, 0, 2, 0, 0,20,20, 0, 0, 9, 0, 0], % 12
            [25,25,14, 0,19, 0, 0,20,20, 5, 0,26, 9, 9, 0], % 13
            [25, 0,14,14,19,19, 0, 0, 5, 5,26,26, 0, 9, 9], % 14
            [ 0, 0, 0,14,14,19,19, 5, 5,26,26, 0, 0, 0, 0]].% 15
       


% Saves a line in memory
save_line([],_,_).
save_line([H|Rest],NLinha,NColuna) :-
    assert(cellContent(H,NLinha, NColuna)),
    NewNColuna is NColuna+1,
    save_line(Rest,NLinha,NewNColuna).

% Saves a board in memory
save_board([],_).
save_board([H|Rest],NLinha) :-
    save_line(H,NLinha,1),
    NewNLinha is NLinha+1,
    save_board(Rest,NewNLinha).



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

