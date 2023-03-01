module BetaGouv.DSFR.Alert exposing
    ( alert
    , small, medium
    , error, info, success, warning
    )

{-|


# Alerte

@docs alert


# Tailles d'alerte

@docs small, medium


# Types d'alerte

@docs error, info, success, warning

-}

import Accessibility exposing (Html, button, div, p, text)
import Accessibility.Role
import Html.Attributes exposing (class)
import Html.Attributes.Extra exposing (empty)
import Html.Events as Events
import Html.Extra exposing (viewMaybe)


type AlertType
    = Success
    | Error
    | Info
    | Warning


type AlertSize
    = SM { title : Maybe String, description : String }
    | MD { title : String, description : Maybe String }


type alias AlertConfig msg =
    Maybe msg


{-| Alerte de petite taille
-}
small : { title : Maybe String, description : String } -> AlertSize
small =
    SM


{-| Alerte de taille medium
-}
medium : { title : String, description : Maybe String } -> AlertSize
medium =
    MD


{-| Crée une alerte

    Alert.small { title = Just "Titre", description = "Description" }
        |> Alert.alert (Just Close) Alert.error

-}
alert : AlertConfig msg -> AlertType -> AlertSize -> Html msg
alert closeMsg type_ size =
    let
        ( sizeClass, title, description ) =
            case size of
                SM sm ->
                    ( class "fr-alert--sm", sm.title, Just sm.description )

                MD md ->
                    ( empty, Just md.title, md.description )

        alertClass =
            case type_ of
                Error ->
                    "error"

                Success ->
                    "success"

                Info ->
                    "info"

                Warning ->
                    "warning"
    in
    div
        [ class <| "fr-alert fr-alert--" ++ alertClass
        , sizeClass
        , Accessibility.Role.alert
        ]
        [ viewMaybe
            (\t ->
                p [ class "fr-alert__title" ]
                    [ text t ]
            )
            title
        , viewMaybe
            (\d ->
                p []
                    [ text d ]
            )
            description
        , viewMaybe
            (\close ->
                button
                    [ class "fr-btn--close fr-btn"
                    , Events.onClick close
                    ]
                    [ text "Masquer le message" ]
            )
            closeMsg
        ]


{-| Une alerte de type erreur
-}
error : AlertType
error =
    Error


{-| Une alerte de type succès
-}
success : AlertType
success =
    Success


{-| Une alerte de type information
-}
info : AlertType
info =
    Info


{-| Une alerte de type attention
-}
warning : AlertType
warning =
    Warning
