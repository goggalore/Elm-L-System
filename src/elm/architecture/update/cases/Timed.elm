module Cases.Timed exposing (toggleTimed)

import Msgs exposing (Msg(..))
import Models exposing (Model)


toggleTimed : Model -> ( Model, Cmd Msg )
toggleTimed model =
    let
        util =
            model.util
    in
        if util.timed then
            ( { model | util = { util | timed = not util.timed, animate = False } }, Cmd.none )
        else
            ( { model | util = { util | timed = not util.timed, animate = util.timed } }, Cmd.none )
