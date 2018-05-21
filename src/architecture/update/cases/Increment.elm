module Cases.Increment exposing (increment)

import List.Extensions exposing (addMember, removeMember, indexOf)
import Models exposing (Model)
import Msgs exposing (Msg(..))


increment : Model -> ( Model, Cmd Msg )
increment model =
    let
        emptyIndex =
            indexOf 0 ( "", "" ) model.rules

        lastEntryEmpty =
            indexOf (model.amount - 1) ( "", "" ) model.rules > -1
    in
        if emptyIndex == -1 && not (List.isEmpty model.rules) then
            ( { model | amount = model.amount + 1, rules = (addMember model.amount ( "", "" ) model.rules) }, Cmd.none )
        else if emptyIndex > -1 && emptyIndex < model.amount - 1 && lastEntryEmpty then
            ( { model | amount = model.amount - 1, rules = (removeMember (model.amount - 1) model.rules) }, Cmd.none )
        else
            ( model, Cmd.none )
