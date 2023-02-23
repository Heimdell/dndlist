module Update exposing (..)

type alias Update model msg =
    msg -> model -> (model, Cmd msg)

compose : List (Update model msg) -> Update model msg
compose list msg model = case list of
    [] -> (model, Cmd.none)
    upd :: upds ->
        let (model1, cmd1) = compose upds msg model in
        let (model2, cmd2) = upd msg model1 in
            (model2, Cmd.batch [cmd1, cmd2])