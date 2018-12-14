% Task Duration Resources

%  T1     16        2   
%  T2     6         9
%  T3     13        3
%  T4     7         7
%  T5     5         10
%  T6     18        1
%  T7     4         11

%Cap maxima: 13

:- use_module(library(clpfd)).
:- use_module(library(lists)).

schedule(Ss, End) :-
    Ss = [S1,S2,S3,S4,S5,S6,S7],
    Es = [E1,E2,E3,E4,E5,E6,E7],
    Tasks = [
        task(S1,16,E1,2,1),
        task(S2,6,E2,9,2),
        task(S3,13,E3,3,3),
        task(S4,7,E4,7,4),
        task(S5,5,E5,10,5),
        task(S6,18,E6,1,6),
        task(S7,4,E7,11,7)
    ],
    domain(Ss, 1, 50), domain(Es,1,100),
    domain([End], 1, 100), maximum(End, Es),
    cumulative(Tasks, [limit(13)]),
    append(Ss, [End], Vars),
    labelling([minimize(End), Vars]).
