module Pages.Home exposing (..)


type alias Model =
    { title : String
    , subtitle : String
    }


type Msg
    = NoOp


init : Model
init =
    Model "Sup" "We cool"
