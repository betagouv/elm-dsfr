module BetaGouv.DSFR.Media exposing
    ( img, imgLG, imgSM, svg
    , decorativeImg, decorativeImgLG, decorativeImgSM, decorativeSvg
    , withCaption, withResponsive
    )

{-|


# Image

@docs img, imgLG, imgSM, svg


# Image décorative

@docs decorativeImg, decorativeImgLG, decorativeImgSM, decorativeSvg


# Configuration

@docs withCaption, withResponsive

-}

import Accessibility exposing (Attribute, Html, div, figcaption, figure, text)
import Accessibility.Aria exposing (hidden, label)
import Html.Attributes exposing (class)
import Html.Attributes.Extra exposing (attributeMaybe, empty, role)
import Html.Extra
import Svg
import Svg.Attributes exposing (version)


type ImageConfig
    = ImageConfig
        { caption : Maybe String
        , responsive : Bool
        }


type ImageSize
    = MD
    | SM
    | LG


imgWrapper : ImageSize -> Maybe String -> List (Html msg) -> Html msg
imgWrapper size caption =
    let
        imageSize =
            case size of
                MD ->
                    empty

                SM ->
                    class "fr-content-media--sm"

                LG ->
                    class "fr-content-media--lg"
    in
    figure [ class "fr-content-media", imageSize, attributeMaybe label caption ]


genericImg : ImageSize -> String -> List (Attribute Never) -> ImageConfig -> Html msg
genericImg size alt attrs (ImageConfig { caption, responsive }) =
    let
        allAttrs =
            if responsive then
                class "fr-responsive-img" :: attrs

            else
                attrs
    in
    imgWrapper size caption <|
        [ div [ class "fr-content-media__img" ]
            [ Accessibility.img alt allAttrs ]
        , genericCaption caption
        ]


genericCaption : Maybe String -> Html msg
genericCaption =
    Html.Extra.viewMaybe (text >> List.singleton >> figcaption [ class "fr-content-media__caption" ])


{-| Crée une image de taille moyenne

    Media.img "Image" [ src "image.png", class "w-full" ] <|
        Media.withResponsive False <|
            Media.withCaption Nothing

-}
img : String -> List (Attribute Never) -> ImageConfig -> Html msg
img =
    genericImg MD


{-| Crée une image de grande taille
-}
imgLG : String -> List (Attribute Never) -> ImageConfig -> Html msg
imgLG =
    genericImg LG


{-| Crée une image de petite taille
-}
imgSM : String -> List (Attribute Never) -> ImageConfig -> Html msg
imgSM =
    genericImg SM


genericDecorativeImg : ImageSize -> List (Attribute Never) -> ImageConfig -> Html msg
genericDecorativeImg size attrs (ImageConfig { caption, responsive }) =
    let
        allAttrs =
            if responsive then
                class "fr-responsive-img" :: attrs

            else
                attrs
    in
    imgWrapper size caption <|
        [ div [ class "fr-content-media__img" ]
            [ Accessibility.decorativeImg (class "fr-responsive-img" :: allAttrs) ]
        , genericCaption caption
        ]


{-| Crée une image décorative de taille moyenne
-}
decorativeImg : List (Attribute Never) -> ImageConfig -> Html msg
decorativeImg =
    genericDecorativeImg MD


{-| Crée une image décorative de grande taille
-}
decorativeImgLG : List (Attribute Never) -> ImageConfig -> Html msg
decorativeImgLG =
    genericDecorativeImg LG


{-| Crée une image décorative de petite taille
-}
decorativeImgSM : List (Attribute Never) -> ImageConfig -> Html msg
decorativeImgSM =
    genericDecorativeImg SM


{-| -}
svg : String -> ImageConfig -> List (Svg.Svg msg) -> Html msg
svg alt (ImageConfig { caption }) children =
    imgWrapper MD caption <|
        [ div [ class "fr-content-media__img" ]
            [ Svg.svg [ version "1.1", role "img", label alt ]
                children
            ]
        , genericCaption caption
        ]


{-| -}
decorativeSvg : ImageConfig -> List (Svg.Svg msg) -> Html msg
decorativeSvg (ImageConfig { caption }) children =
    imgWrapper MD caption <|
        [ div [ class "fr-content-media__img" ]
            [ Svg.svg [ version "1.1", hidden True ]
                children
            ]
        , genericCaption caption
        ]


{-| -}
withCaption : Maybe String -> ImageConfig
withCaption caption =
    ImageConfig { caption = caption, responsive = True }


{-| -}
withResponsive : Bool -> ImageConfig -> ImageConfig
withResponsive responsive (ImageConfig config) =
    ImageConfig { config | responsive = responsive }
