:- dynamic
    accepted/1,
    denied/1.

read_input(X):-
    read_line_to_string(user_input, Str),
    string_lower(Str, X).

confirm_input(X):-
    member(X, ["yes", "ye", "y", "eys", "yeah", "yep"]).

reset():-
    retractall(accepted(_)),
    retractall(denied(_)).

memorise(Ans, Statement):-
    confirm_input(Ans),
    asserta(accepted(Statement)).

memorise(_, Statement):-
    asserta(denied(Statement)).

ask(Statement, Question):-
    write(Question),
    writeln(' (Y/N): '),
    read_input(Answer),
    memorise(Answer, Statement).

check(Fact):-
    accepted(Fact), !.

check(Fact):-
    denied(Fact), !, fail.

check(Fact):-
    trait(Fact), !.

check(Fact):-
    base_trait(Fact, Question),
    ask(Fact, Question),
    check(Fact).

