module Html.Events.Extensions exposing (onChange)

import Json.Decode as Json
import Html exposing (Attribute)
import Html.Events exposing (on, targetValue)


onChange : (String -> msg) -> Attribute msg
onChange tagger =
    on "change" (Json.map tagger targetValue)
