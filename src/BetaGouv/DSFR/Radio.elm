module BetaGouv.DSFR.Radio exposing (Item, radio, radioInline)

import Accessibility exposing (Html, div, fieldset, label)
import Html exposing (input)
import Html.Attributes as Attr
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
    div
        [ Attr.class "fr-form-group"
        ]
        [ fieldset
            [ Attr.class "fr-fieldset"
            , Attr.classList [ ( "fr-fieldset--inline", inline ) ]
            ]
            [ div [ Attr.class "fr-fieldset__content my-4" ] <|
                List.map (radioItem msg current) <|
                    items
            ]
        ]


radioItem : (value -> msg) -> Maybe value -> Item value msg -> Html msg
radioItem msg current { content, value, name } =
    div
        [ Attr.class "fr-radio-group"
        ]
        [ input
            [ Attr.type_ "radio"
            , Attr.id name
            , Attr.checked (current == Just value)
            , Events.onClick <| msg <| value
            ]
            []
        , label
            [ Attr.class "fr-label"
            , Attr.for name
            ]
            [ content ]
        ]
