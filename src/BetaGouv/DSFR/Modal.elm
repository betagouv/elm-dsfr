module BetaGouv.DSFR.Modal exposing (Config, view)

import Accessibility exposing (Html, button, div, h1, span, text)
import BetaGouv.DSFR.Button
import Html exposing (node)
import Html.Attributes as Attr


type alias Config msg =
    { id : String
    , label : String
    , openMsg : msg
    , closeMsg : msg
    , title : Html msg
    }


view : Config msg -> Html msg -> ( Html msg, Html msg )
view config content =
    let
        modalId =
            "modal-" ++ config.id

        modalTitleId =
            modalId ++ "-title"

        but =
            DSFR.Button.new { onClick = Just config.openMsg, label = config.label }
                |> DSFR.Button.withAttrs
                    [ Attr.attribute "aria-controls" modalId
                    ]
                |> DSFR.Button.view

        modal =
            node "dialog"
                [ Attr.attribute "aria-labelledby" <| modalTitleId
                , Attr.attribute "role" "dialog"
                , Attr.id config.id
                , Attr.class "fr-modal"
                ]
                [ div
                    [ Attr.class "fr-container fr-container--fluid fr-container-md"
                    ]
                    [ div
                        [ Attr.class "fr-grid-row fr-grid-row--center"
                        ]
                        [ div
                            [ Attr.class "fr-col-12 fr-col-md-8 fr-col-lg-6"
                            ]
                            [ div
                                [ Attr.class "fr-modal__body"
                                ]
                                [ div
                                    [ Attr.class "fr-modal__header"
                                    ]
                                    [ button
                                        [ Attr.class "fr-link--close fr-link"
                                        , Attr.title "Fermer la fenêtre modale"
                                        , Attr.attribute "aria-controls" modalId
                                        ]
                                        [ text "Fermer" ]
                                    ]
                                , div
                                    [ Attr.class "fr-modal__content"
                                    ]
                                    [ h1
                                        [ Attr.id modalTitleId
                                        , Attr.class "fr-modal__title"
                                        ]
                                        [ span
                                            [ Attr.class "fr-fi-arrow-right-line fr-fi--lg"
                                            , Attr.attribute "aria-hidden" "true"
                                            ]
                                            []
                                        , config.title
                                        ]
                                    , content
                                    ]
                                ]
                            ]
                        ]
                    ]
                ]
    in
    ( modal, but )
