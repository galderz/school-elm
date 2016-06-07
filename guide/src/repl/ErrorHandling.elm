type alias User =
  { name : String
  , age : Maybe Int
  }


sue : User
sue =
  { name = "Sue", age = Nothing }


tom : User
tom =
  { name = "Tom", age = Just 24 }


alice : User
alice =
  User "Alice" (Just 14)


bob = User "Bob" (Just 16)


canBuyAlcohol : User -> Bool
canBuyAlcohol user =
  case user.age of
    Nothing ->
      False

    Just age ->
      age >= 21


getTeenAge : User -> Maybe Int
getTeenAge user =
  case user.age of
    Nothing ->
      Nothing

    Just age ->
      if 13 <= age && age <= 18 then
        Just age

      else
        Nothing

users = [ sue, tom, alice, bob ]

ageDistribution = List.filterMap getTeenAge users

-- Using Result
view : String -> Html msg
view userInputAge =
  case String.toInt userInputAge of
    Err msg ->
      span [class "error"] [text msg]

    Ok age ->
      if age < 0 then
        span [class "error"] [text "I bet you are older than that!"]

      else if age > 140 then
        span [class "error"] [text "Seems unlikely..."]

      else
        text "OK!"


-- Using Tasks
getStockQuotes =
  Time.now `andThen` \time ->
    Http.getString ("//www.example.com/stocks?time=" ++ toString time)
