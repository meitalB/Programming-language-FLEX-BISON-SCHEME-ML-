% Meital Birka
% id:311124283
% group:04
% username: birkame



getElement([H|_],0,H) :-%how undefine???????
    !.
getElement([],_,undefined):-!.
% getElement([],N,H):- H1 is undefined ,getElement([],N,H1).
getElement([_|T],N,H) :-
    N1 is N-1,
    getElement(T,N1,H).



mulList([],1):-!.
mulList([],_):- N1 is 1,mulList([],N1).
mulList([H|T],R):- mulList(T,RR), R is H*RR .



hpairs(_,[],[]):-!.
hpairs(_,[],_):- !.
hpairs(E,[H1|T],[[E,H1]|R]):- hpairs(E,T,R).


apairs([],[]):-!.
apairs([_],[]):-!.
apairs([_],_):-!.
apairs([X|D],[R|Res]):-hpairs(X,D,R),apairs(D,Res).

onePair([H|T],[H,E]):-member(E,T).
onePair([_|T],P):- onePair(T,P).

pairs(L,Pairs):-findall(Pair,onePair(L,Pair),Pairs).

mergeLists(X,[],X):-!.
mergeLists([],X,X):-!.
mergeLists([H1|T1],[H2|T2],[H1,H2|R]):- mergeLists(T1,T2,R).

takeFirst([],[]):-!.
takeFirst([[Y|_]|LSS],[Y|Result]):- takeFirst(LSS,Result).

dropFirst([],[]):-!.
dropFirst([[_|T]|LSS],[T|Result]):- dropFirst(LSS,Result).

selectCol([],_,[]):-!.
selectCol([X|LSS],N ,[R|Result]):- A is N-1,getElement(X,A,R),selectCol(LSS,N,Result).

transpose([],[]):-!.
transpose([[X]],[[X]]):-!.







