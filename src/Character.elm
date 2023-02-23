module Character exposing (..)
import InputFlag
import Named
import Pair.Model as Pair
import Pair.Msg as Pair
import List.Model as List
import Attribute
import Data.List exposing (uncurry)
import Update exposing (Update)
import Pair.Update
import InputCounter
import List.Update
import List.Msg as List
import View exposing (View)
import Pair.View
import List.View
import List exposing (foldr)
import View exposing (vcat)
import Html
import Browser exposing (element)

{-
  Mother-of-god.jpg

  Character model. Has name, [edit] toggle, level and attributes (w/skills).
-}
type alias Model = Named.Model (Pair.Model InputFlag.Model (Pair.Model InputCounter.Model (List.Model Attribute.Model)))
type alias Msg   = Named.Msg   (Pair.Msg   InputFlag.Msg   (Pair.Msg   InputCounter.Msg   (List.Msg   Attribute.Msg  )))

init : String -> List (String, List String) -> Model
init name attrs = Named.init name
  <| Pair.init InputFlag.init
  <| Pair.init InputCounter.init
  <| List.map (uncurry Attribute.init) attrs

update : Update Model Msg
update msg model =
  let proficiency = Tuple.first (Tuple.second model.raw)
  in
  (Named.update
  <| Pair.Update.update  InputFlag.update
  <| Pair.Update.update  InputCounter.update
  <| List.Update.update (Attribute.update proficiency)) msg model

-- domainUpdate : Model -> Model
-- domainUpdate model =
--   { model | raw = 1 }

view : View Model Msg
view model =
  let editable = Tuple.first model.raw
  in
    (Named.view
    <| Pair.View.view View.vcat (InputFlag.view True)
    <| Pair.View.view View.vcat (InputCounter.view editable) (List.View.view (foldr vcat (Html.text "")) (Attribute.view editable))
    ) model

main : Program () Model Msg
main = element
  { init          = \_ -> (init "Bobby" [("Dex", ["Jumping", "Lockpicking"]), ("Int", ["Lore", "Arcana"])], Cmd.none)
  , update        =       update
  , view          =       view
  , subscriptions = \_ -> Sub.none
  }