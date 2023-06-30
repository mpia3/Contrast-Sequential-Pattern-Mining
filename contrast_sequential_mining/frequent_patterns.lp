%*
item(I) :- seq(_, _, I, _).

%% sequential pattern generation
patpos(1).
{ patpos(X+1) } :- patpos(X), X < maxlen.
patlen(L) :- patpos(L), not patpos(L+1).

1 {pat(X, I): item(I)} 1 :- patpos(X).

%% pattern embeddings
occ(T, 1, P) :- seq(T, P, I, _), pat(1, I).
occ(T, L, P) :- occ(T, L,   P-1), seq(T, P, _,_).
occ(T, L, P) :- occ(T, L-1, P-1), seq(T, P, C, _), pat(L, C).

%% frequency constraint
seqlen(T, L) :- seq(T, L, _, _), not seq(T, L+1, _,_).
support(T) :- occ(T, L, LS), patlen(L), seqlen(T, LS).
:- { support(T) } < th.

%% how many sequences contains pattern
len_support(N) :- N = #count{T : support(T)}.

%% delete answer where pattern lenght is less than "minlen"
:- #count{T : pat(T, _)} < minlen.
*%

item(I) :- seq(_, _, I).

%% sequential pattern generation
patpos(1).
{ patpos(X+1) } :- patpos(X), X < maxlen.
patlen(L) :- patpos(L), not patpos(L+1).

1 {pat(X, I): item(I)} 1 :- patpos(X).

%% pattern embeddings
occ(T, 1, P) :- seq(T, P, I), pat(1, I).
occ(T, L, P) :- occ(T, L,   P-1), seq(T, P, _).
occ(T, L, P) :- occ(T, L-1, P-1), seq(T, P, C), pat(L, C).

%% frequency constraint
seqlen(T, L) :- seq(T, L, _), not seq(T, L+1, _).
support(T) :- occ(T, L, LS), patlen(L), seqlen(T, LS).
:- { support(T) } < th.

%% how many sequences contains pattern
len_support(N) :- N = #count{T : support(T)}.

%% delete answer where pattern lenght is less than "minlen"
:- #count{T : pat(T, _)} < minlen.
