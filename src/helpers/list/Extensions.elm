module List.Extensions exposing (..)


indexedRepeat : Int -> (Int -> a) -> List a
indexedRepeat n func =
    indexedRepeatHelp [] n func


indexedRepeatHelp : List a -> Int -> (Int -> a) -> List a
indexedRepeatHelp result n func =
    if n <= 0 then
        result
    else
        indexedRepeatHelp ((func n) :: result) (n - 1) func


indexOf : Int -> a -> List a -> Int
indexOf fromIndex elem list =
    indexOfHelp fromIndex elem list


indexOfHelp : Int -> a -> List a -> Int
indexOfHelp n elem list =
    if n > List.length list - 1 then
        -1
    else
        let
            member =
                getMember n list
        in
            case member of
                Just value ->
                    if value == elem then
                        n
                    else
                        indexOfHelp (n + 1) elem list

                -- for prototyping, shouldn't ever get this as a return value
                Nothing ->
                    -2



-- Adds a member to the given list at the nth (indexed by 0) position


addMember : Int -> a -> List a -> List a
addMember n elem list =
    List.append (List.take n list) (elem :: (List.drop n list))



-- gets the nth (indexed by 0) member of a list


getMember : Int -> List a -> Maybe a
getMember n list =
    if n < 0 then
        Nothing
    else
        List.drop n list
            |> List.head


getLastMember : List a -> Maybe a
getLastMember list =
    getMember (List.length list - 1) list



-- gets the nth (indexed by 0) member of a list, or returns some default member


getMemberWithDefault : Int -> a -> List a -> a
getMemberWithDefault n default list =
    let
        member =
            getMember n list
    in
        case member of
            Just value ->
                value

            Nothing ->
                default



-- removes the nth (indexed by 0) member of a list


removeMember : Int -> List a -> List a
removeMember n list =
    List.append (List.take n list) (List.drop (n + 1) list)
