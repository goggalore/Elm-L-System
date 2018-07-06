module Main exposing (..)

import Html exposing (program)
import Models exposing (Model)
import Msgs exposing (Msg)
import Update exposing (update)
import View exposing (view)
import Ports.Draw
import Presets


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    let
        preset =
            Presets.presets
                { iterations = 0
                , angle = 0
                , orientation = 0
                , amount = 1
                , axiom = ""
                , rules = []
                , util =
                    { description = False
                    , commands = True
                    , animate = False
                    , timed = True
                    , stroke = "#000000"
                    }
                }
                "Hypnotic Circle"
    in
        ( preset, Ports.Draw.draw preset )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
