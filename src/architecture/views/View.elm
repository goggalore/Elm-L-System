module View exposing (..)

import Html exposing (Html, a, canvas, div, footer, h1, h2, header, hr, input, label, option, section, select, small, text)
import Html.Attributes exposing (class, href, id, placeholder, style, title, type_, value)
import Html.Events exposing (onInput, onFocus, onClick)
import HtmlMsg.Rules exposing (ruleSet)
import HtmlMsg.Tabs exposing (description, commands)
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
        , div [ id "presets", class "controlGroup" ]
            [ h2 [] [ text "Presets" ]
            , select []
                [ option [] [ text "Dragon Curve" ]
                , option [] [ text "Sierpinski Triangle" ]
                ]
            ]
        , div [ id "inputs", class "controlGroup" ]
            [ h2 [] [ text "Custom" ]
            , input [ placeholder "Iterations", type_ "number", onInput Iterations ] []
            , input [ placeholder "Angle", type_ "number", onInput Angle ] []
            , input [ placeholder "Orientation", type_ "number", onInput Orientation ] []
            , input [ placeholder "Axiom", onInput Axiom ] []
            , div [ class "ruleSet" ] (ruleSet model)
            ]
        , hr [] []
        , footer [ class "controlGroup" ] [ small [] [ text "By June Crane | ", a [ href "https://github.com/goggalore" ] [ text "Github" ] ] ]
        ]