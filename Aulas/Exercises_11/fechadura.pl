:- use_module(library(clpfd)).

fechadura(Vars) :-
    Vars = [A,B,C],
    domain(Vars, 1, 50), domain([A2,B2],0,9), domain([A1,B1],0,5),

    B #= A*2,
    C #= B+10,
    A+B #> 10,
    A #= 10*A1 + A2,
    A1 mod 2 #\=A2 mod 2,
    B #= 10 * B1+B2,
    B1 mod 2 #= B2 mod 2,
    labeling([ffc], Vars).
    


