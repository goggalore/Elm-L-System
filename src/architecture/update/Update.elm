module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model)
import Cases.Rules exposing (initial, final)
import Cases.Increment exposing (increment)
import Cases.Tabs exposing (toggleDescription, toggleCommands)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Iterations iterations ->
            ( { model | iterations = valid iterations }, Cmd.none )

        Angle angle ->
            ( { model | angle = valid angle }, Cmd.none )

        Orientation orientation ->
            ( { model | orientation = valid orientation }, Cmd.none )

        Axiom axiom ->
            ( { model | axiom = axiom }, Cmd.none )

        Initial index content ->
            initial model index content

        Final index content ->
            final model index content

        Increment _ ->
            increment model

        ToggleDescription ->
            toggleDescription model

        ToggleCommands ->
            toggleCommands model


valid : String -> Int
valid input =
    case String.toInt input of
        Err message ->
            0

        Ok number ->
            number
