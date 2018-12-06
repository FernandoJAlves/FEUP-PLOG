:- use_module(library(trees)).


/*
pessoa(fernando, 20, 174, engenharia).
pessoaAltura(Pessoa,Altura) :- pessoa(Pessoa,_,Altura,_).

////////////////

atype(pedro,alves).
atype(manuel,alves).
atype(filipa,alves).
atype(fernando,alves).
btype(fernando,alves).
ctype(fernando,alves).

union(X,Y) :- atype(X,Y).
union(X,Y) :- btype(X,Y).
union(X,Y) :- ctype(X,Y).

difT(X,Y) :- atype(X,Y).
difT(X,Y) :- \+ btype(X,Y).

///////////////////////

natural_number(0).
natural_number(s(X)) :- natural_number(X).

///////////////////////


list([]).
list([X|Xs]) :- list(Xs).

///////////////////////

prefix([],Ys).
prefix([X|Xs],[X|Ys]) :- prefix(Xs,Ys).

///////////////////////


*/



reverse1([],[]).
reverse1([X|Xs],Zs) :- reverse1(Xs,Ys), append(Ys,[X],Zs).

reverse2(Xs,Ys) :- reverse2(Xs,[],Ys).
reverse2([X|Xs],Acc,Ys) :- reverse2(Xs,[X|Acc], Ys).
reverse2([],Ys,Ys).

delete1([X|Xs],X,Ys) :- delete1(Xs,X,Ys).
delete1([X|Xs],Z,[X|Ys]) :- /*X \= Z,*/ delete1(Xs,Z,Ys).
delete1([],X,[]).

select1(X,[X|Xs],Xs).
select1(X,[Y|Ys],[Y|Zs]) :- select1(X,Ys,Zs).



permutation1(Xs,[Z|Zs]) :- select1(Z,Xs,Ys), permutation1(Ys,Zs).
permutation1([],[]).


tree(Elem,Left,Right).

binary_tree(void).
binary_tree(tree(Elem,Left,Right)) :- binary_tree(Left), binary_tree(Right). 


preorder(tree(X,L,R),Xs) :- preorder(L,Ls), preorder(R,Rs), append([X|Ls],Rs,Xs).
preorder(void,[]).

inorder(tree(X,L,R),Xs) :- inorder(L,Ls), inorder(R,Rs), append([X|Ls],Rs,Xs).
inorder(void,[]).

/*
fac(a).
fac(b).

g1(X) :- fac(X), cut(X).
g2(X) :- fac(X).

cut(a) :- !.
*/

max_t(X,Y,X) :- X>=Y.
max_t(X,Y,Y).

max_cal(X,Y,Max) :- X>=Y,!, Max = X; Max = Y.

test(X) :- write(1), nl, X>1; write(2).

test_list(X,[X|L]).
test_list(X,[Y|L]) :- test_list(X,L).

test_list2(X,[X|L]) :- !.
test_list2(X,[Y|L]) :- test_list2(X,L).

/*
: :- format("This works",[]).
; :- format("This also works",[]).
*/

patient(1).
patient(X) :- patient(X,Y), !; fail.
patient(X,Y) :- write('1 da').
patient(X,Y) :- write('2 nao da').


/*
append(X,[c|Y],[_,_,_,_]).

append([a|X],[d],[a,b,c,d]).
*/
