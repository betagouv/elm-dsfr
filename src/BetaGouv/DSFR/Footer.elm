module BetaGouv.DSFR.Footer exposing (..)

import Accessibility exposing (Html, a, button, div, h1, li, p, text, ul)
import BetaGouv.DSFR.Display
import Html exposing (node)
import Html.Attributes as Attr exposing (class)


type ConformiteAccessibilite
    = NonConforme
    | PartiellementConforme
    | Conforme


accessibiliteConforme : ConformiteAccessibilite
accessibiliteConforme =
    Conforme


accessibilitePartiellementConforme : ConformiteAccessibilite
accessibilitePartiellementConforme =
    PartiellementConforme


accessibiliteNonConforme : ConformiteAccessibilite
accessibiliteNonConforme =
    NonConforme


conformiteAccessibiliteToString : ConformiteAccessibilite -> String
conformiteAccessibiliteToString conformiteAccessibilite =
    case conformiteAccessibilite of
        NonConforme ->
            "non conforme"

        PartiellementConforme ->
            "partiellement conforme"

        Conforme ->
            "conforme"


avecPartenaires :
    { homeLink : String
    , logoText : List (Html msg)
    , blocLiens : Html msg
    , avantBlocLiens : Html msg
    }
    -> Html msg
    -> Html msg
avecPartenaires { homeLink, logoText, blocLiens, avantBlocLiens } partenaires =
    Accessibility.footer
        [ class "fr-footer fr-card--white"
        , Attr.attribute "role" "contentinfo"
        , Attr.id "footer"
        ]
        [ node "dialog"
            [ Attr.id "fr-theme-modal"
            , class "fr-modal"
            , Attr.attribute "role" "dialog"
            , Attr.attribute "aria-labelledby" "fr-theme-modal-title"
            ]
            [ div
                [ class "fr-container fr-container--fluid fr-container-md"
                ]
                [ div
                    [ class "fr-grid-row fr-grid-row--center"
                    ]
                    [ div
                        [ class "fr-col-12 fr-col-md-6 fr-col-lg-4"
                        ]
                        [ div
                            [ class "fr-modal__body"
                            ]
                            [ div
                                [ class "fr-modal__header"
                                ]
                                [ button
                                    [ class "fr-link--close fr-link"
                                    , Attr.attribute "aria-controls" "fr-theme-modal"
                                    ]
                                    [ text "Fermer" ]
                                ]
                            , div
                                [ class "fr-modal__content"
                                ]
                                [ h1
                                    [ Attr.id "fr-theme-modal-title"
                                    , class "fr-modal__title"
                                    ]
                                    [ text "Paramètres d’affichage" ]
                                , div
                                    [ Attr.id "fr-display"
                                    , class "fr-form-group fr-display"
                                    ]
                                    [ div
                                        [ class "fr-form-group"
                                        ]
                                        [ BetaGouv.DSFR.Display.selecteur ]
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
            ]
        , div
            [ class "fr-container"
            ]
            [ div
                [ class "fr-footer__body"
                ]
                [ div
                    [ class "fr-footer__brand fr-enlarge-link"
                    ]
                    [ a
                        [ Attr.href homeLink
                        , Attr.title "Retour à l’accueil"
                        ]
                        [ p
                            [ class "fr-logo"
                            , Attr.title "république française"
                            ]
                            logoText
                        ]
                    ]
                , div
                    [ class "fr-footer__content"
                    ]
                    [ p
                        [ class "fr-footer__content-desc"
                        ]
                        []
                    , ul
                        [ class "fr-footer__content-list"
                        ]
                        [ li
                            [ class "fr-footer__content-item"
                            ]
                            [ a
                                [ class "fr-footer__content-link"
                                , Attr.href "https://legifrance.gouv.fr"
                                ]
                                [ text "legifrance.gouv.fr" ]
                            ]
                        , li
                            [ class "fr-footer__content-item"
                            ]
                            [ a
                                [ class "fr-footer__content-link"
                                , Attr.href "https://gouvernement.fr"
                                ]
                                [ text "gouvernement.fr" ]
                            ]
                        , li
                            [ class "fr-footer__content-item"
                            ]
                            [ a
                                [ class "fr-footer__content-link"
                                , Attr.href "https://service-public.fr"
                                ]
                                [ text "service-public.fr" ]
                            ]
                        , li
                            [ class "fr-footer__content-item"
                            ]
                            [ a
                                [ class "fr-footer__content-link"
                                , Attr.href "https://data.gouv.fr"
                                ]
                                [ text "data.gouv.fr" ]
                            ]
                        ]
                    ]
                ]
            , partenaires
            , div
                [ class "fr-footer__bottom"
                ]
                [ avantBlocLiens
                , blocLiens
                , div
                    [ class "fr-footer__bottom-copy"
                    ]
                    [ p []
                        [ text "Sauf mention contraire, tous les contenus de ce site sont sous "
                        , a
                            [ Attr.href "https://github.com/etalab/licence-ouverte/blob/master/LO.md"
                            , Attr.target "_blank"
                            ]
                            [ text "licence etalab-2.0" ]
                        ]
                    ]
                ]
            ]
        ]
