%embeddings in a reverse order
rocc(T,L,P) :- seq(T,P,I), pat(L,I), patlen(L).
rocc(T,L,P) :- rocc(T, L,   P+1), seq(T,P,_).
rocc(T,L,P) :- rocc(T, L+1, P+1), seq(T,P,C), pat(L,C). 

%insertable items
ins(T,1,I) :- seq(T,P,I), rocc(T,1,P+1).
ins(T,L+1,I) :- seq(T,P,I), occ(T,L,P-1), patlen(L).
ins(T,X,I) :- seq(T,P,I), rocc(T,X,P+1),
                            occ(T,X-1,P-1), patpos(X), X>1.

%#show eocc/3.
%#show ins/3.
