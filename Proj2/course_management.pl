
:- include('board_printer.pl').

:- use_module(library(clpfd)).
:- use_module(library(lists)).

% cellContent(Value,Linha,Coluna)
:- dynamic cellContent/3.


% NOT USED - Gets the board info
get_info_board([H|Rest], Tab) :-
    length([H|Rest], Nlinhas),
    length(H, Ncols),
    format("Nlinhas: ~w   NCols: ~w ", [Nlinhas, Ncols]), nl.


% Counts the number of solids in a line
num_solids_l([],Lout,_, Lout).
num_solids_l([H|Rest], Lin, Laux, Lout) :-
    ifElse((H == 0; member(H,Lin)), append([], Lin, Laux),append([H], Lin, Laux)),
    num_solids_l(Rest, Laux, NewList, Lout).


% Counts the number of solids in memory
num_solids([], Lout, Lout).
num_solids([H|Rest], Lin, Lout) :-
    num_solids_l(H, Lin, Laux, Lout1),
    num_solids(Rest, Lout1, Lout).


% Creates an empty line for processed board
create_empty_line(0,OutLine,OutLine).
create_empty_line(Ncols, InLine, OutLine) :-
    NewNCols is Ncols-1,
    append([0], InLine, AuxLine),
    create_empty_line(NewNCols, AuxLine, OutLine).


% Creates an empty board for processed board
create_empty_board(0, _, OutTab, OutTab).
create_empty_board(Nlines, Ncols, InTab, OutTab) :-
    create_empty_line(Ncols, [],Line),
    append([Line], InTab, NewTab),
    NewNLines is Nlines-1,
    create_empty_board(NewNLines, Ncols, NewTab, OutTab).


% Gets the coords of the points of a solid
get_coords_solid(SolidN, Lin, Lout) :-
    ifElse((cellContent(SolidN, X,Y), \+ member([X,Y],Lin)),(append([[X,Y]],Lin,Laux), get_coords_solid(SolidN, Laux, Lout)),Lout = Lin).


check_up(Val,X,Y,Lin,Lout) :- 
    NewX is X-1,
    NewY is Y,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

check_d1(Val,X,Y,Lin,Lout) :- 
    NewX is X-1,
    NewY is Y+1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

check_right(Val,X,Y,Lin,Lout) :- 
    NewX is X,
    NewY is Y+1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

check_d2(Val,X,Y,Lin,Lout) :- 
    NewX is X+1,
    NewY is Y+1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

check_down(Val,X,Y,Lin,Lout) :- 
    NewX is X+1,
    NewY is Y,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

check_d3(Val,X,Y,Lin,Lout) :- 
    NewX is X+1,
    NewY is Y-1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

check_left(Val,X,Y,Lin,Lout) :- 
    NewX is X,
    NewY is Y-1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

check_d4(Val,X,Y,Lin,Lout) :- 
    NewX is X-1,
    NewY is Y-1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).



% Checks all directions
check_all_directions(Val,X,Y,Lin,OutList) :-
    check_up(Val,X,Y,Lin,Aux1),
    check_d1(Val,X,Y,Aux1,Aux2),
    check_right(Val,X,Y,Aux2,Aux3),
    check_d2(Val,X,Y,Aux3,Aux4),
    check_down(Val,X,Y,Aux4,Aux5),
    check_d3(Val,X,Y,Aux5,Aux6),
    check_left(Val,X,Y,Aux6,Aux7),
    check_d4(Val,X,Y,Aux7,OutList).


% Iterates through all cells in a solid
iterate_solid([], Val, VarsList, VarsList).
iterate_solid([Point|Rest], Val, Lin, VarsList) :- 
    Point = [X|Aux],
    Aux = [Y|_],
    %format("X: ~w   Y: ~w  ", [X,Y]), nl,
    check_all_directions(Val,X,Y,Lin,OutList),

    %format("Near Solids: ~w ", [OutList]), nl,

    iterate_solid(Rest, Val, OutList, VarsList).


% Sets the board to 1 where its needed
setBoardVars([], _, OutTab, OutTab).
setBoardVars([H|Rest], CurrLine, InTab, OutTab) :-
    setPeca(H,CurrLine,1,InTab,AuxTab),
    setBoardVars(Rest, CurrLine, AuxTab, OutTab).


% Fills the board with relations
fill_board([], _, Tab, Tab).
fill_board([H|Rest], Nvars, InTab, OutTab) :- 
    
    get_coords_solid(H,[],Coords), /*TODO - Changes 1 to H*/ 

    %nl, format("Lout: ~w ", [Coords]), nl,

    iterate_solid(Coords, H, [], VarsList), /*TODO - Changes 1 to H*/ 

    format("~w - Near Vars: ~w  ", [H,VarsList]), nl,

    setBoardVars(VarsList, H, InTab, AuxTab),

    fill_board(Rest, Nvars, AuxTab, OutTab).


% Processa o board para devolver no input necessário para o solver
process_board(OriginalTab, Tab) :-
    
    save_board(OriginalTab,1),
    
    %print_mem,

    num_solids(OriginalTab, [], VarsList),
    length(VarsList, Nvars),

    format("VarsList: ~w   Nvars: ~w", [VarsList, Nvars]),nl,
    
    create_empty_board(Nvars, Nvars, [], EmptyTab),

    format("EmptyTab: ~w ", [EmptyTab]), nl,

    fill_board(VarsList, Nvars, EmptyTab, Tab).


% Versao do solver em que o user escolhe um board pelo nome
cm(Vars, TabName) :- 

    fetch_board(TabName,OriginalTab),

    nl, format("Initial Board: ",[]), nl,
    print_board(OriginalTab),

    process_board(OriginalTab, Tab),

    nl, format("Process Board: ",[]), nl,
    print_board(Tab),
 

    length(Tab,Nvars),
    length(Vars,Nvars),

    domain(Vars,0,1),
    
    check_board(Vars,Vars,Tab,Nvars),

    sum(Vars,#=,Sum),
    labeling([maximize(Sum)], Vars).
       

check_board(_,[],[],_).
check_board(Vars,[Hvars|Rvars],[Htab|Rtab],Nvars) :- 
    length(Lsum,Nvars),
    check_line(Hvars,Vars,Htab,Lsum), sum(Lsum,#=,0),
    check_board(Vars,Rvars,Rtab,Nvars).


check_line(_,[],[],[]).
check_line(Var,[Hvar|Rvar],[Hline|Rline],[Hout|Rout]) :-
    (Var * Hvar * Hline) #= Hout,
    check_line(Var,Rvar,Rline,Rout).

% Fim do solver



/*
num_solids(OutList) :-
    cellContent(Val,X,Y),
    NewList = VarList,
    ifElse(member(Val,VarList), true,(format("Val: ~w", [Val]),nl, append([Val],NewList, VarList))),
    format("Varlist: ~w   ", [VarList]),
    fail; true.
*/

/*
            %1, 2, 3, 4, 5, 6, 7 
    Tab =  [[0, 1, 0, 1, 0, 0 ,0],
            [1, 0, 1, 0, 0, 1 ,0],
            [0, 1, 0, 0, 0, 1 ,0],
            [1, 0, 0, 0, 1, 1 ,0],
            [0, 0, 0, 1, 0, 1 ,0],
            [0, 1, 1, 1, 1, 0 ,1],
            [0, 0, 0, 0, 0, 1 ,0]].
*/

