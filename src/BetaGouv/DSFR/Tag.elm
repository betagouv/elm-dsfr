module BetaGouv.DSFR.Tag exposing (..)

import Accessibility exposing (Attribute, Html, a, button, li, p, text, ul)
import Accessibility.Aria exposing (pressed)
import BetaGouv.DSFR.Icons exposing (IconName)
import Html.Attributes exposing (class, href, type_)
import Html.Attributes.Extra exposing (empty)
import Html.Events exposing (onClick)


type alias TagConfig msg data =
    ( MandatoryConfig data
    , Tag msg data
    , OptionalConfig
    )


type alias MandatoryConfig data =
    { data : data
    , toString : data -> String
    }


type Tag msg data
    = Unclickable
    | Clickable Href
    | Selectable Checked (data -> msg)
    | Deletable (data -> msg)


type Href
    = Href String


type Checked
    = Checked Bool


type alias OptionalConfig =
    { icon : Icon
    , extraAttrs : List (Attribute Never)
    }


defaultOptions : OptionalConfig
defaultOptions =
    { icon = NoIcon
    , extraAttrs = []
    }


type Size
    = SM
    | MD


type Icon
    = NoIcon
    | LeftIcon IconName
    | RightIcon IconName


unclickable : MandatoryConfig data -> TagConfig msg data
unclickable config =
    ( config, Unclickable, defaultOptions )


clickable : String -> MandatoryConfig data -> TagConfig msg data
clickable link label =
    ( label, Clickable (Href link), defaultOptions )


selectable : (data -> msg) -> Bool -> MandatoryConfig data -> TagConfig msg data
selectable selectMsg checked label =
    ( label, Selectable (Checked checked) selectMsg, defaultOptions )


deletable : (data -> msg) -> MandatoryConfig data -> TagConfig msg data
deletable deleteMsg label =
    ( label, Deletable deleteMsg, defaultOptions )


view : Size -> TagConfig msg data -> Html msg
view size ( { data, toString }, tag, { icon, extraAttrs } ) =
    let
        tagAttrs =
            class "fr-tag"

        sizeAttrs =
            case size of
                SM ->
                    class "fr-tag--sm"

                MD ->
                    empty

        iconAttrs =
            case icon of
                NoIcon ->
                    empty

                LeftIcon iconName ->
                    class <| "fr-tag--icon-left " ++ DSFR.Icons.toClassName iconName

                RightIcon iconName ->
                    class <| "fr-tag--icon-right " ++ DSFR.Icons.toClassName iconName
    in
    case tag of
        Unclickable ->
            p
                (tagAttrs
                    :: sizeAttrs
                    :: iconAttrs
                    :: extraAttrs
                )
                [ text <| toString data ]

        Clickable (Href link) ->
            a
                (href link
                    :: tagAttrs
                    :: sizeAttrs
                    :: iconAttrs
                    :: extraAttrs
                )
                [ text <| toString data ]

        Selectable (Checked checked) msg ->
            button
                ((onClick <| msg data)
                    :: type_ "button"
                    :: (pressed <| Just checked)
                    :: tagAttrs
                    :: sizeAttrs
                    :: List.map Html.Attributes.Extra.static extraAttrs
                )
                [ text <| toString data ]

        Deletable msg ->
            button
                ((onClick <| msg data)
                    :: type_ "button"
                    :: tagAttrs
                    :: sizeAttrs
                    :: class "fr-tag--dismiss"
                    :: Accessibility.Aria.label ("Retirer " ++ toString data)
                    :: List.map Html.Attributes.Extra.static extraAttrs
                )
                [ text <| toString data ]


small : List (TagConfig msg data) -> Html msg
small =
    group SM


medium : List (TagConfig msg data) -> Html msg
medium =
    group MD


group : Size -> List (TagConfig msg data) -> Html msg
group size configs =
    ul [ class "fr-tags-group" ] <|
        List.map (view size >> List.singleton >> li []) <|
            configs


withAttrs : List (Attribute Never) -> TagConfig msg data -> TagConfig msg data
withAttrs extraAttrs ( mandatory, tag, optional ) =
    ( mandatory, tag, { optional | extraAttrs = extraAttrs } )


withIcon : DSFR.Icons.IconName -> TagConfig msg data -> TagConfig msg data
withIcon iconName ( mandatory, tag, optional ) =
    ( mandatory, tag, { optional | icon = LeftIcon iconName } )
