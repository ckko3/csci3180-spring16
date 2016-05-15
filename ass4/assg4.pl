/*
CSCI3180 Principles of Programming Languages
--- Declaration ---
I declare that the assignment here submitted is original except for source material explicitly acknowledged.
I also acknowledge that I am aware of University policy and regulations on honesty in academic work,
and of the disciplinary guidelines and procedures applicable to breaches of such policy and regulations,
as contained in the http://www.cuhk.edu.hk/policy/academichonesty/
Assignment 4
Name: KO Chi Keung
Student ID: 1155033234
Email Addr: ckko3@se.cuhk.edu.hk
*/

% Rules : sum
sum(0,X,X).
sum(s(X),Y,s(Z)) :- sum(X,Y,Z).

% 1a. Rules : product
product(0,_,0).
%product(s(X),Y,A) :- product(X,Y,Z), sum(Z,Y,A).
product(s(Y),X,A) :- sum(X,Z,A), product(X,Y,Z).

% 1b. Query : product of 3 and 4
% product(s(s(s(0))),s(s(s(s(0)))),A).

% 1c. Query : result of 8 divided by 4
% product(A,s(s(s(s(0)))),s(s(s(s(s(s(s(s(0))))))))).

% 1d. Query : factors of 6s
% product(A,B,s(s(s(s(s(s(0))))))).

% 1e. Rules : exponentiation
exp(_,0,s(0)).
exp(X,s(Y),A) :- exp(X,Y,Z), product(Z,X,A).

% 1f. Query : 2 to the power of 3
% exp(s(s(0)),s(s(s(0))),A).

% 1g. Query : base 2 log of 8
% exp(s(s(0)),A,s(s(s(s(s(s(s(s(0))))))))).

% 2a. Facts : transition(F,X,T)
transition(a,0,c).
transition(a,1,a).
transition(b,0,c).
transition(b,1,a).
transition(c,0,c).
transition(c,1,b).

% 2b. Rules : state(N)
state(N) :- transition(N,_,_).

% 2c. Rules : walk(S,B,E)
walk([S],B,E) :- transition(B,S,E).
walk([S|X],B,E) :- transition(B,S,T), walk(X,T,E).
