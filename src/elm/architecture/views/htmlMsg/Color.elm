module HtmlMsg.Color exposing (color)

import Html exposing (Html, label, input, text)
import Html.Attributes exposing (type_)
import Html.Events.Extensions exposing (onChange)


color : (String -> msg) -> String -> Html msg
color msg name =
    label []
        [ input [ type_ "color", onChange msg ] []
        , text name
        ]
