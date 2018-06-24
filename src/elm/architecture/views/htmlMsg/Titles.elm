module HtmlMsg.Titles exposing (titles)


type alias Descriptor =
    { iterations : String
    , angle : String
    , orientation : String
    , axiom : String
    , rules : String
    }


titles : Descriptor
titles =
    { iterations = "Iterations: How many times the string should apply its mappings to itself"
    , angle = "Angle: How much + and - rotate by"
    , orientation = "Orientation: How much the final image should be rotated by"
    , axiom = "Axiom: The initial string which rules shall be applied to in the first proper iteration"
    , rules = "Rules: What a character should map to each iteration, i.e. 'F (initial) maps to F+G (final)'"
    }
