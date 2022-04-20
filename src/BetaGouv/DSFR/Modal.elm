module BetaGouv.DSFR.Modal exposing (Config, view)

import Accessibility exposing (Html, button, div, h1, li, text, ul)
import Accessibility.Aria exposing (controls, labelledBy)
import Accessibility.Role exposing (dialog)
import BetaGouv.DSFR.Button
import BetaGouv.DSFR.Icon
import Html exposing (node)
import Html.Attributes as Attr exposing (class)
import Html.Extra exposing (viewMaybe)


type alias Config msg =
    { id : String
    , label : String
    , openMsg : msg
    , closeMsg : msg
    , title : Html msg
    , opened : Bool
    }


view : Config msg -> Html msg -> Maybe (Html msg) -> ( Html msg, Html msg )
view config content footer =
    let
        modalId =
            "modal-" ++ config.id

        modalTitleId =
            modalId ++ "-title"

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
                , Attr.id config.id
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
                            [ class "fr-col-12 fr-col-md-8 fr-col-lg-6"
                            ]
                            [ div
                                [ class "fr-modal__body"
                                ]
                                [ div
                                    [ class "fr-modal__header flex flex-row justify-end"
                                    ]
                                    [ DSFR.Button.new
                                        { label = ""
                                        , onClick = Just config.closeMsg
                                        }
                                        |> DSFR.Button.withAttrs
                                            [ Attr.title "Fermer la fenêtre modale"
                                            , Attr.attribute "aria-controls" modalId
                                            ]
                                        |> DSFR.Button.rightIcon DSFR.Icon.closeLine
                                        |> DSFR.Button.tertiaryNoOutline
                                        |> DSFR.Button.small
                                        |> DSFR.Button.view
                                    ]
                                , div
                                    [ class "fr-modal__content"
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
