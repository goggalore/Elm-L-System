module Cases.Animation exposing (toggleAnimation)

import Msgs exposing (Msg(..))
import Models exposing (Model)


toggleAnimation : Model -> ( Model, Cmd Msg )
toggleAnimation model =
    let
        util =
            model.util
    in
        if util.animate then
            ( { model | util = { util | animate = not util.animate, timed = False } }, Cmd.none )
        else
            ( { model | util = { util | animate = not util.animate, timed = util.animate } }, Cmd.none )
