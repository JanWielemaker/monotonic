:- use_module(monotonic).

:- dynamic (q/1, r/1, s/1) as monotonic.

:- monotonic p/1.

p(X) :-
    q(X).

:- monotonic n/1.

n(X) :-
    \+ q(X).

:- monotonic np/1.

np(X) :-
    q(X), \+ r(X).

:- monotonic dp/1.

dp(X) :-
    (   q(X), \+ r(X)
    ;   s(X)
    ).

%!  l(Name)
%
%   List link clause as well as the positive and/or negative that exist.

l(Name) :-
    forall(current_predicate(Name, Head),
           (   functor(Head, Name, Arity),
               atom_concat(pos_, Name, Pos),
               atom_concat(neg_, Name, Neg),
               listing(Name/Arity),
               list_existing(Pos/Arity),
               list_existing(Neg/Arity)
          )).

list_existing(PI) :-
    current_predicate(PI),
    !,
    listing(PI).
list_existing(_).
