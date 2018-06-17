port module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)
import Cases.Rules exposing (initial, final)
import Cases.Increment exposing (increment)
import Cases.Tabs exposing (toggleDescription, toggleCommands)
import Presets exposing (presets)
import Ports.Draw


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Iterations iterations ->
            ( { model | iterations = validInt iterations }, Cmd.none )

        Angle angle ->
            ( { model | angle = validFloat angle }, Cmd.none )

        Orientation orientation ->
            ( { model | orientation = validFloat orientation }, Cmd.none )

        Axiom axiom ->
            ( { model | axiom = axiom }, Cmd.none )

        Initial index content ->
            initial model index content

        Final index content ->
            final model index content

        Increment _ ->
            increment model

        Preset selection ->
            ( presets model selection, Cmd.none )

        ToggleDescription ->
            toggleDescription model

        ToggleCommands ->
            toggleCommands model

        Draw _ ->
            ( model, Ports.Draw.draw model )


validInt : String -> Int
validInt input =
    case String.toInt input of
        Err message ->
            0

        Ok number ->
            number


validFloat : String -> Float
validFloat input =
    case String.toFloat input of
        Err message ->
            0

        Ok number ->
            number