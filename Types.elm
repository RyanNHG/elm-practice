module Types exposing (..)

import Routes exposing (Route)
import Date exposing (Date)


type alias Context =
    { user : Maybe User
    , theme : Theme
    , route : Route
    }


type alias User =
    { username : String
    , posts : List Post
    , followers : List Follower
    }


type Follower
    = Follower User


type alias Post =
    { text : String
    , date : Date
    }


type Theme
    = Light
    | Dark
