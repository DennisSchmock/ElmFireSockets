module EnDecoders exposing (..)

import Msgs exposing (..)
import Json.Decode as Decode
import Json.Decode exposing (Decoder, string)
import Json.Decode.Pipeline exposing (decode, required, requiredAt,optional)
import Json.Encode
import Models exposing (Model,ChatMessage,User)

-- DECODERS
mapInput : String -> Msg
mapInput modelJson =
  case (decodeMessage modelJson) of
    Ok chatMessage ->
      case (chatMessage.command) of
        "login" -> LoginMessage chatMessage.content
        "send" -> NewChatMessage chatMessage
        _ -> NoOp

    Err errorMessage ->
      let
        _ = Debug.log "Error in MapInput: " errorMessage
      in
        NoOp

decodeMessage : String -> Result String ChatMessage
decodeMessage modelJson =
  Decode.decodeString messageDecoder modelJson


messageDecoder :  Decode.Decoder ChatMessage
messageDecoder  =
   decode ChatMessage
   |> required "command" string
   |> required "content" string
   |> optional "userName" string "User"


userDecoder : Decoder User
userDecoder =
  decode User
    |> required "userName" string
    |> optional "email" string ""


--ENCODERS
encodeMessage : ChatMessage -> Json.Encode.Value
encodeMessage chatMessage =
  Json.Encode.object
    [("command", Json.Encode.string chatMessage.command)
    ,("content", Json.Encode.string chatMessage.content)
    ,("userName", Json.Encode.string chatMessage.userName)]
