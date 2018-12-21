
% Checks if a piece of given ID can be placed at given coordinates
canPlace(0,LinCoord, ColCoord,SolidN, 0) :-
    Lcoord1 is LinCoord, Ccoord1 is ColCoord,
    Lcoord2 is LinCoord, Ccoord2 is ColCoord+1,
    Lcoord3 is LinCoord+1, Ccoord3 is ColCoord+1,
    Lcoord4 is LinCoord+1, Ccoord4 is ColCoord+2,
    Lcoord5 is LinCoord+2, Ccoord5 is ColCoord+2,
    
    cellContent(0, Lcoord1, Ccoord1),
    cellContent(0, Lcoord2, Ccoord2),
    cellContent(0, Lcoord3, Ccoord3),
    cellContent(0, Lcoord4, Ccoord4),
    cellContent(0, Lcoord5, Ccoord5),

    retract(cellContent(0, Lcoord1, Ccoord1)),
    retract(cellContent(0, Lcoord2, Ccoord2)),
    retract(cellContent(0, Lcoord3, Ccoord3)),
    retract(cellContent(0, Lcoord4, Ccoord4)),
    retract(cellContent(0, Lcoord5, Ccoord5)),
    
    assert(cellContent(SolidN, Lcoord1, Ccoord1)),
    assert(cellContent(SolidN, Lcoord2, Ccoord2)),
    assert(cellContent(SolidN, Lcoord3, Ccoord3)),
    assert(cellContent(SolidN, Lcoord4, Ccoord4)),
    assert(cellContent(SolidN, Lcoord5, Ccoord5)).


canPlace(0,LinCoord, ColCoord,SolidN, 1) :-
    Lcoord1 is LinCoord, Ccoord1 is ColCoord,
    Lcoord2 is LinCoord+1, Ccoord2 is ColCoord,
    Lcoord3 is LinCoord+1, Ccoord3 is ColCoord+1,
    Lcoord4 is LinCoord+2, Ccoord4 is ColCoord+1,
    Lcoord5 is LinCoord+2, Ccoord5 is ColCoord+2,
    
    cellContent(0, Lcoord1, Ccoord1),
    cellContent(0, Lcoord2, Ccoord2),
    cellContent(0, Lcoord3, Ccoord3),
    cellContent(0, Lcoord4, Ccoord4),
    cellContent(0, Lcoord5, Ccoord5),

    retract(cellContent(0, Lcoord1, Ccoord1)),
    retract(cellContent(0, Lcoord2, Ccoord2)),
    retract(cellContent(0, Lcoord3, Ccoord3)),
    retract(cellContent(0, Lcoord4, Ccoord4)),
    retract(cellContent(0, Lcoord5, Ccoord5)),
    
    assert(cellContent(SolidN, Lcoord1, Ccoord1)),
    assert(cellContent(SolidN, Lcoord2, Ccoord2)),
    assert(cellContent(SolidN, Lcoord3, Ccoord3)),
    assert(cellContent(SolidN, Lcoord4, Ccoord4)),
    assert(cellContent(SolidN, Lcoord5, Ccoord5)).


canPlace(0,LinCoord, ColCoord,SolidN, 2) :-
    Lcoord1 is LinCoord, Ccoord1 is ColCoord,
    Lcoord2 is LinCoord-1, Ccoord2 is ColCoord,
    Lcoord3 is LinCoord-1, Ccoord3 is ColCoord+1,
    Lcoord4 is LinCoord-2, Ccoord4 is ColCoord+1,
    Lcoord5 is LinCoord-2, Ccoord5 is ColCoord+2,
    
    cellContent(0, Lcoord1, Ccoord1),
    cellContent(0, Lcoord2, Ccoord2),
    cellContent(0, Lcoord3, Ccoord3),
    cellContent(0, Lcoord4, Ccoord4),
    cellContent(0, Lcoord5, Ccoord5),

    retract(cellContent(0, Lcoord1, Ccoord1)),
    retract(cellContent(0, Lcoord2, Ccoord2)),
    retract(cellContent(0, Lcoord3, Ccoord3)),
    retract(cellContent(0, Lcoord4, Ccoord4)),
    retract(cellContent(0, Lcoord5, Ccoord5)),
    
    assert(cellContent(SolidN, Lcoord1, Ccoord1)),
    assert(cellContent(SolidN, Lcoord2, Ccoord2)),
    assert(cellContent(SolidN, Lcoord3, Ccoord3)),
    assert(cellContent(SolidN, Lcoord4, Ccoord4)),
    assert(cellContent(SolidN, Lcoord5, Ccoord5)).


canPlace(0,LinCoord, ColCoord,SolidN, 3) :-
    Lcoord1 is LinCoord, Ccoord1 is ColCoord,
    Lcoord2 is LinCoord, Ccoord2 is ColCoord+1,
    Lcoord3 is LinCoord-1, Ccoord3 is ColCoord+1,
    Lcoord4 is LinCoord-1, Ccoord4 is ColCoord+2,
    Lcoord5 is LinCoord-2, Ccoord5 is ColCoord+2,
    
    cellContent(0, Lcoord1, Ccoord1),
    cellContent(0, Lcoord2, Ccoord2),
    cellContent(0, Lcoord3, Ccoord3),
    cellContent(0, Lcoord4, Ccoord4),
    cellContent(0, Lcoord5, Ccoord5),

    retract(cellContent(0, Lcoord1, Ccoord1)),
    retract(cellContent(0, Lcoord2, Ccoord2)),
    retract(cellContent(0, Lcoord3, Ccoord3)),
    retract(cellContent(0, Lcoord4, Ccoord4)),
    retract(cellContent(0, Lcoord5, Ccoord5)),
    
    assert(cellContent(SolidN, Lcoord1, Ccoord1)),
    assert(cellContent(SolidN, Lcoord2, Ccoord2)),
    assert(cellContent(SolidN, Lcoord3, Ccoord3)),
    assert(cellContent(SolidN, Lcoord4, Ccoord4)),
    assert(cellContent(SolidN, Lcoord5, Ccoord5)).

