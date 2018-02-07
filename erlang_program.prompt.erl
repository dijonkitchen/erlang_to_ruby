-module(erlang_program).
-export([format_weight/1]).

format_weight(List_of_objects) ->
    Converted_List = convert_list_to_k(List_of_objects),
    print_weight(Converted_List),
    {Max_object, Min_object} = find_max_and_min(Converted_List),
    print_max_and_min(Max_object, Min_object).

convert_list_to_k([{Name, {l, Weight}} | Rest]) ->
    Converted_Object = {Name, {k, Weight / 0.45359237}},
    [Converted_Object | convert_list_to_k(Rest)];

convert_list_to_k([Object | Rest]) ->
    [Object | convert_list_to_k(Rest)];

convert_list_to_k([]) ->
    [].

print_weight([{Name, {k, Weight}} | Rest]) ->
    io:format("~-15w ~w c~n", [Name, Weight]),
    print_weight(Rest);
print_weight([]) ->
    ok.

find_max_and_min([Object | Rest]) ->
    find_max_and_min(Rest, Object, Object).

find_max_and_min([{Name, {k, Weight}} | Rest],
         {Max_Name, {k, Max_Weight}},
         {Min_Name, {k, Min_Weight}}) ->
    if
        Weight > Max_Weight ->
            Max_Object = {Name, {k, Weight}};
        true ->
            Max_Object = {Max_Name, {k, Max_Weight}}
    end,
    if
         Weight < Min_Weight ->
            Min_Object = {Name, {k, Weight}};
        true ->
            Min_Object = {Min_Name, {k, Min_Weight}}
    end,
    find_max_and_min(Rest, Max_Object, Min_Object);

find_max_and_min([], Max_Object, Min_Object) ->
    {Max_Object, Min_Object}.

print_max_and_min({Max_name, {k, Max_object}}, {Min_name, {k, Min_object}}) ->
    io:format("Max weight was ~w c in ~w~n", [Max_object, Max_name]),
    io:format("Min weight was ~w c in ~w~n", [Min_object, Min_name]).