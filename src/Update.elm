module Update exposing (..)

import Msgs exposing (..)
import Models exposing (Model,ChatMessage,User)
import WebSocket
import EnDecoders exposing (..)
import Json.Encode as JE
import Json.Decode as Decode
import Json.Decode exposing (Decoder, string)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    PostChatMessage ->
      let
        payload = JE.object [
          ("command", JE.string "send")
          ,("content", JE.string model.userMessage)
          ,("userName", JE.string model.userName)
        ]

      in
        ({ model | userMessage = ""}, WebSocket.send "ws://localhost:3000/" (JE.encode 1 payload)
       )

    UpdateUserMessage newMessage ->
      let
        newModel =
          {model|
            userMessage = newMessage}
      in
      (newModel, Cmd.none)
    UpdateUserName uName ->
      let newModel =
        {model| userName = uName}
      in
      (newModel,Cmd.none)

    NewChatMessage newMessage ->
        let
          newModel =
            {model| chatMessages = newMessage :: model.chatMessages}
        in
          (newModel, Cmd.none)
        --(Model userMessage (newMessage :: chatMessages), Cmd.none)
    LoginMessage uName ->
        let
          newModel =
            {model| userName = uName  }
        in
          (newModel,Cmd.none)

    Logout->
      ({model | user = Nothing}, Cmd.none)
    Login ->
      let
        payload = JE.object [
          ("command", JE.string "login")
          ,("content", JE.string model.userName)
          ,("userName", JE.string model.userName)
        ]

      in
      payload
        |> Decode.decodeValue userDecoder
        |> Result.map (\user -> {model | userMessage = "", user = Just user}![WebSocket.send "ws://localhost:3000/" (JE.encode 1 payload)])
        |> Result.withDefault (model ! [])


    NoOp ->
      (model ,Cmd.none)
