module BetaGouv.DSFR.Color exposing
    ( standard, greenEmeraude, greenMenthe, blueCumulus, blueFrance, brownCaramel, brownOpera, purpleGlycine
    , CustomColor(..)
    )

{-|


# Couleurs

@docs standard, greenEmeraude, greenMenthe, blueCumulus, blueFrance, brownCaramel, brownOpera, purpleGlycine


# Type

@docs CustomColor

-}


{-| -}
type CustomColor
    = Standard
    | GreenEmeraude
    | GreenMenthe
    | BlueCumulus
    | BlueFrance
    | BrownCaramel
    | BrownOpera
    | PurpleGlycine


{-| -}
standard : CustomColor
standard =
    blueFrance


{-| -}
greenEmeraude : CustomColor
greenEmeraude =
    GreenEmeraude


{-| -}
greenMenthe : CustomColor
greenMenthe =
    GreenMenthe


{-| -}
blueCumulus : CustomColor
blueCumulus =
    BlueCumulus


{-| -}
blueFrance : CustomColor
blueFrance =
    BlueFrance


{-| -}
brownCaramel : CustomColor
brownCaramel =
    BrownCaramel


{-| -}
brownOpera : CustomColor
brownOpera =
    BrownOpera


{-| -}
purpleGlycine : CustomColor
purpleGlycine =
    PurpleGlycine
