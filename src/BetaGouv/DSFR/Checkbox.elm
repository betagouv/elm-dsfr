module BetaGouv.DSFR.Checkbox exposing
    ( single, viewSingle
    , singleWithDisabled, singleWithError, singleWithHint, singleWithSuccess, singleWithExtraAttrs, singleWithInputAttrs
    , group, viewGroup
    , inline, stacked
    , groupWithDisabled, groupWithError, groupWithExtraAttrs, groupWithHint, groupWithSuccess, groupWithToDisabled, groupWithToError, groupWithToHint, groupWithToSuccess
    , Config, GroupConfig
    )

{-|


# Case à cocher

@docs single, viewSingle


## Configuration

@docs singleWithDisabled, singleWithError, singleWithHint, singleWithSuccess, singleWithExtraAttrs, singleWithInputAttrs


# Groupe


## Création

@docs group, viewGroup


## Orientation

@docs inline, stacked


## Configuration

@docs groupWithDisabled, groupWithError, groupWithExtraAttrs, groupWithHint, groupWithSuccess, groupWithToDisabled, groupWithToError, groupWithToHint, groupWithToSuccess


# Type

@docs Config, GroupConfig

-}

import Accessibility exposing (Attribute, Html, checkbox, div, fieldset, legend, p, span, text)
import Accessibility.Aria exposing (describedBy, labelledBy)
import Accessibility.Role
import BetaGouv.DSFR.Typography as Typo
import Html.Attributes as Attr exposing (class)
import Html.Attributes.Extra exposing (attributeMaybe, empty)
import Html.Events as Events
import Html.Extra exposing (static, viewMaybe)


{-| -}
type alias Config msg =
    ( MandatoryConfig msg
    , OptionalConfig
    )


type alias MandatoryConfig msg =
    { checked : Maybe Bool
    , onChecked : Bool -> msg
    , id : String
    , label : Html Never
    , value : String
    }


type alias OptionalConfig =
    { hint : Maybe String
    , disabled : Bool
    , error : Maybe String
    , success : Maybe String
    , extraAttrs : List (Attribute Never)
    , checkboxAttrs : List (Attribute Never)
    }


defaultOptionalConfig : OptionalConfig
defaultOptionalConfig =
    { hint = Nothing
    , disabled = False
    , error = Nothing
    , success = Nothing
    , extraAttrs = []
    , checkboxAttrs = []
    }


{-| Affiche une checkbox
-}
viewSingle : Config msg -> Html msg
viewSingle ( { checked, onChecked, id, label, value }, { hint, disabled, error, success, extraAttrs, checkboxAttrs } ) =
    div
        ([ class "fr-checkbox-group"
         , attributeMaybe (\_ -> class "fr-checkbox-group--error") error
         , attributeMaybe (\_ -> class "fr-checkbox-group--valid") success
         ]
            ++ extraAttrs
        )
        [ checkbox value
            checked
            ([ Attr.name id
             , Attr.id id
             , Attr.disabled disabled
             , attributeMaybe (\_ -> describedBy [ id ++ "-desc-error" ]) error
             , attributeMaybe (\_ -> describedBy [ id ++ "-desc-valid" ]) success
             , Events.onCheck onChecked
             ]
                ++ List.map (Attr.map Basics.never) checkboxAttrs
            )
        , Accessibility.label
            [ class "fr-label"
            , Attr.for id
            ]
            [ static label
            , viewMaybe
                (text >> List.singleton >> span [ class "fr-hint-text" ])
                hint
            ]
        , viewMaybe (\err -> p [ class "fr-error-text", Attr.id <| id ++ "-desc-error" ] [ text err ]) error
        , viewMaybe (\suc -> p [ class "fr-error-text", Attr.id <| id ++ "-desc-valid" ] [ text suc ]) success
        ]


{-| Crée une checkbox

    Checkbox.single
        { checked = Just True
        , onChecked = ToggleSelection
        , id = "id"
        , label = "label"
        , value = "value"
        }
        |> Checkbox.viewSingle

-}
single :
    { checked : Maybe Bool
    , onChecked : Bool -> msg
    , id : String
    , label : Html Never
    , value : String
    }
    -> Config msg
single config =
    Tuple.pair config defaultOptionalConfig


{-| -}
singleWithHint : Maybe String -> Config msg -> Config msg
singleWithHint hint ( mandatory, optional ) =
    ( mandatory, { optional | hint = hint } )


{-| -}
singleWithDisabled : Bool -> Config msg -> Config msg
singleWithDisabled disabled ( mandatory, optional ) =
    ( mandatory, { optional | disabled = disabled } )


{-| -}
singleWithError : Maybe String -> Config msg -> Config msg
singleWithError error ( mandatory, optional ) =
    ( mandatory, { optional | error = error } )


{-| -}
singleWithSuccess : Maybe String -> Config msg -> Config msg
singleWithSuccess success ( mandatory, optional ) =
    ( mandatory, { optional | success = success } )


{-| -}
singleWithExtraAttrs : List (Attribute Never) -> Config msg -> Config msg
singleWithExtraAttrs extraAttrs ( mandatory, optional ) =
    ( mandatory, { optional | extraAttrs = extraAttrs } )


{-| -}
singleWithInputAttrs : List (Attribute Never) -> Config msg -> Config msg
singleWithInputAttrs inputAttrs ( mandatory, optional ) =
    ( mandatory, { optional | checkboxAttrs = inputAttrs } )


{-| -}
type alias GroupConfig msg data =
    ( MandatoryGroupConfig msg data
    , OptionalGroupConfig data
    )


type alias MandatoryGroupConfig msg data =
    { id : String
    , legend : Html msg
    , options : List data
    , checked : List data
    , onChecked : data -> Bool -> msg
    , toId : data -> String
    , toLabel : data -> Html Never
    , toValue : data -> String
    }


type alias OptionalGroupConfig data =
    { hint : Maybe String
    , disabled : Bool
    , error : Maybe String
    , success : Maybe String
    , orientation : Orientation
    , toHint : data -> Maybe String
    , toDisabled : data -> Bool
    , toError : data -> Maybe String
    , toSuccess : data -> Maybe String
    , extraAttrs : List (Attribute Never)
    }


defaultOptionalGroupConfig : OptionalGroupConfig data
defaultOptionalGroupConfig =
    { hint = Nothing
    , disabled = False
    , error = Nothing
    , success = Nothing
    , orientation = Vertical
    , toHint = always Nothing
    , toDisabled = always False
    , toError = always Nothing
    , toSuccess = always Nothing
    , extraAttrs = []
    }


type Orientation
    = Horizontal
    | Vertical


{-| Crée un groupe de case à cocher

    Checkbox.group
        { id = "group-id"
        , legend = text "Légende du groupe"
        , options = options
        , checked = checkedValues
        , onChecked = ClickOption
        , toId = optionToId
        , toLabel = optionToLabel >> text
        , toValue = optionToValue
        }
        |> Checkbox.inline
        |> Checkbox.viewGroup

-}
group :
    { id : String
    , legend : Html msg
    , options : List data
    , checked : List data
    , onChecked : data -> Bool -> msg
    , toId : data -> String
    , toLabel : data -> Html Never
    , toValue : data -> String
    }
    -> GroupConfig msg data
group config =
    Tuple.pair config defaultOptionalGroupConfig


{-| Affiche le groupe
-}
viewGroup : GroupConfig msg data -> Html msg
viewGroup ( { id, legend, options, checked, onChecked, toId, toLabel, toValue }, { hint, disabled, error, success, orientation, toHint, toDisabled, toError, toSuccess, extraAttrs } ) =
    let
        inlineClass =
            case orientation of
                Horizontal ->
                    class "fr-fieldset__element--inline"

                Vertical ->
                    empty

        viewElement v =
            div
                [ class "fr-fieldset__element", inlineClass ]
                [ single
                    { checked = Just <| List.member v checked
                    , onChecked = onChecked v
                    , id = id ++ "-option-" ++ toId v
                    , label = toLabel v
                    , value = toValue v
                    }
                    |> singleWithHint (toHint v)
                    |> singleWithDisabled (toDisabled v)
                    |> singleWithError (toError v)
                    |> singleWithSuccess (toSuccess v)
                    |> viewSingle
                ]
    in
    fieldset
        ([ class "fr-fieldset"
         , Attr.id id
         , attributeMaybe (\_ -> class "fr-fieldset--error") error
         , attributeMaybe (\_ -> Accessibility.Role.group) error
         , attributeMaybe (\_ -> class "fr-fieldset--valid") success
         , attributeMaybe (\_ -> Accessibility.Role.group) success
         , Attr.disabled disabled
         , labelledBy <|
            String.join " " <|
                List.filterMap identity <|
                    [ Just <| id ++ "-legend"
                    , Maybe.map (\_ -> id ++ "-desc-error") error
                    , Maybe.map (\_ -> id ++ "-desc-valid") success
                    ]
         ]
            ++ extraAttrs
        )
    <|
        Accessibility.legend
            [ class "fr-fieldset__legend"
            , Typo.textRegular
            , Attr.id <| id ++ "-legend"
            ]
            [ legend
            , viewMaybe (\h -> span [ class "fr-hint-text" ] [ text h ]) hint
            ]
            :: List.map viewElement options
            ++ [ viewMaybe (\err -> p [ class "fr-error-text", Attr.id <| id ++ "-desc-error" ] [ text err ]) error
               , viewMaybe (\suc -> p [ class "fr-valid-text", Attr.id <| id ++ "-desc-valid" ] [ text suc ]) success
               ]


{-| -}
groupWithHint : Maybe String -> GroupConfig msg data -> GroupConfig msg data
groupWithHint hint ( mandatory, optional ) =
    ( mandatory, { optional | hint = hint } )


{-| -}
groupWithDisabled : Bool -> GroupConfig msg data -> GroupConfig msg data
groupWithDisabled disabled ( mandatory, optional ) =
    ( mandatory, { optional | disabled = disabled } )


{-| -}
groupWithError : Maybe String -> GroupConfig msg data -> GroupConfig msg data
groupWithError error ( mandatory, optional ) =
    ( mandatory, { optional | error = error } )


{-| -}
groupWithSuccess : Maybe String -> GroupConfig msg data -> GroupConfig msg data
groupWithSuccess success ( mandatory, optional ) =
    ( mandatory, { optional | success = success } )


{-| -}
groupWithOrientation : Orientation -> GroupConfig msg data -> GroupConfig msg data
groupWithOrientation orientation ( mandatory, optional ) =
    ( mandatory, { optional | orientation = orientation } )


{-| -}
inline : GroupConfig msg data -> GroupConfig msg data
inline =
    groupWithOrientation Horizontal


{-| -}
stacked : GroupConfig msg data -> GroupConfig msg data
stacked =
    groupWithOrientation Vertical


{-| -}
groupWithToHint : (data -> Maybe String) -> GroupConfig msg data -> GroupConfig msg data
groupWithToHint toHint ( mandatory, optional ) =
    ( mandatory, { optional | toHint = toHint } )


{-| -}
groupWithToDisabled : (data -> Bool) -> GroupConfig msg data -> GroupConfig msg data
groupWithToDisabled toDisabled ( mandatory, optional ) =
    ( mandatory, { optional | toDisabled = toDisabled } )


{-| -}
groupWithToError : (data -> Maybe String) -> GroupConfig msg data -> GroupConfig msg data
groupWithToError toError ( mandatory, optional ) =
    ( mandatory, { optional | toError = toError } )


{-| -}
groupWithToSuccess : (data -> Maybe String) -> GroupConfig msg data -> GroupConfig msg data
groupWithToSuccess toSuccess ( mandatory, optional ) =
    ( mandatory, { optional | toSuccess = toSuccess } )


{-| -}
groupWithExtraAttrs : List (Attribute Never) -> GroupConfig msg data -> GroupConfig msg data
groupWithExtraAttrs extraAttrs ( mandatory, optional ) =
    ( mandatory, { optional | extraAttrs = extraAttrs } )
