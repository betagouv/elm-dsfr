module BetaGouv.DSFR.Input exposing
    ( new, view
    , textArea, date, email, number, password, textDisplay, text
    , withDisabled, withValid, withError, withExtraAttrs, withHint, withReadonly, withType, withIcon
    , Config
    )

{-|


# Création

@docs new, view


# Types de champ de saisie

@docs textArea, date, email, number, password, textDisplay, text


# Configuration

@docs withDisabled, withValid, withError, withExtraAttrs, withHint, withReadonly, withType, withIcon


# Type

@docs Config

-}

import Accessibility as Html exposing (Attribute, Html)
import Accessibility.Aria as Aria
import BetaGouv.DSFR.Typography
import Html as Root
import Html.Attributes as Attr
import Html.Attributes.Extra exposing (empty)
import Html.Events as Events
import Html.Extra exposing (nothing, static)
import Json.Encode as Encode


type InputType
    = TextInput
    | EmailInput
    | PasswordInput
    | TextArea (Maybe Int)
    | DateInput
    | NumberInput
    | TextDisplay


{-| Crée un champ de saisie

    Input.new
        { onInput = UpdateDate
        , id = "date"
        , label = text "Date"
        , value = date
        }
        |> Input.date
        |> Input.view

-}
new :
    { onInput : String -> msg
    , id : String
    , label : Html Never
    , value : String
    }
    -> Config msg
new mandatory =
    { mandatory = mandatory, optional = defaultOptions }


{-| -}
withHint : List (Html Never) -> Config msg -> Config msg
withHint hint { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | hint = hint } }


{-| -}
withError : Maybe (List (Html msg)) -> Config msg -> Config msg
withError errorMsg { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | errorMsg = errorMsg } }


{-| -}
withValid : Maybe (List (Html msg)) -> Config msg -> Config msg
withValid validMsg { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | validMsg = validMsg } }


{-| -}
withDisabled : Bool -> Config msg -> Config msg
withDisabled disabled { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | disabled = disabled } }


{-| -}
withReadonly : Bool -> Config msg -> Config msg
withReadonly readonly { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | readonly = readonly } }


{-| -}
withIcon : Maybe String -> Config msg -> Config msg
withIcon icon { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | icon = icon } }


{-| -}
withType : InputType -> Config msg -> Config msg
withType type_ { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | type_ = type_ } }


{-| Affiche un textarea

    Input.new
        { onInput = UpdateComment
        , id = "commentaire"
        , label = text "Commentaire"
        , value = value
        }
        |> Input.textArea (Just 8)
        |> Input.withExtraAttrs [ class "w-full" ]
        |> Input.view

-}
textArea : Maybe Int -> Config msg -> Config msg
textArea rows =
    withType <| TextArea rows


{-| -}
text : Config msg -> Config msg
text =
    withType <| TextInput


{-| -}
email : Config msg -> Config msg
email =
    withType <| EmailInput


{-| -}
password : Config msg -> Config msg
password =
    withType <| PasswordInput


{-| -}
textDisplay : Config msg -> Config msg
textDisplay =
    withType TextDisplay


{-| -}
date : Config msg -> Config msg
date =
    withType DateInput


{-| -}
number : Config msg -> Config msg
number =
    withType NumberInput


{-| -}
withExtraAttrs : List (Attribute Never) -> Config msg -> Config msg
withExtraAttrs extraAttrs { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | extraAttrs = extraAttrs } }


{-| -}
type alias Config msg =
    { mandatory : MandatoryInputConfig msg
    , optional : OptionalInputConfig msg
    }


type alias MandatoryInputConfig msg =
    { onInput : String -> msg
    , id : String
    , label : Html Never
    , value : String
    }


type alias OptionalInputConfig msg =
    { disabled : Bool
    , readonly : Bool
    , validMsg : Maybe (List (Html msg))
    , errorMsg : Maybe (List (Html msg))
    , hint : List (Html Never)
    , icon : Maybe String
    , type_ : InputType
    , extraAttrs : List (Attribute Never)
    }


defaultOptions : OptionalInputConfig msg
defaultOptions =
    { disabled = False
    , readonly = False
    , validMsg = Nothing
    , errorMsg = Nothing
    , hint = []
    , icon = Nothing
    , type_ = TextInput
    , extraAttrs = []
    }


{-| -}
view : Config msg -> Html msg
view { mandatory, optional } =
    let
        { label, onInput, value } =
            mandatory

        id =
            "input-" ++ mandatory.id

        { errorMsg, validMsg, disabled, readonly, hint, icon, type_, extraAttrs } =
            optional

        defaultInputAttrs =
            [ Attr.class "fr-input"
            , Attr.classList
                [ ( "fr-input--valid", validMsg /= Nothing )
                , ( "fr-input--error", errorMsg /= Nothing )
                ]
            , Html.Attributes.Extra.attributeIf (Nothing /= validMsg) <|
                Aria.describedBy [ id ++ "-desc-valid" ]
            , Html.Attributes.Extra.attributeIf (Nothing /= errorMsg) <|
                Aria.describedBy [ id ++ "-desc-error" ]
            , Attr.id id
            , Attr.name id
            , Attr.value value
            , Attr.disabled disabled
            , Attr.readonly readonly
            , Events.onInput onInput
            , Attr.property "autocomplete" <| Encode.string id
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
                    Html.inputText id <|
                        (defaultInputAttrs ++ [ Attr.type_ "text" ])

                EmailInput ->
                    Html.inputText id <|
                        (defaultInputAttrs ++ [ Attr.type_ "email" ])

                PasswordInput ->
                    Html.inputText id <|
                        (defaultInputAttrs ++ [ Attr.type_ "password" ])

                TextArea rows ->
                    Html.textarea ((rows |> Maybe.map Attr.rows |> Maybe.withDefault empty) :: defaultInputAttrs) []

                DateInput ->
                    Root.input (defaultInputAttrs ++ [ Attr.type_ "date" ]) []

                NumberInput ->
                    Html.inputNumber id <|
                        (defaultInputAttrs ++ [ Attr.type_ "number", Attr.attribute "inputmode" "numeric", Attr.pattern "[0-9]*" ])

                TextDisplay ->
                    Html.div [ Attr.class "mt-[0.5rem] py-[0.5rem]", BetaGouv.DSFR.Typography.textBold ]
                        [ Html.text <|
                            if value == "" then
                                "-"

                            else
                                value
                        ]
    in
    Html.div
        (Attr.class "fr-input-group"
            :: Attr.classList
                [ ( "fr-input-group--valid", Nothing /= validMsg )
                , ( "fr-input-group--error", Nothing /= errorMsg )
                , ( "fr-input-group--disabled", disabled )
                ]
            :: extraAttrs
        )
    <|
        [ Html.label
            [ Attr.class "fr-label"
            , Attr.for id
            ]
            [ static label
            , case hint of
                [] ->
                    nothing

                hints ->
                    static <| Html.span [ Attr.class "fr-hint-text" ] hints
            ]
        , iconWrapper inp
        ]
            ++ [ Html.Extra.viewMaybe
                    (Html.p
                        [ Attr.id <| id ++ "-desc-valid"
                        , Attr.class "fr-valid-text"
                        ]
                    )
                    validMsg
               , Html.Extra.viewMaybe
                    (Html.p
                        [ Attr.id <| id ++ "-desc-error"
                        , Attr.class "fr-error-text"
                        ]
                    )
                    errorMsg
               ]
