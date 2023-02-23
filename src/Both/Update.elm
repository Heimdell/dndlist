module Both.Update exposing (..)

import Both.Model exposing (Model)
import Update exposing (Update)
import Both.Msg exposing (Msg (..))
import Data.Either exposing (Either(..))

update : Update a msg -> Update b msg -> Update (Model a b) (Msg msg)
update updateA updateB (Msg msg) (a, b) =
  let (a1, cmdA) = updateA msg a in
  let (b1, cmdB) = updateB msg b in
  ((a1, b1), Cmd.map Msg <| Cmd.batch [cmdA, cmdB])
