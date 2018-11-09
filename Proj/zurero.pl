%% includes

:- include('boardGame.pl').
:- include('utilities.pl').


zurero :-
    initialBoard(Tab),
    repeat, 
        display_game(Tab),
        play(Direction,Num),
        terminate(Direction).

play(Direction,Num) :-
    
    repeat,
        write('Write your command: '),
        read(Input),
        get_code(Trash),
        atom_chars(Input, Chars),
        Chars = [Direction|Aux],
        
        (Direction == 'q' -> true;
        checkCommand(Direction,Aux),
        interpret(Aux,Num),
        write('Direction: '),
        write(Direction),
        nl,
        write('Number: '),
        write(Num),
        nl),
        !.


interpret(X,Num):-
    number_chars(N,X),
    Num is N.



getChar(Input):-
	get_char(Input),
	get_char(_).


checkCommand(D,A) :-
    length(A,L),
    (
        L < 1 -> write('You have to select one position'),nl,fail;
        D \= 'u',D \= 'l',D \= 'r',D \= 'd',D \= 'q' -> write('Invalid Direction'),nl,fail;
        true
        ).

terminate('q') :- true;fail,!.
