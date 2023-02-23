module Skill exposing (..)
import Data.Pair exposing (Pair)
import InputCounter
import InputFlag
import OutputCounter
import Data.Either exposing (Either)
import Update exposing (Update)
import Pair.Update
import View exposing (View)
import Pair.View
import Browser exposing (element)
import Data.Either exposing (Either(..))
import Named

type alias ICS = Named.Model InputCounter.Model
type alias ICA = Named.Msg InputCounter.Msg

type alias IFS = Named.Model InputFlag.Model
type alias IFA = Named.Msg InputFlag.Msg

type alias OCS = Named.Model OutputCounter.Model
type alias OCA = Named.Msg OutputCounter.Msg

type alias Model = Named.Model (Pair   ICS (Pair   IFS OCS))
type alias Msg   = Named.Msg   (Either ICA (Either IFA OCA))

update : Int -> Int -> Update Model Msg
update proficiency abScore =
  Update.compose
    [ \_ model -> (domain proficiency abScore model, Cmd.none)
    ,  Named.update
    <| Pair.Update.update (Named.update InputCounter.update)
    (  Pair.Update.update (Named.update InputFlag.update)
                          (Named.update OutputCounter.update)
    )
    ]

domain : Int -> Int -> Model -> Model
domain proficiency abScore model =
  let (i, (f, output)) = model.raw
  in let value = fullBonus proficiency abScore i.raw f.raw
  in
    {model | raw = (i, (f, {output | raw = value}))}

fullBonus : number -> number -> number -> Bool -> number
fullBonus proficiency abScore points isProf =
  if isProf then proficiency + points + abScore else points

view : Bool -> View Model Msg
view editable = Named.view
    <| Pair.View.view View.cat (Named.view (InputCounter.view editable))
     ( Pair.View.view View.cat (Named.view (InputFlag.view editable))
                               (Named.view OutputCounter.view)
     )

init : String -> Model
init name = Named.init name (Named.init "points" InputCounter.init , (Named.init "prof" InputFlag.init, Named.init "calculated" OutputCounter.init))

main : Program () Model Msg
main = element
  { init          = \_ -> update 2 5 (Named.Msg (Right (Right (Named.Msg OutputCounter.None)))) (init "Acrobatics")
  , update        =       update 2 5
  , view          =       view False
  , subscriptions = \_ -> Sub.none
  }