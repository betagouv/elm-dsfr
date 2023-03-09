module BetaGouv.DSFR.Checkbox exposing
    ( single, viewSingle
    , singleWithDisabled, singleWithError, singleWithHint, singleWithSuccess
    , group, viewGroup
    , inline, stacked
    , groupWithDisabled, groupWithError, groupWithExtraAttrs, groupWithHint, groupWithSuccess, groupWithToDisabled, groupWithToError, groupWithToHint, groupWithToSuccess
    )

{-|


# Case à cocher

@docs single, viewSingle


## Configuration

@docs singleWithDisabled, singleWithError, singleWithHint, singleWithSuccess


# Groupe


## Création

@docs group, viewGroup


## Orientation

@docs inline, stacked


## Configuration

@docs groupWithDisabled, groupWithError, groupWithExtraAttrs, groupWithHint, groupWithSuccess, groupWithToDisabled, groupWithToError, groupWithToHint, groupWithToSuccess

-}

import Accessibility exposing (Attribute, Html, checkbox, div, fieldset, legend, p, span, text)
import Accessibility.Aria exposing (describedBy, labelledBy)
import Accessibility.Role
import BetaGouv.DSFR.Typography as Typo
import Html.Attributes as Attr exposing (class)
import Html.Attributes.Extra exposing (attributeMaybe, empty)
import Html.Events as Events
import Html.Extra exposing (viewMaybe)


type alias CheckboxConfig msg data =
    ( MandatoryConfig msg data
    , OptionalConfig
    )


type alias MandatoryConfig msg data =
    { value : data
    , checked : Maybe Bool
    , valueAsString : data -> String
    , id : String
    , label : String
    , onChecked : data -> Bool -> msg
    }


type alias OptionalConfig =
    { hint : Maybe String
    , disabled : Bool
    , error : Maybe String
    , success : Maybe String
    }


defaultOptionalConfig : OptionalConfig
defaultOptionalConfig =
    { hint = Nothing
    , disabled = False
    , error = Nothing
    , success = Nothing
    }


{-| Affiche une checkbox
-}
viewSingle : CheckboxConfig msg data -> Html msg
viewSingle ( { value, checked, valueAsString, id, label, onChecked }, { hint, disabled, error, success } ) =
    div
        [ class "fr-checkbox-group"
        , attributeMaybe (\_ -> class "fr-checkbox-group--error") error
        , attributeMaybe (\_ -> class "fr-checkbox-group--valid") success
        ]
        [ checkbox (valueAsString value)
            checked
            [ Attr.name id
            , Attr.id id
            , Attr.disabled disabled
            , attributeMaybe (\_ -> describedBy [ id ++ "-desc-error" ]) error
            , attributeMaybe (\_ -> describedBy [ id ++ "-desc-valid" ]) success
            , Events.onCheck <| onChecked value
            ]
        , Accessibility.label
            [ class "fr-label"
            , Attr.for id
            ]
            [ text label
            , viewMaybe
                (text >> List.singleton >> span [ class "fr-hint-text" ])
                hint
            ]
        , viewMaybe (\err -> p [ class "fr-error-text", Attr.id <| id ++ "-desc-error" ] [ text err ]) error
        , viewMaybe (\suc -> p [ class "fr-error-text", Attr.id <| id ++ "-desc-valid" ] [ text suc ]) success
        ]


{-| Crée une checkbox

    Checkbox.single
        { value = "value"
        , checked = Just True
        , valueAsString = identity
        , id = "id"
        , label = "label"
        , onChecked = ToggleSelection
        }
        |> Checkbox.viewSingle

-}
single :
    { value : data
    , checked : Maybe Bool
    , valueAsString : data -> String
    , id : String
    , label : String
    , onChecked : data -> Bool -> msg
    }
    -> CheckboxConfig msg data
single config =
    Tuple.pair config defaultOptionalConfig


{-| -}
singleWithHint : Maybe String -> CheckboxConfig msg data -> CheckboxConfig msg data
singleWithHint hint ( mandatory, optional ) =
    ( mandatory, { optional | hint = hint } )


{-| -}
singleWithDisabled : Bool -> CheckboxConfig msg data -> CheckboxConfig msg data
singleWithDisabled disabled ( mandatory, optional ) =
    ( mandatory, { optional | disabled = disabled } )


{-| -}
singleWithError : Maybe String -> CheckboxConfig msg data -> CheckboxConfig msg data
singleWithError error ( mandatory, optional ) =
    ( mandatory, { optional | error = error } )


{-| -}
singleWithSuccess : Maybe String -> CheckboxConfig msg data -> CheckboxConfig msg data
singleWithSuccess success ( mandatory, optional ) =
    ( mandatory, { optional | success = success } )


type alias GroupConfig msg data =
    ( MandatoryGroupConfig msg data
    , OptionalGroupConfig data
    )


type alias MandatoryGroupConfig msg data =
    { id : String
    , label : Html msg
    , onChecked : data -> Bool -> msg
    , values : List data
    , checked : List data
    , valueAsString : data -> String
    , toId : data -> String
    , toLabel : data -> String
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
        { id = "id"
        , label = text "label"
        , onChecked = Action
        , values = values
        , checked = checkedValues
        , valueAsString = identity
        , toId = identity
        , toLabel = identity
        }
        |> Checkbox.inline
        |> Checkbox.viewGroup

-}
group :
    { id : String
    , label : Html msg
    , onChecked : data -> Bool -> msg
    , values : List data
    , checked : List data
    , valueAsString : data -> String
    , toId : data -> String
    , toLabel : data -> String
    }
    -> GroupConfig msg data
group config =
    Tuple.pair config defaultOptionalGroupConfig


{-| Affiche le groupe
-}
viewGroup : GroupConfig msg data -> Html msg
viewGroup ( { id, label, onChecked, values, checked, valueAsString, toId, toLabel }, { hint, disabled, error, success, orientation, toHint, toDisabled, toError, toSuccess, extraAttrs } ) =
    let
        inlineClass =
            case orientation of
                Horizontal ->
                    class "fr-fieldset--inline"

                Vertical ->
                    empty
    in
    div
        (class "fr-form-group"
            :: extraAttrs
        )
        [ fieldset
            [ class "fr-fieldset"
            , Attr.id id
            , inlineClass
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
            [ legend
                [ class "fr-fieldset__legend"
                , Typo.textRegular
                , Attr.id <| id ++ "-legend"
                ]
                [ label
                , viewMaybe (\h -> span [ class "fr-hint-text" ] [ text h ]) hint
                ]
            , div [ class "fr-fieldset__content" ] <|
                List.map
                    (\v ->
                        single
                            { value = v
                            , checked = Just <| List.member v checked
                            , valueAsString = valueAsString
                            , id = id ++ "-option-" ++ toId v
                            , label = toLabel v
                            , onChecked = onChecked
                            }
                            |> singleWithHint (toHint v)
                            |> singleWithDisabled (toDisabled v)
                            |> singleWithError (toError v)
                            |> singleWithSuccess (toSuccess v)
                            |> viewSingle
                    )
                <|
                    values
            , viewMaybe (\err -> p [ class "fr-error-text", Attr.id <| id ++ "-desc-error" ] [ text err ]) error
            , viewMaybe (\suc -> p [ class "fr-valid-text", Attr.id <| id ++ "-desc-valid" ] [ text suc ]) success
            ]
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
