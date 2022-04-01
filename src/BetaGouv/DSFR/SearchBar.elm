module BetaGouv.DSFR.SearchBar exposing (searchBar, searchBarLG)

import Accessibility exposing (Html, formWithListeners, inputText, label, text)
import Accessibility.Landmark
import BetaGouv.DSFR.Button
import Html.Attributes as Attr exposing (class)
import Html.Attributes.Extra exposing (empty)
import Html.Events as Events


type Size
    = MD
    | LG


genericSearchBar : Size -> { submitMsg : msg, inputMsg : String -> msg, buttonLabel : String, inputLabel : String, inputPlaceholder : String, inputId : String, inputValue : String } -> Html msg
genericSearchBar size { submitMsg, inputMsg, buttonLabel, inputLabel, inputPlaceholder, inputId, inputValue } =
    let
        sizeAttr =
            case size of
                MD ->
                    empty

                LG ->
                    class "fr-search-bar--lg"
    in
    formWithListeners
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
            [ text inputLabel ]
        , inputText inputValue
            [ class "fr-input"
            , Attr.type_ "search"
            , Attr.id inputId
            , Attr.name inputId
            , Attr.placeholder inputPlaceholder
            , Events.onInput inputMsg
            ]
        , DSFR.Button.new { onClick = Nothing, label = buttonLabel }
            |> DSFR.Button.submit
            |> DSFR.Button.withAttrs [ Attr.title buttonLabel ]
            |> DSFR.Button.view
        ]


searchBar : { submitMsg : msg, inputMsg : String -> msg, buttonLabel : String, inputLabel : String, inputPlaceholder : String, inputId : String, inputValue : String } -> Html msg
searchBar =
    genericSearchBar MD


searchBarLG : { submitMsg : msg, inputMsg : String -> msg, buttonLabel : String, inputLabel : String, inputPlaceholder : String, inputId : String, inputValue : String } -> Html msg
searchBarLG =
    genericSearchBar LG
