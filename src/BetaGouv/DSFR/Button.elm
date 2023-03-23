module BetaGouv.DSFR.Button exposing
    ( new, view
    , group, viewGroup
    , ButtonConfig
    , small, medium, large
    , disable, linkButton, linkButtonExternal, regular, reset, submit
    , leftIcon, rightIcon, noIcon, onlyIcon
    , close, primary, secondary, tertiary, tertiaryNoOutline
    , groupSmall, groupLarge
    , iconsLeft, iconsRight
    , breakpointSM, breakpointMD, breakpointLG
    , alignedCenter, alignedRight, alignedRightInverted
    , inline, inlineFrom
    , addAfter, addBefore
    , withAttrs, withDisabled, withOptions
    , dropdownSelector
    )

{-|


# Bouton

@docs new, view


# Groupe de boutons

@docs group, viewGroup


# Configuration des boutons

@docs ButtonConfig


## Tailles de bouton

@docs small, medium, large


## Types de bouton

@docs disable, linkButton, linkButtonExternal, regular, reset, submit


## Placement de l'icône

@docs leftIcon, rightIcon, noIcon, onlyIcon


## Importance

@docs close, primary, secondary, tertiary, tertiaryNoOutline


# Configuration des groupes de boutons


## Taille des boutons du groupe

@docs groupSmall, groupLarge


## Placement des icônes des boutons du groupe

@docs iconsLeft, iconsRight


## Points de rupture

@docs breakpointSM, breakpointMD, breakpointLG


## Placement des boutons dans le groupe

@docs alignedCenter, alignedRight, alignedRightInverted


## Disposition des boutons dans le groupe

@docs inline, inlineFrom


## Ajout de boutons au groupe

@docs addAfter, addBefore


## Personnalisation

@docs withAttrs, withDisabled, withOptions


## Liste déroulante

@docs dropdownSelector

-}

import Accessibility exposing (Attribute, Html, button, div, li, nav, text, ul)
import BetaGouv.DSFR.Icons exposing (IconName)
import BetaGouv.DSFR.Typography
import Html as Root
import Html.Attributes as Attr exposing (class)
import Html.Attributes.Extra exposing (empty)
import Html.Events as Events
import Html.Extra exposing (nothing)


type Size
    = SM
    | MD
    | LG


{-| Groupe de petits boutons
-}
groupSmall : GroupConfig msg -> GroupConfig msg
groupSmall config =
    { config | size = SM }


{-| Groupe de grands boutons
-}
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


{-| -}
breakpointSM : Breakpoint
breakpointSM =
    BreakpointSM


{-| -}
breakpointMD : Breakpoint
breakpointMD =
    BreakpointMD


{-| -}
breakpointLG : Breakpoint
breakpointLG =
    BreakpointLG


{-| Applique le mode horizontal
-}
inline : GroupConfig msg -> GroupConfig msg
inline config =
    { config | orientation = Inline }


{-| Applique le mode horizontal à partir d'un certain point de rupture
-}
inlineFrom : Breakpoint -> GroupConfig msg -> GroupConfig msg
inlineFrom breakpoint config =
    { config | orientation = InlineFrom breakpoint }


type Placement
    = Left
    | Center
    | RightNormal
    | RightInverted


{-| -}
alignedCenter : GroupConfig msg -> GroupConfig msg
alignedCenter config =
    { config | placement = Center }


{-| -}
alignedRight : GroupConfig msg -> GroupConfig msg
alignedRight config =
    { config | placement = RightNormal }


{-| -}
alignedRightInverted : GroupConfig msg -> GroupConfig msg
alignedRightInverted config =
    { config | placement = RightInverted }


type GroupIcon
    = LeftI
    | RightI
    | NoI


{-| -}
iconsLeft : GroupConfig msg -> GroupConfig msg
iconsLeft config =
    { config | icons = LeftI }


{-| -}
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


{-| Crée un groupe de boutons

Par défaut les boutons sont de tailles moyennes et placés à la verticale.

    [ Button.new ...]
        |> Button.group
        |> Button.inline
        |> Button.alignedRightInverted
        |> Button.viewGroup

-}
group : List (ButtonConfig msg) -> GroupConfig msg
group buttons =
    { buttons = buttons
    , size = MD
    , orientation = Stacked
    , placement = Left
    , icons = NoI
    , equisized = False
    }


{-| Ajoute un bouton au début du groupe
-}
addBefore : ButtonConfig msg -> GroupConfig msg -> GroupConfig msg
addBefore button config =
    { config | buttons = button :: config.buttons }


{-| Ajoute un bouton à la fin du groupe
-}
addAfter : ButtonConfig msg -> GroupConfig msg -> GroupConfig msg
addAfter button config =
    { config | buttons = config.buttons ++ [ button ] }


{-| Affiche un groupe de boutons
-}
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


single : { onClick : Maybe msg, label : String } -> ButtonConfig msg
single mandatory =
    { mandatory = mandatory, optional = defaultOptions }


{-| Crée un bouton

    Button.new { onClick = Just Action, label = "action" }

-}
new : { onClick : Maybe msg, label : String } -> ButtonConfig msg
new =
    single


{-| Affiche un bouton

    Button.new { onClick = Nothing, label = "Ajouter" }
        |> Button.linkButton "/add"
        |> Button.tertiaryNoOutline
        |> Button.withAttrs [ class "w-full" ]
        |> Button.leftIcon Icons.System.addLine
        |> Button.view

-}
view : ButtonConfig msg -> Html msg
view { mandatory, optional } =
    let
        { label, onClick } =
            mandatory

        { disabled, type_, icon, size, importance, extraAttrs } =
            optional

        ( node, buttonTypeAttrs ) =
            buttonType type_

        ( iconAttrs, lab ) =
            iconAttr label icon

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
            ++ iconAttrs
            ++ extraAttrs
        )
        [ lab ]


{-| -}
type alias ButtonConfig msg =
    { mandatory : { onClick : Maybe msg, label : String }
    , optional : OptionalButtonConfig msg
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


{-| -}
withOptions : OptionalButtonConfig msg -> ButtonConfig msg -> ButtonConfig msg
withOptions optional config =
    { config | optional = optional }


{-| -}
withType : ButtonType -> ButtonConfig msg -> ButtonConfig msg
withType type_ { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | type_ = type_ } }


{-| -}
withSize : ButtonSize -> ButtonConfig msg -> ButtonConfig msg
withSize size { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | size = size } }


{-| -}
withImportance : Importance -> ButtonConfig msg -> ButtonConfig msg
withImportance importance { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | importance = importance } }


{-| -}
withIcon : IconPosition -> ButtonConfig msg -> ButtonConfig msg
withIcon icon { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | icon = icon } }


{-| -}
noIcon : ButtonConfig msg -> ButtonConfig msg
noIcon =
    withIcon NoIcon


{-| -}
leftIcon : IconName -> ButtonConfig msg -> ButtonConfig msg
leftIcon =
    withIcon << LeftIcon


{-| -}
rightIcon : IconName -> ButtonConfig msg -> ButtonConfig msg
rightIcon =
    withIcon << RightIcon


{-| -}
onlyIcon : IconName -> ButtonConfig msg -> ButtonConfig msg
onlyIcon =
    withIcon << OnlyIcon


{-| -}
withDisabled : Bool -> ButtonConfig msg -> ButtonConfig msg
withDisabled disabled { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | disabled = disabled } }


{-| -}
withAttrs : List (Attribute msg) -> ButtonConfig msg -> ButtonConfig msg
withAttrs extraAttrs { mandatory, optional } =
    { mandatory = mandatory, optional = { optional | extraAttrs = extraAttrs } }


{-| -}
regular : ButtonConfig msg -> ButtonConfig msg
regular =
    clickable


{-| -}
clickable : ButtonConfig msg -> ButtonConfig msg
clickable =
    withType ClickableBtn


{-| -}
submit : ButtonConfig msg -> ButtonConfig msg
submit =
    withType SubmitBtn


{-| -}
reset : ButtonConfig msg -> ButtonConfig msg
reset =
    withType ResetBtn


{-| -}
linkButton : String -> ButtonConfig msg -> ButtonConfig msg
linkButton href =
    withType <| LinkButton False href


{-| -}
linkButtonExternal : String -> ButtonConfig msg -> ButtonConfig msg
linkButtonExternal href =
    withType <| LinkButton True href


{-| -}
primary : ButtonConfig msg -> ButtonConfig msg
primary =
    withImportance Primary


{-| -}
secondary : ButtonConfig msg -> ButtonConfig msg
secondary =
    withImportance Secondary


{-| -}
tertiary : ButtonConfig msg -> ButtonConfig msg
tertiary =
    withImportance <| Tertiary With


{-| -}
tertiaryNoOutline : ButtonConfig msg -> ButtonConfig msg
tertiaryNoOutline =
    withImportance <| Tertiary Without


{-| -}
close : ButtonConfig msg -> ButtonConfig msg
close =
    withImportance Close


{-| -}
small : ButtonConfig msg -> ButtonConfig msg
small =
    withSize Small


{-| -}
medium : ButtonConfig msg -> ButtonConfig msg
medium =
    withSize Medium


{-| -}
large : ButtonConfig msg -> ButtonConfig msg
large =
    withSize Large


{-| -}
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
                BetaGouv.DSFR.Typography.externalLinkAttrs href []

              else
                [ Attr.href href ]
            )


iconAttr : String -> IconPosition -> ( List (Attribute msg), Html msg )
iconAttr label icon =
    case icon of
        NoIcon ->
            ( [ empty ], text label )

        LeftIcon iconName ->
            ( [ BetaGouv.DSFR.Icons.toClass iconName, class "fr-btn--icon-left" ], text label )

        RightIcon iconName ->
            ( [ BetaGouv.DSFR.Icons.toClass iconName, class "fr-btn--icon-right" ], text label )

        OnlyIcon iconName ->
            ( [ BetaGouv.DSFR.Icons.toClass iconName, Attr.title label ], nothing )


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


{-| Liste déroulante de boutons

    Button.dropdownSelector { label = "Actions", hint = Just "indication", id = "id" }
        <| [ Button.new ... ]

-}
dropdownSelector : { label : String, hint : Maybe String, id : String } -> List (Html msg) -> Html msg
dropdownSelector { label, hint, id } actions =
    nav
        [ Attr.attribute "role" "navigation"
        , Attr.class "fr-translate fr-nav"
        ]
        [ div
            [ Attr.class "fr-nav__item"
            ]
            [ button
                [ Attr.class "fr-btn fr-translate__btn"
                , Attr.attribute "aria-controls" id
                , Attr.attribute "aria-expanded" "false"
                , hint |> Maybe.map Attr.title |> Maybe.withDefault empty
                ]
                [ text label
                ]
            , div
                [ Attr.class "fr-collapse fr-translate__menu fr-menu"
                , Attr.id id
                ]
                [ ul [ Attr.class "fr-menu__list" ] <|
                    List.map (List.singleton >> li [ class "w-full" ]) <|
                        actions
                ]
            ]
        ]
