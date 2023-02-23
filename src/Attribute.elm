module Attribute exposing (..)

import Pair.Model as Pair
import Pair.Msg   as Pair
import Named
import InputCounter
import List.Model as List
import List.Msg   as List
import Skill
import Update exposing (Update)
import Pair.Update
import List.Update
import View exposing (View)
import Pair.View
import List.View
import List exposing (foldr)
import Html exposing (text)
import Browser exposing (element)
import Data.Either exposing (Either(..))
import OutputCounter

{-
  Attribute w/skills.
-}
type alias Model = Pair.Model (Named.Model InputCounter.Model) (List.Model Skill.Model)
type alias Msg   = Pair.Msg   (Named.Msg   InputCounter.Msg  ) (List.Msg   Skill.Msg  )

init : String -> List String -> Model
init name skills = Pair.init (Named.init name InputCounter.init) (List.map Skill.init skills)


domainUpdate : Int -> Model -> Model
domainUpdate proficiency (attr, skills) =
  let skills1 = skills |> List.map (Skill.domain proficiency attr.raw)
  in (attr, skills1)

update : Int -> Update Model Msg
update proficiency =
  Update.compose
    [ \_ m -> (domainUpdate proficiency m, Cmd.none)
    , \msg (c, ss) ->
      Pair.Update.update
        (Named.update InputCounter.update)
        (List.Update.update (Skill.update proficiency c.raw))
        msg
        (c, ss)
    ]

view : Bool -> View Model Msg
view editable m = Html.div []
  [ Pair.View.view View.vcat (Named.view (InputCounter.view editable)) (List.View.view (foldr View.vcat (text "")) (Skill.view editable)) m
  ]

main : Program () Model Msg
main = element
  { init          = \_ -> update 2 (Right (List.Index 50 (Named.Msg (Right (Right (Named.Msg OutputCounter.None)))))) (init "Dexterity" ["Acrobatics", "Lockpicking"])
  , update        =       update 2
  , view          =       view True
  , subscriptions = \_ -> Sub.none
  }