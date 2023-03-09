module BetaGouv.DSFR.Card exposing
    ( card, view
    , link, linkFull
    , horizontal, vertical
    , withArrow, withDescription, withDetails, withImage, withNoTitle
    )

{-|


# Carte

@docs card, view


# Lien

@docs link, linkFull


# Orientation

@docs horizontal, vertical


# Configuration

@docs withArrow, withDescription, withDetails, withImage, withNoTitle

-}

import Accessibility exposing (Html, a, decorativeImg, div, h4, p, text)
import Html.Attributes as Attr exposing (class)
import Html.Attributes.Extra exposing (empty)
import Html.Extra exposing (viewMaybe)


type alias CardConfig msg =
    ( String, Orientation, Options msg )


type alias Options msg =
    { href : Maybe String
    , fullLink : Bool
    , imageSrc : Maybe String
    , description : Maybe (Html msg)
    , details : Maybe (Html msg)
    , arrow : Bool
    , noTitle : Bool
    }


defaultOptions : Options msg
defaultOptions =
    { href = Nothing
    , fullLink = False
    , imageSrc = Nothing
    , description = Nothing
    , details = Nothing
    , arrow = True
    , noTitle = False
    }


type Orientation
    = Horizontal
    | Vertical


{-| -}
link : String -> CardConfig msg -> CardConfig msg
link href ( t, o, options ) =
    ( t, o, { options | href = Just href } )


{-| -}
linkFull : String -> CardConfig msg -> CardConfig msg
linkFull href ( t, o, options ) =
    ( t, o, { options | href = Just href, fullLink = True } )


{-| -}
withImage : Maybe String -> CardConfig msg -> CardConfig msg
withImage src ( t, o, options ) =
    ( t, o, { options | imageSrc = src } )


{-| -}
withArrow : Bool -> CardConfig msg -> CardConfig msg
withArrow arrow ( t, o, options ) =
    ( t, o, { options | arrow = arrow } )


{-| -}
withDescription : Maybe (Html msg) -> CardConfig msg -> CardConfig msg
withDescription description ( t, o, options ) =
    ( t, o, { options | description = description } )


{-| -}
withDetails : Maybe (Html msg) -> CardConfig msg -> CardConfig msg
withDetails details ( t, o, options ) =
    ( t, o, { options | details = details } )


{-| -}
withNoTitle : CardConfig msg -> CardConfig msg
withNoTitle ( t, o, options ) =
    ( t, o, { options | noTitle = True } )


{-| -}
vertical : Orientation
vertical =
    Vertical


{-| -}
horizontal : Orientation
horizontal =
    Horizontal


{-| Crée une carte

    Card.card "titre" Card.vertical
        |> Card.link "/url"
        |> Card.withArrow False
        |> Card.withNoTitle
        |> Card.withDescription (Just (text description))
        |> Card.view

-}
card : String -> Orientation -> CardConfig msg
card title orientation =
    ( title, orientation, defaultOptions )


{-| -}
view : CardConfig msg -> Html msg
view ( title, orientation, { href, fullLink, imageSrc, description, details, arrow, noTitle } ) =
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
                class "fr-card--no-arrow fr-card--no-icon"

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
                [ class "fr-card__title"
                , if noTitle then
                    class "!m-4"

                  else
                    class ""
                ]
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
