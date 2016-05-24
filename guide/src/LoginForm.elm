import Char exposing (..)
import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)
import String exposing (..)

main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age: String
  , error: (String, String)
  }


model : Model
model =
  Model "" "" "" "" ("red", "")


-- UPDATE


type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String
    | Validate


update : Msg -> Model -> Model
update action model =
  case action of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }

    Age age ->
      { model | age = age }

    Validate ->
      { model | error = validate model}


-- VIEW


validate : Model -> (String, String)
validate model =
  if (length model.password) < 8 then
    ("red", "Password needs to have at least 8 characters")
  else if (not (any isUpper model.password)) then
    ("red", "Password must contain upper case")
  else if (not (any isLower model.password)) then
    ("red", "Password must contain lower case")
  else if (not (any isDigit model.password)) then
    ("red", "Password must contain a digit")
  else if model.password /= model.passwordAgain then
    ("red", "Passwords do not match!")
  else if isEmpty model.age then
    ("red", "Age must not be empty")
  else if not (all isDigit model.age) then
    ("red", "Age must be numeric")
  else
    ("green", "OK")


view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , input [ type' "text", placeholder "Age", onInput Age ] []
    , button [ onClick Validate ] [ text "Submit" ]
    , viewValidation model
    ]

-- viewValidation : Model -> Html msg
-- viewValidation model =
--  let
--    (color, message) = validate model
--  in
--    div [ style [("color", color)] ] [ text message ]

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) = model.error
  in
    if not (isEmpty message) then
      div [ style [("color", color)] ] [ text message ]
    else
      div [] []
