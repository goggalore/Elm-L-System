module View exposing (..)

import Html exposing (Html, div, label, input, text)
import Html.Attributes exposing (class, id, maxlength, placeholder, style, type_, value)
import Html.Events exposing (onInput, onFocus, onClick)
import List.Extensions exposing (indexedRepeat)
import Msgs exposing (Msg, Msg(..))
import Models exposing (Model)


view : Model -> Html Msg
view model =
    div []
        [ div [ class "form" ]
            [ input [ placeholder "Iterations", type_ "number", onInput Iterations ] []
            , input [ placeholder "Angle", type_ "number", onInput Angle ] []
            , input [ placeholder "Orientation", type_ "number", onInput Orientation ] []
            , input [ placeholder "Axiom", onInput Axiom ] []
            , div [ class "rule-set" ] (ruleSet model)
            ]
        ]


ruleSet : Model -> List (Html Msg)
ruleSet model =
    indexedRepeat model.amount
        (\index ->
            (div [ onInput Increment ]
                [ input [ placeholder "Initial", maxlength 1, onInput (Initial (index - 1)) ] []
                , input [ placeholder "Final", onInput (Final (index - 1)) ] []
                ]
            )
        )
