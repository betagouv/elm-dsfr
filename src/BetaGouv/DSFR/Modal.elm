module BetaGouv.DSFR.Modal exposing (Config, view)

import Accessibility exposing (Html, div, h1)
import Accessibility.Aria exposing (controls, labelledBy)
import Accessibility.Role exposing (dialog)
import BetaGouv.DSFR.Button
import Html exposing (node)
import Html.Attributes as Attr exposing (class)
import Html.Extra exposing (nothing, viewMaybe)


type alias Config msg =
    { id : String
    , label : String
    , openMsg : msg
    , closeMsg : Maybe msg
    , title : Html msg
    , opened : Bool
    }


view : Config msg -> Html msg -> Maybe (Html msg) -> ( Html msg, Html msg )
view config content footer =
    let
        modalId =
            "modal-" ++ config.id

        modalTitleId =
            modalId ++ "--title"

        but =
            DSFR.Button.new
                { onClick = Just config.openMsg
                , label = config.label
                }
                |> DSFR.Button.withAttrs [ controls [ modalId ] ]
                |> DSFR.Button.view

        modal =
            node "dialog"
                [ dialog
                , labelledBy modalTitleId
                , Attr.id modalId
                , Attr.classList
                    [ ( "fr-modal", True )
                    , ( "fr-modal--opened", config.opened )
                    ]
                ]
                [ div
                    [ class "fr-container fr-container--fluid fr-container-md"
                    ]
                    [ div
                        [ class "fr-grid-row fr-grid-row--center"
                        ]
                        [ div
                            [ class "fr-col-12 fr-col-md-11 fr-col-lg-10 fr-col-xl-9"
                            ]
                            [ div
                                [ class "fr-modal__body"
                                , Attr.id <| modalId ++ "--body"
                                ]
                                [ div
                                    [ class "fr-modal__header"
                                    ]
                                    [ case config.closeMsg of
                                        Nothing ->
                                            nothing

                                        Just closeMsg ->
                                            DSFR.Button.new
                                                { label = "Fermer"
                                                , onClick = Just closeMsg
                                                }
                                                |> DSFR.Button.withAttrs
                                                    [ Attr.title "Fermer la fenêtre modale"
                                                    , Attr.attribute "aria-controls" modalId
                                                    ]
                                                |> DSFR.Button.close
                                                |> DSFR.Button.view
                                    ]
                                , div
                                    [ class "fr-modal__content"
                                    , Attr.classList
                                        [ ( "!mb-0", footer == Nothing )
                                        ]
                                    ]
                                    [ h1
                                        [ Attr.id modalTitleId
                                        , class "fr-modal__title"
                                        ]
                                        [ config.title
                                        ]
                                    , content
                                    ]
                                , footer
                                    |> viewMaybe (List.singleton >> div [ class "fr-modal__footer" ])
                                ]
                            ]
                        ]
                    ]
                ]
    in
    ( modal, but )
