module HtmlMsg.Rules exposing (ruleSet)

import Html exposing (Html, div, input)
import Html.Attributes exposing (class, maxlength, placeholder, title)
import Html.Events exposing (onInput)
import List.Extensions exposing (indexedRepeat)
import Msgs exposing (Msg(..))
import Models exposing (Model)


ruleSet : Model -> List (Html Msg)
ruleSet model =
    indexedRepeat model.amount
        (\index ->
            (div [ class "rulePair", onInput Increment, title "What a character should map to each iteration, i.e. 'F (initial) maps to F+G (final)'" ]
                [ input [ placeholder "Initial", maxlength 1, onInput (Initial (index - 1)) ] []
                , input [ placeholder "Final", onInput (Final (index - 1)) ] []
                ]
            )
        )
