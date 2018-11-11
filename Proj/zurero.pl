%% includes

:- include('boardPrinter.pl').
:- include('utilities.pl').
:- include('menus.pl').
:- include('gameLogic.pl').
:- use_module(library(lists)).

zurero :-
    mainMenu.


startGame :-
    initialBoard(Tab),
    gameLoop(player1,Tab).

gameLoop(PlayerTurn,Tab) :-
    display_game(Tab),
    play(PlayerTurn,PlayerType,Direction,Tab,NewTab),
    terminate(Direction,NewTab).


play(PlayerTurn,PlayerType,Direction,Tab,NewTab) :-
    
    repeat,
        write('Write your command: '),
        readPlay(Input),
        atom_chars(Input, Chars),
        Chars = [Direction|Aux],
        
        (Direction == 'q' -> true;
        interpret(Direction,Aux,Num),!,
        update(PlayerTurn,Direction,Num,Tab,NewTab)).



interpret('l',List,Num) :- interpretAux(List,Num).
interpret('r',List,Num) :- interpretAux(List,Num).
interpret('u',List,Num) :- charToIndex(List,Num).
interpret('d',List,Num) :- charToIndex(List,Num).
interpret('q',List,Num) :- true.
interpret(_,List,Num) :- write('Invalid Direction. You can only choose u(up), d(down), l(left) or r(right).'),nl,fail.



interpretAux(X,Num):-
    write('Begin'),nl,
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

terminate('q',_) :- true.
terminate(_,Tab) :- changeTurn(Player,NextPlayer),gameLoop(NextPlayer,Tab).
