:- dynamic played/4.

:- use_module(library(lists)).

; :- write('Fudeu').

%player(Name, Username, Age)
player('Danny','Best Player Ever',27).
player('Annie','Worst Player Ever',24).
player('Harry','A-Star Player',26).
player('Manny','The Player',14).
player('Jonny','Age Player',16).

%game(Name, Categories, MinAge)
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

%played(Player, Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).


achievedLittle(Player) :-
    played(Player, _, _, X),
    X < 10.

isAgeAppropriate(Name, Game) :-
    player(Name, _, Age1),
    game(Game,_,Age2),
    Age1 >= Age2.



updatePlayer(Player, Game, Hours, Percentage) :-
    retract(played(Player,Game,Hours1,Percentage1)),
    NewHours is Hours + Hours1,
    NewPenc is Percentage + Percentage1,
    assert(played(Player,Game,NewHours,NewPenc)).
    

auxList(Cat) :-
    game(Name,L,Age),
    member(Cat,L),
    format("~w (~w)", [Name,Age]), nl,
    fail.

listGamesOfCategory(Cat) :-
    auxList(Cat); true.


auxTime(_,[],AuxList, AuxSum, ListOfTime, SumTimes) :- ListOfTime = AuxList, SumTimes = AuxSum.
auxTime(Player, [H|Rest], AuxList, AuxSum, ListOfTimes, SumTimes) :-
    played(Player, H, Hours, _),
    append(AuxList, [Hours], NewList),
    NewSum is AuxSum + Hours,
    auxTime(Player, Rest, NewList, NewSum, ListOfTimes, SumTimes).
auxTime(_,_,_,_,ListOfTime,SumTimes) :- ListOfTime = [0], SumTimes = 0.


timePlayingGames(Player, [H|Rest], ListOfTimes, SumTimes) :-
    auxTime(Player, [H|Rest], [], 0, ListOfTimes, SumTimes), !.



auxFewHours(Player, List, Games) :-
    played(Player, Game, Time, _),
    nonmember(Game, List),
    Time < 10,
    append([Game],List,ListaGames),
    auxFewHours(Player, ListaGames, Games).

auxFewHours(_, Games, Games).



fewHours(Player, Games) :-
    auxFewHours(Player, [], Games), !.





ageRange(MinAge, MaxAge, Players) :-
    findall(Player,(player(Player,_,Age),(Age >= MinAge, Age =< MaxAge)), Players).



averageAge(Game, AverageAge) :-
    findall(Age, (played(Player,Game,_,_),player(_,Player,Age)),Ages),
    length(Ages,Size),
    sumlist(Ages,Total),
    AverageAge is Total/Size.


calcEff(Percent, Hours, Out) :- Out is Percent/Hours.

aux_max([], OutVal, OutVal).
aux_max([H|Rest], OldMax, OutVal) :- 
    NewMax is max(OldMax,H),
    aux_max(Rest,NewMax, OutVal).




max_list(List,OutVal) :-
    aux_max(List, 0, OutVal).



mostEffectivePlayers(Game, Players) :-
    findall(Out, (played(Player,Game,Hours,Percent), calcEff(Percent, Hours, Out)), List),
    max_list(List, MaxEff),
    findall(Player, (played(Player,Game,Hours,Percent), calcEff(Percent, Hours, Out), Out is MaxEff), Players).


    




    


