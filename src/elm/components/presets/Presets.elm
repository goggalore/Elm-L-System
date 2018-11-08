module Presets exposing (..)

import Models exposing (Model)


presets : Model -> String -> Model
presets model selection =
    let
        util =
            model.util
    in
        case selection of
            "Hypnotic Circle" ->
                { iterations = 9
                , angle = 143
                , orientation = 0
                , amount = 2
                , axiom = "A"
                , rules = [ ( "A", "A+A" ), ( "", "" ) ]
                , util = util
                }

            "Dragon Curve" ->
                { iterations = 14
                , angle = 90
                , orientation = 0
                , amount = 3
                , axiom = "Fx"
                , rules = [ ( "x", "x+yF+" ), ( "y", "-Fx-y" ), ( "", "" ) ]
                , util = util
                }

            "Sierpinski Triangle" ->
                { iterations = 7
                , angle = 120
                , orientation = 96
                , amount = 3
                , axiom = "F-G-G"
                , rules = [ ( "F", "F-G+F+G-F" ), ( "G", "GG" ), ( "", "" ) ]
                , util = util
                }

            "Fractal Plant" ->
                { iterations = 6
                , angle = 25
                , orientation = 90
                , amount = 3
                , axiom = "X"
                , rules = [ ( "X", "F+[[X]-X]-F[-FX]+X" ), ( "F", "FF" ), ( "", "" ) ]
                , util = util
                }

            "Symmetrical Plant" ->
                { iterations = 8
                , angle = 30
                , orientation = 90
                , amount = 3
                , axiom = "X"
                , rules = [ ( "X", "F[+X][-X]FX" ), ( "F", "FF" ), ( "", "" ) ]
                , util = util
                }

            "Seaweed" ->
                { iterations = 5
                , angle = 25
                , orientation = 90
                , amount = 2
                , axiom = "F"
                , rules = [ ( "F", "F[+F]F[-F]F" ), ( "", "" ) ]
                , util = util
                }

            _ ->
                { iterations = 0
                , angle = 0
                , orientation = 0
                , amount = 1
                , axiom = ""
                , rules = [ ( "", "" ) ]
                , util = util
                }
