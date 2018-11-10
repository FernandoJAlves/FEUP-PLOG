:- dynamic cell/3.

getPeca(Nlinha, Ncoluna, Tabuleiro, Peca).


getPeca(Nlinha,Ncoluna,Tab,Peca) :-
    nth1(Nlinha,Tab,Linha),
    nth1(Ncoluna,Linha,Peca).

getLinha(1,[Linha|_],Linha).

getLinha(N,[_|Resto],Linha) :-
    N > 1,
    Next is N-1,
    getLinha(Next,Resto,Linha).

setPeca(1, ElemCol, NewElem, [RowAtTheHead|RemainingRows], [NewRowAtTheHead|RemainingRows]):-
	setPecaLinha(ElemCol, NewElem, RowAtTheHead, NewRowAtTheHead).

setPeca(ElemRow, ElemCol, NewElem, [RowAtTheHead|RemainingRows], [RowAtTheHead|ResultRemainingRows]):-
	ElemRow > 1,
	ElemRow1 is ElemRow-1,
	setPeca(ElemRow1, ElemCol, NewElem, RemainingRows, ResultRemainingRows).

%%% 1. position; 2. element to use on replacement; 3. current list; 4. resultant list.
setPecaLinha(1, Elem, [_|L], [Elem|L]).
setPecaLinha(I, Elem, [H|L], [H|ResL]):-
	I > 1,
	I1 is I-1,
	setPecaLinha(I1, Elem, L, ResL).

getPeca(Linha,Coluna,Peca):-
    cell(Linha,Coluna,Peca).

setPeca(Linha):-
    retract(cell(Linha,Coluna,_)),
    assert(cell(Linha,Coluna,Peca)).

append([],Lista,Lista).

append([H|T],Lista,Lista):-
    append(T,Lista,Resto).




playLeft(Index,Tab,NewTab) :-
    nth1(Index,Tab,Linha),
    ((nth1(I2,Linha,Elem),Elem \= emptySpace,!) -> slideStone(Index,I2,Linha,Tab,Elem,NewTab)).


slideStone(Index,I2,Linha,Tab,Stone,NewTab) :-
    Num1 is I2+1,
    Num2 is I2-1,
    nth1(Num1,Linha,Elem),
    print_cell(Elem),
    (
        Elem \= emptySpace -> setPeca(Index,Num2,whiteStone,Tab,NewTab);
        setPeca(Index,I2,whiteStone,Tab,Tab1),
        setPeca(Index,Num1,Stone,Tab1,NewTab)
        ).



