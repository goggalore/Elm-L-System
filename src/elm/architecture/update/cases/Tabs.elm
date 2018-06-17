module Cases.Tabs exposing (toggleDescription, toggleCommands)

import Msgs exposing (Msg(..))
import Models exposing (Model)


toggleDescription : Model -> ( Model, Cmd Msg )
toggleDescription model =
    let
        util =
            model.util
    in
        ( { model | util = { util | description = False, commands = True } }, Cmd.none )


toggleCommands : Model -> ( Model, Cmd Msg )
toggleCommands model =
    let
        util =
            model.util
    in
        ( { model | util = { util | description = True, commands = False } }, Cmd.none )
