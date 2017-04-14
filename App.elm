module App exposing (..)

import Navigation exposing (Location)
import Routes exposing (Route)
import Types exposing (Context)
import Pages.Home
import Pages.Profile
import Pages.Settings
import Html exposing (..)
import Html.Attributes exposing (..)


-- TYPES


type alias Model =
    { context : Context
    , pageModel : PageModel
    }


type PageModel
    = HomePage Pages.Home.Model
    | ProfilePage Pages.Profile.Model
    | SettingsPage Pages.Settings.Model
    | NotFoundPage


type Msg
    = AppMsg ContextMsg
    | HomeMsg Pages.Home.Msg
    | ProfileMsg Pages.Profile.Msg
    | SettingsMsg Pages.Settings.Msg


type ContextMsg
    = UrlChange Location
    | SetPage Route



-- INIT


init : Location -> ( Model, Cmd Msg )
init location =
    initWithRoute (Routes.getRoute location)


initWithRoute : Route -> ( Model, Cmd Msg )
initWithRoute route =
    let
        context =
            (Context
                Nothing
                Types.Light
                route
            )
    in
        (Model
            context
            (initPage context route)
        )
            ! []


initPage : Context -> Routes.Route -> PageModel
initPage context route =
    case route of
        Routes.HomeRoute ->
            HomePage Pages.Home.init

        Routes.ProfileRoute username ->
            ProfilePage <| Pages.Profile.init context username

        Routes.SettingsRoute ->
            SettingsPage <| Pages.Settings.init context

        Routes.NotFound ->
            NotFoundPage



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        AppMsg contextMsg ->
            updateContext contextMsg model

        HomeMsg homeMsg ->
            updateHome homeMsg model

        ProfileMsg profileMsg ->
            updateProfile profileMsg model

        SettingsMsg settingsMsg ->
            updateSettings settingsMsg model


updateContext : ContextMsg -> Model -> ( Model, Cmd Msg )
updateContext contextMsg model =
    case contextMsg of
        UrlChange location ->
            init location

        SetPage route ->
            initWithRoute route


updateHome : Pages.Home.Msg -> Model -> ( Model, Cmd Msg )
updateHome homeMsg model =
    model ! []


updateProfile : Pages.Profile.Msg -> Model -> ( Model, Cmd Msg )
updateProfile profileMsg model =
    model ! []


updateSettings : Pages.Settings.Msg -> Model -> ( Model, Cmd Msg )
updateSettings settingsMsg model =
    model ! []



-- VIEW


view : Model -> Html Msg
view model =
    div [ class "app" ]
        [ viewNavbar model
        , viewPage model
        ]


viewNavbar : Model -> Html Msg
viewNavbar model =
    nav [ class "navbar" ]
        [ link "/" "Home"
        , link "/people/ryan" "Ryan"
        , link "/people/erik" "Erik"
        , link "/settings" "Settings"
        ]


link : String -> String -> Html Msg
link link_ label_ =
    a
        [ style [ ( "margin-right", "10px" ) ]
        , href ("#" ++ link_)
        ]
        [ text label_ ]


viewPage : Model -> Html Msg
viewPage model =
    case model.pageModel of
        HomePage homeModel ->
            viewHome model.context homeModel

        ProfilePage profileModel ->
            viewProfile model.context profileModel

        SettingsPage settingsModel ->
            viewSettings model.context settingsModel

        NotFoundPage ->
            viewNotFound model.context


viewHome : Context -> Pages.Home.Model -> Html Msg
viewHome context pageModel =
    div [ class "home-page" ] []


viewProfile : Context -> Pages.Profile.Model -> Html Msg
viewProfile context pageModel =
    div [ class "profile-page" ] []


viewSettings : Context -> Pages.Settings.Model -> Html Msg
viewSettings context pageModel =
    div [ class "settings-page" ] []


viewNotFound : Context -> Html Msg
viewNotFound context =
    div [ class "not-found-page" ] []



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
