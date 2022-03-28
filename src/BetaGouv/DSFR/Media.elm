module BetaGouv.DSFR.Media exposing (decorativeImg, decorativeImgLG, decorativeImgSM, decorativeSvg, img, imgLG, imgSM, svg, withCaption)

import Accessibility exposing (Attribute, Html, div, figcaption, figure, text)
import Accessibility.Aria exposing (hidden, label)
import Html.Attributes exposing (class)
import Html.Attributes.Extra exposing (attributeMaybe, empty, role)
import Html.Extra
import Svg
import Svg.Attributes exposing (version)


type ImageConfig
    = ImageConfig { caption : Maybe String }


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
genericImg size alt attrs (ImageConfig { caption }) =
    imgWrapper size caption <|
        [ div [ class "fr-content-media__img" ]
            [ Accessibility.img alt (class "fr-responsive-img" :: attrs) ]
        , genericCaption caption
        ]


genericCaption : Maybe String -> Html msg
genericCaption =
    Html.Extra.viewMaybe (text >> List.singleton >> figcaption [ class "fr-content-media__caption" ])


img : String -> List (Attribute Never) -> ImageConfig -> Html msg
img =
    genericImg MD


imgLG : String -> List (Attribute Never) -> ImageConfig -> Html msg
imgLG =
    genericImg LG


imgSM : String -> List (Attribute Never) -> ImageConfig -> Html msg
imgSM =
    genericImg SM


genericDecorativeImg : ImageSize -> List (Attribute Never) -> ImageConfig -> Html msg
genericDecorativeImg size attrs (ImageConfig { caption }) =
    imgWrapper size caption <|
        [ div [ class "fr-content-media__img" ]
            [ Accessibility.decorativeImg (class "fr-responsive-img" :: attrs) ]
        , genericCaption caption
        ]


decorativeImg : List (Attribute Never) -> ImageConfig -> Html msg
decorativeImg =
    genericDecorativeImg MD


decorativeImgLG : List (Attribute Never) -> ImageConfig -> Html msg
decorativeImgLG =
    genericDecorativeImg LG


decorativeImgSM : List (Attribute Never) -> ImageConfig -> Html msg
decorativeImgSM =
    genericDecorativeImg SM


svg : String -> ImageConfig -> List (Svg.Svg msg) -> Html msg
svg alt (ImageConfig { caption }) children =
    imgWrapper MD caption <|
        [ div [ class "fr-content-media__img" ]
            [ Svg.svg [ version "1.1", role "img", label alt ]
                children
            ]
        , genericCaption caption
        ]


decorativeSvg : ImageConfig -> List (Svg.Svg msg) -> Html msg
decorativeSvg (ImageConfig { caption }) children =
    imgWrapper MD caption <|
        [ div [ class "fr-content-media__img" ]
            [ Svg.svg [ version "1.1", hidden True ]
                children
            ]
        , genericCaption caption
        ]


withCaption : String -> ImageConfig
withCaption caption =
    ImageConfig { caption = Just caption }
