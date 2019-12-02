open BsMocha
let describe, it = Mocha.describe, Promise.it;;

describe "CallbagToPromise" (fun () -> begin
  it "should convert an async pullable source to a promise" (fun () -> begin
    let open CallbagBasics
    in
    interval 50
    |> map (( * ) 2)
    |> take 5
    |> CallbagToPromise.to_promise
    |> Js.Promise.then_ (fun result -> begin
         Assert.deep_equal result [|0; 2; 4; 6; 8|]
         |> Js.Promise.resolve
       end)
  end)
end)
