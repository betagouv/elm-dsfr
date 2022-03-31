module BetaGouv.DSFR.Card exposing (card, link, linkFull, view, withArrow, withDescription, withDetails, withImage)

import Accessibility exposing (Html, a, decorativeImg, div, h4, p, text)
import Html.Attributes as Attr exposing (class)
import Html.Attributes.Extra exposing (empty)
import Html.Extra exposing (viewMaybe)


type alias CardConfig msg =
    ( String, Options msg )


type alias Options msg =
    { href : Maybe String
    , fullLink : Bool
    , imageSrc : Maybe String
    , description : Maybe (Html msg)
    , details : Maybe (Html msg)
    , arrow : Bool
    }


defaultOptions : Options msg
defaultOptions =
    { href = Nothing
    , fullLink = False
    , imageSrc = Nothing
    , description = Nothing
    , details = Nothing
    , arrow = False
    }


type Orientation
    = Horizontal
    | Vertical


link : String -> Options msg -> Options msg
link href options =
    { options | href = Just href }


linkFull : String -> Options msg -> Options msg
linkFull href options =
    { options | href = Just href, fullLink = True }


withImage : Maybe String -> Options msg -> Options msg
withImage src options =
    { options | imageSrc = src }


withArrow : Bool -> Options msg -> Options msg
withArrow arrow options =
    { options | arrow = arrow }


withDescription : Maybe (Html msg) -> Options msg -> Options msg
withDescription description options =
    { options | description = description }


withDetails : Maybe (Html msg) -> Options msg -> Options msg
withDetails details options =
    { options | details = details }


card : String -> CardConfig msg
card title =
    ( title, defaultOptions )


view : Orientation -> CardConfig msg -> Html msg
view orientation ( title, { href, fullLink, imageSrc, description, details, arrow } ) =
    let
        orientationClass =
            case orientation of
                Horizontal ->
                    class "fr-card--horizontal"

                Vertical ->
                    class ""

        enlargeClass =
            if fullLink then
                class "fr-enlarge-link"

            else
                empty

        arrowClass =
            if not arrow || href == Nothing then
                class "fr-card--no-arrow"

            else
                empty

        cardTitle =
            href
                |> Maybe.map
                    (\h ->
                        a
                            [ class "fr-card__link", Attr.href h ]
                            [ text title ]
                    )
                |> Maybe.withDefault (text title)
    in
    div
        [ class "fr-card", orientationClass, enlargeClass, arrowClass ]
        [ div
            [ class "fr-card__body" ]
            [ h4
                [ class "fr-card__title" ]
                [ cardTitle ]
            , viewMaybe
                (\desc ->
                    p
                        [ class "fr-card__desc" ]
                        [ desc ]
                )
                description
            , viewMaybe
                (\det ->
                    p
                        [ class "fr-card__detail"
                        ]
                        [ det ]
                )
                details
            ]
        , viewMaybe
            (\src ->
                div
                    [ class "fr-card__img" ]
                    [ decorativeImg
                        [ Attr.src src
                        , class "fr-responsive-img"
                        ]
                    ]
            )
            imageSrc
        ]
