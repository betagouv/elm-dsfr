module BetaGouv.DSFR.Radio exposing (Item, radio, radioInline)

import Accessibility exposing (Html, div, fieldset, label)
import BetaGouv.DSFR.Grid
import Html exposing (input)
import Html.Attributes as Attr exposing (class)
import Html.Events as Events


type alias Item value msg =
    { content : Html msg
    , name : String
    , value : value
    }


radio : List (Item value msg) -> (value -> msg) -> Maybe value -> Html msg
radio =
    radioCommon False


radioInline : List (Item value msg) -> (value -> msg) -> Maybe value -> Html msg
radioInline =
    radioCommon True


radioCommon : Bool -> List (Item value msg) -> (value -> msg) -> Maybe value -> Html msg
radioCommon inline items msg current =
    let
        inlineAttrs =
            if inline then
                [ class "fr-fieldset--inline", DSFR.Grid.col ]

            else
                []
    in
    div
        [ class "fr-form-group", DSFR.Grid.col
        ]
        [ fieldset
            (class "fr-fieldset"
                :: inlineAttrs
            )
            [ div [ class "fr-fieldset__content my-4", DSFR.Grid.col ] <|
                List.map (radioItem msg current) <|
                    items
            ]
        ]


radioItem : (value -> msg) -> Maybe value -> Item value msg -> Html msg
radioItem msg current { content, value, name } =
    div
        [ class "fr-radio-group"
        , DSFR.Grid.col
        ]
        [ input
            [ Attr.type_ "radio"
            , Attr.id name
            , Attr.checked (current == Just value)
            , Events.onClick <| msg <| value
            ]
            []
        , label
            [ class "fr-label"
            , Attr.for name
            ]
            [ content ]
        ]
