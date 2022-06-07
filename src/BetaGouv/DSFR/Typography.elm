module BetaGouv.DSFR.Typography exposing
    ( displayLg
    , displayMd
    , displaySm
    , displayXl
    , displayXs
    , downloadLinkLG
    , downloadLinkMD
    , downloadLinkSM
    , externalLink
    , externalLinkAttrs
    , fr_h1
    , fr_h2
    , fr_h3
    , fr_h4
    , fr_h5
    , fr_h6
    , link
    , linkLeftIcon
    , linkNoIcon
    , linkRightIcon
    , linkStandalone
    , linkStandaloneLG
    , linkStandaloneMD
    , linkStandaloneSM
    , scrollToTop
    , scrollToTopLG
    , scrollToTopMD
    , scrollToTopSM
    , textBold
    , textLead
    , textLg
    , textLight
    , textMd
    , textRegular
    , textSm
    , textSpectralHeavy
    , textSpectralRegular
    , textXl
    , textXs
    , titleLg
    , titleMd
    , titleSm
    , titleXl
    , titleXs
    )

import Accessibility exposing (Attribute, Html, a, text)
import BetaGouv.DSFR.Icons
import BetaGouv.DSFR.Icons.Document
import BetaGouv.DSFR.Icons.System
import Html.Attributes as Attr exposing (class)


fr_h1 : Attribute msg
fr_h1 =
    class "fr-h1"


fr_h2 : Attribute msg
fr_h2 =
    class "fr-h2"


fr_h3 : Attribute msg
fr_h3 =
    class "fr-h3"


fr_h4 : Attribute msg
fr_h4 =
    class "fr-h4"


fr_h5 : Attribute msg
fr_h5 =
    class "fr-h5"


fr_h6 : Attribute msg
fr_h6 =
    class "fr-h6"


displayXl : Attribute msg
displayXl =
    class "fr-display--xl"


displayLg : Attribute msg
displayLg =
    class "fr-display--lg"


displayMd : Attribute msg
displayMd =
    class "fr-display--md"


displaySm : Attribute msg
displaySm =
    class "fr-display--sm"


displayXs : Attribute msg
displayXs =
    class "fr-display--xs"


titleXl : Attribute msg
titleXl =
    displayXl


titleLg : Attribute msg
titleLg =
    displayLg


titleMd : Attribute msg
titleMd =
    displayMd


titleSm : Attribute msg
titleSm =
    displaySm


titleXs : Attribute msg
titleXs =
    displayXs


textXl : Attribute msg
textXl =
    class "fr-text--xl"


textLead : Attribute msg
textLead =
    textXl


textLg : Attribute msg
textLg =
    class "fr-text--lg"


textMd : Attribute msg
textMd =
    class "fr-text--md"


textSm : Attribute msg
textSm =
    class "fr-text--sm"


textXs : Attribute msg
textXs =
    class "fr-text--xs"


textLight : Attribute msg
textLight =
    class "fr-text--light"


textRegular : Attribute msg
textRegular =
    class "fr-text--regular"


textBold : Attribute msg
textBold =
    class "fr-text--bold"


textSpectralRegular : Attribute msg
textSpectralRegular =
    class "fr-text--regular fr-text--alt"


textSpectralHeavy : Attribute msg
textSpectralHeavy =
    class "fr-text--heavy fr-text--alt"


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


externalLink : String -> List (Attribute Never) -> List (Html msg) -> Html msg
externalLink href attrs children =
    a
        (externalLinkAttrs href attrs)
        children


externalLinkAttrs : String -> List (Attribute msg) -> List (Attribute msg)
externalLinkAttrs href attrs =
    Attr.href href
        :: Attr.target "_blank"
        :: Attr.rel "noopener"
        :: Attr.rel "noreferrer"
        :: attrs


type Icon
    = NoIcon
    | LeftIcon DSFR.Icons.IconName
    | RightIcon DSFR.Icons.IconName


type LinkSize
    = SM
    | MD
    | LG


linkNoIcon : Icon
linkNoIcon =
    NoIcon


linkLeftIcon : DSFR.Icons.IconName -> Icon
linkLeftIcon =
    LeftIcon


linkRightIcon : DSFR.Icons.IconName -> Icon
linkRightIcon =
    RightIcon


linkStandaloneSM : Icon -> String -> List (Attribute Never) -> List (Html msg) -> Html msg
linkStandaloneSM =
    linkStandaloneHelper SM


linkStandaloneMD : Icon -> String -> List (Attribute Never) -> List (Html msg) -> Html msg
linkStandaloneMD =
    linkStandaloneHelper MD


linkStandaloneLG : Icon -> String -> List (Attribute Never) -> List (Html msg) -> Html msg
linkStandaloneLG =
    linkStandaloneHelper LG


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
                    [ class "fr-link--icon-left", DSFR.Icons.toClass i ]

                RightIcon i ->
                    [ class "fr-link--icon-right", DSFR.Icons.toClass i ]
    in
    a (Attr.href href :: class "fr-link" :: sizeAttr :: iconAttrs ++ attrs) children


scrollToTopSM : Html msg
scrollToTopSM =
    scrollToTopHelper SM


scrollToTopMD : Html msg
scrollToTopMD =
    scrollToTopHelper MD


scrollToTopLG : Html msg
scrollToTopLG =
    scrollToTopHelper LG


scrollToTop : Html msg
scrollToTop =
    scrollToTopMD


scrollToTopHelper : LinkSize -> Html msg
scrollToTopHelper size =
    linkStandaloneHelper size (linkLeftIcon DSFR.Icons.System.arrowUpFill) "#top" [] [ text "Haut de page" ]


downloadLinkSM : String -> String -> String -> String -> Html msg
downloadLinkSM =
    downloadLinkHelper SM


downloadLinkMD : String -> String -> String -> String -> Html msg
downloadLinkMD =
    downloadLinkHelper MD


downloadLinkLG : String -> String -> String -> String -> Html msg
downloadLinkLG =
    downloadLinkHelper LG


downloadLinkHelper : LinkSize -> String -> String -> String -> String -> Html msg
downloadLinkHelper size href label fileFormat fileSize =
    linkStandaloneHelper size (linkLeftIcon DSFR.Icons.Document.fileDownloadLine) href [] [ text <| label ++ " (format " ++ fileFormat ++ " - " ++ fileSize ++ ")" ]
