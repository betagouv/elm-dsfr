module UI.Card exposing (view)

import Accessibility exposing (Html, a, div, h4, p)
import Html.Attributes as Attr exposing (class)


view : Html msg -> Html msg -> Html msg -> String -> Html msg
view title description detail href =
    div
        [ class "fr-card fr-enlarge-link w-[45%]"
        ]
        [ div
            [ class "fr-card__body"
            ]
            [ h4
                [ class "fr-card__title"
                ]
                [ a
                    [ Attr.href href
                    , class "fr-card__link"
                    ]
                    [ title ]
                ]
            , p
                [ class "fr-card__desc"
                ]
                [ description ]
            , p
                [ class "fr-card__detail"
                ]
                [ detail ]
            ]
        ]
