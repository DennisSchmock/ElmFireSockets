module MyCss exposing (..)

import Css exposing (..)
import Css.Elements exposing (body, li)
import Css.Namespace exposing (namespace)


type CssClasses
    = NavBar


type CssIds
    = ChatArea
    | MessageInput

css : Stylesheet
css =
    (stylesheet << namespace "dreamwriter")
    [ body
        [ overflowX auto
        , minWidth (px 1280)
        ]
    , id ChatArea
        [ backgroundColor (rgb 230 230 230)
        , color (hex "333333")
        , width (pct 100)
        , height (px 600)
        , boxSizing borderBox
        , padding (px 8)
        , margin zero
        , resize none
        , overflow scroll
        ]
    , id MessageInput
        [ backgroundColor (rgb 230 230 230)
        , color (hex "333333")
        , width (pct 100)
        , height (px 30)
        , boxSizing borderBox
        , padding (px 8)
        , margin zero
        , resize none
        , overflow auto
        ]
    , class NavBar
        [ margin zero
        , padding zero
        , children
            [ li
                [ (display inlineBlock) |> important
                , color primaryAccentColor
                ]
            ]
        ]
    ]

primaryAccentColor : Color
primaryAccentColor =
    hex "ccffaa"
