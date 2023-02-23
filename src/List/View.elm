module List.View exposing (..)

import List.Model exposing (Model)
import List.Msg   exposing (Msg (..))
import View       exposing (View)
import Html       exposing (Html)

view : (List (Html (Msg msgA)) -> Html (Msg msgA)) -> View a msgA -> View (Model a) (Msg msgA)
view combine viewA =
  List.indexedMap (\i -> Html.map (Index i) << viewA)
    >> combine