module BetaGouv.DSFR.Typography exposing
    ( textLead, textXl, textLg, textMd, textSm, textXs
    , textLight, textRegular, textBold
    , textSpectralRegular, textSpectralHeavy
    , fr_h1, fr_h2, fr_h3, fr_h4, fr_h5, fr_h6
    , displayXl, displayLg, displayMd, displaySm, displayXs
    , link, linkLeftIcon, linkNoIcon, linkRightIcon, linkStandalone, linkStandaloneLG, linkStandaloneMD, linkStandaloneSM
    , scrollToTop, scrollToTopLG, scrollToTopMD, scrollToTopSM
    , externalLink, externalLinkAttrs
    , downloadLinkLG, downloadLinkMD, downloadLinkSM
    )

{-|


# Typographie


## Tailles

@docs textLead, textXl, textLg, textMd, textSm, textXs


## Epaisseurs avec la police principale Marianne

@docs textLight, textRegular, textBold


## Epaisseurs avec la police alternative Spectral

@docs textSpectralRegular, textSpectralHeavy


# Titres


## Personnalisation des titres

@docs fr_h1, fr_h2, fr_h3, fr_h4, fr_h5, fr_h6


## Titres alternatifs

@docs displayXl, displayLg, displayMd, displaySm, displayXs


# Liens


## Liens standards

@docs link, linkLeftIcon, linkNoIcon, linkRightIcon, linkStandalone, linkStandaloneLG, linkStandaloneMD, linkStandaloneSM


## Liens de retour en haut de page

@docs scrollToTop, scrollToTopLG, scrollToTopMD, scrollToTopSM


## Liens externes

@docs externalLink, externalLinkAttrs


## Liens de téléchargement

@docs downloadLinkLG, downloadLinkMD, downloadLinkSM

-}

import Accessibility exposing (Attribute, Html, a, text)
import BetaGouv.DSFR.Icons
import BetaGouv.DSFR.Icons.Document
import BetaGouv.DSFR.Icons.System
import Html.Attributes as Attr exposing (class)


{-| classe pour h1
-}
fr_h1 : Attribute msg
fr_h1 =
    class "fr-h1"


{-| classe pour h2
-}
fr_h2 : Attribute msg
fr_h2 =
    class "fr-h2"


{-| classe pour h3
-}
fr_h3 : Attribute msg
fr_h3 =
    class "fr-h3"


{-| classe pour h4
-}
fr_h4 : Attribute msg
fr_h4 =
    class "fr-h4"


{-| classe pour h5
-}
fr_h5 : Attribute msg
fr_h5 =
    class "fr-h5"


{-| classe pour h6
-}
fr_h6 : Attribute msg
fr_h6 =
    class "fr-h6"


{-| classe pour un titre alternatif Xl
-}
displayXl : Attribute msg
displayXl =
    class "fr-display--xl"


{-| classe pour un titre alternatif Lg
-}
displayLg : Attribute msg
displayLg =
    class "fr-display--lg"


{-| classe pour un titre alternatif Md
-}
displayMd : Attribute msg
displayMd =
    class "fr-display--md"


{-| classe pour un titre alternatif Sm
-}
displaySm : Attribute msg
displaySm =
    class "fr-display--sm"


{-| classe pour un titre alternatif Xs
-}
displayXs : Attribute msg
displayXs =
    class "fr-display--xs"


{-| classe pour texte de taille Xl
-}
textXl : Attribute msg
textXl =
    class "fr-text--xl"


{-| classe pour texte chapô
-}
textLead : Attribute msg
textLead =
    textXl


{-| classe pour texte de taille Lg
-}
textLg : Attribute msg
textLg =
    class "fr-text--lg"


{-| classe pour texte de taille Md
-}
textMd : Attribute msg
textMd =
    class "fr-text--md"


{-| classe pour texte de taille Sm
-}
textSm : Attribute msg
textSm =
    class "fr-text--sm"


{-| classe pour texte de taille Xs
-}
textXs : Attribute msg
textXs =
    class "fr-text--xs"


{-| classe pour texte light
-}
textLight : Attribute msg
textLight =
    class "fr-text--light"


{-| classe pour texte regular
-}
textRegular : Attribute msg
textRegular =
    class "fr-text--regular"


{-| classe pour texte bold
-}
textBold : Attribute msg
textBold =
    class "fr-text--bold"


{-| -}
textSpectralRegular : Attribute msg
textSpectralRegular =
    class "fr-text--regular fr-text--alt"


{-| -}
textSpectralHeavy : Attribute msg
textSpectralHeavy =
    class "fr-text--heavy fr-text--alt"


{-| -}
link : String -> List (Attribute Never) -> List (Html msg) -> Html msg
link href attrs children =
    let
        nonEmptyHref =
            if href == "" then
                attrs

            else
                Attr.href href :: attrs
    in
    a nonEmptyHref children


{-| -}
externalLink : String -> List (Attribute Never) -> List (Html msg) -> Html msg
externalLink href attrs children =
    a
        (externalLinkAttrs href attrs)
        children


{-| -}
externalLinkAttrs : String -> List (Attribute msg) -> List (Attribute msg)
externalLinkAttrs href attrs =
    Attr.href href
        :: Attr.target "_blank"
        :: Attr.rel "noopener"
        :: Attr.rel "noreferrer"
        :: attrs


type Icon
    = NoIcon
    | LeftIcon BetaGouv.DSFR.Icons.IconName
    | RightIcon BetaGouv.DSFR.Icons.IconName


type LinkSize
    = SM
    | MD
    | LG


{-| -}
linkNoIcon : Icon
linkNoIcon =
    NoIcon


{-| -}
linkLeftIcon : BetaGouv.DSFR.Icons.IconName -> Icon
linkLeftIcon =
    LeftIcon


{-| -}
linkRightIcon : BetaGouv.DSFR.Icons.IconName -> Icon
linkRightIcon =
    RightIcon


{-| -}
linkStandaloneSM : Icon -> String -> List (Attribute Never) -> List (Html msg) -> Html msg
linkStandaloneSM =
    linkStandaloneHelper SM


{-| -}
linkStandaloneMD : Icon -> String -> List (Attribute Never) -> List (Html msg) -> Html msg
linkStandaloneMD =
    linkStandaloneHelper MD


{-| -}
linkStandaloneLG : Icon -> String -> List (Attribute Never) -> List (Html msg) -> Html msg
linkStandaloneLG =
    linkStandaloneHelper LG


{-| -}
linkStandalone : Icon -> String -> List (Attribute Never) -> List (Html msg) -> Html msg
linkStandalone =
    linkStandaloneMD


linkStandaloneHelper : LinkSize -> Icon -> String -> List (Attribute Never) -> List (Html msg) -> Html msg
linkStandaloneHelper size icon href attrs children =
    let
        sizeAttr =
            case size of
                SM ->
                    class "fr-link--sm"

                MD ->
                    class "fr-link--md"

                LG ->
                    class "fr-link--lg"

        iconAttrs =
            case icon of
                NoIcon ->
                    []

                LeftIcon i ->
                    [ class "fr-link--icon-left", BetaGouv.DSFR.Icons.toClass i ]

                RightIcon i ->
                    [ class "fr-link--icon-right", BetaGouv.DSFR.Icons.toClass i ]
    in
    a (Attr.href href :: class "fr-link" :: sizeAttr :: iconAttrs ++ attrs) children


{-| -}
scrollToTopSM : Html msg
scrollToTopSM =
    scrollToTopHelper SM


{-| -}
scrollToTopMD : Html msg
scrollToTopMD =
    scrollToTopHelper MD


{-| -}
scrollToTopLG : Html msg
scrollToTopLG =
    scrollToTopHelper LG


{-| -}
scrollToTop : Html msg
scrollToTop =
    scrollToTopMD


scrollToTopHelper : LinkSize -> Html msg
scrollToTopHelper size =
    linkStandaloneHelper size (linkLeftIcon BetaGouv.DSFR.Icons.System.arrowUpFill) "#top" [] [ text "Haut de page" ]


{-| -}
downloadLinkSM : String -> String -> String -> String -> Html msg
downloadLinkSM =
    downloadLinkHelper SM


{-| -}
downloadLinkMD : String -> String -> String -> String -> Html msg
downloadLinkMD =
    downloadLinkHelper MD


{-| -}
downloadLinkLG : String -> String -> String -> String -> Html msg
downloadLinkLG =
    downloadLinkHelper LG


{-| -}
downloadLinkHelper : LinkSize -> String -> String -> String -> String -> Html msg
downloadLinkHelper size href label fileFormat fileSize =
    linkStandaloneHelper size (linkLeftIcon BetaGouv.DSFR.Icons.Document.fileDownloadLine) href [] [ text <| label ++ " (format " ++ fileFormat ++ " - " ++ fileSize ++ ")" ]
