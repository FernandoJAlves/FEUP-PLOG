:- dynamic botInt/1.


setBotInt(Num):- assert(botInt(Num)).
deactivateBot :- retractall(botInt(Num)).
