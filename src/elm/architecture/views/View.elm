module View exposing (..)

import Html exposing (Html, a, button, canvas, div, footer, h1, h2, header, hr, input, label, option, section, select, small, text)
import Html.Attributes exposing (class, href, id, placeholder, style, title, type_, value)
import Html.Events exposing (onInput, onClick)
import Html.Events.Extensions exposing (onChange)
import HtmlMsg.Checkbox exposing (checkbox)
import HtmlMsg.Color exposing (color)
import HtmlMsg.Rules exposing (ruleSet)
import HtmlMsg.Tabs exposing (description, commands)
import HtmlMsg.Titles exposing (titles)
import Msgs exposing (Msg, Msg(..))
import Models exposing (Model)


view : Model -> Html Msg
view model =
    div [ id "controls" ]
        [ header [] [ h1 [] [ text "L-System Renderer" ] ]
        , div [ class "tabContent" ]
            [ div [ class "tabs" ]
                [ div [ class "tab", onClick ToggleDescription ] [ text "Description" ]
                , div [ class "tab", onClick ToggleCommands ] [ text "Commands" ]
                ]
            , description model
            , commands model
            ]
        , div [ id "presets", class "controlGroup", onChange Draw ]
            [ h2 [] [ text "Presets" ]
            , select [ onChange Preset ]
                [ option [] [ text "Hypnotic Circle" ]
                , option [] [ text "Dragon Curve" ]
                , option [] [ text "Sierpinski Triangle" ]
                , option [] [ text "Fractal Plant" ]
                , option [] [ text "Symmetrical Plant" ]
                , option [] [ text "Seaweed" ]
                ]
            ]
        , div [ id "animate", class "controlGroup", onChange Draw ]
            [ h2 [] [ text "Options" ]
            , div [ class "controlGroup" ] [ checkbox ToggleAnimation "Real Animate" model.util.animate ]
            , div [ class "controlGroup" ] [ checkbox ToggleTimed "Quick Animate" model.util.timed ]
            , div [ class "controlGroup" ] [ color Stroke "Line color" ]
            ]
        , div [ id "inputs", class "controlGroup", onInput Draw ]
            [ h2 [] [ text "Custom" ]
            , div []
                [ button [ onClick Clear ] [ text "Clear" ] ]
            , input [ placeholder "Iterations", type_ "number", onInput Iterations, title titles.iterations, value <| displayInt model.iterations ] []
            , input [ placeholder "Angle", type_ "number", onInput Angle, title titles.angle, value <| displayFloat model.angle ] []
            , input [ placeholder "Orientation", type_ "number", onInput Orientation, title titles.orientation, value <| displayFloat model.orientation ] []
            , input [ placeholder "Axiom", onInput Axiom, title titles.axiom, value model.axiom ] []
            , div [ class "ruleSet" ] (ruleSet model)
            ]
        , hr [] []
        , footer [ class "controlGroup" ] [ small [] [ text "By June Crane | ", a [ href "https://github.com/goggalore" ] [ text "Github" ] ] ]
        ]


displayInt : Int -> String
displayInt value =
    if value == 0 then
        ""
    else
        String.fromInt value


displayFloat : Float -> String 
displayFloat value =
    if value == 0 then
        ""
    else 
        String.fromFloat value