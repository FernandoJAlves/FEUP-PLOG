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
    gameLoop(Tab).

gameLoop(Tab) :-
    display_game(Tab),
    play(Direction,Num,Tab,NewTab),
    terminate(Direction,NewTab).

play(Direction,Num,Tab,NewTab) :-
    
    repeat,
        write('Write your command: '),
        readPlay(Input),
        atom_chars(Input, Chars),
        Chars = [Direction|Aux],
        
        (Direction == 'q' -> true;
        checkCommand(Direction,Aux),
        interpret(Aux,Num),!,
        update(Direction,Num,Tab,NewTab)).


interpret(X,Num):-
    number_chars(N,X),
    Num is N.


update('l',Coord,Tab,NewTab):- playLeft(Coord,Tab,NewTab).
update('r',Coord,Tab,NewTab):- playRight(Coord,Tab,NewTab).



charToIndex(Char,Index) :-
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
        Char == 'S' -> Index is 19
        ).

checkCommand(D,A) :-
    length(A,L),
    (
        L < 1 -> write('You have to select one position'),nl,fail;
        D \= 'u',D \= 'l',D \= 'r',D \= 'd',D \= 'q' -> write('Invalid Direction'),nl,fail;
        true
        ).

terminate('q',_) :- true.
terminate(_,Tab) :- gameLoop(Tab).
