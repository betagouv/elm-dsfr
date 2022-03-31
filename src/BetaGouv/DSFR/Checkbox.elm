module BetaGouv.DSFR.Checkbox exposing (CheckboxConfig, GroupConfig, MandatoryConfig, MandatoryGroupConfig, OptionalConfig, OptionalGroupConfig, Orientation, defaultOptionalConfig, defaultOptionalGroupConfig, group, groupWithDisabled, groupWithError, groupWithHint, groupWithOrientation, groupWithSuccess, groupWithToDisabled, groupWithToError, groupWithToHint, groupWithToSuccess, horizontal, inline, single, singleWithDisabled, singleWithError, singleWithHint, singleWithSuccess, stacked, vertical, viewGroup, viewSingle)

import Accessibility exposing (Html, checkbox, div, fieldset, legend, p, span, text)
import Accessibility.Aria exposing (describedBy, labelledBy)
import Accessibility.Role
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
    , checked : Bool
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


viewSingle : CheckboxConfig msg data -> Html msg
viewSingle ( { value, checked, valueAsString, id, label, onChecked }, { hint, disabled, error, success } ) =
    div
        [ class "fr-checkbox-group"
        , attributeMaybe (\_ -> class "fr-checkbox-group--error") error
        , attributeMaybe (\_ -> class "fr-checkbox-group--valid") success
        ]
        [ checkbox (valueAsString value)
            (Just checked)
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


single : MandatoryConfig msg data -> ( MandatoryConfig msg data, OptionalConfig )
single config =
    Tuple.pair config defaultOptionalConfig


singleWithHint : Maybe String -> ( MandatoryConfig msg data, OptionalConfig ) -> ( MandatoryConfig msg data, OptionalConfig )
singleWithHint hint ( mandatory, optional ) =
    ( mandatory, { optional | hint = hint } )


singleWithDisabled : Bool -> ( MandatoryConfig msg data, OptionalConfig ) -> ( MandatoryConfig msg data, OptionalConfig )
singleWithDisabled disabled ( mandatory, optional ) =
    ( mandatory, { optional | disabled = disabled } )


singleWithError : Maybe String -> ( MandatoryConfig msg data, OptionalConfig ) -> ( MandatoryConfig msg data, OptionalConfig )
singleWithError error ( mandatory, optional ) =
    ( mandatory, { optional | error = error } )


singleWithSuccess : Maybe String -> ( MandatoryConfig msg data, OptionalConfig ) -> ( MandatoryConfig msg data, OptionalConfig )
singleWithSuccess success ( mandatory, optional ) =
    ( mandatory, { optional | success = success } )


type alias GroupConfig msg data =
    ( MandatoryGroupConfig msg data
    , OptionalGroupConfig data
    )


type alias MandatoryGroupConfig msg data =
    { id : String
    , label : String
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
    }


type Orientation
    = Horizontal
    | Vertical


group : MandatoryGroupConfig msg data -> GroupConfig msg data
group config =
    Tuple.pair config defaultOptionalGroupConfig


viewGroup : GroupConfig msg data -> Html msg
viewGroup ( { id, label, onChecked, values, checked, valueAsString, toId, toLabel }, { hint, disabled, error, success, orientation, toHint, toDisabled, toError, toSuccess } ) =
    let
        inlineClass =
            case orientation of
                Horizontal ->
                    class "fr-fieldset--inline"

                Vertical ->
                    empty
    in
    div [ class "fr-form-group" ]
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
                [ class "fr-fieldset__legend fr-text--regular"
                , Attr.id <| id ++ "-legend"
                ]
                [ text label
                , viewMaybe (\h -> span [ class "fr-hint-text" ] [ text h ]) hint
                ]
            , div [ class "fr-fieldset__content" ] <|
                List.map
                    (\v ->
                        single
                            { value = v
                            , checked = List.member v checked
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


groupWithHint : Maybe String -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
groupWithHint hint ( mandatory, optional ) =
    ( mandatory, { optional | hint = hint } )


groupWithDisabled : Bool -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
groupWithDisabled disabled ( mandatory, optional ) =
    ( mandatory, { optional | disabled = disabled } )


groupWithError : Maybe String -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
groupWithError error ( mandatory, optional ) =
    ( mandatory, { optional | error = error } )


groupWithSuccess : Maybe String -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
groupWithSuccess success ( mandatory, optional ) =
    ( mandatory, { optional | success = success } )


groupWithOrientation : Orientation -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
groupWithOrientation orientation ( mandatory, optional ) =
    ( mandatory, { optional | orientation = orientation } )


horizontal : ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
horizontal =
    groupWithOrientation Horizontal


inline : ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
inline =
    groupWithOrientation Horizontal


vertical : ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
vertical =
    groupWithOrientation Vertical


stacked : ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
stacked =
    groupWithOrientation Vertical


groupWithToHint : (data -> Maybe String) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
groupWithToHint toHint ( mandatory, optional ) =
    ( mandatory, { optional | toHint = toHint } )


groupWithToDisabled : (data -> Bool) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
groupWithToDisabled toDisabled ( mandatory, optional ) =
    ( mandatory, { optional | toDisabled = toDisabled } )


groupWithToError : (data -> Maybe String) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
groupWithToError toError ( mandatory, optional ) =
    ( mandatory, { optional | toError = toError } )


groupWithToSuccess : (data -> Maybe String) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data ) -> ( MandatoryGroupConfig msg data, OptionalGroupConfig data )
groupWithToSuccess toSuccess ( mandatory, optional ) =
    ( mandatory, { optional | toSuccess = toSuccess } )
