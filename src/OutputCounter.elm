module OutputCounter exposing (..)
import Update exposing (Update)
import View exposing (View)
import Html exposing (text)
import Debug exposing (toString)

{-
  Most useless component eval, literally a number.
-}

type alias Model = Int

type Msg = None

update : Update Model Msg
update _ model = (model, Cmd.none)

view : View Model Msg
view = text << toString

init : Model
init = 0
