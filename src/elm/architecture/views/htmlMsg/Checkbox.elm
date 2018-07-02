module HtmlMsg.Checkbox exposing (checkbox)

import Html exposing (Html, label, input, text)
import Html.Attributes exposing (checked, type_)
import Html.Events exposing (onClick)


checkbox : msg -> String -> Html msg
checkbox msg name =
    label []
        [ input [ type_ "checkbox", checked True, onClick msg ] []
        , text name
        ]
