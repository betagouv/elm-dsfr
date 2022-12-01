module BetaGouv.DSFR.CallOut exposing (callout)

import Accessibility exposing (Html, div, h3, p, text)
import Html.Attributes exposing (class)


callout : String -> Html msg -> Html msg
callout title content =
    div [ class "fr-callout" ]
        [ h3 [ class "fr-callout__title" ] [ text title ]
        , p [ class "fr-callout__text" ]
            [ content ]
        ]
