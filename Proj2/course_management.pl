
:- include('board_printer.pl').

:- use_module(library(clpfd)).
:- use_module(library(lists)).

% cellContent(Value,Linha,Coluna)
:- dynamic cellContent/3.


interate_board([H|Rest], Tab) :-
    length([H|Rest], Nlinhas),
    length(H, Ncols),
    format("Nlinhas: ~w   NCols: ~w ", [Nlinhas, Ncols]), nl.

num_solids_l([],Lout,_, Lout).
num_solids_l([H|Rest], Lin, Laux, Lout) :-
    ifElse((H == 0; member(H,Lin)), append([], Lin, Laux),append([H], Lin, Laux)),
    num_solids_l(Rest, Laux, NewList, Lout).

num_solids([], Lout, Lout).
num_solids([H|Rest], Lin, Lout) :-
    num_solids_l(H, Lin, Laux, Lout1),
    num_solids(Rest, Lout1, Lout).

create_empty_line(0,OutLine,OutLine).
create_empty_line(Ncols, InLine, OutLine) :-
    NewNCols is Ncols-1,
    append([0], InLine, AuxLine),
    create_empty_line(NewNCols, AuxLine, OutLine).


create_empty_board(0, _, OutTab, OutTab).
create_empty_board(Nlines, Ncols, InTab, OutTab) :-
    create_empty_line(Ncols, [],Line),
    append([Line], InTab, NewTab),
    NewNLines is Nlines-1,
    create_empty_board(NewNLines, Ncols, NewTab, OutTab).


/*
num_solids(OutList) :-
    cellContent(Val,X,Y),
    NewList = VarList,
    ifElse(member(Val,VarList), true,(format("Val: ~w", [Val]),nl, append([Val],NewList, VarList))),
    format("Varlist: ~w   ", [VarList]),
    fail; true.
*/

%Processa o board para devolver no input necessário para o solver
process_board(OriginalTab, Tab) :-
    
    save_board(OriginalTab,1),
    
    %print_mem,

    num_solids(OriginalTab, [], VarsList),
    length(VarsList, Nvars),

    format("VarsList: ~w   Nvars: ~w", [VarsList, Nvars]),nl,
    
    create_empty_board(Nvars, Nvars, [], Tab),

    %interate_board(OriginalTab, Tab),

    /*
            %1, 2, 3, 4, 5, 6, 7 
    Tab = [[0, 1, 0, 1, 0, 0 ,0],
            [1, 0, 1, 0, 0, 1 ,0],
            [0, 1, 0, 0, 0, 1 ,0],
            [1, 0, 0, 0, 1, 1 ,0],
            [0, 0, 0, 1, 0, 1 ,0],
            [0, 1, 1, 1, 1, 0 ,1],
            [0, 0, 0, 0, 0, 1 ,0]].
    */

    true.


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

