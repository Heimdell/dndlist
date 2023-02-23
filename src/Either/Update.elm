module Either.Update exposing (..)

import Data.Either exposing (Either(..))
import Data.Pair as Pair
import Update exposing (Update)
import Either.Model exposing (Model)
import Either.Msg exposing (Msg)

update : Update a msgA -> Update b msgB -> Update (Model a b) (Msg msgA msgB)
update updateA updateB msg model =
  case (msg, model) of
    (Left  msgA, Left  a) -> Pair.bimap Left  (Cmd.map Left)  <| updateA msgA a
    (Right msgB, Right b) -> Pair.bimap Right (Cmd.map Right) <| updateB msgB b
    _                     -> (model, Cmd.none)