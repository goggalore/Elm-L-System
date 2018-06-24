module HtmlMsg.Rules exposing (ruleSet)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (class, maxlength, placeholder, title, value)
import Html.Events exposing (onInput)
import HtmlMsg.Titles exposing (titles)
import List.Extensions exposing (getMemberWithDefault, indexedRepeat)
import Msgs exposing (Msg(..))
import Models exposing (Model)


ruleSet : Model -> List (Html Msg)
ruleSet model =
    indexedRepeat model.amount
        (\index ->
            (div [ class "rulePair", onInput Increment, title titles.rules ]
                [ input
                    [ placeholder "Initial"
                    , maxlength 1
                    , onInput (Initial (index - 1))
                    , value <| Tuple.first <| getMemberWithDefault (index - 1) ( "", "" ) model.rules
                    ]
                    []
                , input
                    [ placeholder "Final"
                    , onInput (Final (index - 1))
                    , value <| Tuple.second <| getMemberWithDefault (index - 1) ( "", "" ) model.rules
                    ]
                    []
                ]
            )
        )
