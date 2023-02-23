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

{-
  Counter with a label, model and message.
-}
type alias ICS = Named.Model InputCounter.Model
type alias ICA = Named.Msg InputCounter.Msg

{-
  Boolean flag with a label, model and message.
-}
type alias IFS = Named.Model InputFlag.Model
type alias IFA = Named.Msg InputFlag.Msg

{-
  Readonly counter, model and message.
-}
type alias OCS = Named.Model OutputCounter.Model
type alias OCA = Named.Msg OutputCounter.Msg

{-
  Model and message for "Skill" component, has "Points" and "Is proficient" inputs.
  Outputs overall skill value.
-}
type alias Model = Named.Model (Pair   ICS (Pair   IFS OCS))
type alias Msg   = Named.Msg   (Either ICA (Either IFA OCA))

{-
  Update the component, using external values of overall player prof level
  and the linked ability score.
-}
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

{-
  Make cached overall skill score correct.

  _Why do I need it, when I can calculate it in view-function?_
-}
domain : Int -> Int -> Model -> Model
domain proficiency abScore model =
  let (i, (f, output)) = model.raw
  in let value = fullBonus proficiency abScore i.raw f.raw
  in
    {model | raw = (i, (f, {output | raw = value}))}

{-
  Calculate overall skill score.
-}
fullBonus : number -> number -> number -> Bool -> number
fullBonus proficiency abScore points isProf =
  if isProf then proficiency + points + abScore else points

{-
  Make an HTML from the model.
-}
view : Bool -> View Model Msg
view editable = Named.view
  <| Pair.View.view View.cat (Named.view (InputCounter.view editable))
  (  Pair.View.view View.cat (Named.view (InputFlag.view editable))
                             (Named.view OutputCounter.view)
  )

{-
  Zero-initialise the model.
-}
init : String -> Model
init name = Named.init name (Named.init "points" InputCounter.init, (Named.init "prof" InputFlag.init, Named.init "calculated" OutputCounter.init))

{-
  Test the component in isolation.
-}
main : Program () Model Msg
main = element
  { init          = \_ -> update 2 5 (Named.Msg (Right (Right (Named.Msg OutputCounter.None)))) (init "Acrobatics")
  , update        =       update 2 5
  , view          =       view False
  , subscriptions = \_ -> Sub.none
  }