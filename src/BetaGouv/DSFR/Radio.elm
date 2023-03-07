module BetaGouv.DSFR.Radio exposing
    ( group, view
    , inline, stacked
    , viewRich, withDisabled, withDisabledOption, withError, withExtraAttrs, withHint, withLegendAttrs, withLegendExtra, withSuccess
    )

{-|


# Groupe de bouton radio

@docs group, view


## Orientation

@docs inline, stacked


## Configuration

@docs viewRich, withDisabled, withDisabledOption, withError, withExtraAttrs, withHint, withLegendAttrs, withLegendExtra, withSuccess

-}

import Accessibility exposing (Attribute, Html, decorativeImg, div, fieldset, label, p, span, text)
import Accessibility.Aria exposing (labelledBy)
import Accessibility.Role
import Html exposing (input)
import Html.Attributes as Attr exposing (class, classList)
import Html.Attributes.Extra exposing (attributeMaybe, empty)
import Html.Events as Events
import Html.Extra exposing (static, viewMaybe)
import Html.Keyed as Keyed


type alias GroupConfig msg data =
    ( MandatoryConfig msg data, OptionalConfig msg data )


type alias MandatoryConfig msg data =
    { id : String
    , options : List data
    , current : Maybe data
    , toLabel : data -> Html Never
    , toId : data -> String
    , msg : data -> msg
    , legend : Html msg
    }


type alias OptionalConfig msg data =
    { toHint : Maybe (data -> Html msg)
    , legendExtra : Maybe (Html msg)
    , error : Maybe String
    , success : Maybe String
    , orientation : Orientation
    , disabled : Bool
    , disabledOption : data -> Bool
    , extraAttrs : List (Attribute Never)
    , legendAttrs : List (Attribute Never)
    }


type Orientation
    = Horizontal
    | Vertical


type alias Dimensions =
    ( Int, Int )


defaultOptions : OptionalConfig msg data
defaultOptions =
    { toHint = Nothing
    , legendExtra = Nothing
    , error = Nothing
    , success = Nothing
    , orientation = Vertical
    , disabled = False
    , disabledOption = \_ -> False
    , extraAttrs = []
    , legendAttrs = []
    }


{-| Crée un groupe de boutons radio

    Radio.group
        { id = "group-id"
        , options = options
        , current = Just option
        , toLabel = optionToLabel >> text
        , toId = optionToId
        , msg = ClickOption
        , legend = text "Légende du groupe"
        }
        |> Radio.withError formErrors
        |> Radio.inline
        |> Radio.view

-}
group : MandatoryConfig msg data -> GroupConfig msg data
group mandatory =
    ( mandatory, defaultOptions )


{-| Affiche un groupe de boutons radio
-}
view : GroupConfig msg data -> Html msg
view =
    viewGeneric Nothing


{-| Affiche un groupe de boutons radio illustrés
-}
viewRich : (data -> ( String, Maybe Dimensions )) -> GroupConfig msg data -> Html msg
viewRich toSrc =
    viewGeneric <| Just toSrc


viewGeneric : Maybe (data -> ( String, Maybe Dimensions )) -> GroupConfig msg data -> Html msg
viewGeneric toSrc ( { id, options, current, toLabel, toId, msg, legend }, { toHint, legendExtra, error, success, orientation, disabled, disabledOption, extraAttrs, legendAttrs } ) =
    let
        inlineAttrs =
            case orientation of
                Horizontal ->
                    [ class "fr-fieldset--inline", class "fr-col" ]

                Vertical ->
                    []
    in
    div
        (class "fr-form-group"
            :: class "fr-col"
            :: extraAttrs
        )
        [ fieldset
            (class "fr-fieldset"
                :: attributeMaybe (\_ -> class "fr-fieldset--error") error
                :: attributeMaybe (\_ -> Accessibility.Role.group) error
                :: attributeMaybe (\_ -> class "fr-fieldset--valid") success
                :: attributeMaybe (\_ -> Accessibility.Role.group) success
                :: Attr.disabled disabled
                :: (labelledBy <|
                        String.join " " <|
                            List.filterMap identity <|
                                [ Just <| id ++ "-legend"
                                , Maybe.map (\_ -> id ++ "-desc-error") error
                                , Maybe.map (\_ -> id ++ "-desc-valid") success
                                ]
                   )
                :: inlineAttrs
            )
            [ Accessibility.legend
                (class "fr-fieldset__legend fr-text--regular" :: legendAttrs)
                [ legend
                , viewMaybe (List.singleton >> span [ class "fr-hint-text" ]) legendExtra
                ]
            , Keyed.node "div" [ class "fr-fieldset__content", class "fr-col" ] <|
                List.map
                    (\option ->
                        let
                            dis =
                                disabledOption option

                            name =
                                id ++ "-option-" ++ toId option
                        in
                        ( name
                        , div
                            [ class "fr-radio-group"
                            , classList [ ( "fr-radio-rich", toSrc /= Nothing ) ]
                            , class "fr-col"
                            ]
                            [ input
                                [ Attr.type_ "radio"
                                , Attr.id <| name
                                , Attr.checked (current == Just option)
                                , if dis then
                                    empty

                                  else
                                    Events.onClick <| msg <| option
                                , Attr.disabled dis
                                ]
                                []
                            , label
                                [ class "fr-label"
                                , Attr.for <| name
                                ]
                                [ static <| toLabel option
                                , viewMaybe ((\fn -> fn option) >> List.singleton >> span [ class "fr-hint-text" ]) <| toHint
                                ]
                            , viewMaybe
                                (\fn ->
                                    let
                                        ( src, dimensions ) =
                                            fn option

                                        dimensionsAttrs =
                                            dimensions
                                                |> Maybe.map (\( width, height ) -> [ Attr.width width, Attr.height height ])
                                                |> Maybe.withDefault []
                                    in
                                    div [ class "fr-radio-rich__img" ]
                                        [ decorativeImg <| Attr.src src :: dimensionsAttrs ]
                                )
                                toSrc
                            ]
                        )
                    )
                <|
                    options
            , viewMaybe (\err -> p [ class "fr-error-text", Attr.id <| id ++ "-desc-error" ] [ text err ]) error
            , viewMaybe (\suc -> p [ class "fr-valid-text", Attr.id <| id ++ "-desc-valid" ] [ text suc ]) success
            ]
        ]


{-| -}
inline : GroupConfig msg data -> GroupConfig msg data
inline ( mandatory, optional ) =
    ( mandatory, { optional | orientation = Horizontal } )


{-| -}
stacked : GroupConfig msg data -> GroupConfig msg data
stacked ( mandatory, optional ) =
    ( mandatory, { optional | orientation = Vertical } )


{-| -}
withHint : Maybe (data -> Html msg) -> GroupConfig msg data -> GroupConfig msg data
withHint toHint ( mandatory, optional ) =
    ( mandatory, { optional | toHint = toHint } )


{-| -}
withLegendExtra : Maybe (Html msg) -> GroupConfig msg data -> GroupConfig msg data
withLegendExtra legendExtra ( mandatory, optional ) =
    ( mandatory, { optional | legendExtra = legendExtra } )


{-| -}
withError : Maybe String -> GroupConfig msg data -> GroupConfig msg data
withError error ( mandatory, optional ) =
    ( mandatory, { optional | error = error } )


{-| -}
withSuccess : Maybe String -> GroupConfig msg data -> GroupConfig msg data
withSuccess success ( mandatory, optional ) =
    ( mandatory, { optional | success = success } )


{-| -}
withDisabled : Bool -> GroupConfig msg data -> GroupConfig msg data
withDisabled disabled ( mandatory, optional ) =
    ( mandatory, { optional | disabled = disabled } )


{-| -}
withDisabledOption : (data -> Bool) -> GroupConfig msg data -> GroupConfig msg data
withDisabledOption disabledFn ( mandatory, optional ) =
    ( mandatory, { optional | disabledOption = disabledFn } )


{-| -}
withExtraAttrs : List (Attribute Never) -> GroupConfig msg data -> GroupConfig msg data
withExtraAttrs extraAttrs ( mandatory, optional ) =
    ( mandatory, { optional | extraAttrs = extraAttrs } )


{-| -}
withLegendAttrs : List (Attribute Never) -> GroupConfig msg data -> GroupConfig msg data
withLegendAttrs legendAttrs ( mandatory, optional ) =
    ( mandatory, { optional | legendAttrs = legendAttrs } )
