module View exposing (..)

import Html exposing (Html)

type alias View model msg =
    model -> Html msg

cat : Html a -> Html a -> Html a
cat a b = Html.span [] [a, Html.text ", ", b]

vcat : Html a -> Html a -> Html a
vcat a b = Html.div [] [a, Html.hr [] [], b]