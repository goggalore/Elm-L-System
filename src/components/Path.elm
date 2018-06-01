module Path exposing (..)

import List.Extensions exposing (getLastMember)
import Models exposing (Model)


type alias Coordinates =
    { x : Float
    , y : Float
    , action : String
    }


commandString : Model -> String
commandString model =
    commandStringHelp model model.axiom


commandStringHelp : Model -> String -> String
commandStringHelp model result =
    if model.iterations <= 0 then
        result
    else
        let
            newResult =
                String.toList result
                    |> List.map (mapCharToRule model.rules)
                    |> String.join ""
        in
            commandStringHelp { model | iterations = model.iterations - 1 } newResult


isRule : Char -> ( String, String ) -> Bool
isRule char rule =
    if Tuple.first rule == String.fromChar char then
        True
    else
        False


mapCharToRule : List ( String, String ) -> Char -> String
mapCharToRule ruleSet char =
    let
        lastDefined =
            List.filter
                (\tuple ->
                    if isRule char tuple then
                        True
                    else
                        False
                )
                ruleSet
                |> getLastMember
    in
        case lastDefined of
            Just mapping ->
                Tuple.second mapping

            Nothing ->
                String.fromChar char
