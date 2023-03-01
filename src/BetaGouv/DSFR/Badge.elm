module BetaGouv.DSFR.Badge exposing
    ( badgeMD, badgeSM
    , default, system
    , Context
    , groupMD, groupSM
    , withColor, withAttrs
    )

{-| Badge


# Badges

@docs badgeMD, badgeSM


# Structure

@docs default, system


# Contexte de badge

@docs Context


# Groupe de badges

@docs groupMD, groupSM


# Configuration

@docs withColor, withAttrs

-}

import Accessibility exposing (Attribute, Html, li, p, span, ul)
import BetaGouv.DSFR.Color exposing (CustomColor)
import Html.Attributes exposing (class)
import Html.Attributes.Extra exposing (empty)
import Html.Extra exposing (static)


type BadgeConfig
    = Default { label : Label, color : CustomColor } (List (Attribute Never))
    | System { label : Label, context : Context, withIcon : Bool } (List (Attribute Never))


type alias Label =
    Html Never


type Size
    = SM
    | MD


{-| -}
type Context
    = Success
    | Error
    | Info
    | Warning
    | New


customColorToClass : CustomColor -> String
customColorToClass customColor =
    (++) "fr-badge--" <|
        case customColor of
            BetaGouv.DSFR.Color.Standard ->
                ""

            BetaGouv.DSFR.Color.GreenEmeraude ->
                "green-emeraude"

            BetaGouv.DSFR.Color.GreenMenthe ->
                "green-menthe"

            BetaGouv.DSFR.Color.BlueCumulus ->
                "blue-cumulus"

            BetaGouv.DSFR.Color.BlueFrance ->
                "blue-france"

            BetaGouv.DSFR.Color.BrownCaramel ->
                "brown-caramel"

            BetaGouv.DSFR.Color.BrownOpera ->
                "brown-opera"

            BetaGouv.DSFR.Color.PurpleGlycine ->
                "purple-glycine"


contextToClass : Context -> String
contextToClass context =
    (++) "fr-badge--" <|
        case context of
            Success ->
                "success"

            Error ->
                "error"

            Info ->
                "info"

            Warning ->
                "warning"

            New ->
                "new"


{-| Crée un badge de taille medium

    text "badge medium"
        |> Badge.system { context = DSFR.Badge.New, withIcon = True }
        |> Badge.badgeMD

-}
badgeMD : BadgeConfig -> Html msg
badgeMD =
    badge MD


{-| Crée un badge de petite taille

    text "petit badge"
        |> Badge.system { context = Badge.New, withIcon = True }
        |> Badge.badgeSM

-}
badgeSM : BadgeConfig -> Html msg
badgeSM =
    badge SM


{-| Crée un group de badges mediums
-}
groupMD : List BadgeConfig -> Html msg
groupMD =
    group MD


{-| Crée un group de petits badges
-}
groupSM : List BadgeConfig -> Html msg
groupSM =
    group SM


{-| Badge par défaut

    text "badge"
        |> Badge.default
        |> Badge.withColor Color.purpleGlycine
        |> Badge.badgeMD

-}
default : Html Never -> BadgeConfig
default label =
    Default { label = label, color = BetaGouv.DSFR.Color.standard } []


{-| Définit la couleur du badge par défaut
-}
withColor : CustomColor -> BadgeConfig -> BadgeConfig
withColor color config =
    case config of
        Default c attrs ->
            Default { c | color = color } attrs

        System _ _ ->
            config


{-| Badge système (avec icône optionnelle)

    text "badge"
        |> Badge.system { context = Badge.New, withIcon = True }
        |> Badge.badgeSM

-}
system : { context : Context, withIcon : Bool } -> Html Never -> BadgeConfig
system { context, withIcon } label =
    System { label = label, context = context, withIcon = withIcon } []


{-| Ajoute des attributs au badge
-}
withAttrs : List (Attribute Never) -> BadgeConfig -> BadgeConfig
withAttrs attrs config =
    case config of
        Default c _ ->
            Default c attrs

        System c _ ->
            System c attrs


group : Size -> List BadgeConfig -> Html msg
group size configs =
    static <|
        ul [ class "fr-badge-group" ] <|
            List.map (view size >> List.singleton >> li []) <|
                configs


badge : Size -> BadgeConfig -> Html msg
badge size config =
    static <|
        view size config


view : Size -> BadgeConfig -> Html Never
view size config =
    let
        sizeAttr =
            case size of
                MD ->
                    empty

                SM ->
                    class "fr-badge--sm"

        ( colorAttrs, iconAttrs ) =
            case config of
                Default { color } _ ->
                    ( class <| customColorToClass color, empty )

                System { context, withIcon } _ ->
                    ( class <| contextToClass context
                    , if withIcon then
                        empty

                      else
                        class "fr-badge--no-icon"
                    )

        ( content, extraAttrs ) =
            case config of
                Default { label } attrs ->
                    ( label, attrs )

                System { label } attrs ->
                    ( label, attrs )
    in
    span [] <|
        [ p
            (class "fr-badge"
                :: sizeAttr
                :: colorAttrs
                :: iconAttrs
                :: extraAttrs
            )
            [ content ]
        ]
