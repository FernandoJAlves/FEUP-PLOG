:- dynamic cell/3.

getPeca(Nlinha, Ncoluna, Tabuleiro, Peca).


getPeca(Nlinha,Ncoluna,Tab,Peca) :-
    nth1(Nlinha,Tab,Linha),
    nth1(Ncoluna,Linha,Peca).

getLinha(1,[Linha|_],Linha).

getLinha(N,[_|Resto],Linha) :-
    N > 1,
    Next is N-1,
    getLinha(Next,Resto,Linha).

setPeca(Nlinha, Ncoluna, Peca, TabIn, TabOut).

setPeca(Nlinha,Ncoluna,Peca,TabIn,TabOut) :-
    setPecaLinha(Nlinha,Ncoluna,Peca,TabIn,TabOut).

setPecaLinha(1,Ncolunas,Peca,[Linha|MaisLinhas],[NovaLinha|MaisLinhas]) :-
    setPecaColuna(Ncolunas,Peca,Linha,NovaLinha).

setPecaLinha(N, Ncolunas,Peca,[Linha|MaisLinhas],[Linha|NovasLinhas]) :-
    N > 1,
    Next is N-1,
    setPecaLinha(Next,Ncolunas,Peca,MaisLinhas,NovasLinhas).

setPecaColuna(1,Peca,[_|Resto],[Peca,Resto]).

setPecaColuna(N,Peca,[Peca1|Resto],[Peca1|Mais]) :-
    N > 1,
    Next is N-1,
    setPecaColuna(Next,Peca,Resto,Mais).



getPeca(Linha,Coluna,Peca):-
    cell(Linha,Coluna,Peca).

setPeca(Linha):-
    retract(cell(Linha,Coluna,_)),
    assert(cell(Linha,Coluna,Peca)).

append([],Lista,Lista).

append([H|T],Lista,Lista):-
    append(T,Lista,Resto).

reverse([],[]).

reverse([x|Resto],Invertida):-
    reverse(Resto,RestoInv),
    append(restoInv,[X],Invertida).

reverse(Lista1,Lista2):-
    reverse3(Lista1,[],Lista2).

reverse3([],Invertida, Invertida).

reverse([X|Resto],Imp,Invertida):-
    reverse(Resto,[X|Imp],Invertida).

/*  
 joga(h,h,_)
 joga(h,c,Nivel)
 joga(c,c,Nivel)
*/
joga :- 
    tabuleiro(Tab0),
    assert(tabuleiro(Tab0)),
/*
    repeat,
        retreat(tabuleiro(TabIn)),
        jogada(TabuleiroIn,TabuleiroOut),
        assert(tabuleiro(tabulerioOut)),
        terminou;
*/