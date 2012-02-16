#!/usr/local/bin/escript
%% -*- erlang -*-

main(_) ->
    inets:start(),


get_url(Url) ->
    Request = {Url, Headers, "audio/mpeg", Body},
    case httpc:request(put, Request, HTTPOptions, Options, Profile) of
        {ok, {Status, _Header, _Content}} -> Status;
        {error, Reason} ->
            io:format("Error: ~p~n", [Reason])
    end.
