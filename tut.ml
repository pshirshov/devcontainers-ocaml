let fizzbuzz i = match ((i mod 3), (i mod 5)) with
  | (0, 0) -> "fizbuzz"
  | (_, 0) -> "buzz"
  | (0, _) -> "fizz"
  | (_, _) -> string_of_int i;;

let do_fizzbuzz n = for i = 1 to n do
    print_endline (fizzbuzz i)
  done;;

let rec sort lst =
  match lst with
    []->[]
  | head :: tail -> insert head (sort tail)
and insert elt lst =
  match lst with
    [] -> [elt]
  | head :: tail -> if elt <= head then elt :: lst else head :: insert elt tail
;;

do_fizzbuzz 100;;

let l = ["x"; "y"; "z"];;

(sort l);;

let deriv f dx = function x -> (f (x +. dx) -. f x) /. dx;;

let sin'x x = deriv sin x;;


print_string (String.concat " " (List.map (function x -> string_of_int(x + 1)) [1; 2]));;

type first_record = { x: int; y: int; z: int}
type snd_record = { x: int; y: int; z: int}

let project_and_rotate {x; y; _ } = { x= - y; y = x ; z = 0} ;;
