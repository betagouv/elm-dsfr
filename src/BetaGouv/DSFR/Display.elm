module BetaGouv.DSFR.Display exposing (selecteur)

import Accessibility exposing (Html, div, span, text)
import Html
import Html.Attributes
import Svg
import Svg.Attributes


selecteur : Html msg
selecteur =
    Accessibility.fieldset
        [ Html.Attributes.class "fr-fieldset"
        ]
        [ Accessibility.legend
            [ Html.Attributes.class "fr-fieldset__legend fr-text--regular"
            , Html.Attributes.id "-legend"
            ]
            [ text "Choisissez un thème pour personnaliser l’apparence du site." ]
        , div
            [ Html.Attributes.class "fr-fieldset__content"
            ]
            [ div
                [ Html.Attributes.class "fr-radio-group fr-radio-rich"
                ]
                [ Html.input
                    [ Html.Attributes.value "light"
                    , Html.Attributes.type_ "radio"
                    , Html.Attributes.id "fr-radios-theme-light"
                    , Html.Attributes.name "fr-radios-theme"
                    ]
                    []
                , Accessibility.label
                    [ Html.Attributes.class "fr-label"
                    , Html.Attributes.for "fr-radios-theme-light"
                    ]
                    [ text "Thème clair" ]
                , div
                    [ Html.Attributes.class "fr-radio-rich__img"
                    ]
                    [ Svg.svg
                        [ Svg.Attributes.class "fr-artwork"
                        , Svg.Attributes.width "80px"
                        , Svg.Attributes.height "80px"
                        , Svg.Attributes.viewBox "0 0 80 80"
                        ]
                        [ Svg.use
                            [ Svg.Attributes.class "fr-artwork-decorative"
                            , Svg.Attributes.xlinkHref "/assets/light.svg#artwork-decorative"
                            ]
                            []
                        , Svg.use
                            [ Svg.Attributes.class "fr-artwork-minor"
                            , Svg.Attributes.xlinkHref "/assets/light.svg#artwork-minor"
                            ]
                            []
                        , Svg.use
                            [ Svg.Attributes.class "fr-artwork-major"
                            , Svg.Attributes.xlinkHref "/assets/light.svg#artwork-major"
                            ]
                            []
                        ]
                    ]
                ]
            , div
                [ Html.Attributes.class "fr-radio-group fr-radio-rich"
                ]
                [ Html.input
                    [ Html.Attributes.value "dark"
                    , Html.Attributes.type_ "radio"
                    , Html.Attributes.id "fr-radios-theme-dark"
                    , Html.Attributes.name "fr-radios-theme"
                    ]
                    []
                , Accessibility.label
                    [ Html.Attributes.class "fr-label"
                    , Html.Attributes.for "fr-radios-theme-dark"
                    ]
                    [ text "Thème sombre" ]
                , div
                    [ Html.Attributes.class "fr-radio-rich__img"
                    ]
                    [ Svg.svg
                        [ Svg.Attributes.class "fr-artwork"
                        , Svg.Attributes.width "80px"
                        , Svg.Attributes.height "80px"
                        , Svg.Attributes.viewBox "0 0 80 80"
                        ]
                        [ Svg.use
                            [ Svg.Attributes.class "fr-artwork-decorative"
                            , Svg.Attributes.xlinkHref "/assets/dark.svg#artwork-decorative"
                            ]
                            []
                        , Svg.use
                            [ Svg.Attributes.class "fr-artwork-minor"
                            , Svg.Attributes.xlinkHref "/assets/dark.svg#artwork-minor"
                            ]
                            []
                        , Svg.use
                            [ Svg.Attributes.class "fr-artwork-major"
                            , Svg.Attributes.xlinkHref "/assets/dark.svg#artwork-major"
                            ]
                            []
                        ]
                    ]
                ]
            , div
                [ Html.Attributes.class "fr-radio-group fr-radio-rich"
                ]
                [ Html.input
                    [ Html.Attributes.value "system"
                    , Html.Attributes.type_ "radio"
                    , Html.Attributes.id "fr-radios-theme-system"
                    , Html.Attributes.name "fr-radios-theme"
                    ]
                    []
                , Accessibility.label
                    [ Html.Attributes.class "fr-label"
                    , Html.Attributes.for "fr-radios-theme-system"
                    ]
                    [ text "Système"
                    , span
                        [ Html.Attributes.class "fr-hint-text"
                        ]
                        [ text "Utilise les paramètres système." ]
                    ]
                , div
                    [ Html.Attributes.class "fr-radio-rich__img"
                    ]
                    [ Svg.svg
                        [ Svg.Attributes.class "fr-artwork"
                        , Svg.Attributes.width "80px"
                        , Svg.Attributes.height "80px"
                        , Svg.Attributes.viewBox "0 0 80 80"
                        ]
                        [ Svg.use
                            [ Svg.Attributes.class "fr-artwork-decorative"
                            , Svg.Attributes.xlinkHref "/assets/system.svg#artwork-decorative"
                            ]
                            []
                        , Svg.use
                            [ Svg.Attributes.class "fr-artwork-minor"
                            , Svg.Attributes.xlinkHref "/assets/system.svg#artwork-minor"
                            ]
                            []
                        , Svg.use
                            [ Svg.Attributes.class "fr-artwork-major"
                            , Svg.Attributes.xlinkHref "/assets/system.svg#artwork-major"
                            ]
                            []
                        ]
                    ]
                ]
            ]
        ]
