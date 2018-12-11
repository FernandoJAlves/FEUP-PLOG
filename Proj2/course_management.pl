
:- use_module(library(clpfd)).

% cellContent(Value,Linha,Coluna)
:- dynamic cellContent/3.


print_line([]) :- format("|",[]), nl.
print_line([H|Rest]) :-
    format("| ~w ", [H]),
    print_line(Rest).

print_separator(0) :- write('+'), nl.
print_separator(SizeL) :- 
    format("+---",[]),
    NewSize is SizeL-1,
    print_separator(NewSize).

print_board([H|[]]) :-
    length(H, SizeL),
    print_separator(SizeL),
    print_line(H),
    print_separator(SizeL).
print_board([H|Rest]) :-
    length(H, SizeL),
    print_separator(SizeL),
    print_line(H),
    print_board(Rest).


save_line([],_,_).
save_line([H|Rest],NLinha,NColuna) :-
    assert(cellContent(H,NLinha, NColuna)),
    NewNColuna is NColuna+1,
    save_line(Rest,NLinha,NewNColuna).

save_board([],_).
save_board([H|Rest],NLinha) :-
    save_line(H,NLinha,1),
    NewNLinha is NLinha+1,
    save_board(Rest,NewNLinha).

print_mem :-
    cellContent(Val,X,Y),
    format("Val: ~w  X: ~w  Y: ~w", [Val,X,Y]), nl,
    fail.


fetch_board(tab1, Tab) :-

    Tab =  [[1,1,2,2,0,0,3,3],
            [4,1,1,2,2,3,3,0],
            [4,4,1,0,2,3,0,0],
            [5,4,4,0,6,6,0,7],
            [5,5,0,6,6,0,7,7],
            [0,5,5,6,0,7,7,0]].       

/*
fetch_board(tab2, Tab) :-
            %1, 2, 3, 4, 5 
    Tab =  [[0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 1, 0, 1, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0]].

fetch_board(tab3, Tab) :-
            %1, 2, 3, 4, 5, 6, 7, 8, 9, 10 
    Tab =  [[0, 1, 0, 0, 0, 0, 0, 1, 0, 0],
            [1, 0, 1, 0, 0, 0, 0, 1, 1, 0],
            [0, 1, 0, 1, 0, 0, 0, 0, 1, 1],
            [0, 0, 1, 0, 1, 0, 0, 0, 0, 1],
            [0, 0, 0, 1, 0, 0, 0, 0, 0, 1],
            [0, 0, 0, 0, 0, 0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
            [1, 1, 0, 0, 0, 1, 0, 0, 1, 0],
            [0, 1, 1, 0, 0, 0, 0, 1, 0, 1],
            [0, 0, 1, 1, 1, 0, 1, 0, 1, 0]].
*/

process_board(OriginalTab, Tab) :-
    
    save_board(OriginalTab,1),
    
    %print_mem,
    
    
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

