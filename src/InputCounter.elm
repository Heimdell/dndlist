module InputCounter exposing (..)
import Update exposing (Update)
import View exposing (View)
import Html exposing (..)
import Html.Events exposing (onClick)
import Debug exposing (toString)
import List exposing (concat)

{-
  Counter input. Can be disabled at view.
-}
type alias Model = Int

type Msg
  = Inc
  | Dec

init : Model
init = 0

update : Update Model Msg
update msg count =
  case msg of
    Inc -> (count + 1, Cmd.none)
    Dec -> (if count - 1 >= 0 then count - 1 else count, Cmd.none)

view : Bool -> View Model Msg
view editable model =
  span [ ]
    <| concat
    [ if editable then [button [ onClick Dec ] [ text "-" ]] else []
    , [text (toString model)]
    , if editable then [button [ onClick Inc ] [ text "+" ]] else []
    ]

-- main : Program () Model Msg
-- main = element
--   { init          = \_ -> ({ count = 10, editable = True}, Cmd.none)
--   , update        =       update
--   , view          =       view
--   , subscriptions = \_ -> Sub.none
--   }