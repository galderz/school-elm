import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json
import String exposing (..)
import Task


main =
  Html.program
    { init = init ""
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL


type alias Model =
  { topic : String
  , gifUrl : String
  , error: String
  }


init : String -> (Model, Cmd Msg)
init topic =
  (Model topic "waiting.gif" "", Cmd.none)



-- UPDATE


type Msg
  = MorePlease
  | FetchSucceed String
  | FetchFail Http.Error
  | Topic String
--  | TopicCats
--  | TopicDogs


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      -- (model, Cmd.none)
      (model, getRandomGif model.topic)

    FetchSucceed newUrl ->
      (Model model.topic newUrl "", Cmd.none)

    FetchFail httpErr ->
      -- { model | error = errorMapper httpErr}
      ({ model | error = errorMapper httpErr }, Cmd.none)

    Topic topic ->
      ({ model | topic = topic }, Cmd.none)

    -- TopicCats ->
    --  ({ model | topic = "cats"}, Cmd.none)

    -- TopicDogs ->
    --  ({ model | topic = "dogs"}, Cmd.none)


getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
    Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)


decodeGifUrl : Json.Decoder String
decodeGifUrl =
  Json.at ["data", "image_url"] Json.string


errorMapper : Http.Error -> String
errorMapper err =
  case err of
    Http.Timeout -> "Http request timed out"

    Http.NetworkError -> "Network error"

    Http.UnexpectedPayload s -> s

    Http.BadResponse status s -> "Bad response: " ++ toString status ++ s


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.topic]
    , select [ on "change" (Json.map Topic targetValue) ]
        [ option [] [ text "Cats" ]
        , option [] [ text "Dogs" ]
        ]
    -- , input [ type' "text", placeholder "Topic", onInput Topic ] []
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , br [] []
    , img [src model.gifUrl] []
    , viewError model
    ]


viewError : Model -> Html msg
viewError model =
  if not (isEmpty model.error) then
    div [ style [("color", "red")] ] [ text model.error ]
  else
    div [] []


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
