## Introduction

Un package Elm pour le [System de design du gouvernement français (DSFR)](https://www.systeme-de-design.gouv.fr/). Ce projet est en cours développement. Contribuez et faites-nous part de vos retours via les [GitHub Issues](https://github.com/betagouv/elm-dsfr/issues).

## Installation

En premier lieu, chargez les [feuilles de styles du DSFR](https://www.systeme-de-design.gouv.fr/utilisation-et-organisation/developpeurs/prise-en-main).

Puis installez les packages Elm suivants :

```
elm install tesk9/accessible-html
elm install betagouv/elm-dsfr
```

## Exemples

Afficher un champ date :

```elm
import Accessibility exposing (Html, text)
import BetaGouv.DSFR.Input as Input

view : String -> Html Msg
view date =
    Input.new
        { value = date
        , onInput = UpdateDate
        , label = text "Date"
        , name = "nom"
        }
        |> Input.date
        |> Input.view
```
Afficher un textarea avec une classe personnalisée :

```elm
import Accessibility exposing (Html, text)
import BetaGouv.DSFR.Input as Input
import Html.Attributes exposing (class)

view : String -> Html Msg
view value =
    Input.new
        { value = value
        , onInput = UpdateComment
        , label = text "Commentaire"
        , name = "commentaire"
        }
        |> Input.textArea (Just 8)
        |> Input.withExtraAttrs [ class "w-full" ]
        |> Input.view
```

## Documentation

Retrouvez la documentation complète sur [package.elm-lang.org/packages/betagouv/elm-dsfr/latest/](https://package.elm-lang.org/packages/betagouv/elm-dsfr/latest/).

