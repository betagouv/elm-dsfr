module BetaGouv.DSFR.Alert exposing (alert, error, info, success, warning)

import Accessibility as Html
import Html.Attributes as Attr


type AlertType
    = Success
    | Error
    | Info
    | Warning


alert type_ { title, description } =
    let
        class =
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
    Html.div
        [ Attr.class <| "fr-alert fr-alert--" ++ class
        ]
        [ Html.p
            [ Attr.class "fr-alert__title"
            ]
            [ Html.text title ]
        , Html.p []
            [ Html.text description ]
        ]


error : { a | title : String, description : String } -> Html.Html msg
error =
    alert Error


success : { a | title : String, description : String } -> Html.Html msg
success =
    alert Success


info : { a | title : String, description : String } -> Html.Html msg
info =
    alert Info


warning : { a | title : String, description : String } -> Html.Html msg
warning =
    alert Warning
