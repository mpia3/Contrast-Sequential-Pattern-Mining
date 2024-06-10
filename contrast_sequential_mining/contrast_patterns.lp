%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% contrast sequential patterns %%%%%%%%%%%%%%%%

%% According to "Contrast Pattern Mining: A Survey" by Yao Chena, Wensheng Gan, Yongdong Wu and Philip S. Yu
%% Given two sequence datasets: D1 belongs to class c1 and D2 belongs to class c2. The "growth rate" 
%% from D2 to D1 of a sequential pattern X is denoted as GR_c1(X): "inf" if sup(X, c2)=0 and sup(X, c1)!=0;
%% (sup(X, c1)/|D1|)/(sup(X, c2)/|D2|) otherwise.
%% Similarly, the "growth rate" from D1 to D2 of a sequential pattern X is denoted as GR_c2(X): "inf" if sup(X, c1)=0 and sup(X, c1)!=0;
%% (sup(X, c2)/|D2|)/(sup(X, c1)/|D1|) otherwise.
%% The "contrast rate" of X is denoted as CR(X): "inf" if GR_c1(X) = 0 or GR_c2(X) = 0;
%% max(GR_c1(X), GR_c2(X)) otherwise.
%% A sequence s in a sequential database is said to be a "CSP" if its contrast rate is no less than the given CR threshold "mincr".

#const c1 = c1.
#const c2 = c2.
#const mincr = 1.

#script (python)
import clingo
def growth_rate(s1, c1, s2, c2):
	s1 = float(s1.number)
	c1 = float(c1.number)
	s2 = float(s2.number)
	c2 = float(c2.number)
	
	gr = (s1/c1)/(s2/c2)
	return clingo.String(str(gr))
	
def contrast_rate(p_gr, n_gr, c1, c2):
	p_gr = p_gr.string
	n_gr = n_gr.string
	
	n_p_gr = float(p_gr)
	n_n_gr = float(n_gr)
	
	if n_p_gr > n_n_gr:
		return clingo.String(str(n_p_gr)), clingo.Function(c1.name)
	else:
		return clingo.String(str(n_n_gr)), clingo.Function(c2.name)

def minimum_contrast_difference(min_diff, c1_gr, c2_gr):
	min_diff = min_diff.number
	class_diff = abs(float(c1_gr.string) - float(c2_gr.string))
	
	if float(class_diff) < min_diff:
		return clingo.Function("no")
	else:
		return clingo.Function("yes")
	
def contrast_sequential_pattern(cr, min_cr):
	cr = cr.string
	min_cr = min_cr.number
	
	if float(cr) < min_cr:
		return clingo.Function("no")
	else:
		return clingo.Function("yes")
	
#end.

%% cardinality
card(Card, c1) :- Card = #count{T : cl(T, c1)}.
card(Card, c2) :- Card = #count{T : cl(T, c2)}. 

%% support
sup(Sup, c1) :- Sup = #count{T : support(T), seq(T, _, _), cl(T, c1)}.
sup(Sup, c2) :- Sup = #count{T : support(T), seq(T, _, _), cl(T, c2)}.

%% growth rate
growth_rate(inf, c1) :- sup(Sup1, c1), Sup1 != 0, sup(0, c2).
growth_rate(inf, c2) :- sup(Sup2, c2), Sup2 != 0, sup(0, c1).
%growth_rate(@growth_rate(Sup1, Card1, Sup2, Card2), Class) :- sup(Sup1, c1), card(Card1, c1), sup(Sup2, c2), card(Card2, c2), Sup1 > 0, Sup2 > 0.
growth_rate(@growth_rate(Sup1, Card1, Sup2, Card2), c1) :- sup(Sup1, c1), card(Card1, c1), sup(Sup2, c2), card(Card2, c2), Sup1 > 0, Sup2 > 0.
growth_rate(@growth_rate(Sup2, Card2, Sup1, Card1), c2) :- sup(Sup1, c1), card(Card1, c1), sup(Sup2, c2), card(Card2, c2), Sup1 > 0, Sup2 > 0.

%% contrast pattern
contrast_pattern(yes, Class) :- growth_rate(inf, Class).
contrast_pattern(@contrast_sequential_pattern(Cr, mincr), Class) :- growth_rate(Cr, Class), Cr != inf.

:- contrast_pattern(no, c1), contrast_pattern(no, c2).
:- contrast_pattern(yes, c1), contrast_pattern(yes, c2).

#show growth_rate/2.
#show contrast_pattern/2.
%#show min_diff/3.