ligado(a,b).  ligado(f,i). 
ligado(a,c).  ligado(f,j). 
ligado(b,d).  ligado(f,k). 
ligado(b,e).  ligado(g,l). 
ligado(b,f).  ligado(g,m). 
ligado(c,g).  ligado(k,n). 
ligado(d,h).  ligado(l,o). 
ligado(d,i).  ligado(i,f).


pesq_prof(X,Y,L) :- 
    ligado(X,Y),
    append(L,[X],Ls),
    pesq_prof(Y,Z,Ls).

pesq_larg(X,Y,L) :- 
    ligado(X,Y),
    append(L,[X],Ls),
    pesq_larg(X,Z,Ls),
    pesq_larg(Y,Z,Ls).
