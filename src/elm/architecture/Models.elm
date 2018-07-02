module Models exposing (Model)


type alias Model =
    { iterations : Int
    , angle : Float
    , orientation : Float
    , amount : Int
    , axiom : String
    , rules : List ( String, String )
    , util :
        { description : Bool
        , commands : Bool
        , animate : Bool
        }
    }
