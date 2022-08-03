module BetaGouv.DSFR.Button exposing (ButtonConfig, MandatoryButtonConfig, OptionalButtonConfig, addAfter, addBefore, alignedCenter, alignedRight, alignedRightInverted, breakpointLG, breakpointMD, breakpointSM, buttonSize, buttonType, defaultOptions, disable, group, groupLarge, groupSmall, iconAttr, iconsLeft, iconsRight, inline, inlineFrom, large, leftIcon, linkButton, linkButtonExternal, medium, new, noIcon, onlyIcon, primary, regular, reset, rightIcon, secondary, single, small, submit, tertiary, tertiaryNoOutline, view, viewGroup, withAttrs, withDisabled, withOptions, close)

import Accessibility exposing (Attribute, Html, button, li, text, ul)
import BetaGouv.DSFR.Icons exposing (IconName)
import BetaGouv.DSFR.Typography
import Html as Root
import Html.Attributes as Attr exposing (class)
import Html.Attributes.Extra exposing (empty)
import Html.Events as Events


type Size
    = SM
    | MD
    | LG


groupSmall : GroupConfig msg -> GroupConfig msg
groupSmall config =
    { config | size = SM }


groupLarge : GroupConfig msg -> GroupConfig msg
groupLarge config =
    { config | size = LG }


type Orientation
    = Stacked
    | Inline
    | InlineFrom Breakpoint


type Breakpoint
    = BreakpointSM
    | BreakpointMD
    | BreakpointLG


breakpointSM : Breakpoint
breakpointSM =
    BreakpointSM


breakpointMD : Breakpoint
breakpointMD =
    BreakpointMD


breakpointLG : Breakpoint
breakpointLG =
    BreakpointLG


inline : GroupConfig msg -> GroupConfig msg
inline config =
    { config | orientation = Inline }


inlineFrom : Breakpoint -> GroupConfig msg -> GroupConfig msg
inlineFrom breakpoint config =
    { config | orientation = InlineFrom breakpoint }


type Placement
    = Left
    | Center
    | RightNormal
    | RightInverted


alignedCenter : GroupConfig msg -> GroupConfig msg
alignedCenter config =
    { config | placement = Center }


alignedRight : GroupConfig msg -> GroupConfig msg
alignedRight config =
    { config | placement = RightNormal }


alignedRightInverted : GroupConfig msg -> GroupConfig msg
alignedRightInverted config =
    { config | placement = RightInverted }


type GroupIcon
    = LeftI
    | RightI
    | NoI


iconsLeft : GroupConfig msg -> GroupConfig msg
iconsLeft config =
    { config | icons = LeftI }


iconsRight : GroupConfig msg -> GroupConfig msg
iconsRight config =
    { config | icons = RightI }


type alias GroupConfig msg =
    { buttons : List (ButtonConfig msg)
    , size : Size
    , orientation : Orientation
    , placement : Placement
    , icons : GroupIcon
    , equisized : Bool
    }


group : List (ButtonConfig msg) -> GroupConfig msg
group buttons =
    { buttons = buttons
    , size = MD
    , orientation = Stacked
    , placement = Left
    , icons = NoI
    , equisized = False
    }


addBefore : ButtonConfig msg -> GroupConfig msg -> GroupConfig msg
addBefore button config =
    { config | buttons = button :: config.buttons }


addAfter : ButtonConfig msg -> GroupConfig msg -> GroupConfig msg
addAfter button config =
    { config | buttons = config.buttons ++ [ button ] }


viewGroup : GroupConfig msg -> Html msg
viewGroup { buttons, size, orientation, placement, icons, equisized } =
    let
        orientationClass =
            case orientation of
                Stacked ->
                    empty

                Inline ->
                    class "fr-btns-group--inline"

                InlineFrom breakpoint ->
                    case breakpoint of
                        BreakpointSM ->
                            class "fr-btns-group--inline-sm"

                        BreakpointMD ->
                            class "fr-btns-group--inline-md"

                        BreakpointLG ->
                            class "fr-btns-group--inline-lg"

        sizeClass =
            case size of
                SM ->
                    class "fr-btns-group--sm"

                MD ->
                    empty

                LG ->
                    class "fr-btns-group--lg"

        placementClass =
            case placement of
                Left ->
                    [ empty ]

                Center ->
                    [ class "fr-btns-group--center" ]

                RightNormal ->
                    [ class "fr-btns-group--right" ]

                RightInverted ->
                    [ class "fr-btns-group--right", class "fr-btns-group--inline-reverse" ]

        equisizedClass =
            if equisized then
                class "fr-btns-group--equisized"

            else
                empty

        iconsClass =
            case icons of
                NoI ->
                    empty

                LeftI ->
                    class "fr-btns-group--icon-left"

                RightI ->
                    class "fr-btns-group--icon-right"
    in
    ul
        (class "fr-btns-group"
            :: sizeClass
            :: orientationClass
            :: equisizedClass
            :: iconsClass
            :: placementClass
        )
    <|
        List.map (li [] << List.singleton << view << withSize None) <|
            buttons


single : MandatoryButtonConfig msg -> ButtonConfig msg
single mandatory =
    { mandatory = mandatory, optional = defaultOptions }


new : MandatoryButtonConfig msg -> ButtonConfig msg
new =
    single


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

                Close ->
                    class "fr-btn--close"
    in
    node
        (class "fr-btn"
            :: importanceClass
            :: Attr.disabled disabled
            :: buttonSize size
            :: (onClick
                    |> Maybe.map Events.onClick
                    |> Maybe.withDefault Html.Attributes.Extra.empty
               )
            :: buttonTypeAttrs
            ++ iconAttr label icon
            ++ extraAttrs
        )
        [ text label ]


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
    | LinkButton Bool String


type ButtonSize
    = Small
    | Medium
    | Large
    | None


type IconPosition
    = NoIcon
    | LeftIcon IconName
    | RightIcon IconName
    | OnlyIcon IconName


type Importance
    = Primary
    | Secondary
    | Tertiary Outline
    | Close


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
    withType <| LinkButton False href


linkButtonExternal : String -> ButtonConfig msg -> ButtonConfig msg
linkButtonExternal href =
    withType <| LinkButton True href


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


close : ButtonConfig msg -> ButtonConfig msg
close =
    withImportance Close


small : ButtonConfig msg -> ButtonConfig msg
small =
    withSize Small


medium : ButtonConfig msg -> ButtonConfig msg
medium =
    withSize Medium


large : ButtonConfig msg -> ButtonConfig msg
large =
    withSize Large


disable : ButtonConfig msg -> ButtonConfig msg
disable =
    withDisabled True


defaultOptions : OptionalButtonConfig msg
defaultOptions =
    { disabled = False
    , type_ = ClickableBtn
    , size = Medium
    , icon = NoIcon
    , importance = Primary
    , extraAttrs = []
    }


buttonType : ButtonType -> ( List (Attribute msg) -> List (Html msg) -> Html msg, List (Attribute msg) )
buttonType type_ =
    case type_ of
        SubmitBtn ->
            ( button, [ Attr.type_ "submit" ] )

        ResetBtn ->
            ( button, [ Attr.type_ "reset" ] )

        ClickableBtn ->
            ( button, [ Attr.type_ "button" ] )

        LinkButton external href ->
            ( Root.a
            , if external then
                DSFR.Typography.externalLinkAttrs href []

              else
                [ Attr.href href ]
            )


iconAttr : String -> IconPosition -> List (Attribute msg)
iconAttr label icon =
    case icon of
        NoIcon ->
            [ empty ]

        LeftIcon iconName ->
            [ DSFR.Icons.toClass iconName, class "fr-btn--icon-left" ]

        RightIcon iconName ->
            [ DSFR.Icons.toClass iconName, class "fr-btn--icon-right" ]

        OnlyIcon iconName ->
            [ DSFR.Icons.toClass iconName, Attr.title label ]


buttonSize : ButtonSize -> Attribute msg
buttonSize size =
    case size of
        None ->
            empty

        Small ->
            class "fr-btn--sm"

        Medium ->
            Html.Attributes.Extra.empty

        Large ->
            class "fr-btn--lg"
