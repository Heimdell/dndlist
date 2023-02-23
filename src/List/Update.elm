module List.Update exposing (..)

import Data.List as List
import Update exposing (Update)
import List.Model as Model exposing (Model)
import List.Msg as Msg
import List.Msg exposing (Msg(..))
import Data.Pair as Pair

update : Update a msgA -> Update (Model a) (Msg msgA)
update updateA msg model = case (msg, model) of
  (Index 0 msgA, a :: az) -> Pair.bimap (Model.snoc az) (Cmd.map (Index 0)) <| updateA msgA a
  (Index n msgA, a :: az) -> Pair.bimap (Model.cons a)  (Cmd.map  Msg.inc)  <| update updateA (Index (n - 1) msgA) az
  (_,            [])      -> ([], Cmd.none)