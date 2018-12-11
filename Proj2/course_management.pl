
:- include('board_printer.pl').

:- use_module(library(clpfd)).

% cellContent(Value,Linha,Coluna)
:- dynamic cellContent/3.


process_board(OriginalTab, Tab) :-
    
    save_board(OriginalTab,1),
    
    print_mem,
    
    
            %1, 2, 3, 4, 5, 6, 7 
    Tab = [[0, 1, 0, 1, 0, 0 ,0],
            [1, 0, 1, 0, 0, 1 ,0],
            [0, 1, 0, 0, 0, 1 ,0],
            [1, 0, 0, 0, 1, 1 ,0],
            [0, 0, 0, 1, 0, 1 ,0],
            [0, 1, 1, 1, 1, 0 ,1],
            [0, 0, 0, 0, 0, 1 ,0]].


cm(Vars, TabName) :- 

    fetch_board(TabName,OriginalTab),

    nl, format("Initial Board: ",[]), nl,
    print_board(OriginalTab),

    process_board(OriginalTab, Tab),

    nl, format("Process Board: ",[]), nl,
    print_board(Tab).
 

/*
    length(Tab,Nvars),
    length(Vars,Nvars),

    domain(Vars,0,1),
    
    check_board(Vars,Vars,Tab,Nvars),

    sum(Vars,#=,Sum),
    labeling([maximize(Sum)], Vars).*/
       

check_board(_,[],[],_).
check_board(Vars,[Hvars|Rvars],[Htab|Rtab],Nvars) :- 
    length(Lsum,Nvars),
    check_line(Hvars,Vars,Htab,Lsum), sum(Lsum,#=,0),
    check_board(Vars,Rvars,Rtab,Nvars).


check_line(_,[],[],[]).
check_line(Var,[Hvar|Rvar],[Hline|Rline],[Hout|Rout]) :-
    (Var * Hvar * Hline) #= Hout,
    check_line(Var,Rvar,Rline,Rout).

