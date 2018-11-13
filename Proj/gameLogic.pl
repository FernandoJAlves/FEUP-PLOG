:- dynamic blackCell/2.
:- dynamic whiteCell/2.


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


playLeft(PlayerTurn,I,Tab,NewTab) :-
    Index is 20-I,
    nth1(Index,Tab,Linha),
    ((nth1(I2,Linha,Elem),Elem \= emptySpace,!) -> slideStoneFromLeft(PlayerTurn,Index,I2,Linha,Tab,Elem,NewTab)).

playRight(PlayerTurn,I,Tab,NewTab) :-
    Index is 20-I,
    nth1(Index,Tab,Linha),
    reverse(Linha,Temp),
    ((nth1(Aux,Temp,Elem),Elem \= emptySpace,!) -> I2 is 20-Aux,slideStoneFromRight(PlayerTurn,Index,I2,Linha,Tab,Elem,NewTab)).

playUp(PlayerTurn,Index,Tab,NewTab) :-
    ((getPeca(I2,Index,Tab,Elem),Elem \= emptySpace,!) -> slideStoneFromUp(PlayerTurn,I2,Index,Elem,Tab,NewTab)).

playDown(PlayerTurn,Index,Tab,NewTab) :-
    reverse(Tab,Temp),
    ((getPeca(Aux,Index,Temp,Elem),Elem \= emptySpace,!) -> I2 is 20-Aux,slideStoneFromDown(PlayerTurn,I2,Index,Elem,Tab,NewTab)).




slideStoneFromLeft(PlayerTurn,Index,I2,Linha,Tab,Stone,NewTab) :-
    
    Num1 is I2+1,
    Num2 is I2-1,
    nth1(Num1,Linha,Elem),
    getPlayerSymbol(PlayerTurn,Symbol),
    (
        Elem \= emptySpace -> setPeca(Index,Num2,Symbol,Tab,NewTab);
        setPeca(Index,I2,Symbol,Tab,Tab1),
        setPeca(Index,Num1,Stone,Tab1,NewTab),
        rmCell(Stone,Index,I2),
        storeCell(Symbol,Index,I2),
        storeCell(Stone,Index,Num1)
        ).

slideStoneFromRight(PlayerTurn,Index,I2,Linha,Tab,Stone,NewTab) :-
    Num1 is I2-1,
    Num2 is I2+1,
    nth1(Num1,Linha,Elem),
    getPlayerSymbol(PlayerTurn,Symbol),
    (
        Elem \= emptySpace -> setPeca(Index,Num2,Symbol,Tab,NewTab);
        setPeca(Index,I2,Symbol,Tab,Tab1),
        setPeca(Index,Num1,Stone,Tab1,NewTab),
        rmCell(Stone,Index,I2),
        storeCell(Symbol,Index,I2),
        storeCell(Stone,Index,Num1)
        ).


slideStoneFromUp(PlayerTurn,I2,Index,Stone,Tab,NewTab) :-
    Num1 is I2+1,
    Num2 is I2-1,
    getPeca(Num1,Index,Tab,NextElem),
    getPlayerSymbol(PlayerTurn,Symbol),
    (
        NextElem \= emptySpace -> setPeca(Num2,Index,Symbol,Tab,NewTab);
        setPeca(I2,Index,Symbol,Tab,Tab1),
        setPeca(Num1,Index,Stone,Tab1,NewTab),
        rmCell(Stone,I2,Index),
        storeCell(Symbol,I2,Index),
        storeCell(Stone,Num1,Index)
        ).

slideStoneFromDown(PlayerTurn,I2,Index,Stone,Tab,NewTab) :-
    Num1 is I2-1,
    Num2 is I2+1,
    getPeca(Num1,Index,Tab,NextElem),
    getPlayerSymbol(PlayerTurn,Symbol),
    (
        NextElem \= emptySpace -> setPeca(Num2,Index,Symbol,Tab,NewTab),storeCell(Symbol,Num2,Index);
        setPeca(I2,Index,Symbol,Tab,Tab1),
        setPeca(Num1,Index,Stone,Tab1,NewTab),
        rmCell(Stone,I2,Index),
        storeCell(Symbol,I2,Index),
        storeCell(Stone,Num1,Index)
    ).


getPlayerSymbol(player1,whiteStone).
getPlayerSymbol(player2,blackStone).

changeTurn(player1,player2).
changeTurn(player2,player1).

otherSymbol(whiteStone,blackStone).
otherSymbol(blackStone,whiteStone).

storeCell(whiteStone,Nlinha,Ncol) :- assert(whiteCell(Nlinha,Ncol)).
storeCell(blackStone,Nlinha,Ncol) :- assert(blackCell(Nlinha,Ncol)).

rmCell(whiteStone,Nlinha,Ncol) :- retract(whiteCell(Nlinha,Ncol)).
rmCell(blackStone,Nlinha,Ncol) :- retract(blackCell(Nlinha,Ncol)).