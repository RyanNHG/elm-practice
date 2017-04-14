module Pages.Settings exposing (..)

import Types exposing (Theme, Context)


type alias Model =
    { theme : Theme
    }


type Msg
    = NoOp


init : Context -> Model
init context =
    Model context.theme
