module Models exposing (..)



-- MODEL
type alias Model =
 { userMessage : String
 , chatMessages : List ChatMessage
 , userName : String
 , user : Maybe User

 }

type alias User =
  {userName : String,
    email : String  }


type alias ChatMessage =
 { command: String
 , content: String
 , userName : String
 }

initialModel : Model
initialModel = {
    userMessage = ""
    ,chatMessages = [{
      command = "",
      content = "Welcome to the chat...",
      userName = "System"
    }]
    ,userName = ""
    , user = Nothing
    }
