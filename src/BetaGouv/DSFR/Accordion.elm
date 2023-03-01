module BetaGouv.DSFR.Accordion exposing (group, single)

{-| Accordéons

@docs group, single

-}

import Accessibility exposing (Html, button, div, p, section)
import Accessibility.Aria exposing (controls, expanded)
import Html.Attributes as Attr exposing (class, classList)
import Html.Events as Events
import Html.Extra exposing (static)


type alias Accordion msg =
    { id : String
    , open : Bool
    , onClick : msg
    , header : Html Never
    , content : Html msg
    }


type alias AccordionGroup msg data =
    { id : String
    , accordions : List data
    , opened : Maybe data
    , onClick : data -> msg
    , toId : data -> String
    , toHeader : data -> Html Never
    , toContent : data -> Html msg
    }


{-| Crée un accordéon

    Accordion.single
        { id = "filter-group-localisation"
        , open = False
        , onClick = Open
        , header = text "Header"
        , content = []
        }

-}
single : Accordion msg -> Html msg
single { id, open, onClick, header, content } =
    section [ class "fr-accordion" ]
        [ p [ class "fr-accordion__title" ]
            [ button
                [ class "fr-accordion__btn"
                , controls [ id ]
                , expanded open
                , Events.onClick onClick
                ]
                [ static header ]
            ]
        , div [ class "fr-collapse", Attr.id id ] [ content ]
        ]


{-| Crée un groupe d'accordéons
-}
group : AccordionGroup msg data -> Html msg
group { id, accordions, opened, onClick, toId, toHeader, toContent } =
    div [ class "fr-accordions-group", Attr.id id ] <|
        List.map
            (\acc ->
                single
                    { id = toId acc
                    , open = Maybe.map toId opened == Just (toId acc)
                    , onClick = onClick acc
                    , header = toHeader acc
                    , content = toContent acc
                    }
            )
        <|
            accordions
