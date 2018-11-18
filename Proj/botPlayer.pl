:- dynamic botInt/1.


setBotInt(Num):- assert(botInt(Num)).
deactivateBot :- retractall(botInt(Num)).


choose_move(Tab, 1, MoveDir, MoveIndex) :-
    currentPieces(Tab,Pieces),
    random(0,4,Aux),
    choose_move_dir(Pieces, Aux, Out1, Out2),
    MoveDir = Out1,
    MoveIndex = Out2.


choose_move(Tab, 2, MoveDir, MoveIndex) :-

    PlayerTurn = player2,

    simAllMoves(PlayerTurn,Tab,Moves),

    %%fazer cada jogada e avaliar o tabuleiro

    MoveDir = Out1,
    MoveIndex = Out2.



simAllMoves(PlayerTurn,Tab,Moves) :- 
    currentPieces(Tab,Pieces),
    getYcoords(Pieces, Aux1, OutList1),
    getMinList(OutList1, MinY),
    getMaxList(OutList1, MaxY),

    getXcoords(Pieces, Aux2, OutList2),
    getMinList(OutList2, MinX),
    getMaxList(OutList2, MaxX),

    % Ver aqui
    NewMaxY is MaxY+1,
    NewMaxX is MaxX+1,

    simMovesUp(PlayerTurn,MinY,NewMaxY,Lin,Lout,Tab),

    format("Lout: ~w" ,[Lout]).

simMovesUp(PlayerTurn,MaxY, MaxY, Lin, Lout,Tab) :- Lout = Lin.
simMovesUp(PlayerTurn,MinY, MaxY, Lin, Lout,Tab) :- 
    startSim,
    updateSim(PlayerTurn,'u',MinY,Tab),
    value(_,PlayerTurn,Value),
    append(Lin, [[Value, 'u', MinY]], Aux),
    NewMin is MinY+1,
    format("Value: ~w", [Value]),nl,
    endSim,
    simMovesUp(PlayerTurn,NewMin, MaxY, Aux, Lout,Tab).
    

updateSim(PlayerTurn,'l',MoveIndex,Tab) :- playLeftSim(PlayerTurn,Coord,Tab).
updateSim(PlayerTurn,'r',MoveIndex,Tab) :- playRightSim(PlayerTurn,Coord,Tab).
updateSim(PlayerTurn,'u',MoveIndex,Tab) :- playUpSim(PlayerTurn,Coord,Tab).
updateSim(PlayerTurn,'d',MoveIndex,Tab) :- playDownSim(PlayerTurn,Coord,Tab).






value(Board, player1, Value) :- 
    b_piecesSim(Lb),
    valueBlack(Lb,0,OutVal1),
    w_piecesSim(Lw),
    valueWhite(Lw,0,OutVal2),
    Value is OutVal2 - OutVal1.
    
value(Board, player2, Value) :-
    b_piecesSim(Lb),
    valueBlack(Lb,0,OutVal1),
    w_piecesSim(Lw),
    valueWhite(Lw,0,OutVal2),
    Value is OutVal1 - OutVal2.


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



valueBlack([],AuxSum,OutVal) :- OutVal = AuxSum.
valueBlack([H|Rest],AuxSum,OutVal) :-
    H = [X|Aux],
    Aux = [Y|_],
    avaliate_b(X,Y,AuxSum,Out1),
    valueBlack(Rest,Out1,OutVal).

valueWhite([],AuxSum,OutVal) :- OutVal = AuxSum.
valueWhite([H|Rest],AuxSum,OutVal) :-
    H = [X|Aux],
    Aux = [Y|_],
    avaliate_w(X,Y,AuxSum,Out1),
    valueWhite(Rest,Out1,OutVal).

avaliate_b(X,Y,Aux1,OutVal) :-
    b_piecesSim(Lb),
    w_piecesSim(Lw),

    avaliate_hor_b(X,Y,Lw,Lb,Aux1,Aux2),
    avaliate_vert_b(X,Y,Lw,Lb,Aux2,Aux3),
    avaliate_dia1_b(X,Y,Lw,Lb,Aux3,Aux4),
    avaliate_dia2_b(X,Y,Lw,Lb,Aux4,Aux5),
    avaliate_hor_rev_b(X,Y,Lw,Lb,Aux5,Aux6),
    avaliate_vert_rev_b(X,Y,Lw,Lb,Aux6,Aux7),
    avaliate_dia1_rev_b(X,Y,Lw,Lb,Aux7,Aux8),
    avaliate_dia2_rev_b(X,Y,Lw,Lb,Aux8,Aux9),
    OutVal is Aux9.

avaliate_w(X,Y,Aux1,OutVal) :-
    b_piecesSim(Lb),
    w_piecesSim(Lw),
    avaliate_hor_w(X,Y,Lw,Lb,Aux1,Aux2),
    avaliate_vert_w(X,Y,Lw,Lb,Aux2,Aux3),
    avaliate_dia1_w(X,Y,Lw,Lb,Aux3,Aux4),
    avaliate_dia2_w(X,Y,Lw,Lb,Aux4,Aux5),
    avaliate_hor_rev_w(X,Y,Lw,Lb,Aux5,Aux6),
    avaliate_vert_rev_w(X,Y,Lw,Lb,Aux6,Aux7),
    avaliate_dia1_rev_w(X,Y,Lw,Lb,Aux7,Aux8),
    avaliate_dia2_rev_w(X,Y,Lw,Lb,Aux8,Aux9),
    OutVal is Aux9.



countHor(Xmax,Y,L,OldN,NewN,Xmax) :- NewN = OldN.
countHor(X,Y,L,OldN,NewN,Xmax) :-
    ifElse(member([X,Y], L),Aux is OldN+1,Aux is OldN),
    NewX is X+1,
    countHor(NewX,Y,L,Aux,NewN,Xmax).

countVert(X,Ymax,L,OldN,NewN,Ymax) :- NewN = OldN.
countVert(X,Y,L,OldN,NewN,Ymax) :-
    ifElse(member([X,Y], L),Aux is OldN+1,Aux is OldN),
    NewY is Y+1,
    countVert(X,NewY,L,Aux,NewN,Ymax).

countDia1(Nmax,_,L,OldN,NewN,Nmax) :- NewN = OldN.
countDia1(X,Y,L,OldN,NewN,Nmax) :-
    ifElse(member([X,Y], L),Aux is OldN+1,Aux is OldN),
    NewX is X+1,
    NewY is Y+1,
    countDia1(NewX,NewY,L,Aux,NewN,Nmax).

countDia2(Nmax,_,L,OldN,NewN,Nmax) :- NewN = OldN.
countDia2(X,Y,L,OldN,NewN,Nmax) :-
    ifElse(member([X,Y], L),Aux is OldN+1,Aux is OldN),
    NewX is X+1,
    NewY is Y-1,
    countDia2(NewX,NewY,L,Aux,NewN,Nmax).


avaliate_hor_b(X,Y,Lw,Lb,Aux1,Aux2) :-
    Xmax is X+5,
    OldNb is 0,
    OldNw is 0,
    countHor(X,Y,Lw,OldNw,NewNw,Xmax),
    countHor(X,Y,Lb,OldNb,NewNb,Xmax),
    scoreLine(NewNb,NewNw,Aval),
    Aux2 is Aux1 + Aval.

avaliate_hor_rev_b(X,Y,Lw,Lb,Aux1,Aux2) :-
    Xmin is X-4,
    Xmax is X+1,
    OldNb is 0,
    OldNw is 0,
    countHor(Xmin,Y,Lw,OldNw,NewNw,Xmax),
    countHor(Xmin,Y,Lb,OldNb,NewNb,Xmax),
    scoreLine(NewNb,NewNw,Aval),
    Aux2 is Aux1 + Aval.    
    

avaliate_hor_w(X,Y,Lw,Lb,Aux1,Aux2) :-
    Xmax is X+5,
    OldNb is 0,
    OldNw is 0,
    countHor(X,Y,Lw,OldNw,NewNw,Xmax),
    countHor(X,Y,Lb,OldNb,NewNb,Xmax),
    scoreLine(NewNw,NewNb,Aval),
    Aux2 is Aux1 + Aval.

avaliate_hor_rev_w(X,Y,Lw,Lb,Aux1,Aux2) :-
    Xmin is X-4,
    Xmax is X+1,
    OldNb is 0,
    OldNw is 0,
    countHor(Xmin,Y,Lw,OldNw,NewNw,Xmax),
    countHor(Xmin,Y,Lb,OldNb,NewNb,Xmax),
    scoreLine(NewNw,NewNb,Aval),
    Aux2 is Aux1 + Aval.        

avaliate_vert_b(X,Y,Lw,Lb,Aux1,Aux2) :-
    Ymax is Y+5,
    OldNb is 0,
    OldNw is 0,
    countVert(X,Y,Lw,OldNw,NewNw,Ymax),
    countVert(X,Y,Lb,OldNb,NewNb,Ymax),
    scoreLine(NewNb,NewNw,Aval),
    Aux2 is Aux1 + Aval.

avaliate_vert_rev_b(X,Y,Lw,Lb,Aux1,Aux2) :-
    Ymax is Y+1,
    Ymin is Y-4,
    OldNb is 0,
    OldNw is 0,
    countVert(X,Ymin,Lw,OldNw,NewNw,Ymax),
    countVert(X,Ymin,Lb,OldNb,NewNb,Ymax),
    scoreLine(NewNb,NewNw,Aval),
    Aux2 is Aux1 + Aval.    

avaliate_vert_w(X,Y,Lw,Lb,Aux1,Aux2) :-
    Ymax is Y+5,
    OldNb is 0,
    OldNw is 0,
    countVert(X,Y,Lw,OldNw,NewNw,Ymax),
    countVert(X,Y,Lb,OldNb,NewNb,Ymax),
    scoreLine(NewNw,NewNb,Aval),
    Aux2 is Aux1 + Aval.

avaliate_vert_rev_w(X,Y,Lw,Lb,Aux1,Aux2) :-
    Ymax is Y+1,
    Ymin is Y-4,
    OldNb is 0,
    OldNw is 0,
    countVert(X,Ymin,Lw,OldNw,NewNw,Ymax),
    countVert(X,Ymin,Lb,OldNb,NewNb,Ymax),
    scoreLine(NewNw,NewNb,Aval),
    Aux2 is Aux1 + Aval.    

avaliate_dia1_b(X,Y,Lw,Lb,Aux1,Aux2) :-
    Nmax is X+5,
    OldNb is 0,
    OldNw is 0,
    countDia1(X,Y,Lw,OldNw,NewNw,Nmax),
    countDia1(X,Y,Lb,OldNb,NewNb,Nmax),
    scoreLine(NewNb,NewNw,Aval),
    Aux2 is Aux1 + Aval.

avaliate_dia1_rev_b(X,Y,Lw,Lb,Aux1,Aux2) :-
    Nmax is X+1,
    Xmin is X-4,
    Ymin is Y-4,
    OldNb is 0,
    OldNw is 0,
    countDia1(Xmin,Ymin,Lw,OldNw,NewNw,Nmax),
    countDia1(Xmin,Ymin,Lb,OldNb,NewNb,Nmax),
    scoreLine(NewNb,NewNw,Aval),
    Aux2 is Aux1 + Aval.    

avaliate_dia1_w(X,Y,Lw,Lb,Aux1,Aux2) :-
    Nmax is X+5,
    OldNb is 0,
    OldNw is 0,
    countDia1(X,Y,Lw,OldNw,NewNw,Nmax),
    countDia1(X,Y,Lb,OldNb,NewNb,Nmax),
    scoreLine(NewNw,NewNb,Aval),
    Aux2 is Aux1 + Aval.

avaliate_dia1_rev_w(X,Y,Lw,Lb,Aux1,Aux2) :-
    Nmax is X+1,
    Xmin is X-4,
    Ymin is Y-4,
    OldNb is 0,
    OldNw is 0,
    countDia1(Xmin,Ymin,Lw,OldNw,NewNw,Nmax),
    countDia1(Xmin,Ymin,Lb,OldNb,NewNb,Nmax),
    scoreLine(NewNw,NewNb,Aval),
    Aux2 is Aux1 + Aval.    


avaliate_dia2_b(X,Y,Lw,Lb,Aux1,Aux2) :-
    Nmax is X+5,
    OldNb is 0,
    OldNw is 0,
    countDia2(X,Y,Lw,OldNw,NewNw,Nmax),
    countDia2(X,Y,Lb,OldNb,NewNb,Nmax),
    scoreLine(NewNb,NewNw,Aval),
    Aux2 is Aux1 + Aval.

avaliate_dia2_rev_b(X,Y,Lw,Lb,Aux1,Aux2) :-
    Nmax is X+1,
    Xmin is X-4,
    Ymin is Y+4,
    OldNb is 0,
    OldNw is 0,
    countDia2(Xmin,Ymin,Lw,OldNw,NewNw,Nmax),
    countDia2(Xmin,Ymin,Lb,OldNb,NewNb,Nmax),
    scoreLine(NewNb,NewNw,Aval),
    Aux2 is Aux1 + Aval.

avaliate_dia2_w(X,Y,Lw,Lb,Aux1,Aux2) :-
    Nmax is X+5,
    OldNb is 0,
    OldNw is 0,
    countDia2(X,Y,Lw,OldNw,NewNw,Nmax),
    countDia2(X,Y,Lb,OldNb,NewNb,Nmax),
    scoreLine(NewNw,NewNb,Aval),
    Aux2 is Aux1 + Aval.

avaliate_dia2_rev_w(X,Y,Lw,Lb,Aux1,Aux2) :-
    Nmax is X+1,
    Xmin is X-4,
    Ymin is Y+4,
    OldNb is 0,
    OldNw is 0,
    countDia2(Xmin,Ymin,Lw,OldNw,NewNw,Nmax),
    countDia2(Xmin,Ymin,Lb,OldNb,NewNb,Nmax),
    scoreLine(NewNw,NewNb,Aval),
    Aux2 is Aux1 + Aval.