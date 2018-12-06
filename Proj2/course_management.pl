
:- use_module(library(clpfd)).



cm(Vars, tab1) :- 
            %1, 2, 3, 4, 5, 6, 7 
    Tab =  [[0, 1, 0, 1, 0, 0 ,0],
            [1, 0, 1, 0, 0, 1 ,0],
            [0, 1, 0, 0, 0, 1 ,0],
            [1, 0, 0, 0, 1, 1 ,0],
            [0, 0, 0, 1, 0, 1 ,0],
            [0, 1, 1, 1, 1, 0 ,1],
            [0, 0, 0, 0, 0, 1 ,0]],
    %write(Tab), nl,

    Vars = [A,B,C,D,E,F,G], %depois passar para length para o dinamico
    domain(Vars,0,1),

    length(Lsum1,7),
    length(Lsum2,7),
    length(Lsum3,7),
    length(Lsum4,7),
    length(Lsum5,7),
    length(Lsum6,7),
    length(Lsum7,7),
    

    check_line(A,Vars,[0, 1, 0, 1, 0, 0 ,0],Lsum1), sum(Lsum1,#=,0),
    check_line(B,Vars,[1, 0, 1, 0, 0, 1 ,0],Lsum2), sum(Lsum2,#=,0),
    check_line(C,Vars,[0, 1, 0, 0, 0, 1 ,0],Lsum3), sum(Lsum3,#=,0),
    check_line(D,Vars,[1, 0, 0, 0, 1, 1 ,0],Lsum4), sum(Lsum4,#=,0),
    check_line(E,Vars,[0, 0, 0, 1, 0, 1 ,0],Lsum5), sum(Lsum5,#=,0),
    check_line(F,Vars,[0, 1, 1, 1, 1, 0 ,1],Lsum6), sum(Lsum6,#=,0),
    check_line(G,Vars,[0, 0, 0, 0, 0, 1 ,0],Lsum7), sum(Lsum7,#=,0),    



    sum(Vars,#=,Sum),
    labeling([maximize(Sum)], Vars).
       

check_board(Vars,Tab) :- false.

check_line(_,[],[],[]).
check_line(Var,[Hvar|Rvar],[Hline|Rline],[Hout|Rout]) :-
    (Var * Hvar * Hline) #= Hout,
    check_line(Var,Rvar,Rline,Rout).


    quad([_,_,_],[]).
quad([A,B,C,D|R], [V|RV]) :-
    A #= 1 #/\ B #= 2 #/\ C #= 3 #/\ D #= 4 #<=> V,
    quad([B,C,D|R],RV).
