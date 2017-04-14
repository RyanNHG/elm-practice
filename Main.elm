module Main exposing (..)

import Navigation exposing (program)
import App


main : Program Never App.Model App.Msg
main =
    program
        navigationMsg
        { init = App.init
        , update = App.update
        , view = App.view
        , subscriptions = App.subscriptions
        }


navigationMsg : Navigation.Location -> App.Msg
navigationMsg location =
    (App.AppMsg <| App.UrlChange location)
