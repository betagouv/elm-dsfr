module BetaGouv.DSFR.Pagination exposing (..)

import Accessibility exposing (Attribute, Html, li, nav, text, ul)
import Accessibility.Aria
import BetaGouv.DSFR.Icons
import BetaGouv.DSFR.Icons.System
import BetaGouv.DSFR.Typography
import Html.Attributes as Attr exposing (class)
import Html.Attributes.Extra exposing (empty)
import Html.Extra exposing (nothing)


view : Int -> Int -> (Int -> String) -> Html msg
view current total toHref =
    let
        list =
            if total > 7 then
                let
                    {-
                       Règles de pagination :
                       - si on a moins de 7 pages, on montre tout
                           < 1 2 3 4 5 6 7 >
                       - si on a plus de 7 pages, on montre au max 9 boutons :
                           - on montre toujours la première page
                           - on montre toujours la page actuelle
                           - on montre toujours la dernière page
                           - on montre toujours 1 page avant et après l'actuelle
                           - on montre une troncature avant l'actuelle si elle ne "rejoint" pas assez vite le début
                           - on montre une troncature après l'actuelle si elle ne "rejoint" pas assez vite la fin
                           - concrètement, ça donne ça :
                           <  _1_  2   3   4   5  ...  9   >
                           <   1  _2_  3   4   5  ...  9   >
                           <   1   2  _3_  4   5  ...  9   >
                           <   1   2   3  _4_  5  ...  9   >
                           <   1  ...  4  _5_  6  ...  9   >
                           <   1  ...  5  _6_  7   8   9   >
                           <   1  ...  5   6  _7_  8   9   >
                           <   1  ...  5   6   7  _8_  9   >
                    -}
                    l =
                        if current < 1 + 4 then
                            List.reverse <|
                                PageNumber total
                                    :: Ellipsis
                                    :: List.reverse (List.map PageNumber <| List.range 1 <| 1 + 4)

                        else if current > total - 4 then
                            PageNumber 1
                                :: Ellipsis
                                :: (List.map PageNumber <| List.range (total - 4) <| total)

                        else
                            [ PageNumber 1
                            , Ellipsis
                            , PageNumber (current - 1)
                            , PageNumber current
                            , PageNumber (current + 1)
                            , Ellipsis
                            , PageNumber total
                            ]
                in
                previousPage toHref current
                    :: List.map (viewDisplayPage toHref current) l
                    ++ [ nextPage total toHref current ]

            else
                previousPage toHref current
                    :: (List.map (shownPage toHref current) <| List.range 1 total)
                    ++ [ nextPage total toHref current ]
    in
    nav
        [ Attr.attribute "role" "navigation"
        , class "fr-pagination"
        , Attr.attribute "aria-label" "Pagination"
        ]
        [ ul [ class "fr-pagination__list" ] <|
            list
        ]


type DisplayPage
    = Ellipsis
    | PageNumber Int


viewDisplayPage : (Int -> String) -> Int -> DisplayPage -> Html msg
viewDisplayPage toHref current dp =
    case dp of
        Ellipsis ->
            truncatedPage

        PageNumber page ->
            shownPage toHref current page


firstPage : (number -> String) -> number -> Html msg
firstPage toHref current =
    toLink [ class "fr-pagination__link--first", Attr.title "Première page" ] (current == 1) False (toHref 1) nothing


previousPage : (number -> String) -> number -> Html msg
previousPage toHref current =
    toLink [ class "fr-pagination__link--prev", Attr.title "Page précédente" ] (current == 1) False (toHref <| current - 1) nothing


nextPage : number -> (number -> String) -> number -> Html msg
nextPage total toHref current =
    toLink [ class "fr-pagination__link--next", Attr.title "Page suivante" ] (current == total) False (toHref <| current + 1) nothing


lastPage : a -> (a -> String) -> a -> Html msg
lastPage total toHref current =
    toLink [ class "fr-pagination__link--last", Attr.title "Dernière page" ] (current == total) False (toHref total) nothing


shownPage : (Int -> String) -> Int -> Int -> Html msg
shownPage toHref current page =
    toLink [ class "", Attr.title <| "Page " ++ String.fromInt page ] (current == page) (current == page) (toHref page) <| text (String.fromInt page)


truncatedPage : Html msg
truncatedPage =
    toLink [ class "" ] True False "" <|
        DSFR.Icons.iconMD <|
            DSFR.Icons.System.moreLine


toLink : List (Attribute Never) -> Bool -> Bool -> String -> Html msg -> Html msg
toLink attrs disabled current href label =
    let
        actualHref =
            if disabled then
                ""

            else
                href

        ariaCurrent =
            if current then
                Accessibility.Aria.currentPage

            else
                empty
    in
    li []
        [ DSFR.Typography.link actualHref
            (class "fr-pagination__link fr-pagination__link--lg-label"
                :: Accessibility.Aria.disabled disabled
                :: ariaCurrent
                :: Attr.attribute "role" "link"
                :: attrs
            )
            [ label ]
        ]
