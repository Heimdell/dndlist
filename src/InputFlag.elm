module InputFlag exposing (..)
import Update exposing (Update)
import View exposing (View)
import Html exposing (..)
import Html.Events exposing (onClick)
-- import Browser exposing (element)

{-
  Togglable flag.
-}
type alias Model = Bool

type Msg = Click

init : Model
init = False


update : Update Model Msg
update _ model =
  ( not model
  , Cmd.none
  )

view : Bool -> View Model Msg
view editable model =
  Html.button
    (if editable then [ onClick Click ] else [])
    [ text (if model then "*" else "_") ]


-- main : Program () Model Msg
-- main = element
--   { init          = \_ -> ({ flag = False, editable = True}, Cmd.none)
--   , update        =       update
--   , view          =       view
--   , subscriptions = \_ -> Sub.none
--   }