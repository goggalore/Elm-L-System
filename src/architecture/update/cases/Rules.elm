module Cases.Rules exposing (initial, final)

import List.Extensions exposing (addMember, removeMember, getMember)
import Msgs exposing (Msg(..))
import Models exposing (Model)


initial : Model -> Int -> String -> ( Model, Cmd Msg )
initial model index content =
    let
        ( _, oldContent ) =
            (Maybe.withDefault ( "", "" ) (getMember index model.rules))
    in
        ( { model | rules = (addMember index ( content, oldContent ) (removeMember index model.rules)) }, Cmd.none )


final : Model -> Int -> String -> ( Model, Cmd Msg )
final model index content =
    let
        ( oldContent, _ ) =
            (Maybe.withDefault ( "", "" ) (getMember index model.rules))
    in
        ( { model | rules = (addMember index ( oldContent, content ) (removeMember index model.rules)) }, Cmd.none )
