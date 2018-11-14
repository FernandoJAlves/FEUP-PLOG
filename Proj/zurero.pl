%% includes

:- include('boardPrinter.pl').
:- include('utilities.pl').
:- include('menus.pl').
:- include('gameLogic.pl').
:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(random)).

player(player1).
player(player2).

zurero :-
    mainMenu.


startGame :-
    initialBoard(Tab),
    storeCell(blackStone,10,10),
    gameLoop(player1,Tab).

gameLoop(PlayerTurn,Tab) :-
    display_game(Tab),
    playHuman(PlayerTurn,Direction,Tab,NewTab),
    terminate(Direction,PlayerTurn,NewTab).


playHuman(PlayerTurn,Direction,Tab,NewTab) :-
    
    repeat,
        playerMessage(PlayerTurn),nl,
        write('Write your command: '),
        readPlay(Input),
        atom_chars(Input, Chars),
        Chars = [Direction|Aux],
        
        (Direction == 'q' -> true;
        interpret(Direction,Aux,Num),!,
        update(PlayerTurn,Direction,Num,Tab,NewTab)).

playBot(PlayerTurn,1,Direction,Tab,NewTab):-
    possibleMoves(Tab,Moves),
    choose_move(Moves,1,Move).
    %%execute


choose_move(Moves, 1, Move) :-
    random(0,3,Aux),
    choose_move_dir(Moves, Aux, Out),
    Move = Out.

    
%%move cima    
choose_move_dir(Moves, 0, Move) :- 
    range_hor(Moves, Xval),
    format("~w ~w", [Xval, Yval]).


getXcoords([], Xvalues, FinalList) :- FinalList = Xvalues.
getXcoords([H|Rest], Xvalues, FinalList) :-
    H = [X|Aux],
    Aux = [Y|_],
    append(Xvalues, [X], NewList),
    getXcoords(Rest, NewList, FinalList).

getYcoords([], Yvalues, FinalList) :- FinalList = Yvalues.
getYcoords([H|Rest], Yvalues, FinalList) :-
    H = [X|Aux],
    Aux = [Y|_],
    append(Yvalues, [Y], NewList),
    getYcoords(Rest, NewList, FinalList).



range_hor(Pieces, Out) :- 
    getXcoords(Pieces, Aux, OutList),
    getMinList(OutList, Min),
    getMaxList(OutList, Max),
    random(Min, Max, Out).
    
range_vert(Pieces, Out) :- 
    getYcoords(Pieces, Aux, OutList),
    getMinList(OutList, Min),
    getMaxList(OutList, Max),
    random(Min, Max, Out).


possibleMoves(Tab,Moves) :-
    b_pieces(Lb),
    w_pieces(Lw),
    append(Lb,Lw,Moves).
    

interpret('l',List,Num) :- interpretAux(List,Num).
interpret('r',List,Num) :- interpretAux(List,Num).
interpret('u',List,Num) :- charToIndex(List,Num).
interpret('d',List,Num) :- charToIndex(List,Num).
interpret('q',List,Num) :- true.
interpret(_,List,Num) :- write('Invalid Direction. You can only choose u(up), d(down), l(left) or r(right).'),nl,fail.

playerMessage(player1):- write('Player 1 Turn. You are the white stones').
playerMessage(player2):- write('Player 2 Turn. You are the black stones').


interpretAux(X,Num):-
    length(X,L),
    (
        L < 1 -> write('You have to select one position between 1 and 19'),nl,fail;
        true
    ),
    
    checkCharList(X),
    number_chars(N,X),
    Num is N,
    (
        N > 19 -> write('Invalid Input: You have to select one position between 1 and 19'),nl,fail;
        true
        ).
    


update(PlayerTurn,'l',Coord,Tab,NewTab):- playLeft(PlayerTurn,Coord,Tab,NewTab).
update(PlayerTurn,'r',Coord,Tab,NewTab):- playRight(PlayerTurn,Coord,Tab,NewTab).
update(PlayerTurn,'u',Coord,Tab,NewTab):- playUp(PlayerTurn,Coord,Tab,NewTab).
update(PlayerTurn,'d',Coord,Tab,NewTab):- playDown(PlayerTurn,Coord,Tab,NewTab).
update(PlayerTurn,'q',Coord,Tab,NewTab):- true.
update(PlayerTurn,_,Coord,Tab,NewTab):- write('Invalid Direction. You can only choose u(up), d(down), l(left) or r(right).'),nl,fail.



charToIndex([Char|_],Index) :-
    (
        Char == 'A' -> Index is 1;
        Char == 'B' -> Index is 2;
        Char == 'C' -> Index is 3;
        Char == 'D' -> Index is 4;
        Char == 'E' -> Index is 5;
        Char == 'F' -> Index is 6;
        Char == 'G' -> Index is 7;
        Char == 'H' -> Index is 8;
        Char == 'I' -> Index is 9;
        Char == 'J' -> Index is 10;
        Char == 'K' -> Index is 11;
        Char == 'L' -> Index is 12;
        Char == 'M' -> Index is 13;
        Char == 'N' -> Index is 14;
        Char == 'O' -> Index is 15;
        Char == 'P' -> Index is 16;
        Char == 'Q' -> Index is 17;
        Char == 'R' -> Index is 18;
        Char == 'S' -> Index is 19;
        write('Invalid Input: you can only choose a letter between A and S.'),nl,fail
        ).



terminate('q',Player,_) :- true.
terminate(_,Player,Tab) :- game_over(Tab,Winner), continueGame(Winner, Player, Tab).

validate_hor_b(X,Y) :-
Xmax is X+4,
between(X,Xmax,N),
b_pieces(L),
\+member([N,Y], L), !, fail; true.

validate_vert_b(X,Y) :-
Ymax is Y+4,
between(Y,Ymax,N),
b_pieces(L),
\+member([X,N], L), !, fail; true.

validate_dia1_b(X,Y) :-
between(0,4,N),
Xnew is X + N,
Ynew is Y + N,
b_pieces(L),
\+member([Xnew,Ynew], L), !, fail; true.

validate_dia2_b(X,Y) :-
between(0,4,N),
Xnew is X + N,
Ynew is Y - N,
b_pieces(L),
\+member([Xnew,Ynew], L), !, fail; true.


validate_hor_w(X,Y) :-
Xmax is X+4,
between(X,Xmax,N),
w_pieces(L),
\+member([N,Y], L), !, fail; true.

validate_vert_w(X,Y) :-
Ymax is Y+4,
between(Y,Ymax,N),
w_pieces(L),
\+member([X,N], L), !, fail; true.

validate_dia1_w(X,Y) :-
between(0,4,N),
Xnew is X + N,
Ynew is Y + N,
w_pieces(L),
\+member([Xnew,Ynew], L), !, fail; true.

validate_dia2_w(X,Y) :-
between(0,4,N),
Xnew is X + N,
Ynew is Y - N,
w_pieces(L),
\+member([Xnew,Ynew], L), !, fail; true.



validate_b(X,Y) :-
validate_hor_b(X,Y), !;
validate_vert_b(X,Y), !;
validate_dia1_b(X,Y), !;
validate_dia2_b(X,Y).

validate_w(X,Y) :- 
validate_hor_w(X,Y), !;
validate_vert_w(X,Y), !;
validate_dia1_w(X,Y), !;
validate_dia2_w(X,Y).

game_over(Tab,Winner) :-

b_pieces(Lb),
w_pieces(Lw),

%%write(Lb), nl,

(checkBlack(Lb) -> Winner = player1; 
checkWhite(Lw) -> Winner = player2;
Winner = none),
write(Winner), nl.



checkBlack([H|Rest]) :-
    H = [X|Aux],
    Aux = [Y|_],
    validate_b(X,Y), !;
    checkBlack(Rest).

checkWhite([H|Rest]) :-
    H = [X|Aux],
    Aux = [Y|_],
    validate_w(X,Y), !;
    checkWhite(Rest).

continueGame(none, Player, Tab) :-
    changeTurn(Player,NextPlayer),gameLoop(NextPlayer,Tab).

continueGame(player1, Player, Tab) :-
    format("Congratulations Player 1, you win!", []), nl,
    pressEnterToContinue.

continueGame(player2, Player, Tab) :-
    format("Congratulations Player 2, you win!", []), nl,
    pressEnterToContinue.