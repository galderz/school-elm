module FilterTodoList exposing (..)


type Visibility =
  All
  | Active
  | Completed


type alias Task = { task : String, complete : Bool }


buy : Task
buy =
  { task = "Buy milk", complete = True }


drink : Task
drink =
  { task = "Drink milk", complete = False }


tasks : List Task
tasks =
  [ buy, drink ]

keep : Visibility -> List Task -> List Task
keep visibility tasks =
  case visibility of
    All ->
      tasks

    Active ->
      List.filter (\task -> not task.complete) tasks

    Completed ->
      List.filter (\task -> task.complete) tasks
