module Msgs exposing (Msg(..))


type Msg
    = Iterations String
    | Angle String
    | Orientation String
    | Axiom String
    | Increment String
    | Initial Int String
    | Final Int String
    | Preset String
    | Stroke String
    | Clear
    | ToggleDescription
    | ToggleCommands
    | ToggleAnimation
    | ToggleTimed
    | Draw String
