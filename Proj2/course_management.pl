
:- include('board_printer.pl').
:- include('piece_templates.pl').

:- use_module(library(clpfd)).
:- use_module(library(lists)).
:- use_module(library(random)).

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


%Checks the solid index above the current cell
check_up(Val,X,Y,Lin,Lout) :- 
    NewX is X-1,
    NewY is Y,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

%Checks the solid index above and to the right of the current cell
check_d1(Val,X,Y,Lin,Lout) :- 
    NewX is X-1,
    NewY is Y+1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

%Checks the solid index to the right of the current cell
check_right(Val,X,Y,Lin,Lout) :- 
    NewX is X,
    NewY is Y+1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

%Checks the solid index below and to the right of the current cell
check_d2(Val,X,Y,Lin,Lout) :- 
    NewX is X+1,
    NewY is Y+1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

%Checks the solid index below the current cell
check_down(Val,X,Y,Lin,Lout) :- 
    NewX is X+1,
    NewY is Y,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

%Checks the solid index below and to the left of the current cell
check_d3(Val,X,Y,Lin,Lout) :- 
    NewX is X+1,
    NewY is Y-1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

%Checks the solid index to the left of the current cell
check_left(Val,X,Y,Lin,Lout) :- 
    NewX is X,
    NewY is Y-1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).

%Checks the solid index above and to the left of the current cell
check_d4(Val,X,Y,Lin,Lout) :- 
    NewX is X-1,
    NewY is Y-1,
    ifElse((cellContent(CellVal,NewX,NewY), \+ member(CellVal,Lin),CellVal \= Val, CellVal \= 0),(append([CellVal],Lin,Lout)),Lout = Lin).


% Checks all directions for the cell contents and adds to the array of indeces nearby
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

    %format("~w - Near Vars: ~w  ", [H,VarsList]), nl,

    setBoardVars(VarsList, H, InTab, AuxTab),

    fill_board(Rest, Nvars, AuxTab, OutTab).


% Extrai os indices dos solidos selecionados
extractSolidIndexes([], _, OutList, OutList).
extractSolidIndexes([H|Rest], SolidN, InList, OutList) :-
    ifElse(H #= 1, append(InList, [SolidN], AuxList), AuxList = InList),
    NewN is SolidN + 1,
    extractSolidIndexes(Rest, NewN, AuxList, OutList).


% Processa o board para devolver no input necessário para o solver
process_board(OriginalTab, Tab) :-
    
    save_board(OriginalTab,1),
    
    %print_mem,

    num_solids(OriginalTab, [], VarsList),
    length(VarsList, Nvars),

    %format("VarsList: ~w   Nvars: ~w", [VarsList, Nvars]),nl,
    
    create_empty_board(Nvars, Nvars, [], EmptyTab),

    %format("EmptyTab: ~w ", [EmptyTab]), nl,

    fill_board(VarsList, Nvars, EmptyTab, Tab).

% Processa o board dinamico para devolver no input necessário para o solver
process_board_din(Nvars, Tab) :-
    
    length(VarsList, Nvars),

    create_solids_list(VarsList, 1),
    
    %format("VarsList: ~w~n", [VarsList]),

    create_empty_board(Nvars, Nvars, [], EmptyTab),

    fill_board(VarsList, Nvars, EmptyTab, Tab).


% Creates the list of solid indexes used in process_board_din
create_solids_list([],_).
create_solids_list([H|Rest], CurrentN) :-
    H = CurrentN,
    NewN is CurrentN+1,
    create_solids_list(Rest, NewN).


% Randomly places pieces in a dynamic generated board
placePieces(_, _, _, SolidCounter, 50, NVars) :- NVars is SolidCounter-1. % End after 50 failed attempts
placePieces(IdPeca, NLinhas, NColunas, SolidCounter, ErrorCount, NVars) :-
    NewL is NLinhas + 1,
    NewC is NColunas + 1,
    random(1, NewL, Lcoord),
    random(1, NewC, Ccoord),
    random(0, 4, Orientation),
    ifElse((canPlace(IdPeca,Lcoord,Ccoord,SolidCounter,Orientation)),(NewCount = 0, NewSolidC is SolidCounter+1), (NewCount is ErrorCount+1, NewSolidC = SolidCounter)),
    
    placePieces(IdPeca,NLinhas, NColunas, NewSolidC, NewCount, NVars).



% Versao do solver em que o user escolhe um board pelo nome
cm(Vars, TabName, Sum) :- 

    retractall(cellContent(Val,X,Y)), % To erase values from previous executions

    fetch_board(TabName,OriginalTab), % Get the board in memory

    nl, format("Initial Board: ",[]), nl,
    print_board(OriginalTab),

    process_board(OriginalTab, Tab), % Converts the board to a input that the solver understands

    nl, format("Board Selected, press enter to continue to solver ",[]), nl,
    read_line(_),
 
    length(Tab,Nvars),  % Defines size of Nvars
    length(Vars,Nvars), % Defines size of the Vars list
    domain(Vars,0,1),   % Defines the domain of every element of Vars
    
    check_board(Vars,Vars,Tab,Nvars), % Solver (!)
    sum(Vars,#=,Sum), !, % Final restriction used to get the best answer

    labeling([], Vars),

    extractSolidIndexes(Vars, 1, [], IndexList), % Get the solids that are in the best answer

    nl, format("Final Board: ",[]), nl,
    draw_board_final(OriginalTab, IndexList), !.


    






% Versao do solver em que o board é gerado dinamicamente
cm(din, NLinhas, NColunas, Nsolids, IdPeca) :-
    
    retractall(cellContent(Val,X,Y)),

    create_empty_board(NLinhas, NColunas, [], EmptyTab),
    save_board(EmptyTab, 1),
    
    placePieces(IdPeca, NLinhas, NColunas, 1, 0, Nvars), % Places pieces in random positions to make a random board

    print_mem_board(1, NLinhas, NColunas),

    process_board_din(Nvars, Tab), % Converts the board to a input that the solver understands

    nl, format("Dynamic Board Generated, please enter the number of solids wanted in the solution ",[]), nl,
    read(Sum),
 
    format("Sum ~w~n", [Sum]),
    format("Nvars ~w~n", [Nvars]),
    length(Vars,Nvars), % Defines size of the Vars list
    domain(Vars,0,1),   % Defines the domain of every element of Vars
    
    check_board(Vars,Vars,Tab,Nvars), % Solver (!)
    sum(Vars,#=,Sum), !, % Final restriction used to get the best answer
    labeling([], Vars),

    extractSolidIndexes(Vars, 1, [], IndexList), % Get the solids that are in the best answer

    format("Vars: ~w~n", [Vars]),
    format("Indexlist: ~w~n", [IndexList]),

    nl, format("Final Board: ",[]), nl,
    draw_mem_final(1, NLinhas, NColunas, IndexList), !.
    
       
% Solver for the board
check_board(_,[],[],_).
check_board(Vars,[Hvars|Rvars],[Htab|Rtab],Nvars) :- 
    length(Lsum,Nvars),
    check_line(Hvars,Vars,Htab,Lsum), sum(Lsum,#=,0),
    check_board(Vars,Rvars,Rtab,Nvars).

% Solver for a line
check_line(_,[],[],[]).
check_line(Var,[Hvar|Rvar],[Hline|Rline],[Hout|Rout]) :-
    (Var * Hvar * Hline) #= Hout,
    check_line(Var,Rvar,Rline,Rout).



