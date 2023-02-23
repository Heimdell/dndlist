module View exposing (..)

import Html exposing (Html)

{-
  Type of view-functions.
-}
type alias View model msg =
    model -> Html msg

{-
  Compose two pieces of HTML horisontally (via <span>).
-}
cat : Html a -> Html a -> Html a
cat a b = Html.span [] [a, Html.text ", ", b]

{-
  Compose two pieces of HTML vertically (via <div>).
-}
vcat : Html a -> Html a -> Html a
vcat a b = Html.div [] [a, Html.hr [] [], b]