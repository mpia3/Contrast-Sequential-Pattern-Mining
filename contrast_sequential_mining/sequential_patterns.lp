item(I) :- seq(_, _, I).

%% sequential pattern generation
patpos(1).
{ patpos(X+1) } :- patpos(X), X < maxlen.
patlen(L) :- patpos(L), not patpos(L+1).
:- patlen(L), L < minlen.

1 {pat(X, I): item(I)} 1 :- patpos(X).

%% pattern embeddings
occ(T, 1, P) :- seq(T, P, I), pat(1, I).
occ(T, L, P) :- occ(T, L,   P-1), seq(T, P, _).
occ(T, L, P) :- occ(T, L-1, P-1), seq(T, P, C), pat(L, C).

%% frequency constraint
seqlen(T, L) :- seq(T, L, _), not seq(T, L+1, _).
support(T) :- occ(T, L, LS), patlen(L), seqlen(T, LS). %% basic formulation and min-max gap
:- { support(T) } < minsup.

%% how many sequences contains pattern
len_support(N) :- N = #count{T : support(T)}.

#show pat/2.
%#show occ/3.
%#show support/1.
%#show patlen/1.
