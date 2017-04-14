module Pages.Profile exposing (..)

import Types exposing (User, Context)


type alias Model =
    { username : String
    }


type Msg
    = NoOp


init : Context -> String -> Model
init context username =
    Model username
