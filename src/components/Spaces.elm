module Spaces exposing (..)

import Regex exposing (replace, regex, HowMany(All))
import Models exposing (Model)


removeSpaces : String -> String
removeSpaces input =
    replace All (regex "\\s") (\_ -> "") input


removeSpacesFromListWithTuples : List ( String, String ) -> List ( String, String )
removeSpacesFromListWithTuples list =
    List.map
        (\tuple ->
            let
                one =
                    Tuple.first tuple |> removeSpaces

                two =
                    Tuple.second tuple |> removeSpaces
            in
                ( one, two )
        )
        list


removeSpacesFromModel : Model -> Model
removeSpacesFromModel model =
    { model | axiom = removeSpaces model.axiom, rules = removeSpacesFromListWithTuples model.rules }
