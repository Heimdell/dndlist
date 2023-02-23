module Both.View exposing (..)

import Both.Model exposing (..)
import Html exposing (Html)
import Both.Msg exposing (Msg (..))
import Data.Either exposing (Either(..))
import View exposing (View)

view
  :  (Html (Msg msg) -> Html (Msg msg) -> Html (Msg msg))
  -> View a msg
  -> View b msg
  -> View (Model a b) (Msg msg)
view append viewA viewB (first, second) =
  append
    (Html.map Msg <| viewA first)
    (Html.map Msg <| viewB second)