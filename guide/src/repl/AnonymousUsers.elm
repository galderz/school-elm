module AnonymousUsers exposing (..)

type User
  = Anonymous
  | Named String


userPhoto : User -> String
userPhoto user =
  case user of
    Anonymous ->
      "anon.png"

    Named name ->
      "users/" ++ name ++ ".png"


activeUsers : List User
activeUsers =
  [ Anonymous, Named "catface420", Named "AzureDiamond", Anonymous ]


photos : List String
photos =
  List.map userPhoto activeUsers
