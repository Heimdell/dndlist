module Either.View exposing (..)

import Data.Either as Either exposing (Either(..))
import View exposing (View)
import Either.Model exposing (Model)
import Either.Msg exposing (Msg)
import Html

view : View a msgA -> View b msgB -> View (Model a b) (Msg msgA msgB)
view viewA viewB = Either.elim
  (Html.map Left  << viewA)
  (Html.map Right << viewB)