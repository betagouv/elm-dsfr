module BetaGouv.DSFR.Button exposing (ButtonConfig, MandatoryButtonConfig, OptionalButtonConfig, buttonSize, buttonType, defaultOptions, disable, iconAttr, large, leftIcon, linkButton, medium, new, noIcon, onlyIcon, primary, regular, reset, rightIcon, secondary, small, submit, tertiary, tertiaryNoOutline, view, withAttrs, withDisabled, withOptions)

import Accessibility as Html exposing (Attribute, Html)
import BetaGouv.DSFR.Icon exposing (IconName)
import Html as Root
import Html.Attributes as Attr exposing (class)
import Html.Attributes.Extra exposing (empty)
import Html.Events as Events


new : MandatoryButtonConfig msg -> ButtonConfig msg
new mandatory =
    { mandatory = mandatory, optional = defaultOptions }


view : ButtonConfig msg -> Html msg
view { mandatory, optional } =
    let
        { label, onClick } =
            mandatory

        { disabled, type_, icon, size, importance, extraAttrs } =
            optional

        ( node, buttonTypeAttrs ) =
            buttonType type_

        importanceClass =
            case importance of
                Primary ->
                    empty

                Secondary ->
                    class "fr-btn--secondary"

                Tertiary With ->
                    class "fr-btn--tertiary"

                Tertiary Without ->
                    class "fr-btn--tertiary-no-outline"
    in
    node
        (Attr.class "fr-btn"
            :: importanceClass
            :: Attr.disabled disabled
            :: iconAttr icon
            :: buttonSize size
            :: (onClick
                    |> Maybe.map Events.onClick
                    |> Maybe.withDefault Html.Attributes.Extra.empty
               )
            :: buttonTypeAttrs
            :: extraAttrs
        )
        [ Html.text label ]


type alias ButtonConfig msg =
    { mandatory : MandatoryButtonConfig msg
    , optional : OptionalButtonConfig msg
    }


type alias MandatoryButtonConfig msg =
    { onClick : Maybe msg
    , label : String
    }


type alias OptionalButtonConfig msg =
    { disabled : Bool
    , type_ : ButtonType
    , size : ButtonSize
    , icon : IconPosition
    , importance : Importance
    , extraAttrs : List (Attribute msg)
    }


type ButtonType
    = ClickableBtn
    | SubmitBtn
    | ResetBtn
    | LinkButton String


type ButtonSize
    = SmallBtn
    | MediumBtn
    | LargeBtn


type IconPosition
    = NoIcon
    | LeftIcon IconName
    | RightIcon IconName
    | OnlyIcon IconName


type Importance
    = Primary
    | Secondary
    | Tertiary Outline


type Outline
    = With
    | Without


withOptions : OptionalButtonConfig msg -> ButtonConfig msg -> ButtonConfig msg
withOptions optional config =
    { config | optional = optional }


withType : ButtonType -> ButtonConfig msg -> ButtonConfig msg
withType type_ { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | type_ = type_ } }


withSize : ButtonSize -> ButtonConfig msg -> ButtonConfig msg
withSize size { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | size = size } }


withImportance : Importance -> ButtonConfig msg -> ButtonConfig msg
withImportance importance { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | importance = importance } }


withIcon : IconPosition -> ButtonConfig msg -> ButtonConfig msg
withIcon icon { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | icon = icon } }


noIcon : ButtonConfig msg -> ButtonConfig msg
noIcon =
    withIcon NoIcon


leftIcon : IconName -> ButtonConfig msg -> ButtonConfig msg
leftIcon =
    withIcon << LeftIcon


rightIcon : IconName -> ButtonConfig msg -> ButtonConfig msg
rightIcon =
    withIcon << RightIcon


onlyIcon : IconName -> ButtonConfig msg -> ButtonConfig msg
onlyIcon =
    withIcon << OnlyIcon


withDisabled : Bool -> ButtonConfig msg -> ButtonConfig msg
withDisabled disabled { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | disabled = disabled } }


withAttrs : List (Attribute msg) -> ButtonConfig msg -> ButtonConfig msg
withAttrs extraAttrs { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | extraAttrs = extraAttrs } }


regular : ButtonConfig msg -> ButtonConfig msg
regular =
    clickable


clickable : ButtonConfig msg -> ButtonConfig msg
clickable =
    withType ClickableBtn


submit : ButtonConfig msg -> ButtonConfig msg
submit =
    withType SubmitBtn


reset : ButtonConfig msg -> ButtonConfig msg
reset =
    withType ResetBtn


linkButton : String -> ButtonConfig msg -> ButtonConfig msg
linkButton href =
    withType <| LinkButton href


primary : ButtonConfig msg -> ButtonConfig msg
primary =
    withImportance Primary


secondary : ButtonConfig msg -> ButtonConfig msg
secondary =
    withImportance Secondary


tertiary : ButtonConfig msg -> ButtonConfig msg
tertiary =
    withImportance <| Tertiary With


tertiaryNoOutline : ButtonConfig msg -> ButtonConfig msg
tertiaryNoOutline =
    withImportance <| Tertiary Without


small : ButtonConfig msg -> ButtonConfig msg
small =
    withSize SmallBtn


medium : ButtonConfig msg -> ButtonConfig msg
medium =
    withSize MediumBtn


large : ButtonConfig msg -> ButtonConfig msg
large =
    withSize LargeBtn


disable : ButtonConfig msg -> ButtonConfig msg
disable =
    withDisabled True


defaultOptions : OptionalButtonConfig msg
defaultOptions =
    { disabled = False
    , type_ = ClickableBtn
    , size = MediumBtn
    , icon = NoIcon
    , importance = Primary
    , extraAttrs = []
    }


buttonType : ButtonType -> ( List (Attribute msg) -> List (Html msg) -> Html msg, Attribute msg )
buttonType type_ =
    case type_ of
        SubmitBtn ->
            ( Html.button, Attr.type_ "submit" )

        ResetBtn ->
            ( Html.button, Attr.type_ "reset" )

        ClickableBtn ->
            ( Html.button, Attr.type_ "button" )

        LinkButton href ->
            ( Root.a, Attr.href href )


iconAttr : IconPosition -> Attribute msg
iconAttr icon =
    case icon of
        NoIcon ->
            empty

        LeftIcon iconName ->
            Attr.classList [ ( DSFR.Icon.toClassName iconName, True ), ( "fr-btn--icon-left", True ) ]

        RightIcon iconName ->
            Attr.classList [ ( DSFR.Icon.toClassName iconName, True ), ( "fr-btn--icon-right", True ) ]

        OnlyIcon iconName ->
            Attr.class <| DSFR.Icon.toClassName iconName


buttonSize : ButtonSize -> Attribute msg
buttonSize size =
    case size of
        SmallBtn ->
            Attr.class "fr-btn--sm"

        MediumBtn ->
            Html.Attributes.Extra.empty

        LargeBtn ->
            Attr.class "fr-btn--lg"
