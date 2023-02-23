module Pair.View exposing (..)

import Pair.Model exposing (..)
import Html exposing (Html)
import Pair.Msg exposing (Msg)
import Data.Either exposing (Either(..))
import View exposing (View)

view
  :  (Html (Msg msgA msgB) -> Html (Msg msgA msgB) -> Html (Msg msgA msgB))
  -> View a msgA
  -> View b msgB
  -> View (Model a b) (Msg msgA msgB)
view append viewA viewB (first, second) =
  append
    (Html.map Left (viewA first))
    (Html.map Right (viewB second))