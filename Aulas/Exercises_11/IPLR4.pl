:- use_module(library(clpfd)).



     

auxGetLetters([], Laux, Lout) :- Lout = Laux.
auxGetLetters([H|Tail], Laux, Lout) :-
    nonmember(H, Laux),
    append(Laux, [H], NewList),
    auxGetLetters(Tail, NewList, Lout).
    
auxGetLetters([H|Tail], Laux, Lout) :- auxGetLetters(Tail, Laux, Lout).

getSum(_, [], Out1, Out1).
getSum(X, [H|Rest], Aux, Out1) :-
    NewX is X-1,
    NewAux is H*exp(10,X) + Aux,
    getSum(NewX, Rest, NewAux, Out1).

puzzle(N, L1, L2, Lsum) :-
    length(Lsum, X),
    domain(L1, 0, 9),
    domain(L2, 0, 9),
    domain(Lsum, 0, 9),
    /*
    length(Lout, 10),
    domain(Lout, 0, 9),
    auxGetLetters(L1, Lout, Lout),
    auxGetLetters(L2, Lout, Lout),
    auxGetLetters(Lsum, Lout, Lout),
    format("~w", [Lout]), nl.
*/
    getSum(X, L1, 0, Out1),
    getSum(X, L2, Out1, Out2),
    getSum(X, Lsum, Out2, Outsum),

    Out1 + Out2 #= Outsum,
    labeling([],Lsum).

/*
puzzle(1, [D,O,N,A,L,D],[G,E,R,A,L,D],[R,O,B,E,R,T]) :-
    Vars = [D,O,N,A,L,G,E,R,B,T],
    domain(Vars, 0, 9),
    all_distinct(Vars),
    
    100000*D + 10000*O + 1000*N + 100*A + 10*L + D + 
    100000*G + 10000*E + 1000*R + 100*A + 10*L + D #=
    100000*R + 10000*O + 1000*B + 100*E + 10*R + T,

    labeling([], Vars).
*/

