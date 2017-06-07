port module Ports exposing (..)

import Json.Encode exposing (..)

port sendMessage : Value -> Cmd msg
