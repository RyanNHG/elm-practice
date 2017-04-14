module Routes exposing (..)

import Navigation exposing (Location)
import UrlParser as Url exposing (top, map, oneOf, Parser, (</>), s, string)


type Route
    = HomeRoute
    | ProfileRoute String
    | SettingsRoute
    | NotFound


useHashes : Bool
useHashes =
    True


getMaybeRoute : Location -> Maybe Route
getMaybeRoute location =
    if useHashes then
        Url.parseHash route location
    else
        Url.parsePath route location


getRoute : Location -> Route
getRoute location =
    case getMaybeRoute location of
        Just route ->
            route

        Nothing ->
            NotFound


route : Parser (Route -> Route) Route
route =
    oneOf
        [ map HomeRoute top
        , map ProfileRoute (s "people" </> string)
        , map SettingsRoute (s "settings")
        ]
