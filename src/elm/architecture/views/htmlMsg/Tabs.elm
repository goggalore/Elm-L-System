module HtmlMsg.Tabs exposing (description, commands)

import Html exposing (Html, dl, p, section, text)
import Html.Attributes exposing (class, hidden)
import Models exposing (Model)
import Msgs exposing (Msg(..))


description : Model -> Html Msg
description model =
    let
        util =
            model.util
    in
        section [ class "controlGroup", hidden util.description ]
            [ p []
                [ text "An L-System (Lindenmayer system) is a type of formal grammar and a parallel rewriting system. It consists of a set of symbols and a ruleset with rules that define how to map each symbol into other symbols. An initial axiom string (of symbols) is given from which to begin construction. Each iteration of applying the mappings results in a new, often more complex, string." ]
            , p []
                [ text "Associating each symbol with a command (i.e. draw forward, rotate by 60 degrees) results in geometric and recursive images as seen in this visual renderer." ]
            , p []
                [ text "Click the 'commands' tab to see how symbols are denoted in this L-System renderer." ]
            ]


commands : Model -> Html Msg
commands model =
    let
        util =
            model.util
    in
        section [ class "controlGroup", hidden util.commands ]
            [ dl [] [ text "+  means rotate counterclockwise by angle" ]
            , dl [] [ text "-  means rotate clockwise by angle" ]
            , dl [] [ text "[  means save current position and orientation" ]
            , dl [] [ text "]  means return to the most recently saved position and orientation" ]
            , dl [] [ text "Any uppercase character: Draw forward" ]
            , dl [] [ text "Any lowercase character: Denotes a constant, and is used to control the evolution of the curve." ]
            ]
