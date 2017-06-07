module View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (placeholder,autofocus,value,class,readonly)
import Html.Events exposing (..)
import Models exposing (Model, ChatMessage)
import Msgs exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import MyCss
import Html.CssHelpers
import Models

{ id, class, classList } =
    Html.CssHelpers.withNamespace "dreamwriter"

userList : List String
userList = ["Dennis","Henrik","Nogen Andre","a","dasfsda"]




-- VIEW
view : Model -> Html Msg
view model =
  Grid.container []
    [ CDN.stylesheet
    , Grid.row [][
        Grid.col[Col.xs8][]
      ,Grid.col[][loginField model] ]
    , Grid.row []
      [Grid.col[Col.xs2][]
      ,Grid.col[ Col.xs8][
        messagesView model,
        messageInputView model]
      ,Grid.col[Col.xs2][
        userListView userList
      ]]
     ]

messageInputView : Model -> Html Msg
messageInputView model =
    form [ onSubmit PostChatMessage ]
    [input[
      placeholder "message..."
      , autofocus True
      , value model.userMessage
      , onInput UpdateUserMessage
      , id [MyCss.MessageInput]


      ][]]

messagesView : Model -> Html Msg
messagesView model =
  textarea [
    id [MyCss.ChatArea]
    , readonly True] (List.map viewMessage (List.reverse model.chatMessages))

loginField : Model -> Html Msg
loginField model =
  case model.user of
    Nothing ->
      form [ onSubmit Login ]
      [input[
        placeholder "Enter Username"
        , autofocus True
        , value model.userName
        , onInput UpdateUserName
        , id [MyCss.MessageInput]


        ][]
        ,br[][]]
    Just user ->
      div [][
      text ("Welcome " ++ user.userName)
      , button[onClick Logout][text "Logout"]]


userListView : List String -> Html Msg
userListView string =
  textarea [
    id[MyCss.ChatArea]
    , readonly True
  ](List.map userView (List.sort userList))


userView : String -> Html Msg
userView string =
  div[] [ text (string ++ "\n")
    ]


viewMessage : ChatMessage -> Html msg
viewMessage msg =
  div [] [  text (msg.userName ++ ": " ++ msg.content ++ "\n") ]
