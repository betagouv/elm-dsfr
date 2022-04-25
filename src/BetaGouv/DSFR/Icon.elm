module BetaGouv.DSFR.Icon exposing
    ( IconName
    , accountFill
    , accountLine
    , addCircleFill
    , addCircleLine
    , addLine
    , allIcons
    , arrowDownLine
    , arrowDownSLine
    , arrowGoBackFill
    , arrowGoBackLine
    , arrowLeftLine
    , arrowLeftSFirstLine
    , arrowLeftSLine
    , arrowLeftSLineDouble
    , arrowRightLine
    , arrowRightSLastLine
    , arrowRightSLine
    , arrowRightSLineDouble
    , arrowRightUpLine
    , arrowUpFill
    , arrowUpLine
    , arrowUpSLine
    , attachmentFill
    , attachmentLine
    , bold
    , calendarFill
    , calendarLine
    , chatQuoteFill
    , chatQuoteLine
    , checkLine
    , closeLine
    , custom
    , dailymotionFill
    , dailymotionLine
    , deleteFill
    , deleteLine
    , downloadLine
    , editFill
    , editLine
    , equalizerFill
    , equalizerLine
    , errorFill
    , errorLine
    , errorWarningFill
    , errorWarningLine
    , externalLinkLine
    , eyeFill
    , eyeLine
    , eyeOffFill
    , eyeOffLine
    , facebookCircleFill
    , facebookCircleLine
    , fileDownloadFill
    , fileDownloadLine
    , fileFill
    , fileLine
    , filePdfFill
    , filePdfLine
    , filterFill
    , filterLine
    , flashlightFill
    , flashlightLine
    , fontSize
    , githubFill
    , githubLine
    , highlight
    , home4Fill
    , home4Line
    , icon
    , iconLG
    , iconMD
    , iconXL
    , imageFill
    , imageLine
    , infoFill
    , infoLine
    , informationFill
    , informationLine
    , instagramFill
    , instagramLine
    , italic
    , lineChartFill
    , lineChartLine
    , linkUnlink
    , linkedinBoxFill
    , linkedinBoxLine
    , linksFill
    , listOrdered
    , listUnordered
    , lockFill
    , lockLine
    , logoutBoxRFill
    , logoutBoxRLine
    , mailFill
    , mailLine
    , mapPin2Fill
    , mapPin2Line
    , menu2Fill
    , menuFill
    , npmjsFill
    , npmjsLine
    , pauseCircleFill
    , pauseCircleLine
    , phoneFill
    , phoneLine
    , playFill
    , playLine
    , printerFill
    , printerLine
    , questionFill
    , questionLine
    , refreshFill
    , refreshLine
    , remixiconFill
    , remixiconLine
    , roadMapFill
    , roadMapLine
    , rssFill
    , rssLine
    , saveFill
    , saveLine
    , searchFill
    , searchLine
    , slackFill
    , slackLine
    , snapchatFill
    , snapchatLine
    , subtractLine
    , successFill
    , successLine
    , telegramFill
    , telegramLine
    , themeFill
    , tiktokFill
    , tiktokLine
    , toClass
    , toClassName
    , twitchFill
    , twitchLine
    , twitterFill
    , twitterLine
    , upload2Fill
    , upload2Line
    , userFill
    , userLine
    , vimeoFill
    , vimeoLine
    , volumeDownFill
    , volumeDownLine
    , volumeMuteFill
    , volumeMuteLine
    , volumeUpFill
    , volumeUpLine
    , warningFill
    , warningLine
    , youtubeFill
    , youtubeLine
    , zoomInFill
    , zoomInLine
    , zoomOutFill
    , zoomOutLine
    )

import Accessibility exposing (Attribute, Html, span)
import Html.Attributes exposing (attribute, class)


type IconName
    = IconName String


type IconSize
    = MD
    | LG
    | XL


genericIcon : IconSize -> IconName -> Html msg
genericIcon size iconName =
    let
        iconSize =
            case size of
                MD ->
                    ""

                LG ->
                    "fr-fi--lg"

                XL ->
                    "fr-fi--xl"
    in
    span
        [ toClass iconName
        , class iconSize
        , attribute "aria-hidden" "true"
        ]
        []


toClass : IconName -> Attribute msg
toClass =
    class << toClassName


toClassName : IconName -> String
toClassName (IconName iconName) =
    iconName


icon : IconName -> Html msg
icon =
    iconMD


iconMD : IconName -> Html msg
iconMD =
    genericIcon MD


iconLG : IconName -> Html msg
iconLG =
    genericIcon LG


iconXL : IconName -> Html msg
iconXL =
    genericIcon XL


custom : String -> IconName
custom =
    IconName


successFill : IconName
successFill =
    IconName "fr-icon-success-fill"


successLine : IconName
successLine =
    IconName "fr-icon-success-line"


errorFill : IconName
errorFill =
    IconName "fr-icon-error-fill"


errorLine : IconName
errorLine =
    IconName "fr-icon-error-line"


infoFill : IconName
infoFill =
    IconName "fr-icon-info-fill"


infoLine : IconName
infoLine =
    IconName "fr-icon-info-line"


warningFill : IconName
warningFill =
    IconName "fr-icon-warning-fill"


warningLine : IconName
warningLine =
    IconName "fr-icon-warning-line"


flashlightFill : IconName
flashlightFill =
    IconName "fr-icon-flashlight-fill"


flashlightLine : IconName
flashlightLine =
    IconName "fr-icon-flashlight-line"


menuFill : IconName
menuFill =
    IconName "fr-fi-menu-fill"


menu2Fill : IconName
menu2Fill =
    IconName "fr-fi-menu-2-fill"


arrowUpLine : IconName
arrowUpLine =
    IconName "fr-fi-arrow-up-line"


arrowUpFill : IconName
arrowUpFill =
    IconName "fr-fi-arrow-up-fill"


arrowRightLine : IconName
arrowRightLine =
    IconName "fr-fi-arrow-right-line"


arrowDownLine : IconName
arrowDownLine =
    IconName "fr-fi-arrow-down-line"


arrowLeftLine : IconName
arrowLeftLine =
    IconName "fr-fi-arrow-left-line"


arrowUpSLine : IconName
arrowUpSLine =
    IconName "fr-fi-arrow-up-s-line"


arrowRightSLine : IconName
arrowRightSLine =
    IconName "fr-fi-arrow-right-s-line"


arrowDownSLine : IconName
arrowDownSLine =
    IconName "fr-fi-arrow-down-s-line"


arrowLeftSLine : IconName
arrowLeftSLine =
    IconName "fr-fi-arrow-left-s-line"


arrowLeftSFirstLine : IconName
arrowLeftSFirstLine =
    IconName "fr-fi-arrow-left-s-first-line"


arrowLeftSLineDouble : IconName
arrowLeftSLineDouble =
    IconName "fr-fi-arrow-left-s-line-double"


arrowRightSLastLine : IconName
arrowRightSLastLine =
    IconName "fr-fi-arrow-right-s-last-line"


arrowRightSLineDouble : IconName
arrowRightSLineDouble =
    IconName "fr-fi-arrow-right-s-line-double"


arrowRightUpLine : IconName
arrowRightUpLine =
    IconName "fr-fi-arrow-right-up-line"


arrowGoBackFill : IconName
arrowGoBackFill =
    IconName "fr-fi-arrow-go-back-fill"


arrowGoBackLine : IconName
arrowGoBackLine =
    IconName "fr-fi-arrow-go-back-line"


userFill : IconName
userFill =
    IconName "fr-fi-user-fill"


userLine : IconName
userLine =
    IconName "fr-fi-user-line"


accountFill : IconName
accountFill =
    IconName "fr-fi-account-fill"


accountLine : IconName
accountLine =
    IconName "fr-fi-account-line"


lockFill : IconName
lockFill =
    IconName "fr-fi-lock-fill"


lockLine : IconName
lockLine =
    IconName "fr-fi-lock-line"


logoutBoxRFill : IconName
logoutBoxRFill =
    IconName "fr-fi-logout-box-r-fill"


logoutBoxRLine : IconName
logoutBoxRLine =
    IconName "fr-fi-logout-box-r-line"


home4Fill : IconName
home4Fill =
    IconName "fr-fi-home-4-fill"


home4Line : IconName
home4Line =
    IconName "fr-fi-home-4-line"


addCircleFill : IconName
addCircleFill =
    IconName "fr-fi-add-circle-fill"


addCircleLine : IconName
addCircleLine =
    IconName "fr-fi-add-circle-line"


subtractLine : IconName
subtractLine =
    IconName "fr-fi-subtract-line"


addLine : IconName
addLine =
    IconName "fr-fi-add-line"


closeLine : IconName
closeLine =
    IconName "fr-fi-close-line"


checkLine : IconName
checkLine =
    IconName "fr-fi-check-line"


informationFill : IconName
informationFill =
    IconName "fr-fi-information-fill"


informationLine : IconName
informationLine =
    IconName "fr-fi-information-line"


questionFill : IconName
questionFill =
    IconName "fr-fi-question-fill"


questionLine : IconName
questionLine =
    IconName "fr-fi-question-line"


errorWarningFill : IconName
errorWarningFill =
    IconName "fr-fi-error-warning-fill"


errorWarningLine : IconName
errorWarningLine =
    IconName "fr-fi-error-warning-line"


searchFill : IconName
searchFill =
    IconName "fr-fi-search-fill"


searchLine : IconName
searchLine =
    IconName "fr-fi-search-line"


eyeFill : IconName
eyeFill =
    IconName "fr-fi-eye-fill"


eyeLine : IconName
eyeLine =
    IconName "fr-fi-eye-line"


eyeOffFill : IconName
eyeOffFill =
    IconName "fr-fi-eye-off-fill"


eyeOffLine : IconName
eyeOffLine =
    IconName "fr-fi-eye-off-line"


zoomInFill : IconName
zoomInFill =
    IconName "fr-fi-zoom-in-fill"


zoomInLine : IconName
zoomInLine =
    IconName "fr-fi-zoom-in-line"


zoomOutFill : IconName
zoomOutFill =
    IconName "fr-fi-zoom-out-fill"


zoomOutLine : IconName
zoomOutLine =
    IconName "fr-fi-zoom-out-line"


printerFill : IconName
printerFill =
    IconName "fr-fi-printer-fill"


printerLine : IconName
printerLine =
    IconName "fr-fi-printer-line"


upload2Fill : IconName
upload2Fill =
    IconName "fr-fi-upload-2-fill"


upload2Line : IconName
upload2Line =
    IconName "fr-fi-upload-2-line"


fileDownloadFill : IconName
fileDownloadFill =
    IconName "fr-fi-file-download-fill"


fileDownloadLine : IconName
fileDownloadLine =
    IconName "fr-fi-file-download-line"


downloadLine : IconName
downloadLine =
    IconName "fr-fi-download-line"


externalLinkLine : IconName
externalLinkLine =
    IconName "fr-fi-external-link-line"


editFill : IconName
editFill =
    IconName "fr-fi-edit-fill"


editLine : IconName
editLine =
    IconName "fr-fi-edit-line"


linksFill : IconName
linksFill =
    IconName "fr-fi-links-fill"


linkUnlink : IconName
linkUnlink =
    IconName "fr-fi-link-unlink"


deleteLine : IconName
deleteLine =
    IconName "fr-fi-delete-line"


deleteFill : IconName
deleteFill =
    IconName "fr-fi-delete-fill"


saveFill : IconName
saveFill =
    IconName "fr-fi-save-fill"


saveLine : IconName
saveLine =
    IconName "fr-fi-save-line"


calendarFill : IconName
calendarFill =
    IconName "fr-fi-calendar-fill"


calendarLine : IconName
calendarLine =
    IconName "fr-fi-calendar-line"


fileFill : IconName
fileFill =
    IconName "fr-fi-file-fill"


fileLine : IconName
fileLine =
    IconName "fr-fi-file-line"


mailFill : IconName
mailFill =
    IconName "fr-fi-mail-fill"


mailLine : IconName
mailLine =
    IconName "fr-fi-mail-line"


phoneFill : IconName
phoneFill =
    IconName "fr-fi-phone-fill"


phoneLine : IconName
phoneLine =
    IconName "fr-fi-phone-line"


refreshFill : IconName
refreshFill =
    IconName "fr-fi-refresh-fill"


refreshLine : IconName
refreshLine =
    IconName "fr-fi-refresh-line"


equalizerFill : IconName
equalizerFill =
    IconName "fr-fi-equalizer-fill"


equalizerLine : IconName
equalizerLine =
    IconName "fr-fi-equalizer-line"


filterFill : IconName
filterFill =
    IconName "fr-fi-filter-fill"


filterLine : IconName
filterLine =
    IconName "fr-fi-filter-line"


attachmentFill : IconName
attachmentFill =
    IconName "fr-fi-attachment-fill"


attachmentLine : IconName
attachmentLine =
    IconName "fr-fi-attachment-line"


italic : IconName
italic =
    IconName "fr-fi-italic"


listOrdered : IconName
listOrdered =
    IconName "fr-fi-list-ordered"


listUnordered : IconName
listUnordered =
    IconName "fr-fi-list-unordered"


fontSize : IconName
fontSize =
    IconName "fr-fi-font-size"


bold : IconName
bold =
    IconName "fr-icon-bold"


highlight : IconName
highlight =
    IconName "fr-icon-highlight"


playFill : IconName
playFill =
    IconName "fr-fi-play-fill"


playLine : IconName
playLine =
    IconName "fr-fi-play-line"


volumeUpFill : IconName
volumeUpFill =
    IconName "fr-fi-volume-up-fill"


volumeUpLine : IconName
volumeUpLine =
    IconName "fr-fi-volume-up-line"


volumeMuteFill : IconName
volumeMuteFill =
    IconName "fr-fi-volume-mute-fill"


volumeMuteLine : IconName
volumeMuteLine =
    IconName "fr-fi-volume-mute-line"


volumeDownFill : IconName
volumeDownFill =
    IconName "fr-fi-volume-down-fill"


volumeDownLine : IconName
volumeDownLine =
    IconName "fr-fi-volume-down-line"


pauseCircleFill : IconName
pauseCircleFill =
    IconName "fr-fi-pause-circle-fill"


pauseCircleLine : IconName
pauseCircleLine =
    IconName "fr-fi-pause-circle-line"


filePdfFill : IconName
filePdfFill =
    IconName "fr-fi-file-pdf-fill"


filePdfLine : IconName
filePdfLine =
    IconName "fr-fi-file-pdf-line"


chatQuoteFill : IconName
chatQuoteFill =
    IconName "fr-fi-chat-quote-fill"


chatQuoteLine : IconName
chatQuoteLine =
    IconName "fr-fi-chat-quote-line"


rssFill : IconName
rssFill =
    IconName "fr-fi-rss-fill"


rssLine : IconName
rssLine =
    IconName "fr-fi-rss-line"


imageFill : IconName
imageFill =
    IconName "fr-fi-image-fill"


imageLine : IconName
imageLine =
    IconName "fr-fi-image-line"


lineChartFill : IconName
lineChartFill =
    IconName "fr-fi-line-chart-fill"


lineChartLine : IconName
lineChartLine =
    IconName "fr-fi-line-chart-line"


mapPin2Fill : IconName
mapPin2Fill =
    IconName "fr-fi-map-pin-2-fill"


mapPin2Line : IconName
mapPin2Line =
    IconName "fr-fi-map-pin-2-line"


roadMapFill : IconName
roadMapFill =
    IconName "fr-fi-road-map-fill"


roadMapLine : IconName
roadMapLine =
    IconName "fr-fi-road-map-line"


dailymotionFill : IconName
dailymotionFill =
    IconName "fr-fi-dailymotion-fill"


dailymotionLine : IconName
dailymotionLine =
    IconName "fr-fi-dailymotion-line"


facebookCircleFill : IconName
facebookCircleFill =
    IconName "fr-fi-facebook-circle-fill"


facebookCircleLine : IconName
facebookCircleLine =
    IconName "fr-fi-facebook-circle-line"


githubFill : IconName
githubFill =
    IconName "fr-fi-github-fill"


githubLine : IconName
githubLine =
    IconName "fr-fi-github-line"


instagramFill : IconName
instagramFill =
    IconName "fr-fi-instagram-fill"


instagramLine : IconName
instagramLine =
    IconName "fr-fi-instagram-line"


linkedinBoxFill : IconName
linkedinBoxFill =
    IconName "fr-fi-linkedin-box-fill"


linkedinBoxLine : IconName
linkedinBoxLine =
    IconName "fr-fi-linkedin-box-line"


npmjsFill : IconName
npmjsFill =
    IconName "fr-fi-npmjs-fill"


npmjsLine : IconName
npmjsLine =
    IconName "fr-fi-npmjs-line"


remixiconFill : IconName
remixiconFill =
    IconName "fr-fi-remixicon-fill"


remixiconLine : IconName
remixiconLine =
    IconName "fr-fi-remixicon-line"


slackFill : IconName
slackFill =
    IconName "fr-fi-slack-fill"


slackLine : IconName
slackLine =
    IconName "fr-fi-slack-line"


snapchatFill : IconName
snapchatFill =
    IconName "fr-fi-snapchat-fill"


snapchatLine : IconName
snapchatLine =
    IconName "fr-fi-snapchat-line"


telegramFill : IconName
telegramFill =
    IconName "fr-fi-telegram-fill"


telegramLine : IconName
telegramLine =
    IconName "fr-fi-telegram-line"


twitterFill : IconName
twitterFill =
    IconName "fr-fi-twitter-fill"


twitterLine : IconName
twitterLine =
    IconName "fr-fi-twitter-line"


tiktokFill : IconName
tiktokFill =
    IconName "fr-fi-tiktok-fill"


tiktokLine : IconName
tiktokLine =
    IconName "fr-fi-tiktok-line"


twitchFill : IconName
twitchFill =
    IconName "fr-fi-twitch-fill"


twitchLine : IconName
twitchLine =
    IconName "fr-fi-twitch-line"


vimeoFill : IconName
vimeoFill =
    IconName "fr-fi-vimeo-fill"


vimeoLine : IconName
vimeoLine =
    IconName "fr-fi-vimeo-line"


youtubeFill : IconName
youtubeFill =
    IconName "fr-fi-youtube-fill"


youtubeLine : IconName
youtubeLine =
    IconName "fr-fi-youtube-line"


themeFill : IconName
themeFill =
    IconName "fr-fi-theme-fill"


allIcons : List ( IconName, String )
allIcons =
    [ ( accountFill, "accountFill" )
    , ( accountLine, "accountLine" )
    , ( addCircleFill, "addCircleFill" )
    , ( addCircleLine, "addCircleLine" )
    , ( addLine, "addLine" )
    , ( arrowDownLine, "arrowDownLine" )
    , ( arrowDownSLine, "arrowDownSLine" )
    , ( arrowGoBackFill, "arrowGoBackFill" )
    , ( arrowGoBackLine, "arrowGoBackLine" )
    , ( arrowLeftLine, "arrowLeftLine" )
    , ( arrowLeftSFirstLine, "arrowLeftSFirstLine" )
    , ( arrowLeftSLine, "arrowLeftSLine" )
    , ( arrowLeftSLineDouble, "arrowLeftSLineDouble" )
    , ( arrowRightLine, "arrowRightLine" )
    , ( arrowRightSLastLine, "arrowRightSLastLine" )
    , ( arrowRightSLine, "arrowRightSLine" )
    , ( arrowRightSLineDouble, "arrowRightSLineDouble" )
    , ( arrowRightUpLine, "arrowRightUpLine" )
    , ( arrowUpFill, "arrowUpFill" )
    , ( arrowUpLine, "arrowUpLine" )
    , ( arrowUpSLine, "arrowUpSLine" )
    , ( attachmentFill, "attachmentFill" )
    , ( attachmentLine, "attachmentLine" )
    , ( bold, "bold" )
    , ( calendarFill, "calendarFill" )
    , ( calendarLine, "calendarLine" )
    , ( chatQuoteFill, "chatQuoteFill" )
    , ( chatQuoteLine, "chatQuoteLine" )
    , ( checkLine, "checkLine" )
    , ( closeLine, "closeLine" )
    , ( dailymotionFill, "dailymotionFill" )
    , ( dailymotionLine, "dailymotionLine" )
    , ( deleteFill, "deleteFill" )
    , ( deleteLine, "deleteLine" )
    , ( downloadLine, "downloadLine" )
    , ( editFill, "editFill" )
    , ( editLine, "editLine" )
    , ( equalizerFill, "equalizerFill" )
    , ( equalizerLine, "equalizerLine" )
    , ( errorFill, "errorFill" )
    , ( errorLine, "errorLine" )
    , ( errorWarningFill, "errorWarningFill" )
    , ( errorWarningLine, "errorWarningLine" )
    , ( externalLinkLine, "externalLinkLine" )
    , ( eyeFill, "eyeFill" )
    , ( eyeLine, "eyeLine" )
    , ( eyeOffFill, "eyeOffFill" )
    , ( eyeOffLine, "eyeOffLine" )
    , ( facebookCircleFill, "facebookCircleFill" )
    , ( facebookCircleLine, "facebookCircleLine" )
    , ( fileDownloadFill, "fileDownloadFill" )
    , ( fileDownloadLine, "fileDownloadLine" )
    , ( fileFill, "fileFill" )
    , ( fileLine, "fileLine" )
    , ( filePdfFill, "filePdfFill" )
    , ( filePdfLine, "filePdfLine" )
    , ( filterFill, "filterFill" )
    , ( filterLine, "filterLine" )
    , ( flashlightFill, "flashlightFill" )
    , ( flashlightLine, "flashlightLine" )
    , ( fontSize, "fontSize" )
    , ( githubFill, "githubFill" )
    , ( githubLine, "githubLine" )
    , ( highlight, "highlight" )
    , ( home4Fill, "home4Fill" )
    , ( home4Line, "home4Line" )
    , ( imageFill, "imageFill" )
    , ( imageLine, "imageLine" )
    , ( infoFill, "infoFill" )
    , ( infoLine, "infoLine" )
    , ( informationFill, "informationFill" )
    , ( informationLine, "informationLine" )
    , ( instagramFill, "instagramFill" )
    , ( instagramLine, "instagramLine" )
    , ( italic, "italic" )
    , ( lineChartFill, "lineChartFill" )
    , ( lineChartLine, "lineChartLine" )
    , ( linkUnlink, "linkUnlink" )
    , ( linkedinBoxFill, "linkedinBoxFill" )
    , ( linkedinBoxLine, "linkedinBoxLine" )
    , ( linksFill, "linksFill" )
    , ( listOrdered, "listOrdered" )
    , ( listUnordered, "listUnordered" )
    , ( lockFill, "lockFill" )
    , ( lockLine, "lockLine" )
    , ( logoutBoxRFill, "logoutBoxRFill" )
    , ( logoutBoxRLine, "logoutBoxRLine" )
    , ( mailFill, "mailFill" )
    , ( mailLine, "mailLine" )
    , ( mapPin2Fill, "mapPin2Fill" )
    , ( mapPin2Line, "mapPin2Line" )
    , ( menu2Fill, "menu2Fill" )
    , ( menuFill, "menuFill" )
    , ( npmjsFill, "npmjsFill" )
    , ( npmjsLine, "npmjsLine" )
    , ( pauseCircleFill, "pauseCircleFill" )
    , ( pauseCircleLine, "pauseCircleLine" )
    , ( phoneFill, "phoneFill" )
    , ( phoneLine, "phoneLine" )
    , ( playFill, "playFill" )
    , ( playLine, "playLine" )
    , ( printerFill, "printerFill" )
    , ( printerLine, "printerLine" )
    , ( questionFill, "questionFill" )
    , ( questionLine, "questionLine" )
    , ( refreshFill, "refreshFill" )
    , ( refreshLine, "refreshLine" )
    , ( remixiconFill, "remixiconFill" )
    , ( remixiconLine, "remixiconLine" )
    , ( roadMapFill, "roadMapFill" )
    , ( roadMapLine, "roadMapLine" )
    , ( rssFill, "rssFill" )
    , ( rssLine, "rssLine" )
    , ( saveFill, "saveFill" )
    , ( saveLine, "saveLine" )
    , ( searchFill, "searchFill" )
    , ( searchLine, "searchLine" )
    , ( slackFill, "slackFill" )
    , ( slackLine, "slackLine" )
    , ( snapchatFill, "snapchatFill" )
    , ( snapchatLine, "snapchatLine" )
    , ( subtractLine, "subtractLine" )
    , ( successFill, "successFill" )
    , ( successLine, "successLine" )
    , ( telegramFill, "telegramFill" )
    , ( telegramLine, "telegramLine" )
    , ( themeFill, "themeFill" )
    , ( tiktokFill, "tiktokFill" )
    , ( tiktokLine, "tiktokLine" )
    , ( twitchFill, "twitchFill" )
    , ( twitchLine, "twitchLine" )
    , ( twitterFill, "twitterFill" )
    , ( twitterLine, "twitterLine" )
    , ( upload2Fill, "upload2Fill" )
    , ( upload2Line, "upload2Line" )
    , ( userFill, "userFill" )
    , ( userLine, "userLine" )
    , ( vimeoFill, "vimeoFill" )
    , ( vimeoLine, "vimeoLine" )
    , ( volumeDownFill, "volumeDownFill" )
    , ( volumeDownLine, "volumeDownLine" )
    , ( volumeMuteFill, "volumeMuteFill" )
    , ( volumeMuteLine, "volumeMuteLine" )
    , ( volumeUpFill, "volumeUpFill" )
    , ( volumeUpLine, "volumeUpLine" )
    , ( warningFill, "warningFill" )
    , ( warningLine, "warningLine" )
    , ( youtubeFill, "youtubeFill" )
    , ( youtubeLine, "youtubeLine" )
    , ( zoomInFill, "zoomInFill" )
    , ( zoomInLine, "zoomInLine" )
    , ( zoomOutFill, "zoomOutFill" )
    , ( zoomOutLine, "zoomOutLine" )
    ]
