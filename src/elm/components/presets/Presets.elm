module Presets exposing (..)

import Models exposing (Model)


presets : Model -> String -> Model
presets model selection =
    let
        util =
            model.util
    in
        case selection of
            "Dragon Curve" ->
                { iterations = 14
                , angle = 90
                , orientation = 0
                , amount = 3
                , axiom = "Fx"
                , rules = [ ( "x", "x+yF+" ), ( "y", "-Fx-y" ), ( "", "" ) ]
                , util =
                    { description = util.description
                    , commands = util.commands
                    }
                }

            "Sierpinski Triangle" ->
                { iterations = 7
                , angle = 120
                , orientation = 96
                , amount = 3
                , axiom = "F-G-G"
                , rules = [ ( "F", "F-G+F+G-F" ), ( "G", "GG" ), ( "", "" ) ]
                , util =
                    { description = util.description
                    , commands = util.commands
                    }
                }

            selection ->
                { iterations = 0
                , angle = 0
                , orientation = 0
                , amount = 1
                , axiom = ""
                , rules = [ ( "", "Something went wrong" ) ]
                , util =
                    { description = util.description
                    , commands = util.commands
                    }
                }
