type user
val root : user
val inj_user : sql_injectable_prim user
val eq_user : eq user

table user : { Id : user, Nam : string, Email : string, Pass : string }
  PRIMARY KEY Id

val userId : unit -> transaction (option user)
val currentUserInfo : unit -> transaction (option {Nam : string, Email : string})
val blurb : (unit -> transaction page) -> transaction xbody