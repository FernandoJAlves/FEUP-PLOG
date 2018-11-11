:- dynamic cell/3.


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




playLeft(PlayerTurn,I,Tab,NewTab) :-
    Index is 20-I,
    nth1(Index,Tab,Linha),
    ((nth1(I2,Linha,Elem),Elem \= emptySpace,!) -> slideStoneFromLeft(Index,I2,Linha,Tab,Elem,NewTab)).

playRight(PlayerTurn,I,Tab,NewTab) :-
    Index is 20-I,
    nth1(Index,Tab,Linha),
    reverse(Linha,Temp),
    ((nth1(Aux,Temp,Elem),Elem \= emptySpace,!) -> I2 is 20-Aux,slideStoneFromRight(Index,I2,Linha,Tab,Elem,NewTab)).

playUp(PlayerTurn,Index,Tab,NewTab) :-
    ((getPeca(I2,Index,Tab,Elem),Elem \= emptySpace,!) -> slideStoneFromUp(I2,Index,Elem,Tab,NewTab)).

playDown(PlayerTurn,Index,Tab,NewTab) :-
    reverse(Tab,Temp),
    ((getPeca(Aux,Index,Temp,Elem),Elem \= emptySpace,!) -> I2 is 20-Aux,slideStoneFromDown(I2,Index,Elem,Tab,NewTab)).


playDown(Index,Tab,NewTab).


slideStoneFromLeft(Index,I2,Linha,Tab,Stone,NewTab) :-
    Num1 is I2+1,
    Num2 is I2-1,
    nth1(Num1,Linha,Elem),
    (
        Elem \= emptySpace -> setPeca(Index,Num2,whiteStone,Tab,NewTab);
        setPeca(Index,I2,whiteStone,Tab,Tab1),
        setPeca(Index,Num1,Stone,Tab1,NewTab)
        ).

slideStoneFromRight(Index,I2,Linha,Tab,Stone,NewTab) :-
    Num1 is I2-1,
    Num2 is I2+1,
    nth1(Num1,Linha,Elem),
        (
            Elem \= emptySpace -> setPeca(Index,Num2,whiteStone,Tab,NewTab);
            setPeca(Index,I2,whiteStone,Tab,Tab1),
            setPeca(Index,Num1,Stone,Tab1,NewTab)
            ).


slideStoneFromUp(I2,Index,Stone,Tab,NewTab) :-
    Num1 is I2+1,
    Num2 is I2-1,
    getPeca(Num1,Index,Tab,NextElem),
    (
        NextElem \= emptySpace -> setPeca(Num2,Index,whiteStone,Tab,NewTab);
        setPeca(I2,Index,whiteStone,Tab,Tab1),
        setPeca(Num1,Index,Stone,Tab1,NewTab)
        ).

slideStoneFromDown(I2,Index,Stone,Tab,NewTab) :-
    Num1 is I2-1,
    Num2 is I2+1,
    getPeca(Num1,Index,Tab,NextElem),
    (
        NextElem \= emptySpace -> setPeca(Num2,Index,whiteStone,Tab,NewTab);
        setPeca(I2,Index,whiteStone,Tab,Tab1),
        setPeca(Num1,Index,Stone,Tab1,NewTab)
    ).


getPlayerSymbol(player1,whiteStone).
getPlayerSymbol(player2,blackStone).
changeTurn(player1,player2).
changeTurn(player2,player1).