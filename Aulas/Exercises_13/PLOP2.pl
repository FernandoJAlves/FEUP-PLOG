:- use_module(library(clpfd)).

sum_dist([_],0).
sum_dist([A,B|R], S) :-
    S #= abs(A-B) + RS,
    sum_dist([B|R], RS).

carteiro(N, S, SDist) :-
    length(S,N),
    domain(S,1,N),
    all_distinct(S),
    sum_dist(S,SDist),
    element(N,S,6),
    labeling([maximize(SDist)], S).
    
    


