%% min max gap constrains
%*
A gap constraint specifies the maximal/minimal number of positions (or timestamp difference) between two successive itemsets in an embedding. The maximal gap constraint is anti-monotonic while the minimal gap is not anti-monotonic.
*%
#const maxgap = 10.
#const mingap = 0.

%% duration (span) constraint
%*
The duration (or span) of some pattern is the difference between its last item timestamp and its first item timestamp. A duration constraint requires that the pattern duration should be longer or shorter than a given time period.
*%
#const maxspan = 10.
#const minspan = 0.

item(I) :- seq(_, _, I).

%% sequential pattern generation
patpos(1).
{ patpos(X+1) } :- patpos(X), X < maxlen.
patlen(L) :- patpos(L), not patpos(L+1).
% NEW WAY TO ERASE PATTERN WHERE LENGHT IS LESS THAN MINLEN
:- patlen(L), L < minlen.

1 {pat(X, I): item(I)} 1 :- patpos(X).

%% pattern embeddings, no min-max gap, no min-max span
%*
occ(T, 1, P) :- seq(T, P, I), pat(1, I).
occ(T, L, P) :- occ(T, L,   P-1), seq(T, P, _).
occ(T, L, P) :- occ(T, L-1, P-1), seq(T, P, C), pat(L, C).
*%

%% pattern embeddings, min-max gap
occ(T, 1, P) :- seq(T, P, I), pat(1, I).
occ(T, L, P) :- occ(T, L,   P-1), seq(T, P, _).
occ(T, L, P) :- occ(T, L-1, P-1), seq(T, P, C), pat(L, C), pat(L-1, C1), seq(T, P2, C1), P-P2-1 >= mingap, P-P2-1 <= maxgap.

%% pattern embeddings, min-max span
%*
occ(T, 1, P, P) :- seq(T, P, I), pat(1, I).
occ(T, L, P, IP) :- occ(T, L,   P-1, IP), seq(T, P, _).
occ(T, L, P, IP) :- occ(T, L-1, P-1, IP), seq(T, P, C), pat(L, C), P-IP+1 >= minspan, P-IP+1 <= maxspan.
*%

%% pattern embeddings, min-max gap, min-max span
%*
occ(T, 1, P, P) :- seq(T, P, I), pat(1, I).
occ(T, L, P, IP) :- occ(T, L,   P-1, IP), seq(T, P, _).
occ(T, L, P, IP) :- occ(T, L-1, P-1, IP), seq(T, P, C), pat(L, C), pat(L-1, C1), seq(T, P2, C1), P-P2-1 >= mingap, P-P2-1 <= maxgap, P-IP+1 >= minspan, P-IP+1 <= maxspan.
*%

%% frequency constraint
seqlen(T, L) :- seq(T, L, _), not seq(T, L+1, _).
%support(T) :- occ(T, L, LS, _), patlen(L), seqlen(T, LS). %% only when you use min-max span in pattern embeddings
support(T) :- occ(T, L, LS), patlen(L), seqlen(T, LS). %% basic formulation and min-max gap
:- { support(T) } < th.

%% how many sequences contains pattern
len_support(N) :- N = #count{T : support(T)}.

%% OLD WAY
%% delete answer where pattern lenght is less than "minlen"
%:- #count{T : pat(T, _)} < minlen.

#show pat/2.
%#show occ/3.
%#show support/1.
%#show patlen/1.