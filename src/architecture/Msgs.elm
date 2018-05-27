module Msgs exposing (Msg, Msg(..))


type Msg
    = Iterations String
    | Angle String
    | Orientation String
    | Axiom String
    | Increment String
    | Initial Int String
    | Final Int String
    | ToggleDescription
    | ToggleCommands
