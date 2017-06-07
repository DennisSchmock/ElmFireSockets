module Msgs exposing (..)
import Models exposing (Model,ChatMessage)

type Msg
  = PostChatMessage
  | UpdateUserMessage String
  | NewChatMessage ChatMessage
  | NoOp
  | LoginMessage String
  | Login
  | UpdateUserName String
