:- use_module(library(clpfd)).

/*
+------------+
|S1 |S2|S3|S4|
-------------
|S12|  |  |S5|
-------------
|S11|  |  |S6|
-------------
|S10|S9|S8|S7|
+------------+
*/


guardas1(Vars) :-
    Vars = [S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12],
    domain(Vars, 0, 5),
    sum(Vars, #=, 12),
    S1+S2+S3+S4 #= 5,
    S4+S5+S6+S7 #= 5,
    S7+S8+S9+S10 #= 5,
    S10+S11+S12+S1 #= 5,
    labeling([], Vars).
    
%REVER ISTO \/
guardas2(Vars) :-
    length(Vars,12),
    domain(Vars, 1,12),
    count(1,Vars,#=,C1),
    count(2,Vars,#=,C2),
    count(3,Vars,#=,C3),
    count(4,Vars,#=,C4),

    sum([C1,C2,C3,C4], #=, 5),

    labeling([], Vars).

