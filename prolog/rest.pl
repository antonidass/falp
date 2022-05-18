:- use_module(library(http/http_server)).

:- initialization
    http_server([port(102)]).

:- http_handler(root(.),
                http_redirect(moved, location_by_id(home_page)),
                []).
:- http_handler(root(home), home_page, []).


operator("-", X, Y, Res) :- Res is X - Y. 


print_request([]).
print_request([H|T]) :-
        H =.. [Name, Value],
        format('<tr><td>~w<td>~w~n', [Name, Value]),
        print_request(T).


home_page(_Request) :-
    operator("-", 10, 20, Res),
    reply_html_page(
        title('Demo server'),
        [
            
            format('Content-type: text/html~n~n
                    <html><body>Вычисление чисел Фиббоначчи<br/>
                        ~w
                    </body></html>~n', [Res])
        ]
        ).




