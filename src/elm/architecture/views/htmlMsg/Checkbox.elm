module HtmlMsg.Checkbox exposing (checkbox)

import Html exposing (Html, label, input, text)
import Html.Attributes exposing (checked, type_)
import Html.Events exposing (onClick)


checkbox : msg -> String -> Bool -> Html msg
checkbox msg name bool =
    label []
        [ input [ type_ "checkbox", checked bool, onClick msg ] []
        , text name
        ]
