module Named exposing (..)
import Update exposing (Update)
import View exposing (View)
import Html exposing (..)

{-
  Add a label to another component.

  This is a hindrance, I'd rathe factor this in each other component manually.
-}
type alias Model a =
  { label : String
  , raw : a
  }

type Msg a = Msg a

update : Update a msgA -> Update (Model a) (Msg msgA)
update upd (Msg msg) model =
  let (raw, cmd) = upd msg model.raw
  in  ({model | raw = raw}, Cmd.map Msg cmd)

view : View a msgA -> View (Model a) (Msg msgA)
view v {label, raw} = span []
  [ text (label ++ " [")
  , Html.map Msg <| v raw
  , text "]"
  ]

init : String -> a -> Model a
init str a = {label = str, raw = a}