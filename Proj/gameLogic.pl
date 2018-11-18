:- dynamic blackCell/2.
:- dynamic whiteCell/2.
:- dynamic bSimCell/2.
:- dynamic wSimCell/2.


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
    ifElse((nth1(I2,Linha,Elem),Elem \= emptySpace,!),slideStoneFromLeft(PlayerTurn,Index,I2,Linha,Tab,Elem,NewTab),true).

playRight(PlayerTurn,I,Tab,NewTab) :-
    Index is 20-I,
    nth1(Index,Tab,Linha),
    reverse(Linha,Temp),
    ifElse((nth1(Aux,Temp,Elem),Elem \= emptySpace,!),(I2 is 20-Aux,slideStoneFromRight(PlayerTurn,Index,I2,Linha,Tab,Elem,NewTab)),true).

playUp(PlayerTurn,Index,Tab,NewTab) :-
    ifElse((getPeca(I2,Index,Tab,Elem),Elem \= emptySpace,!),slideStoneFromUp(PlayerTurn,I2,Index,Elem,Tab,NewTab),true).

playDown(PlayerTurn,Index,Tab,NewTab) :-
    reverse(Tab,Temp),
    ifElse((getPeca(Aux,Index,Temp,Elem),Elem \= emptySpace,!),(I2 is 20-Aux,slideStoneFromDown(PlayerTurn,I2,Index,Elem,Tab,NewTab)),true).

playLeftSim(PlayerTurn,I,Tab) :-
    Index is 20-I,
    nth1(Index,Tab,Linha),
    ifElse((nth1(I2,Linha,Elem),Elem \= emptySpace,!),slideStoneFromLeftSim(PlayerTurn,Index,I2,Linha,Tab,Elem),true).

playRightSim(PlayerTurn,I,Tab) :-
    Index is 20-I,
    nth1(Index,Tab,Linha),
    reverse(Linha,Temp),
    ifElse((nth1(Aux,Temp,Elem),Elem \= emptySpace,!),(I2 is 20-Aux,slideStoneFromRightSim(PlayerTurn,Index,I2,Linha,Tab,Elem)),true).

playUpSim(PlayerTurn,Index,Tab) :-
    ifElse((getPeca(I2,Index,Tab,Elem),Elem \= emptySpace,!),slideStoneFromUpSim(PlayerTurn,I2,Index,Elem,Tab),true).

playDownSim(PlayerTurn,Index,Tab) :-
    reverse(Tab,Temp),
    ifElse((getPeca(Aux,Index,Temp,Elem),Elem \= emptySpace,!),(I2 is 20-Aux,slideStoneFromDownSim(PlayerTurn,I2,Index,Elem,Tab)),true).




slideStoneFromLeft(PlayerTurn,Index,I2,Linha,Tab,Stone,NewTab) :-
    
    Num1 is I2+1,
    Num2 is I2-1,
    nth1(Num1,Linha,Elem),
    getPlayerSymbol(PlayerTurn,Symbol),
    ifElse(
        (Elem \= emptySpace), (setPeca(Index,Num2,Symbol,Tab,NewTab),storeCell(Symbol,Index,Num2)),
        (setPeca(Index,I2,Symbol,Tab,Tab1),
        setPeca(Index,Num1,Stone,Tab1,NewTab),
        rmCell(Stone,Index,I2),
        storeCell(Symbol,Index,I2),
        storeCell(Stone,Index,Num1))
).


slideStoneFromRight(PlayerTurn,Index,I2,Linha,Tab,Stone,NewTab) :-
    Num1 is I2-1,
    Num2 is I2+1,
    nth1(Num1,Linha,Elem),
    getPlayerSymbol(PlayerTurn,Symbol),
    (
        Elem \= emptySpace -> setPeca(Index,Num2,Symbol,Tab,NewTab),storeCell(Symbol,Index,Num2);
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
        NextElem \= emptySpace -> setPeca(Num2,Index,Symbol,Tab,NewTab),storeCell(Symbol,Num2,Index);
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



slideStoneFromLeftSim(PlayerTurn,Index,I2,Linha,Tab,Stone) :-
    
    Num1 is I2+1,
    Num2 is I2-1,
    nth1(Num1,Linha,Elem),
    getPlayerSymbol(PlayerTurn,Symbol),
    (
        Elem \= emptySpace -> storeSim(Symbol,Index,Num2);

        rmSim(Stone,Index,I2),
        storeSim(Symbol,Index,I2),
        storeSim(Stone,Index,Num1)
).

slideStoneFromRightSim(PlayerTurn,Index,I2,Linha,Tab,Stone) :-
    Num1 is I2-1,
    Num2 is I2+1,
    nth1(Num1,Linha,Elem),
    getPlayerSymbol(PlayerTurn,Symbol),
    (
        Elem \= emptySpace -> storeSim(Symbol,Index,Num2);

        rmSim(Stone,Index,I2),
        storeSim(Symbol,Index,I2),
        storeSim(Stone,Index,Num1)
).

slideStoneFromUpSim(PlayerTurn,I2,Index,Stone,Tab) :-
    Num1 is I2+1,
    Num2 is I2-1,
    getPeca(Num1,Index,Tab,NextElem),
    getPlayerSymbol(PlayerTurn,Symbol),
    (
        NextElem \= emptySpace -> storeSim(Symbol,Num2,Index);
        rmSim(Stone,I2,Index),
        storeSim(Symbol,I2,Index),
        storeSim(Stone,Num1,Index)
).

slideStoneFromDownSim(PlayerTurn,I2,Index,Stone,Tab) :-
    Num1 is I2-1,
    Num2 is I2+1,
    getPeca(Num1,Index,Tab,NextElem),
    getPlayerSymbol(PlayerTurn,Symbol),
    (
        NextElem \= emptySpace -> storeSim(Symbol,Num2,Index);
        rmSim(Stone,I2,Index),
        storeSim(Symbol,I2,Index),
        storeSim(Stone,Num1,Index)
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


getMinList(List, Out) :-
    List = [H|Rest],
    getMinList(Rest, H, Out).
getMinList([], Min, Out) :- Out = Min.
getMinList([H|Rest], Min, Out) :-
    %%format("H: ~w   Min: ~w", [H,Min]), nl,
    Min1 is min(H, Min),
    getMinList(Rest, Min1, Out).

getMaxList(List, Out) :-
    List = [H|Rest],
    getMaxList(Rest, H, Out).
getMaxList([], Max, Out) :- Out = Max.
getMaxList([H|Rest], Max, Out) :-
    %%format("H: ~w   Max: ~w", [H,Max]), nl,
    Max1 is max(H, Max),
    getMaxList(Rest, Max1, Out).



storeSim(whiteStone,Nlinha,Ncol) :- assert(wSimCell(Nlinha,Ncol)).
storeSim(blackStone,Nlinha,Ncol) :- assert(bSimCell(Nlinha,Ncol)).

rmSim(whiteStone,Nlinha,Ncol) :- retract(wSimCell(Nlinha,Ncol)).
rmSim(blackStone,Nlinha,Ncol) :- retract(bSimCell(Nlinha,Ncol)).

startSim :- 
    copyDataBase.

endSim :-
    retractall(bSimCell(X,Y)),
    retractall(wSimCell(X,Y)).