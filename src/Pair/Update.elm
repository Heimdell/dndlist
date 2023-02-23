module Pair.Update exposing (..)

import Pair.Model exposing (Model)
import Update exposing (Update)
import Pair.Msg exposing (Msg)
import Data.Either exposing (Either(..))

update : Update a msgA -> Update b msgB -> Update (Model a b) (Msg msgA msgB)
update updateA updateB msg (a, b) =
  case msg of
    Left  msgA -> let (a1, cmdA) = updateA msgA a in ((a1, b), Cmd.map Left  cmdA)
    Right msgB -> let (b1, cmdB) = updateB msgB b in ((a, b1), Cmd.map Right cmdB)