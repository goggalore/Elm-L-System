module Models exposing (Model)


type alias Model =
    { iterations : Int
    , angle : Int
    , orientation : Int
    , amount : Int
    , axiom : String
    , rules : List ( String, String )
    }
