module Cases.Animation exposing (toggleAnimation)

import Msgs exposing (Msg(..))
import Models exposing (Model)


toggleAnimation : Model -> ( Model, Cmd Msg )
toggleAnimation model =
    let
        util =
            model.util
    in
        ( { model | util = { util | animate = not util.animate } }, Cmd.none )
