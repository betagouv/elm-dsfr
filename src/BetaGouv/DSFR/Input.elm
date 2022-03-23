module BetaGouv.DSFR.Input exposing (InputConfig, InputType(..), MandatoryInputConfig, OptionalInputConfig, defaultOptions, input, new, view, withDisabled, withError, withHint, withName, withOptions, withType)

import Accessibility as Html exposing (Html)
import Accessibility.Aria as Aria
import Html as Root
import Html.Attributes as Attr
import Html.Events as Events
import Html.Extra exposing (empty)
import Json.Encode as Encode


input : MandatoryInputConfig msg -> Html msg
input config =
    view { mandatory = config, optional = defaultOptions }


type InputType
    = TextInput
    | TextArea
    | DateInput
    | NumberInput


new : MandatoryInputConfig msg -> InputConfig msg
new mandatory =
    { mandatory = mandatory, optional = defaultOptions }


withOptions : OptionalInputConfig msg -> InputConfig msg -> InputConfig msg
withOptions optional config =
    { config | optional = optional }


withHint : List (Html Never) -> InputConfig msg -> InputConfig msg
withHint hint { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | hint = hint } }


withError : Maybe (List (Html msg)) -> InputConfig msg -> InputConfig msg
withError errorMsg { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | errorMsg = errorMsg } }


withDisabled : Bool -> InputConfig msg -> InputConfig msg
withDisabled disabled { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | disabled = disabled } }


withType : InputType -> InputConfig msg -> InputConfig msg
withType type_ { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | type_ = type_ } }


withName : String -> InputConfig msg -> InputConfig msg
withName name { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | name = name } }


type alias InputConfig msg =
    { mandatory : MandatoryInputConfig msg
    , optional : OptionalInputConfig msg
    }


type alias MandatoryInputConfig msg =
    { value : String
    , onInput : String -> msg
    , label : Html Never
    }


type alias OptionalInputConfig msg =
    { name : String
    , disabled : Bool
    , validMsg : Maybe (List (Html msg))
    , errorMsg : Maybe (List (Html msg))
    , hint : List (Html Never)
    , icon : Maybe String
    , type_ : InputType
    }


defaultOptions : OptionalInputConfig msg
defaultOptions =
    { name = "text-input"
    , disabled = False
    , validMsg = Nothing
    , errorMsg = Nothing
    , hint = []
    , icon = Nothing
    , type_ = TextInput
    }


view : InputConfig msg -> Html msg
view { mandatory, optional } =
    let
        { label, onInput, value } =
            mandatory

        { name, errorMsg, validMsg, disabled, hint, icon, type_ } =
            optional

        defaultInputAttrs =
            [ Attr.class "fr-input"
            , Attr.classList
                [ ( "fr-input--valid", validMsg /= Nothing )
                , ( "fr-input--error", errorMsg /= Nothing )
                ]
            , Html.Extra.attrIf (Nothing /= validMsg) <|
                Aria.describedBy [ name ++ "-desc-valid" ]
            , Html.Extra.attrIf (Nothing /= errorMsg) <|
                Aria.describedBy [ name ++ "-desc-error" ]
            , Attr.id name
            , Attr.name name
            , Attr.value value
            , Attr.disabled disabled
            , Events.onInput onInput
            , Attr.property "autocomplete" <| Encode.string name
            ]

        iconWrapper =
            case icon of
                Nothing ->
                    identity

                Just iconName ->
                    List.singleton
                        >> Html.div [ Attr.class "fr-input-wrap", Attr.class iconName ]

        inp =
            case type_ of
                TextInput ->
                    Html.inputText name <|
                        (defaultInputAttrs ++ [ Attr.type_ "text" ])

                TextArea ->
                    Html.textarea defaultInputAttrs []

                DateInput ->
                    Root.input (defaultInputAttrs ++ [ Attr.type_ "date" ]) []

                NumberInput ->
                    Html.inputNumber name <|
                        (defaultInputAttrs ++ [ Attr.type_ "number", Attr.attribute "inputmode" "numeric", Attr.pattern "[0-9]*" ])
    in
    Html.div
        [ Attr.class "fr-input-group"
        , Attr.classList
            [ ( "fr-input-group--valid", Nothing /= validMsg )
            , ( "fr-input-group--error", Nothing /= errorMsg )
            , ( "fr-input-group--disabled", disabled )
            ]
        ]
        [ Html.labelBefore []
            (Html.label
                [ Attr.class "fr-label"
                , Attr.for name
                ]
                [ label
                , case hint of
                    [] ->
                        empty

                    hints ->
                        Html.span [ Attr.class "fr-hint-text" ] hints
                ]
            )
            (iconWrapper <|
                inp
            )
        , Html.Extra.viewJust validMsg <|
            Html.p
                [ Attr.id <| name ++ "-desc-valid"
                , Attr.class "fr-valid-text"
                ]
        , Html.Extra.viewJust errorMsg <|
            Html.p
                [ Attr.id <| name ++ "-desc-error"
                , Attr.class "fr-error-text"
                ]
        ]
