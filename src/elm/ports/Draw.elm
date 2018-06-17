port module Ports.Draw exposing (draw)

import Models exposing (Model)


-- type alias Data =
--     { commands : String
--     , angle : Float
--     , orientation : Float
--     , animate : Bool
--     }


port draw : Model -> Cmd msg



-- data : Model -> Data
-- data model =
--     { commands = getCommandString model
--     , angle = model.angle
--     , orientation = model.orientation
--     , animate = False
--     }
