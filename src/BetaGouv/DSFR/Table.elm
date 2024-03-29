module BetaGouv.DSFR.Table exposing
    ( table, view
    , bordered, captionBottom, captionHidden, captionTop, fixed, noBorders, noScroll, scroll
    , withContainerAttrs, withTableAttrs, withCaptionAttrs, withTheadAttrs, withTbodyAttrs, withToRowAttrs
    , MandatoryConfig
    )

{-|


# Tableau

@docs table, view


# Options d'affichage

@docs bordered, captionBottom, captionHidden, captionTop, fixed, noBorders, noScroll, scroll


# Configuration des attributs

@docs withContainerAttrs, withTableAttrs, withCaptionAttrs, withTheadAttrs, withTbodyAttrs, withToRowAttrs


# Type

@docs MandatoryConfig

-}

import Accessibility exposing (Attribute, Html, div, td, th, tr)
import Html
import Html.Attributes exposing (class, scope)
import Html.Attributes.Extra exposing (static)
import Html.Keyed as Keyed


type alias TableConfig msg header data =
    ( MandatoryConfig msg header data, OptionalConfig data )


{-| -}
type alias MandatoryConfig msg header data =
    { id : String
    , caption : Html msg
    , headers : List header
    , rows : List data
    , toHeader : header -> Html msg
    , toRowId : data -> String
    , toCell : header -> data -> Html msg
    }


type alias OptionalConfig data =
    { borders : Bool
    , scrollable : ScrollType
    , captionPosition : CaptionPosition
    , containerAttrs : List (Attribute Never)
    , tableAttrs : List (Attribute Never)
    , captionAttrs : List (Attribute Never)
    , theadAttrs : List (Attribute Never)
    , tbodyAttrs : List (Attribute Never)
    , toRowAttrs : data -> List (Attribute Never)
    }


type CaptionPosition
    = Top
    | Bottom
    | Hidden


type ScrollType
    = Scroll
    | NoScroll
    | Fixed


{-| -}
bordered : TableConfig msg header data -> TableConfig msg header data
bordered ( mandatory, optional ) =
    ( mandatory, { optional | borders = True } )


{-| -}
noBorders : TableConfig msg header data -> TableConfig msg header data
noBorders ( mandatory, optional ) =
    ( mandatory, { optional | borders = False } )


{-| -}
captionTop : TableConfig msg header data -> TableConfig msg header data
captionTop ( mandatory, optional ) =
    ( mandatory, { optional | captionPosition = Top } )


{-| -}
captionBottom : TableConfig msg header data -> TableConfig msg header data
captionBottom ( mandatory, optional ) =
    ( mandatory, { optional | captionPosition = Bottom } )


{-| -}
captionHidden : TableConfig msg header data -> TableConfig msg header data
captionHidden ( mandatory, optional ) =
    ( mandatory, { optional | captionPosition = Hidden } )


{-| -}
scroll : TableConfig msg header data -> TableConfig msg header data
scroll ( mandatory, optional ) =
    ( mandatory, { optional | scrollable = Scroll } )


{-| -}
noScroll : TableConfig msg header data -> TableConfig msg header data
noScroll ( mandatory, optional ) =
    ( mandatory, { optional | scrollable = NoScroll } )


{-| -}
fixed : TableConfig msg header data -> TableConfig msg header data
fixed ( mandatory, optional ) =
    ( mandatory, { optional | scrollable = Fixed } )


{-| -}
withContainerAttrs : List (Attribute Never) -> TableConfig msg header data -> TableConfig msg header data
withContainerAttrs containerAttrs ( mandatory, optional ) =
    ( mandatory, { optional | containerAttrs = containerAttrs } )


{-| -}
withTableAttrs : List (Attribute Never) -> TableConfig msg header data -> TableConfig msg header data
withTableAttrs tableAttrs ( mandatory, optional ) =
    ( mandatory, { optional | tableAttrs = tableAttrs } )


{-| -}
withCaptionAttrs : List (Attribute Never) -> TableConfig msg header data -> TableConfig msg header data
withCaptionAttrs captionAttrs ( mandatory, optional ) =
    ( mandatory, { optional | captionAttrs = captionAttrs } )


{-| -}
withTheadAttrs : List (Attribute Never) -> TableConfig msg header data -> TableConfig msg header data
withTheadAttrs theadAttrs ( mandatory, optional ) =
    ( mandatory, { optional | theadAttrs = theadAttrs } )


{-| -}
withTbodyAttrs : List (Attribute Never) -> TableConfig msg header data -> TableConfig msg header data
withTbodyAttrs tbodyAttrs ( mandatory, optional ) =
    ( mandatory, { optional | tbodyAttrs = tbodyAttrs } )


{-| -}
withToRowAttrs : (data -> List (Attribute Never)) -> TableConfig msg header data -> TableConfig msg header data
withToRowAttrs toRowAttrs ( mandatory, optional ) =
    ( mandatory, { optional | toRowAttrs = toRowAttrs } )


defaultOptions : OptionalConfig data
defaultOptions =
    { borders = True
    , scrollable = Scroll
    , captionPosition = Top
    , containerAttrs = []
    , tableAttrs = []
    , captionAttrs = []
    , theadAttrs = []
    , tbodyAttrs = []
    , toRowAttrs = \_ -> []
    }


{-| Crée un tableau

    Table.table
        { id = "tableau"
        , caption = text "Utilisateurs"
        , headers = headers
        , rows = rows
        , toHeader = headerToString >> text
        , toRowId = toRowId
        , toCell = toCell
        }
        |> Table.withContainerAttrs [ class "!mb-0" ]
        |> Table.withToRowAttrs
        |> Table.noBorders
        |> Table.captionHidden
        |> Table.fixed
        |> Table.view

-}
table : MandatoryConfig msg header data -> TableConfig msg header data
table config =
    ( config, defaultOptions )


{-| Affiche le tableau
-}
view : TableConfig msg header data -> Html msg
view ( mandatory, optional ) =
    let
        { id, caption, headers, rows, toHeader, toRowId, toCell } =
            mandatory

        { borders, scrollable, captionPosition, containerAttrs, captionAttrs, tableAttrs, theadAttrs, tbodyAttrs, toRowAttrs } =
            optional

        borderedClass =
            class <|
                if borders then
                    "fr-table--bordered"

                else
                    ""

        captionClass =
            class <|
                case captionPosition of
                    Top ->
                        ""

                    Bottom ->
                        "fr-table--caption-bottom"

                    Hidden ->
                        "fr-table--no-caption"

        scrollClass =
            class <|
                case scrollable of
                    Scroll ->
                        ""

                    NoScroll ->
                        "fr-table--no-scroll"

                    Fixed ->
                        "fr-table--layout-fixed"

        toRow data =
            ( toRowId data
            , tr ((Html.Attributes.id <| toRowId data) :: toRowAttrs data) <|
                List.map (\header -> td [] [ toCell header data ]) <|
                    headers
            )
    in
    div
        (class "fr-table"
            :: Html.Attributes.id id
            :: borderedClass
            :: captionClass
            :: scrollClass
            :: containerAttrs
        )
        [ Accessibility.table tableAttrs
            [ Accessibility.caption captionAttrs
                [ caption ]
            , Html.thead (class "" :: List.map static theadAttrs) <|
                List.singleton <|
                    tr [] <|
                        List.map (th [ scope "col" ] << List.singleton << toHeader) <|
                            headers
            , Keyed.node "tbody" (class "" :: List.map (Html.Attributes.map never) tbodyAttrs) <|
                List.map toRow <|
                    rows
            ]
        ]
