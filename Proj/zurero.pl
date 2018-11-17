%% includes

:- include('boardPrinter.pl').
:- include('utilities.pl').
:- include('menus.pl').
:- include('gameLogic.pl').
:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(random)).
:- use_module(library(system)).

player(player1).
player(player2).

zurero :-
    setrandomness,
    mainMenu.


startGame(GameMode) :-
    initialBoard(Tab),
    retractall(blackCell(X,Y)),
    retractall(whiteCell(X,Y)),
    storeCell(blackStone,10,10),
    gameLoop(GameMode,player1,Tab).

gameLoop(pvp,PlayerTurn,Tab) :-
    display_game(Tab),
    playHuman(PlayerTurn,Direction,Tab,NewTab),
    terminate(pvp,Direction,PlayerTurn,NewTab).

gameLoop(pvb,player1,Tab) :-
    %%format("Player 1", []), nl,
    display_game(Tab),
    playHuman(player1,Direction,Tab,NewTab),
    terminate(pvb,Direction,player1,NewTab).

gameLoop(pvb,player2,Tab) :-
    %%format("Player 2", []), nl,
    display_game(Tab),
    playBot(player2,1,Direction,Tab,NewTab),
    %%format("Before terminate 2, ~w", [Direction]), nl,
    Direction = 'p', %%Valor aleatorio para ficar instanciado,
    terminate(pvb,Direction,player2,NewTab).
    %%format("After terminate 2, ~w", [Direction]), nl.


gameLoop(bvb,PlayerTurn,Tab) :-
    display_game(Tab),
    playBot(PlayerTurn,1,Direction,Tab,NewTab),
    Direction = 'p', %%Valor aleatorio para ficar instanciado,
    terminate(bvb,Direction,PlayerTurn,NewTab).


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
    Direction == 'q' -> true, !;
    choose_move(Tab,1, MoveDir, MoveIndex),
    format("Simulated Move: ~w~w", [MoveDir, MoveIndex]), nl,
    update(PlayerTurn,MoveDir,MoveIndex,Tab,NewTab).
    %%format("After update", []), nl.
    %%display_game(NewTab).


playBot(PlayerTurn,2,Direction,Tab,NewTab):-
    Direction == 'q' -> true, !;

    choose_move(Tab,2, MoveDir, MoveIndex),
    format("Simulated Move: ~w~w", [MoveDir, MoveIndex]), nl,
    update(PlayerTurn,MoveDir,MoveIndex,Tab,NewTab).



choose_move(Tab, 1, MoveDir, MoveIndex) :-
    currentPieces(Tab,Pieces),
    random(0,4,Aux),
    %%nl, nl, format("Dir: ~w    Pieces: ~w", [Aux, Pieces]), nl,
    choose_move_dir(Pieces, Aux, Out1, Out2),
    MoveDir = Out1,
    MoveIndex = Out2.

choose_move(Tab, 2, MoveDir, MoveIndex) :-

    simAllMoves,

    %%fazer cada jogada e avaliar o tabuleiro

    MoveDir = Out1,
    MoveIndex = Out2.


simAllMoves(PlayerTurn,Tab) :- 
    currentPieces(Tab,Pieces),
    getYcoords(Pieces, Aux, OutList1),
    getMinList(OutList1, MinY),
    getMaxList(OutList1, MaxY),

    getXcoords(Pieces, Aux, OutList2),
    getMinList(OutList2, MinX),
    getMaxList(OutList2, MaxX),

    simMovesUp(PlayerTurn,MinY,MaxY,Lin,Lout,Tab),
    

    true. 

simMovesUp(PlayerTurn,MaxY, MaxY, Lin, Lout,Tab) :- true.
simMovesUp(PlayerTurn,MinY, MaxY, Lin, Lout,Tab) :- 
    startSim,
    updateSim(PlayerTurn,'u',MinY,Tab),
    value(_,PlayerTurn,Value),
    append(Lin, [Value, 'u', MinY], Lout),
    endSim.

value(Board, player1, Value) :- 
    b_piecesSim(Lb),
    valueBlack(Lb,OutValB),
    % White - black points
    true.
    
value(Board, player2, Value) :-
    Value = 10,
    % Black - white points
    true.


getBestMoves([], _, Aux, OutList, SizeAux, SizeOut) :- OutList = Aux, SizeOut = SizeAux.
getBestMoves(List, CurrMax, Aux, OutList, SizeAux, SizeOut) :- fail.
    % OutList format will be [MoveDir, MoveIndex]
    % Usar o if else das aulas
    % if List.head.head > CurrMax, clear Aux, SizeAux = 0, append [MoveDir, MoveIndex], getBestMoves(Tail, List.head, NewAux, OutList)
    % else if List.head.head == CurrMax (permitir multiplas jogadas, depois escolhe 1 random dessas), append [MoveDir, MoveIndex], SizeAux++ ,getBestMoves(Tail, CurrMax, NewAux, OutList)
    % else getBestMoves(Tail, CurrMax, NewAux, OutList)
    
selAMove(BestMoves,SizeList,MoveDir,MoveIndex) :-
    random(0, SizeList, Index),
    iterateList(Index, BestMoves, Out1, Out2),
    MoveDir = Out1,
    MoveIndex = Out2.

iterateList(0, [H|Rest], MoveDir, MoveIndex) :-
    H = [MoveDir|Aux],
    Aux = [MoveIndex|_].
iterateList(Index, [H|Rest], MoveDir, MoveIndex) :-
    NewIndex is Index-1,
    iterateList(NewIndex, Rest, MoveDir, MoveIndex).



%%move cima    
choose_move_dir(Moves, 0, Out1, Out2) :- 
    range_hor(Moves, Xval),
    Out1 = 'u',
    Out2 = Xval.
%%move baixo   
choose_move_dir(Moves, 1, Out1, Out2) :- 
    range_hor(Moves, Xval),
    Out1 = 'd',
    Out2 = Xval.
%%move esquerda    
choose_move_dir(Moves, 2, Out1, Out2) :- 
    range_vert(Moves, Yval),
    Out1 = 'l',
    Out2 is 20 - Yval.
%%move direita    
choose_move_dir(Moves, 3, Out1, Out2) :- 
    range_vert(Moves, Yval),
    Out1 = 'r',
    Out2 is 20 - Yval.    




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
    getYcoords(Pieces, Aux, OutList),
    %%format("OutList Hor1: ~w", [OutList]), nl,
    getMinList(OutList, Min),
    %%format("OutList Hor1: ~w", [OutList]), nl,
    getMaxList(OutList, Max),
    NewMax is Max + 1,
    random(Min, NewMax, Out).
    
range_vert(Pieces, Out) :- 
    getXcoords(Pieces, Aux, OutList),
    %%format("OutList Vert1: ~w", [OutList]), nl,
    getMinList(OutList, Min),
    %%format("OutList Vert2: ~w", [OutList]), nl,
    getMaxList(OutList, Max),
    %%format("Min: ~w   Max: ~w", [Min, Max]), nl,
    NewMax is Max + 1,
    %%format("Min: ~w   NewMax: ~w", [Min, NewMax]), nl,
    random(Min, NewMax, Out).
    %%format("Saiu com Out: ~w", [Out]), nl.



currentPieces(Tab,Moves) :-
    b_pieces(Lb),
    w_pieces(Lw),
    append(Lb,Lw,Moves),
    format("Cells: ~w" , [Moves]), nl.
    

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


updateSim(PlayerTurn,'l',MoveIndex,Tab) :- playLeftSim(PlayerTurn,Coord,Tab).
updateSim(PlayerTurn,'r',MoveIndex,Tab) :- playRightSim(PlayerTurn,Coord,Tab).
updateSim(PlayerTurn,'u',MoveIndex,Tab) :- playUpSim(PlayerTurn,Coord,Tab).
updateSim(PlayerTurn,'d',MoveIndex,Tab) :- playDownSim(PlayerTurn,Coord,Tab).


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



terminate(GameMode,'q',Player,_) :- true.
terminate(GameMode,_,Player,Tab) :- game_over(Tab,Winner), continueGame(Winner, GameMode,Player, Tab).

validate_hor_b(X,Y,L) :-
Xmax is X+4,
between(X,Xmax,N),
\+member([N,Y], L), !, fail; true.

validate_vert_b(X,Y,L) :-
Ymax is Y+4,
between(Y,Ymax,N),
\+member([X,N], L), !, fail; true.

validate_dia1_b(X,Y,L) :-
between(0,4,N),
Xnew is X + N,
Ynew is Y + N,
\+member([Xnew,Ynew], L), !, fail; true.

validate_dia2_b(X,Y,L) :-
between(0,4,N),
Xnew is X + N,
Ynew is Y - N,
\+member([Xnew,Ynew], L), !, fail; true.


validate_hor_w(X,Y,L) :-
Xmax is X+4,
between(X,Xmax,N),
\+member([N,Y], L), !, fail; true.

validate_vert_w(X,Y,L) :-
Ymax is Y+4,
between(Y,Ymax,N),
\+member([X,N], L), !, fail; true.

validate_dia1_w(X,Y,L) :-
between(0,4,N),
Xnew is X + N,
Ynew is Y + N,
\+member([Xnew,Ynew], L), !, fail; true.

validate_dia2_w(X,Y,L) :-
between(0,4,N),
Xnew is X + N,
Ynew is Y - N,
\+member([Xnew,Ynew], L), !, fail; true.



validate_b(X,Y) :-
b_pieces(L),
validate_hor_b(X,Y,L), !;
b_pieces(L),
validate_vert_b(X,Y,L), !;
b_pieces(L),
validate_dia1_b(X,Y,L), !;
b_pieces(L),
validate_dia2_b(X,Y,L).

validate_w(X,Y) :- 
w_pieces(L),    
validate_hor_w(X,Y,L), !;
w_pieces(L), 
validate_vert_w(X,Y,L), !;
w_pieces(L), 
validate_dia1_w(X,Y,L), !;
w_pieces(L), 
validate_dia2_w(X,Y,L).

avaliate_b(X,Y) :-
    avaliate_hor_b(X,Y,Lw), !;
    avaliate_vert_b(X,Y,Lw), !;
    avaliate_dia1_b(X,Y,Lw), !;
    avaliate_dia2_b(X,Y,Lw).




game_over(Tab,Winner) :-

b_pieces(Lb),
w_pieces(Lw),

%%write(Lb), nl,

(checkBlack(Lb) -> Winner = player2; 
checkWhite(Lw) -> Winner = player1;
Winner = none).
%%write(Winner), nl.


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

valueBlack([],OutVal,OutVal).
valueBlack([H|Rest],AuxSum,OutVal) :-
    H = [X|Aux],
    Aux = [Y|_],
    avaliate_b(X,Y,AuxSum,Out1), !;
    valueBlack(Rest,Out1,OutVal).

valueWhite([],OutVal,OutVal).
valueWhite([H|Rest],AuxSum,OutVal) :-
    H = [X|Aux],
    Aux = [Y|_],
    avaliate_w(X,Y,AuxSum,Out1), !;
    valueWhite(Rest,Out1,OutVal).


continueGame(none, GameMode,Player, Tab) :-
    %%format("In continueGame", []), nl,
    changeTurn(Player,NextPlayer),
    %%format("Player: ~w    Gamemode: ~w", [NextPlayer, GameMode]), nl,
    gameLoop(GameMode,NextPlayer,Tab).

continueGame(player1, GameMode,Player, Tab) :-
    display_game(Tab),
    format("Congratulations Player 1, you win!", []), nl,
    pressEnterToContinue.

continueGame(player2, GameMode,Player, Tab) :-
    display_game(Tab),
    format("Congratulations Player 2, you win!", []), nl,
    pressEnterToContinue.