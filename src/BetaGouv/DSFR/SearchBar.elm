module BetaGouv.DSFR.SearchBar exposing (searchBar, searchBarLG)

{-|


# Barre de recherche

@docs searchBar, searchBarLG

-}

import Accessibility exposing (Html, div, formWithListeners, inputText, label, span, text)
import Accessibility.Landmark
import BetaGouv.DSFR.Button
import Html.Attributes as Attr exposing (class)
import Html.Attributes.Extra exposing (attributeMaybe, empty)
import Html.Events as Events
import Html.Extra exposing (nothing)
import Json.Decode as Decode


type Size
    = MD
    | LG


type alias MandatoryConfig msg =
    { submitMsg : msg
    , inputMsg : String -> msg
    , buttonLabel : String
    , inputLabel : String
    , inputPlaceholder : Maybe String
    , inputId : String
    , inputValue : String
    , hints : List (Html msg)
    , fullLabel : Maybe (Html msg)
    }


genericSearchBar : Size -> MandatoryConfig msg -> Html msg
genericSearchBar size { submitMsg, inputMsg, buttonLabel, inputLabel, inputPlaceholder, inputId, inputValue, hints, fullLabel } =
    let
        sizeAttr =
            case size of
                MD ->
                    empty

                LG ->
                    class "fr-search-bar--lg"

        hint =
            case hints of
                [] ->
                    nothing

                _ ->
                    span [ Attr.class "fr-hint-text" ] hints
    in
    div [ class "flex flex-col gap-2" ]
        [ case fullLabel of
            Just l ->
                label
                    [ Attr.class "fr-label"
                    , Attr.for inputId
                    ]
                    [ l, hint ]

            Nothing ->
                hint
        , formWithListeners
            [ class "fr-search-bar"
            , Attr.id <| "header-" ++ inputId
            , Accessibility.Landmark.search
            , sizeAttr
            , Events.onSubmit submitMsg
            ]
            [ label
                [ class "fr-label"
                , Attr.for inputId
                ]
                [ text inputLabel
                ]
            , inputText inputValue
                [ class "fr-input"
                , Attr.type_ "search"
                , Attr.id inputId
                , Attr.name inputId
                , inputPlaceholder
                    |> attributeMaybe Attr.placeholder
                , Events.onInput inputMsg
                , Events.on "search" <|
                    Decode.succeed submitMsg
                ]
            , BetaGouv.DSFR.Button.new { onClick = Nothing, label = buttonLabel }
                |> BetaGouv.DSFR.Button.submit
                |> BetaGouv.DSFR.Button.withAttrs [ Attr.title buttonLabel ]
                |> BetaGouv.DSFR.Button.view
            ]
        ]


{-| Crée une barre de recherche

    SearchBar.searchBar
        { submitMsg = SubmitSearch
        , buttonLabel = "Rechercher"
        , inputMsg = UpdatedSearch
        , inputLabel = "Rechercher un contact"
        , inputPlaceholder = Just "Recherche par email, nom, prénom"
        , inputId = "id"
        , inputValue = value
        , hints = []
        , fullLabel = Nothing
        }

-}
searchBar : MandatoryConfig msg -> Html msg
searchBar =
    genericSearchBar MD


{-| Crée une grande barre de recherche
-}
searchBarLG : MandatoryConfig msg -> Html msg
searchBarLG =
    genericSearchBar LG
