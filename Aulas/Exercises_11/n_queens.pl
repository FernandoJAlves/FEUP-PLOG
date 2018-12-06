:- use_module(library(clpfd)).


nqueens(Cols) :-
    Cols = [C1,C2,C3,C4],
    domain(Cols,1,4), all_distinct(Cols),
    C1-1 #\= C2, C1+1 #\= C2,
    C1-2 #\= C3, C1+2 #\= C3,
    C1-3 #\= C4, C1+3 #\= C4,
    C2-1 #\= C3, C2+1 #\= C3,
    C2-2 #\= C4, C2+2 #\= C4,
    C3-1 #\= C4, C3+1 #\= C4,
    labeling([], Cols).
    

    


