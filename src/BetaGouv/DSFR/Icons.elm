module BetaGouv.DSFR.Icons exposing
    ( buildings, business, communication, design, development, device, document, editor, finance, health, icon, iconLG, iconMD, iconName, iconSM, iconXL, logo, map, media, others, system, toClass, user, weather
    , custom, toClassName, IconName
    )

{-|


# Icônes

@docs buildings, business, communication, design, development, device, document, editor, finance, health, icon, iconLG, iconMD, iconName, iconSM, iconXL, logo, map, media, others, system, toClass, user, weather


# Utilitaires

@docs custom, toClassName, IconName

-}

import Accessibility exposing (Attribute, Html, span)
import Html.Attributes exposing (attribute, class)


{-| -}
type IconName
    = IconName String


{-| -}
iconName : String -> IconName
iconName =
    IconName


type IconSize
    = SM
    | MD
    | LG
    | XL


genericIcon : IconSize -> IconName -> Html msg
genericIcon size name =
    let
        iconSize =
            case size of
                SM ->
                    "fr-icon--sm"

                MD ->
                    "fr-icon"

                LG ->
                    "fr-icon--lg"

                XL ->
                    "fr-icon--xl"
    in
    span
        [ toClass name
        , class iconSize
        , attribute "aria-hidden" "true"
        ]
        []


{-| -}
toClass : IconName -> Attribute msg
toClass =
    class << toClassName


{-| -}
toClassName : IconName -> String
toClassName (IconName name) =
    name


{-| -}
icon : IconName -> Html msg
icon =
    iconMD


{-| -}
iconSM : IconName -> Html msg
iconSM =
    genericIcon SM


{-| -}
iconMD : IconName -> Html msg
iconMD =
    genericIcon MD


{-| -}
iconLG : IconName -> Html msg
iconLG =
    genericIcon LG


{-| -}
iconXL : IconName -> Html msg
iconXL =
    genericIcon XL


{-| Crée une icône avec un nom de classe personnalisé
-}
custom : String -> IconName
custom =
    (++) " text-[1.5rem] "
        >> IconName


{-| -}
buildings : { ancientGateFill : IconName, ancientGateLine : IconName, ancientPavilionFill : IconName, ancientPavilionLine : IconName, bankFill : IconName, bankLine : IconName, buildingFill : IconName, buildingLine : IconName, communityFill : IconName, communityLine : IconName, governmentFill : IconName, governmentLine : IconName, home4Fill : IconName, home4Line : IconName, hospitalFill : IconName, hospitalLine : IconName, hotelFill : IconName, hotelLine : IconName, storeFill : IconName, storeLine : IconName }
buildings =
    { ancientGateFill = IconName "fr-icon-ancient-gate-fill"
    , ancientGateLine = IconName "fr-icon-ancient-gate-line"
    , ancientPavilionFill = IconName "fr-icon-ancient-pavilion-fill"
    , ancientPavilionLine = IconName "fr-icon-ancient-pavilion-line"
    , bankFill = IconName "fr-icon-bank-fill"
    , bankLine = IconName "fr-icon-bank-line"
    , buildingFill = IconName "fr-icon-building-fill"
    , buildingLine = IconName "fr-icon-building-line"
    , communityFill = IconName "fr-icon-community-fill"
    , communityLine = IconName "fr-icon-community-line"
    , governmentFill = IconName "fr-icon-government-fill"
    , governmentLine = IconName "fr-icon-government-line"
    , home4Fill = IconName "fr-icon-home-4-fill"
    , home4Line = IconName "fr-icon-home-4-line"
    , hospitalFill = IconName "fr-icon-hospital-fill"
    , hospitalLine = IconName "fr-icon-hospital-line"
    , hotelFill = IconName "fr-icon-hotel-fill"
    , hotelLine = IconName "fr-icon-hotel-line"
    , storeFill = IconName "fr-icon-store-fill"
    , storeLine = IconName "fr-icon-store-line"
    }


{-| -}
business : { archiveFill : IconName, archiveLine : IconName, attachmentFill : IconName, attachmentLine : IconName, awardFill : IconName, awardLine : IconName, barChartBoxFill : IconName, barChartBoxLine : IconName, bookmarkFill : IconName, bookmarkLine : IconName, briefcaseFill : IconName, briefcaseLine : IconName, calendar2Fill : IconName, calendar2Line : IconName, calendarEventFill : IconName, calendarEventLine : IconName, calendarFill : IconName, calendarLine : IconName, cloudFill : IconName, cloudLine : IconName, copyrightFill : IconName, copyrightLine : IconName, customerServiceFill : IconName, customerServiceLine : IconName, flagFill : IconName, flagLine : IconName, globalFill : IconName, globalLine : IconName, lineChartFill : IconName, lineChartLine : IconName, linksFill : IconName, linksLine : IconName, mailFill : IconName, mailLine : IconName, mailOpenFill : IconName, mailOpenLine : IconName, medalFill : IconName, medalLine : IconName, pieChart2Fill : IconName, pieChart2Line : IconName, pieChartBoxFill : IconName, pieChartBoxLine : IconName, printerFill : IconName, printerLine : IconName, profilFill : IconName, profilLine : IconName, projector2Fill : IconName, projector2Line : IconName, sendPlaneFill : IconName, sendPlaneLine : IconName, slideshowFill : IconName, slideshowLine : IconName, windowFill : IconName, windowLine : IconName }
business =
    { archiveFill = IconName "fr-icon-archive-fill"
    , archiveLine = IconName "fr-icon-archive-line"
    , attachmentFill = IconName "fr-icon-attachment-fill"
    , attachmentLine = IconName "fr-icon-attachment-line"
    , awardFill = IconName "fr-icon-award-fill"
    , awardLine = IconName "fr-icon-award-line"
    , barChartBoxFill = IconName "fr-icon-bar-chart-box-fill"
    , barChartBoxLine = IconName "fr-icon-bar-chart-box-line"
    , bookmarkFill = IconName "fr-icon-bookmark-fill"
    , bookmarkLine = IconName "fr-icon-bookmark-line"
    , briefcaseFill = IconName "fr-icon-briefcase-fill"
    , briefcaseLine = IconName "fr-icon-briefcase-line"
    , calendar2Fill = IconName "fr-icon-calendar-2-fill"
    , calendar2Line = IconName "fr-icon-calendar-2-line"
    , calendarEventFill = IconName "fr-icon-calendar-event-fill"
    , calendarEventLine = IconName "fr-icon-calendar-event-line"
    , calendarFill = IconName "fr-icon-calendar-fill"
    , calendarLine = IconName "fr-icon-calendar-line"
    , cloudFill = IconName "fr-icon-cloud-fill"
    , cloudLine = IconName "fr-icon-cloud-line"
    , copyrightFill = IconName "fr-icon-copyright-fill"
    , copyrightLine = IconName "fr-icon-copyright-line"
    , customerServiceFill = IconName "fr-icon-customer-service-fill"
    , customerServiceLine = IconName "fr-icon-customer-service-line"
    , flagFill = IconName "fr-icon-flag-fill"
    , flagLine = IconName "fr-icon-flag-line"
    , globalFill = IconName "fr-icon-global-fill"
    , globalLine = IconName "fr-icon-global-line"
    , lineChartFill = IconName "fr-icon-line-chart-fill"
    , lineChartLine = IconName "fr-icon-line-chart-line"
    , linksFill = IconName "fr-icon-links-fill"
    , linksLine = IconName "fr-icon-links-line"
    , mailFill = IconName "fr-icon-mail-fill"
    , mailLine = IconName "fr-icon-mail-line"
    , mailOpenFill = IconName "fr-icon-mail-open-fill"
    , mailOpenLine = IconName "fr-icon-mail-open-line"
    , medalFill = IconName "fr-icon-medal-fill"
    , medalLine = IconName "fr-icon-medal-line"
    , pieChart2Fill = IconName "fr-icon-pie-chart-2-fill"
    , pieChart2Line = IconName "fr-icon-pie-chart-2-line"
    , pieChartBoxFill = IconName "fr-icon-pie-chart-box-fill"
    , pieChartBoxLine = IconName "fr-icon-pie-chart-box-line"
    , printerFill = IconName "fr-icon-printer-fill"
    , printerLine = IconName "fr-icon-printer-line"
    , profilFill = IconName "fr-icon-profil-fill"
    , profilLine = IconName "fr-icon-profil-line"
    , projector2Fill = IconName "fr-icon-projector-2-fill"
    , projector2Line = IconName "fr-icon-projector-2-line"
    , sendPlaneFill = IconName "fr-icon-send-plane-fill"
    , sendPlaneLine = IconName "fr-icon-send-plane-line"
    , slideshowFill = IconName "fr-icon-slideshow-fill"
    , slideshowLine = IconName "fr-icon-slideshow-line"
    , windowFill = IconName "fr-icon-window-fill"
    , windowLine = IconName "fr-icon-window-line"
    }


{-| -}
communication : { chat2Fill : IconName, chat2Line : IconName, chat3Fill : IconName, chat3Line : IconName, chatCheckFill : IconName, chatCheckLine : IconName, chatDeleteFill : IconName, chatDeleteLine : IconName, chatPollFill : IconName, chatPollLine : IconName, discussFill : IconName, discussLine : IconName, feedbackFill : IconName, feedbackLine : IconName, message2Fill : IconName, message2Line : IconName, questionAnswerFill : IconName, questionAnswerLine : IconName, questionnaireFill : IconName, questionnaireLine : IconName, videoChatFill : IconName, videoChatLine : IconName }
communication =
    { chat2Fill = IconName "fr-icon-chat-2-fill"
    , chat2Line = IconName "fr-icon-chat-2-line"
    , chat3Fill = IconName "fr-icon-chat-3-fill"
    , chat3Line = IconName "fr-icon-chat-3-line"
    , chatCheckFill = IconName "fr-icon-chat-check-fill"
    , chatCheckLine = IconName "fr-icon-chat-check-line"
    , chatDeleteFill = IconName "fr-icon-chat-delete-fill"
    , chatDeleteLine = IconName "fr-icon-chat-delete-line"
    , chatPollFill = IconName "fr-icon-chat-poll-fill"
    , chatPollLine = IconName "fr-icon-chat-poll-line"
    , discussFill = IconName "fr-icon-discuss-fill"
    , discussLine = IconName "fr-icon-discuss-line"
    , feedbackFill = IconName "fr-icon-feedback-fill"
    , feedbackLine = IconName "fr-icon-feedback-line"
    , message2Fill = IconName "fr-icon-message-2-fill"
    , message2Line = IconName "fr-icon-message-2-line"
    , questionAnswerFill = IconName "fr-icon-question-answer-fill"
    , questionAnswerLine = IconName "fr-icon-question-answer-line"
    , questionnaireFill = IconName "fr-icon-questionnaire-fill"
    , questionnaireLine = IconName "fr-icon-questionnaire-line"
    , videoChatFill = IconName "fr-icon-video-chat-fill"
    , videoChatLine = IconName "fr-icon-video-chat-line"
    }


{-| -}
design : { ballPenFill : IconName, ballPenLine : IconName, brush3Fill : IconName, brush3Line : IconName, brushFill : IconName, brushLine : IconName, contrastFill : IconName, contrastLine : IconName, cropFill : IconName, cropLine : IconName, dragMove2Fill : IconName, dragMove2Line : IconName, dropFill : IconName, dropLine : IconName, editBoxFill : IconName, editBoxLine : IconName, editFill : IconName, editLine : IconName, inkBottleFill : IconName, inkBottleLine : IconName, layoutGridFill : IconName, layoutGridLine : IconName, markPenFill : IconName, markPenLine : IconName, paintBrushFill : IconName, paintBrushLine : IconName, paintFill : IconName, paintLine : IconName, paletteFill : IconName, paletteLine : IconName, pantoneFill : IconName, pantoneLine : IconName, penNibFill : IconName, penNibLine : IconName, pencilFill : IconName, pencilLine : IconName, pencilRulerFill : IconName, pencilRulerLine : IconName, sipFill : IconName, sipLine : IconName, tableFill : IconName, tableLine : IconName }
design =
    { ballPenFill = IconName "fr-icon-ball-pen-fill"
    , ballPenLine = IconName "fr-icon-ball-pen-line"
    , brush3Fill = IconName "fr-icon-brush-3-fill"
    , brush3Line = IconName "fr-icon-brush-3-line"
    , brushFill = IconName "fr-icon-brush-fill"
    , brushLine = IconName "fr-icon-brush-line"
    , contrastFill = IconName "fr-icon-contrast-fill"
    , contrastLine = IconName "fr-icon-contrast-line"
    , cropFill = IconName "fr-icon-crop-fill"
    , cropLine = IconName "fr-icon-crop-line"
    , dragMove2Fill = IconName "fr-icon-drag-move-2-fill"
    , dragMove2Line = IconName "fr-icon-drag-move-2-line"
    , dropFill = IconName "fr-icon-drop-fill"
    , dropLine = IconName "fr-icon-drop-line"
    , editBoxFill = IconName "fr-icon-edit-box-fill"
    , editBoxLine = IconName "fr-icon-edit-box-line"
    , editFill = IconName "fr-icon-edit-fill"
    , editLine = IconName "fr-icon-edit-line"
    , inkBottleFill = IconName "fr-icon-ink-bottle-fill"
    , inkBottleLine = IconName "fr-icon-ink-bottle-line"
    , layoutGridFill = IconName "fr-icon-layout-grid-fill"
    , layoutGridLine = IconName "fr-icon-layout-grid-line"
    , markPenFill = IconName "fr-icon-mark-pen-fill"
    , markPenLine = IconName "fr-icon-mark-pen-line"
    , paintBrushFill = IconName "fr-icon-paint-brush-fill"
    , paintBrushLine = IconName "fr-icon-paint-brush-line"
    , paintFill = IconName "fr-icon-paint-fill"
    , paintLine = IconName "fr-icon-paint-line"
    , paletteFill = IconName "fr-icon-palette-fill"
    , paletteLine = IconName "fr-icon-palette-line"
    , pantoneFill = IconName "fr-icon-pantone-fill"
    , pantoneLine = IconName "fr-icon-pantone-line"
    , penNibFill = IconName "fr-icon-pen-nib-fill"
    , penNibLine = IconName "fr-icon-pen-nib-line"
    , pencilFill = IconName "fr-icon-pencil-fill"
    , pencilLine = IconName "fr-icon-pencil-line"
    , pencilRulerFill = IconName "fr-icon-pencil-ruler-fill"
    , pencilRulerLine = IconName "fr-icon-pencil-ruler-line"
    , sipFill = IconName "fr-icon-sip-fill"
    , sipLine = IconName "fr-icon-sip-line"
    , tableFill = IconName "fr-icon-table-fill"
    , tableLine = IconName "fr-icon-table-line"
    }


{-| -}
development : { bugFill : IconName, bugLine : IconName, codeBoxFill : IconName, codeBoxLine : IconName, codeSSlashLine : IconName, cursorFill : IconName, cursorLine : IconName, gitBranchFill : IconName, gitBranchLine : IconName, gitCommitFill : IconName, gitCommitLine : IconName, gitMergeFill : IconName, gitMergeLine : IconName, gitPullRequestFill : IconName, gitPullRequestLine : IconName, gitRepositoryCommitsFill : IconName, gitRepositoryCommitsLine : IconName, gitRepositoryFill : IconName, gitRepositoryLine : IconName, gitRepositoryPrivateFill : IconName, gitRepositoryPrivateLine : IconName, terminalBoxFill : IconName, terminalBoxLine : IconName, terminalLine : IconName, terminalWindowFill : IconName, terminalWindowLine : IconName }
development =
    { bugFill = IconName "fr-icon-bug-fill"
    , bugLine = IconName "fr-icon-bug-line"
    , codeBoxFill = IconName "fr-icon-code-box-fill"
    , codeBoxLine = IconName "fr-icon-code-box-line"
    , codeSSlashLine = IconName "fr-icon-code-s-slash-line"
    , cursorFill = IconName "fr-icon-cursor-fill"
    , cursorLine = IconName "fr-icon-cursor-line"
    , gitBranchFill = IconName "fr-icon-git-branch-fill"
    , gitBranchLine = IconName "fr-icon-git-branch-line"
    , gitCommitFill = IconName "fr-icon-git-commit-fill"
    , gitCommitLine = IconName "fr-icon-git-commit-line"
    , gitMergeFill = IconName "fr-icon-git-merge-fill"
    , gitMergeLine = IconName "fr-icon-git-merge-line"
    , gitPullRequestFill = IconName "fr-icon-git-pull-request-fill"
    , gitPullRequestLine = IconName "fr-icon-git-pull-request-line"
    , gitRepositoryCommitsFill = IconName "fr-icon-git-repository-commits-fill"
    , gitRepositoryCommitsLine = IconName "fr-icon-git-repository-commits-line"
    , gitRepositoryFill = IconName "fr-icon-git-repository-fill"
    , gitRepositoryLine = IconName "fr-icon-git-repository-line"
    , gitRepositoryPrivateFill = IconName "fr-icon-git-repository-private-fill"
    , gitRepositoryPrivateLine = IconName "fr-icon-git-repository-private-line"
    , terminalBoxFill = IconName "fr-icon-terminal-box-fill"
    , terminalBoxLine = IconName "fr-icon-terminal-box-line"
    , terminalLine = IconName "fr-icon-terminal-line"
    , terminalWindowFill = IconName "fr-icon-terminal-window-fill"
    , terminalWindowLine = IconName "fr-icon-terminal-window-line"
    }


{-| -}
device : { bluetoothFill : IconName, bluetoothLine : IconName, computerFill : IconName, computerLine : IconName, dashboard3Fill : IconName, dashboard3Line : IconName, databaseFill : IconName, databaseLine : IconName, deviceFill : IconName, deviceLine : IconName, hardDrive2Fill : IconName, hardDrive2Line : IconName, macFill : IconName, macLine : IconName, phoneFill : IconName, phoneLine : IconName, qrCodeFill : IconName, qrCodeLine : IconName, rssFill : IconName, rssLine : IconName, save3Fill : IconName, save3Line : IconName, saveFill : IconName, saveLine : IconName, serverFill : IconName, serverLine : IconName, smartphoneFill : IconName, smartphoneLine : IconName, tabletFill : IconName, tabletLine : IconName, tvFill : IconName, tvLine : IconName, wifiFill : IconName, wifiLine : IconName }
device =
    { bluetoothFill = IconName "fr-icon-bluetooth-fill"
    , bluetoothLine = IconName "fr-icon-bluetooth-line"
    , computerFill = IconName "fr-icon-computer-fill"
    , computerLine = IconName "fr-icon-computer-line"
    , dashboard3Fill = IconName "fr-icon-dashboard-3-fill"
    , dashboard3Line = IconName "fr-icon-dashboard-3-line"
    , databaseFill = IconName "fr-icon-database-fill"
    , databaseLine = IconName "fr-icon-database-line"
    , deviceFill = IconName "fr-icon-device-fill"
    , deviceLine = IconName "fr-icon-device-line"
    , hardDrive2Fill = IconName "fr-icon-hard-drive-2-fill"
    , hardDrive2Line = IconName "fr-icon-hard-drive-2-line"
    , macFill = IconName "fr-icon-mac-fill"
    , macLine = IconName "fr-icon-mac-line"
    , phoneFill = IconName "fr-icon-phone-fill"
    , phoneLine = IconName "fr-icon-phone-line"
    , qrCodeFill = IconName "fr-icon-qr-code-fill"
    , qrCodeLine = IconName "fr-icon-qr-code-line"
    , rssFill = IconName "fr-icon-rss-fill"
    , rssLine = IconName "fr-icon-rss-line"
    , save3Fill = IconName "fr-icon-save-3-fill"
    , save3Line = IconName "fr-icon-save-3-line"
    , saveFill = IconName "fr-icon-save-fill"
    , saveLine = IconName "fr-icon-save-line"
    , serverFill = IconName "fr-icon-server-fill"
    , serverLine = IconName "fr-icon-server-line"
    , smartphoneFill = IconName "fr-icon-smartphone-fill"
    , smartphoneLine = IconName "fr-icon-smartphone-line"
    , tabletFill = IconName "fr-icon-tablet-fill"
    , tabletLine = IconName "fr-icon-tablet-line"
    , tvFill = IconName "fr-icon-tv-fill"
    , tvLine = IconName "fr-icon-tv-line"
    , wifiFill = IconName "fr-icon-wifi-fill"
    , wifiLine = IconName "fr-icon-wifi-line"
    }


{-| -}
document : { articleFill : IconName, articleLine : IconName, book2Fill : IconName, book2Line : IconName, bookletFill : IconName, bookletLine : IconName, clipboardFill : IconName, clipboardLine : IconName, draftFill : IconName, draftLine : IconName, fileAddFill : IconName, fileAddLine : IconName, fileDownloadFill : IconName, fileDownloadLine : IconName, fileFill : IconName, fileLine : IconName, filePdfFill : IconName, filePdfLine : IconName, fileTextFill : IconName, fileTextLine : IconName, folder2Fill : IconName, folder2Line : IconName, newspaperFill : IconName, newspaperLine : IconName, surveyFill : IconName, surveyLine : IconName, todoFill : IconName, todoLine : IconName }
document =
    { articleFill = IconName "fr-icon-article-fill"
    , articleLine = IconName "fr-icon-article-line"
    , book2Fill = IconName "fr-icon-book-2-fill"
    , book2Line = IconName "fr-icon-book-2-line"
    , bookletFill = IconName "fr-icon-booklet-fill"
    , bookletLine = IconName "fr-icon-booklet-line"
    , clipboardFill = IconName "fr-icon-clipboard-fill"
    , clipboardLine = IconName "fr-icon-clipboard-line"
    , draftFill = IconName "fr-icon-draft-fill"
    , draftLine = IconName "fr-icon-draft-line"
    , fileAddFill = IconName "fr-icon-file-add-fill"
    , fileAddLine = IconName "fr-icon-file-add-line"
    , fileDownloadFill = IconName "fr-icon-file-download-fill"
    , fileDownloadLine = IconName "fr-icon-file-download-line"
    , fileFill = IconName "fr-icon-file-fill"
    , fileLine = IconName "fr-icon-file-line"
    , filePdfFill = IconName "fr-icon-file-pdf-fill"
    , filePdfLine = IconName "fr-icon-file-pdf-line"
    , fileTextFill = IconName "fr-icon-file-text-fill"
    , fileTextLine = IconName "fr-icon-file-text-line"
    , folder2Fill = IconName "fr-icon-folder-2-fill"
    , folder2Line = IconName "fr-icon-folder-2-line"
    , newspaperFill = IconName "fr-icon-newspaper-fill"
    , newspaperLine = IconName "fr-icon-newspaper-line"
    , surveyFill = IconName "fr-icon-survey-fill"
    , surveyLine = IconName "fr-icon-survey-line"
    , todoFill = IconName "fr-icon-todo-fill"
    , todoLine = IconName "fr-icon-todo-line"
    }


{-| -}
editor : { codeView : IconName, fontSize : IconName, bold : IconName, highlight : IconName, quoteFill : IconName, quoteLine : IconName, h1 : IconName, h2 : IconName, h3 : IconName, h4 : IconName, h5 : IconName, h6 : IconName, hashtag : IconName, italic : IconName, linkUnlink : IconName, link : IconName, listOrdered : IconName, listUnordered : IconName, questionMark : IconName, separator : IconName, space : IconName, subscript : IconName, superscript : IconName, table2 : IconName, translate2 : IconName }
editor =
    { codeView = IconName "fr-icon-code-view"
    , fontSize = IconName "fr-icon-font-size"
    , bold = IconName "fr-icon-bold"
    , highlight = IconName "fr-icon-highlight"
    , quoteFill = IconName "fr-icon-quote-fill"
    , quoteLine = IconName "fr-icon-quote-line"
    , h1 = IconName "fr-icon-h-1"
    , h2 = IconName "fr-icon-h-2"
    , h3 = IconName "fr-icon-h-3"
    , h4 = IconName "fr-icon-h-4"
    , h5 = IconName "fr-icon-h-5"
    , h6 = IconName "fr-icon-h-6"
    , hashtag = IconName "fr-icon-hashtag"
    , italic = IconName "fr-icon-italic"
    , linkUnlink = IconName "fr-icon-link-unlink"
    , link = IconName "fr-icon-link"
    , listOrdered = IconName "fr-icon-list-ordered"
    , listUnordered = IconName "fr-icon-list-unordered"
    , questionMark = IconName "fr-icon-question-mark"
    , separator = IconName "fr-icon-separator"
    , space = IconName "fr-icon-space"
    , subscript = IconName "fr-icon-subscript"
    , superscript = IconName "fr-icon-superscript"
    , table2 = IconName "fr-icon-table-2"
    , translate2 = IconName "fr-icon-translate-2"
    }


{-| -}
finance : { bankCardFill : IconName, bankCardLine : IconName, coinFill : IconName, giftFill : IconName, giftLine : IconName, moneyEuroBoxFill : IconName, moneyEuroBoxLine : IconName, moneyEuroCircleFill : IconName, moneyEuroCircleLine : IconName, securePaymentFill : IconName, securePaymentLine : IconName, shoppingBagFill : IconName, shoppingBagLine : IconName, shoppingCart2Fill : IconName, shoppingCart2Line : IconName, trophyFill : IconName, trophyLine : IconName }
finance =
    { bankCardFill = IconName "fr-icon-bank-card-fill"
    , bankCardLine = IconName "fr-icon-bank-card-line"
    , coinFill = IconName "fr-icon-coin-fill"
    , giftFill = IconName "fr-icon-gift-fill"
    , giftLine = IconName "fr-icon-gift-line"
    , moneyEuroBoxFill = IconName "fr-icon-money-euro-box-fill"
    , moneyEuroBoxLine = IconName "fr-icon-money-euro-box-line"
    , moneyEuroCircleFill = IconName "fr-icon-money-euro-circle-fill"
    , moneyEuroCircleLine = IconName "fr-icon-money-euro-circle-line"
    , securePaymentFill = IconName "fr-icon-secure-payment-fill"
    , securePaymentLine = IconName "fr-icon-secure-payment-line"
    , shoppingBagFill = IconName "fr-icon-shopping-bag-fill"
    , shoppingBagLine = IconName "fr-icon-shopping-bag-line"
    , shoppingCart2Fill = IconName "fr-icon-shopping-cart-2-fill"
    , shoppingCart2Line = IconName "fr-icon-shopping-cart-2-line"
    , trophyFill = IconName "fr-icon-trophy-fill"
    , trophyLine = IconName "fr-icon-trophy-line"
    }


{-| -}
health : { capsuleFill : IconName, capsuleLine : IconName, dislikeFill : IconName, dislikeLine : IconName, dossierFill : IconName, dossierLine : IconName, firstAidKitFill : IconName, firstAidKitLine : IconName, handSanitizerFill : IconName, handSanitizerLine : IconName, healthBookFill : IconName, healthBookLine : IconName, heartFill : IconName, heartLine : IconName, heartPulseFill : IconName, heartPulseLine : IconName, lungsFill : IconName, lungsLine : IconName, medicineBottleFill : IconName, medicineBottleLine : IconName, mentalHealthFill : IconName, mentalHealthLine : IconName, microscopeFill : IconName, microscopeLine : IconName, psychotherapyFill : IconName, psychotherapyLine : IconName, pulseLine : IconName, stethoscopeFill : IconName, stethoscopeLine : IconName, surgicalMaskFill : IconName, surgicalMaskLine : IconName, syringeFill : IconName, syringeLine : IconName, testTubeFill : IconName, testTubeLine : IconName, thermometerFill : IconName, thermometerLine : IconName, virusFill : IconName, virusLine : IconName }
health =
    { capsuleFill = IconName "fr-icon-capsule-fill"
    , capsuleLine = IconName "fr-icon-capsule-line"
    , dislikeFill = IconName "fr-icon-dislike-fill"
    , dislikeLine = IconName "fr-icon-dislike-line"
    , dossierFill = IconName "fr-icon-dossier-fill"
    , dossierLine = IconName "fr-icon-dossier-line"
    , firstAidKitFill = IconName "fr-icon-first-aid-kit-fill"
    , firstAidKitLine = IconName "fr-icon-first-aid-kit-line"
    , handSanitizerFill = IconName "fr-icon-hand-sanitizer-fill"
    , handSanitizerLine = IconName "fr-icon-hand-sanitizer-line"
    , healthBookFill = IconName "fr-icon-health-book-fill"
    , healthBookLine = IconName "fr-icon-health-book-line"
    , heartFill = IconName "fr-icon-heart-fill"
    , heartLine = IconName "fr-icon-heart-line"
    , heartPulseFill = IconName "fr-icon-heart-pulse-fill"
    , heartPulseLine = IconName "fr-icon-heart-pulse-line"
    , lungsFill = IconName "fr-icon-lungs-fill"
    , lungsLine = IconName "fr-icon-lungs-line"
    , medicineBottleFill = IconName "fr-icon-medicine-bottle-fill"
    , medicineBottleLine = IconName "fr-icon-medicine-bottle-line"
    , mentalHealthFill = IconName "fr-icon-mental-health-fill"
    , mentalHealthLine = IconName "fr-icon-mental-health-line"
    , microscopeFill = IconName "fr-icon-microscope-fill"
    , microscopeLine = IconName "fr-icon-microscope-line"
    , psychotherapyFill = IconName "fr-icon-psychotherapy-fill"
    , psychotherapyLine = IconName "fr-icon-psychotherapy-line"
    , pulseLine = IconName "fr-icon-pulse-line"
    , stethoscopeFill = IconName "fr-icon-stethoscope-fill"
    , stethoscopeLine = IconName "fr-icon-stethoscope-line"
    , surgicalMaskFill = IconName "fr-icon-surgical-mask-fill"
    , surgicalMaskLine = IconName "fr-icon-surgical-mask-line"
    , syringeFill = IconName "fr-icon-syringe-fill"
    , syringeLine = IconName "fr-icon-syringe-line"
    , testTubeFill = IconName "fr-icon-test-tube-fill"
    , testTubeLine = IconName "fr-icon-test-tube-line"
    , thermometerFill = IconName "fr-icon-thermometer-fill"
    , thermometerLine = IconName "fr-icon-thermometer-line"
    , virusFill = IconName "fr-icon-virus-fill"
    , virusLine = IconName "fr-icon-virus-line"
    }


{-| -}
logo : { chromeFill : IconName, chromeLine : IconName, edgeFill : IconName, edgeLine : IconName, facebookCircleFill : IconName, facebookCircleLine : IconName, firefoxFill : IconName, firefoxLine : IconName, dailymotionFill : IconName, dailymotionLine : IconName, tiktokFill : IconName, tiktokLine : IconName, githubFill : IconName, githubLine : IconName, googleFill : IconName, googleLine : IconName, ieFill : IconName, ieLine : IconName, instagramFill : IconName, instagramLine : IconName, linkedinBoxFill : IconName, linkedinBoxLine : IconName, mastodonFill : IconName, mastodonLine : IconName, npmjsFill : IconName, npmjsLine : IconName, remixiconFill : IconName, remixiconLine : IconName, safariFill : IconName, safariLine : IconName, slackFill : IconName, slackLine : IconName, snapchatFill : IconName, snapchatLine : IconName, telegramFill : IconName, telegramLine : IconName, twitchFill : IconName, twitchLine : IconName, twitterFill : IconName, twitterLine : IconName, vimeoFill : IconName, vimeoLine : IconName, vuejsFill : IconName, vuejsLine : IconName, youtubeFill : IconName, youtubeLine : IconName }
logo =
    { chromeFill = IconName "fr-icon-chrome-fill"
    , chromeLine = IconName "fr-icon-chrome-line"
    , edgeFill = IconName "fr-icon-edge-fill"
    , edgeLine = IconName "fr-icon-edge-line"
    , facebookCircleFill = IconName "fr-icon-facebook-circle-fill"
    , facebookCircleLine = IconName "fr-icon-facebook-circle-line"
    , firefoxFill = IconName "fr-icon-firefox-fill"
    , firefoxLine = IconName "fr-icon-firefox-line"
    , dailymotionFill = IconName "fr-icon-dailymotion-fill"
    , dailymotionLine = IconName "fr-icon-dailymotion-line"
    , tiktokFill = IconName "fr-icon-tiktok-fill"
    , tiktokLine = IconName "fr-icon-tiktok-line"
    , githubFill = IconName "fr-icon-github-fill"
    , githubLine = IconName "fr-icon-github-line"
    , googleFill = IconName "fr-icon-google-fill"
    , googleLine = IconName "fr-icon-google-line"
    , ieFill = IconName "fr-icon-ie-fill"
    , ieLine = IconName "fr-icon-ie-line"
    , instagramFill = IconName "fr-icon-instagram-fill"
    , instagramLine = IconName "fr-icon-instagram-line"
    , linkedinBoxFill = IconName "fr-icon-linkedin-box-fill"
    , linkedinBoxLine = IconName "fr-icon-linkedin-box-line"
    , mastodonFill = IconName "fr-icon-mastodon-fill"
    , mastodonLine = IconName "fr-icon-mastodon-line"
    , npmjsFill = IconName "fr-icon-npmjs-fill"
    , npmjsLine = IconName "fr-icon-npmjs-line"
    , remixiconFill = IconName "fr-icon-remixicon-fill"
    , remixiconLine = IconName "fr-icon-remixicon-line"
    , safariFill = IconName "fr-icon-safari-fill"
    , safariLine = IconName "fr-icon-safari-line"
    , slackFill = IconName "fr-icon-slack-fill"
    , slackLine = IconName "fr-icon-slack-line"
    , snapchatFill = IconName "fr-icon-snapchat-fill"
    , snapchatLine = IconName "fr-icon-snapchat-line"
    , telegramFill = IconName "fr-icon-telegram-fill"
    , telegramLine = IconName "fr-icon-telegram-line"
    , twitchFill = IconName "fr-icon-twitch-fill"
    , twitchLine = IconName "fr-icon-twitch-line"
    , twitterFill = IconName "fr-icon-twitter-fill"
    , twitterLine = IconName "fr-icon-twitter-line"
    , vimeoFill = IconName "fr-icon-vimeo-fill"
    , vimeoLine = IconName "fr-icon-vimeo-line"
    , vuejsFill = IconName "fr-icon-vuejs-fill"
    , vuejsLine = IconName "fr-icon-vuejs-line"
    , youtubeFill = IconName "fr-icon-youtube-fill"
    , youtubeLine = IconName "fr-icon-youtube-line"
    }


{-| -}
map : { anchorFill : IconName, anchorLine : IconName, bikeFill : IconName, bikeLine : IconName, busFill : IconName, busLine : IconName, carFill : IconName, carLine : IconName, caravanFill : IconName, caravanLine : IconName, chargingPile2Fill : IconName, chargingPile2Line : IconName, compass3Fill : IconName, compass3Line : IconName, cupFill : IconName, cupLine : IconName, earthFill : IconName, earthLine : IconName, franceFill : IconName, franceLine : IconName, gasStationFill : IconName, gasStationLine : IconName, gobletFill : IconName, gobletLine : IconName, mapPin2Fill : IconName, mapPin2Line : IconName, mapPinUserFill : IconName, mapPinUserLine : IconName, motorbikeFill : IconName, motorbikeLine : IconName, passportFill : IconName, passportLine : IconName, restaurantFill : IconName, restaurantLine : IconName, roadMapFill : IconName, roadMapLine : IconName, sailboatFill : IconName, sailboatLine : IconName, ship2Fill : IconName, ship2Line : IconName, signalTowerFill : IconName, signalTowerLine : IconName, suitcase2Fill : IconName, suitcase2Line : IconName, taxiFill : IconName, taxiLine : IconName, trainFill : IconName, trainLine : IconName }
map =
    { anchorFill = IconName "fr-icon-anchor-fill"
    , anchorLine = IconName "fr-icon-anchor-line"
    , bikeFill = IconName "fr-icon-bike-fill"
    , bikeLine = IconName "fr-icon-bike-line"
    , busFill = IconName "fr-icon-bus-fill"
    , busLine = IconName "fr-icon-bus-line"
    , carFill = IconName "fr-icon-car-fill"
    , carLine = IconName "fr-icon-car-line"
    , caravanFill = IconName "fr-icon-caravan-fill"
    , caravanLine = IconName "fr-icon-caravan-line"
    , chargingPile2Fill = IconName "fr-icon-charging-pile-2-fill"
    , chargingPile2Line = IconName "fr-icon-charging-pile-2-line"
    , compass3Fill = IconName "fr-icon-compass-3-fill"
    , compass3Line = IconName "fr-icon-compass-3-line"
    , cupFill = IconName "fr-icon-cup-fill"
    , cupLine = IconName "fr-icon-cup-line"
    , earthFill = IconName "fr-icon-earth-fill"
    , earthLine = IconName "fr-icon-earth-line"
    , franceFill = IconName "fr-icon-france-fill"
    , franceLine = IconName "fr-icon-france-line"
    , gasStationFill = IconName "fr-icon-gas-station-fill"
    , gasStationLine = IconName "fr-icon-gas-station-line"
    , gobletFill = IconName "fr-icon-goblet-fill"
    , gobletLine = IconName "fr-icon-goblet-line"
    , mapPin2Fill = IconName "fr-icon-map-pin-2-fill"
    , mapPin2Line = IconName "fr-icon-map-pin-2-line"
    , mapPinUserFill = IconName "fr-icon-map-pin-user-fill"
    , mapPinUserLine = IconName "fr-icon-map-pin-user-line"
    , motorbikeFill = IconName "fr-icon-motorbike-fill"
    , motorbikeLine = IconName "fr-icon-motorbike-line"
    , passportFill = IconName "fr-icon-passport-fill"
    , passportLine = IconName "fr-icon-passport-line"
    , restaurantFill = IconName "fr-icon-restaurant-fill"
    , restaurantLine = IconName "fr-icon-restaurant-line"
    , roadMapFill = IconName "fr-icon-road-map-fill"
    , roadMapLine = IconName "fr-icon-road-map-line"
    , sailboatFill = IconName "fr-icon-sailboat-fill"
    , sailboatLine = IconName "fr-icon-sailboat-line"
    , ship2Fill = IconName "fr-icon-ship-2-fill"
    , ship2Line = IconName "fr-icon-ship-2-line"
    , signalTowerFill = IconName "fr-icon-signal-tower-fill"
    , signalTowerLine = IconName "fr-icon-signal-tower-line"
    , suitcase2Fill = IconName "fr-icon-suitcase-2-fill"
    , suitcase2Line = IconName "fr-icon-suitcase-2-line"
    , taxiFill = IconName "fr-icon-taxi-fill"
    , taxiLine = IconName "fr-icon-taxi-line"
    , trainFill = IconName "fr-icon-train-fill"
    , trainLine = IconName "fr-icon-train-line"
    }


{-| -}
media : { cameraFill : IconName, cameraLine : IconName, clapperboardFill : IconName, clapperboardLine : IconName, equalizerFill : IconName, equalizerLine : IconName, filmFill : IconName, filmLine : IconName, galleryFill : IconName, galleryLine : IconName, headphoneFill : IconName, headphoneLine : IconName, imageAddFill : IconName, imageAddLine : IconName, imageEditFill : IconName, imageEditLine : IconName, imageFill : IconName, imageLine : IconName, liveFill : IconName, liveLine : IconName, micFill : IconName, micLine : IconName, music2Fill : IconName, music2Line : IconName, notification3Fill : IconName, notification3Line : IconName, pauseCircleFill : IconName, pauseCircleLine : IconName, playCircleFill : IconName, playCircleLine : IconName, stopCircleFill : IconName, stopCircleLine : IconName, transcription : IconName, volumeDownFill : IconName, volumeDownLine : IconName, volumeMuteFill : IconName, volumeMuteLine : IconName, volumeUpFill : IconName, volumeUpLine : IconName }
media =
    { cameraFill = IconName "fr-icon-camera-fill"
    , cameraLine = IconName "fr-icon-camera-line"
    , clapperboardFill = IconName "fr-icon-clapperboard-fill"
    , clapperboardLine = IconName "fr-icon-clapperboard-line"
    , equalizerFill = IconName "fr-icon-equalizer-fill"
    , equalizerLine = IconName "fr-icon-equalizer-line"
    , filmFill = IconName "fr-icon-film-fill"
    , filmLine = IconName "fr-icon-film-line"
    , galleryFill = IconName "fr-icon-gallery-fill"
    , galleryLine = IconName "fr-icon-gallery-line"
    , headphoneFill = IconName "fr-icon-headphone-fill"
    , headphoneLine = IconName "fr-icon-headphone-line"
    , imageAddFill = IconName "fr-icon-image-add-fill"
    , imageAddLine = IconName "fr-icon-image-add-line"
    , imageEditFill = IconName "fr-icon-image-edit-fill"
    , imageEditLine = IconName "fr-icon-image-edit-line"
    , imageFill = IconName "fr-icon-image-fill"
    , imageLine = IconName "fr-icon-image-line"
    , liveFill = IconName "fr-icon-live-fill"
    , liveLine = IconName "fr-icon-live-line"
    , micFill = IconName "fr-icon-mic-fill"
    , micLine = IconName "fr-icon-mic-line"
    , music2Fill = IconName "fr-icon-music-2-fill"
    , music2Line = IconName "fr-icon-music-2-line"
    , notification3Fill = IconName "fr-icon-notification-3-fill"
    , notification3Line = IconName "fr-icon-notification-3-line"
    , pauseCircleFill = IconName "fr-icon-pause-circle-fill"
    , pauseCircleLine = IconName "fr-icon-pause-circle-line"
    , playCircleFill = IconName "fr-icon-play-circle-fill"
    , playCircleLine = IconName "fr-icon-play-circle-line"
    , stopCircleFill = IconName "fr-icon-stop-circle-fill"
    , stopCircleLine = IconName "fr-icon-stop-circle-line"
    , transcription = IconName "fr-icon-transcription"
    , volumeDownFill = IconName "fr-icon-volume-down-fill"
    , volumeDownLine = IconName "fr-icon-volume-down-line"
    , volumeMuteFill = IconName "fr-icon-volume-mute-fill"
    , volumeMuteLine = IconName "fr-icon-volume-mute-line"
    , volumeUpFill = IconName "fr-icon-volume-up-fill"
    , volumeUpLine = IconName "fr-icon-volume-up-line"
    }


{-| -}
others : { leafFill : IconName, leafLine : IconName, lightbulbFill : IconName, lightbulbLine : IconName, plantFill : IconName, plantLine : IconName, recycleFill : IconName, recycleLine : IconName, scales3Fill : IconName, scales3Line : IconName, seedlingFill : IconName, seedlingLine : IconName, umbrellaFill : IconName, umbrellaLine : IconName }
others =
    { leafFill = IconName "fr-icon-leaf-fill"
    , leafLine = IconName "fr-icon-leaf-line"
    , lightbulbFill = IconName "fr-icon-lightbulb-fill"
    , lightbulbLine = IconName "fr-icon-lightbulb-line"
    , plantFill = IconName "fr-icon-plant-fill"
    , plantLine = IconName "fr-icon-plant-line"
    , recycleFill = IconName "fr-icon-recycle-fill"
    , recycleLine = IconName "fr-icon-recycle-line"
    , scales3Fill = IconName "fr-icon-scales-3-fill"
    , scales3Line = IconName "fr-icon-scales-3-line"
    , seedlingFill = IconName "fr-icon-seedling-fill"
    , seedlingLine = IconName "fr-icon-seedling-line"
    , umbrellaFill = IconName "fr-icon-umbrella-fill"
    , umbrellaLine = IconName "fr-icon-umbrella-line"
    }


{-| -}
system : { addCircleFill : IconName, addCircleLine : IconName, addLine : IconName, alarmWarningFill : IconName, alarmWarningLine : IconName, alertFill : IconName, alertLine : IconName, arrowDownFill : IconName, arrowDownLine : IconName, arrowDownSFill : IconName, arrowDownSLine : IconName, arrowGoBackFill : IconName, arrowGoBackLine : IconName, arrowGoForwardFill : IconName, arrowGoForwardLine : IconName, arrowLeftFill : IconName, arrowLeftLine : IconName, arrowLeftSFill : IconName, arrowLeftSLine : IconName, arrowRightFill : IconName, arrowRightLine : IconName, arrowRightSFill : IconName, arrowRightSLine : IconName, arrowRightUpLine : IconName, arrowUpFill : IconName, arrowUpLine : IconName, arrowUpSFill : IconName, arrowUpSLine : IconName, checkLine : IconName, checkboxCircleFill : IconName, checkboxCircleLine : IconName, checkboxFill : IconName, checkboxLine : IconName, closeCircleFill : IconName, closeCircleLine : IconName, closeLine : IconName, deleteFill : IconName, deleteLine : IconName, downloadFill : IconName, downloadLine : IconName, errorWarningFill : IconName, errorWarningLine : IconName, externalLinkFill : IconName, externalLinkLine : IconName, eyeFill : IconName, eyeLine : IconName, eyeOffFill : IconName, eyeOffLine : IconName, filterFill : IconName, filterLine : IconName, arrowLeftSFirstLine : IconName, arrowLeftSLineDouble : IconName, arrowRightSLastLine : IconName, arrowRightSLineDouble : IconName, errorFill : IconName, errorLine : IconName, infoFill : IconName, infoLine : IconName, successFill : IconName, successLine : IconName, themeFill : IconName, warningFill : IconName, warningLine : IconName, informationFill : IconName, informationLine : IconName, lockFill : IconName, lockLine : IconName, lockUnlockFill : IconName, lockUnlockLine : IconName, logoutBoxRFill : IconName, logoutBoxRLine : IconName, menu2Fill : IconName, menuFill : IconName, moreFill : IconName, moreLine : IconName, notificationBadgeFill : IconName, notificationBadgeLine : IconName, questionFill : IconName, questionLine : IconName, refreshFill : IconName, refreshLine : IconName, searchFill : IconName, searchLine : IconName, settings5Fill : IconName, settings5Line : IconName, shieldFill : IconName, shieldLine : IconName, starFill : IconName, starLine : IconName, starSFill : IconName, starSLine : IconName, subtractLine : IconName, thumbDownFill : IconName, thumbDownLine : IconName, thumbUpFill : IconName, thumbUpLine : IconName, timeFill : IconName, timeLine : IconName, timerFill : IconName, timerLine : IconName, upload2Fill : IconName, upload2Line : IconName, uploadFill : IconName, uploadLine : IconName, zoomInFill : IconName, zoomInLine : IconName, zoomOutFill : IconName, zoomOutLine : IconName }
system =
    { addCircleFill = IconName "fr-icon-add-circle-fill"
    , addCircleLine = IconName "fr-icon-add-circle-line"
    , addLine = IconName "fr-icon-add-line"
    , alarmWarningFill = IconName "fr-icon-alarm-warning-fill"
    , alarmWarningLine = IconName "fr-icon-alarm-warning-line"
    , alertFill = IconName "fr-icon-alert-fill"
    , alertLine = IconName "fr-icon-alert-line"
    , arrowDownFill = IconName "fr-icon-arrow-down-fill"
    , arrowDownLine = IconName "fr-icon-arrow-down-line"
    , arrowDownSFill = IconName "fr-icon-arrow-down-s-fill"
    , arrowDownSLine = IconName "fr-icon-arrow-down-s-line"
    , arrowGoBackFill = IconName "fr-icon-arrow-go-back-fill"
    , arrowGoBackLine = IconName "fr-icon-arrow-go-back-line"
    , arrowGoForwardFill = IconName "fr-icon-arrow-go-forward-fill"
    , arrowGoForwardLine = IconName "fr-icon-arrow-go-forward-line"
    , arrowLeftFill = IconName "fr-icon-arrow-left-fill"
    , arrowLeftLine = IconName "fr-icon-arrow-left-line"
    , arrowLeftSFill = IconName "fr-icon-arrow-left-s-fill"
    , arrowLeftSLine = IconName "fr-icon-arrow-left-s-line"
    , arrowRightFill = IconName "fr-icon-arrow-right-fill"
    , arrowRightLine = IconName "fr-icon-arrow-right-line"
    , arrowRightSFill = IconName "fr-icon-arrow-right-s-fill"
    , arrowRightSLine = IconName "fr-icon-arrow-right-s-line"
    , arrowRightUpLine = IconName "fr-icon-arrow-right-up-line"
    , arrowUpFill = IconName "fr-icon-arrow-up-fill"
    , arrowUpLine = IconName "fr-icon-arrow-up-line"
    , arrowUpSFill = IconName "fr-icon-arrow-up-s-fill"
    , arrowUpSLine = IconName "fr-icon-arrow-up-s-line"
    , checkLine = IconName "fr-icon-check-line"
    , checkboxCircleFill = IconName "fr-icon-checkbox-circle-fill"
    , checkboxCircleLine = IconName "fr-icon-checkbox-circle-line"
    , checkboxFill = IconName "fr-icon-checkbox-fill"
    , checkboxLine = IconName "fr-icon-checkbox-line"
    , closeCircleFill = IconName "fr-icon-close-circle-fill"
    , closeCircleLine = IconName "fr-icon-close-circle-line"
    , closeLine = IconName "fr-icon-close-line"
    , deleteFill = IconName "fr-icon-delete-fill"
    , deleteLine = IconName "fr-icon-delete-line"
    , downloadFill = IconName "fr-icon-download-fill"
    , downloadLine = IconName "fr-icon-download-line"
    , errorWarningFill = IconName "fr-icon-error-warning-fill"
    , errorWarningLine = IconName "fr-icon-error-warning-line"
    , externalLinkFill = IconName "fr-icon-external-link-fill"
    , externalLinkLine = IconName "fr-icon-external-link-line"
    , eyeFill = IconName "fr-icon-eye-fill"
    , eyeLine = IconName "fr-icon-eye-line"
    , eyeOffFill = IconName "fr-icon-eye-off-fill"
    , eyeOffLine = IconName "fr-icon-eye-off-line"
    , filterFill = IconName "fr-icon-filter-fill"
    , filterLine = IconName "fr-icon-filter-line"
    , arrowLeftSFirstLine = IconName "fr-icon-arrow-left-s-first-line"
    , arrowLeftSLineDouble = IconName "fr-icon-arrow-left-s-line-double"
    , arrowRightSLastLine = IconName "fr-icon-arrow-right-s-last-line"
    , arrowRightSLineDouble = IconName "fr-icon-arrow-right-s-line-double"
    , errorFill = IconName "fr-icon-error-fill"
    , errorLine = IconName "fr-icon-error-line"
    , infoFill = IconName "fr-icon-info-fill"
    , infoLine = IconName "fr-icon-info-line"
    , successFill = IconName "fr-icon-success-fill"
    , successLine = IconName "fr-icon-success-line"
    , themeFill = IconName "fr-icon-theme-fill"
    , warningFill = IconName "fr-icon-warning-fill"
    , warningLine = IconName "fr-icon-warning-line"
    , informationFill = IconName "fr-icon-information-fill"
    , informationLine = IconName "fr-icon-information-line"
    , lockFill = IconName "fr-icon-lock-fill"
    , lockLine = IconName "fr-icon-lock-line"
    , lockUnlockFill = IconName "fr-icon-lock-unlock-fill"
    , lockUnlockLine = IconName "fr-icon-lock-unlock-line"
    , logoutBoxRFill = IconName "fr-icon-logout-box-r-fill"
    , logoutBoxRLine = IconName "fr-icon-logout-box-r-line"
    , menu2Fill = IconName "fr-icon-menu-2-fill"
    , menuFill = IconName "fr-icon-menu-fill"
    , moreFill = IconName "fr-icon-more-fill"
    , moreLine = IconName "fr-icon-more-line"
    , notificationBadgeFill = IconName "fr-icon-notification-badge-fill"
    , notificationBadgeLine = IconName "fr-icon-notification-badge-line"
    , questionFill = IconName "fr-icon-question-fill"
    , questionLine = IconName "fr-icon-question-line"
    , refreshFill = IconName "fr-icon-refresh-fill"
    , refreshLine = IconName "fr-icon-refresh-line"
    , searchFill = IconName "fr-icon-search-fill"
    , searchLine = IconName "fr-icon-search-line"
    , settings5Fill = IconName "fr-icon-settings-5-fill"
    , settings5Line = IconName "fr-icon-settings-5-line"
    , shieldFill = IconName "fr-icon-shield-fill"
    , shieldLine = IconName "fr-icon-shield-line"
    , starFill = IconName "fr-icon-star-fill"
    , starLine = IconName "fr-icon-star-line"
    , starSFill = IconName "fr-icon-star-s-fill"
    , starSLine = IconName "fr-icon-star-s-line"
    , subtractLine = IconName "fr-icon-subtract-line"
    , thumbDownFill = IconName "fr-icon-thumb-down-fill"
    , thumbDownLine = IconName "fr-icon-thumb-down-line"
    , thumbUpFill = IconName "fr-icon-thumb-up-fill"
    , thumbUpLine = IconName "fr-icon-thumb-up-line"
    , timeFill = IconName "fr-icon-time-fill"
    , timeLine = IconName "fr-icon-time-line"
    , timerFill = IconName "fr-icon-timer-fill"
    , timerLine = IconName "fr-icon-timer-line"
    , upload2Fill = IconName "fr-icon-upload-2-fill"
    , upload2Line = IconName "fr-icon-upload-2-line"
    , uploadFill = IconName "fr-icon-upload-fill"
    , uploadLine = IconName "fr-icon-upload-line"
    , zoomInFill = IconName "fr-icon-zoom-in-fill"
    , zoomInLine = IconName "fr-icon-zoom-in-line"
    , zoomOutFill = IconName "fr-icon-zoom-out-fill"
    , zoomOutLine = IconName "fr-icon-zoom-out-line"
    }


{-| -}
user : { accountCircleFill : IconName, accountCircleLine : IconName, accountFill : IconName, accountLine : IconName, accountPinCircleFill : IconName, accountPinCircleLine : IconName, adminFill : IconName, adminLine : IconName, groupFill : IconName, groupLine : IconName, parentFill : IconName, parentLine : IconName, teamFill : IconName, teamLine : IconName, userAddFill : IconName, userAddLine : IconName, userFill : IconName, userHeartFill : IconName, userHeartLine : IconName, userLine : IconName, userSearchFill : IconName, userSearchLine : IconName, userSettingFill : IconName, userSettingLine : IconName, userStarFill : IconName, userStarLine : IconName }
user =
    { accountCircleFill = IconName "fr-icon-account-circle-fill"
    , accountCircleLine = IconName "fr-icon-account-circle-line"
    , accountFill = IconName "fr-icon-account-fill"
    , accountLine = IconName "fr-icon-account-line"
    , accountPinCircleFill = IconName "fr-icon-account-pin-circle-fill"
    , accountPinCircleLine = IconName "fr-icon-account-pin-circle-line"
    , adminFill = IconName "fr-icon-admin-fill"
    , adminLine = IconName "fr-icon-admin-line"
    , groupFill = IconName "fr-icon-group-fill"
    , groupLine = IconName "fr-icon-group-line"
    , parentFill = IconName "fr-icon-parent-fill"
    , parentLine = IconName "fr-icon-parent-line"
    , teamFill = IconName "fr-icon-team-fill"
    , teamLine = IconName "fr-icon-team-line"
    , userAddFill = IconName "fr-icon-user-add-fill"
    , userAddLine = IconName "fr-icon-user-add-line"
    , userFill = IconName "fr-icon-user-fill"
    , userHeartFill = IconName "fr-icon-user-heart-fill"
    , userHeartLine = IconName "fr-icon-user-heart-line"
    , userLine = IconName "fr-icon-user-line"
    , userSearchFill = IconName "fr-icon-user-search-fill"
    , userSearchLine = IconName "fr-icon-user-search-line"
    , userSettingFill = IconName "fr-icon-user-setting-fill"
    , userSettingLine = IconName "fr-icon-user-setting-line"
    , userStarFill = IconName "fr-icon-user-star-fill"
    , userStarLine = IconName "fr-icon-user-star-line"
    }


{-| -}
weather : { cloudy2Fill : IconName, cloudy2Line : IconName, flashlightFill : IconName, flashlightLine : IconName, moonFill : IconName, moonLine : IconName, sunFill : IconName, sunLine : IconName }
weather =
    { cloudy2Fill = IconName "fr-icon-cloudy-2-fill"
    , cloudy2Line = IconName "fr-icon-cloudy-2-line"
    , flashlightFill = IconName "fr-icon-flashlight-fill"
    , flashlightLine = IconName "fr-icon-flashlight-line"
    , moonFill = IconName "fr-icon-moon-fill"
    , moonLine = IconName "fr-icon-moon-line"
    , sunFill = IconName "fr-icon-sun-fill"
    , sunLine = IconName "fr-icon-sun-line"
    }
