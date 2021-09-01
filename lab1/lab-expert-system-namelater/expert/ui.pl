:- ['base.pl', 'scheme.pl'].

:- initialization(find_job, main).

find_job():-
    reset(),
    writeln("Далее будут выводиться вопросы, по ответам на которые будет выведена подходящая умениям работа"),
    job(X),
    write("Подходящая работа: "),
    writeln(X);
    write("Подходящей работы не найдено").

