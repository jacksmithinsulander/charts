type user = int
val root = 0
val inj_user = _
val eq_user = _

sequence userIds
policy sendOwnIds userIds

table user : { Id : user, Nam : string, Email : string, Pass : string }
  PRIMARY KEY Id

task initialize = fn () =>
  b <- nonempty user;
  if b then
    return ()
  else
    dml (INSERT INTO user (Id, Nam, Email, Pass)
         VALUES ({[root]}, 'root', 'root@localhost', 'root'))

policy sendClient (SELECT user.Id, user.Nam, user.Email
                   FROM user)

policy sendClient (SELECT *
                   FROM user
                   WHERE known(user.Pass))

policy mayInsert (SELECT *
                  FROM user AS New)

cookie login : { Id : user, Pass : string }

fun isOk r = oneRowE1 (SELECT COUNT( * ) > 0
                       FROM user
                       WHERE user.Id = {[r.Id]}
                         AND user.Pass = {[r.Pass]})

fun userId () =
  ro <- getCookie login;
  case ro of
    None => return None
  | Some r =>
    b <- isOk r;
    return (if b then
              Some r.Id
            else
              None)

fun currentUserInfo () =
  uo <- userId ();
  case uo of
    None => return None
  | Some uid =>
    row <- oneRow (SELECT user.Nam, user.Email
                   FROM user
                   WHERE user.Id = {[uid]});
    return (Some {Nam = row.User.Nam, Email = row.User.Email})

fun blurb (goHome : unit -> transaction page) =
  let
    fun logon r =
      ro <- oneOrNoRows (SELECT user.Id
                         FROM user
                         WHERE user.Nam = {[r.Nam]}
                           AND user.Pass = {[r.Pass]});
      case ro of
        None => error <xml>Wrong username or password!</xml>
      | Some r' =>
        setCookie login {Value = {Id = r'.User.Id, Pass = r.Pass}, Secure = False, Expires = None};
        goHome ()

    fun logoff () =
      clearCookie login;
      goHome ()

    fun signup () =
      let
        fun create r =
          id <- nextval userIds;
          dml (INSERT INTO user (Id, Nam, Email, Pass)
               VALUES ({[id]}, {[r.Nam]}, {[r.Email]}, {[r.Pass]}));
          setCookie login {Value = {Id = id, Pass = r.Pass}, Secure = False, Expires = None};
          goHome ()
      in
        return <xml>
          <head>
            <title>Sign-up</title>
          </head>

          <body>
            <form><table>
              <tr> <th>Name:</th> <td><textbox{#Nam}/></td> </tr>
              <tr> <th>Email:</th> <td><textbox{#Email}/></td> </tr>
              <tr> <th>Password:</th> <td><password{#Pass}/></td> </tr>
              <tr> <td><submit value="Create" action={create}/></td> </tr>
            </table></form>
          </body>
        </xml>
      end
  in
    u <- userId ();

    return (case u of
              None => <xml>
                <h2>Log in</h2>

                <form><table>
                  <tr> <th>Name:</th> <td><textbox{#Nam}/></td> </tr>
                  <tr> <th>Password:</th> <td><password{#Pass}/></td> </tr>
                  <tr> <td><submit value="Log on" action={logon}/></td> </tr>
                </table></form>

                <a link={signup ()}>Create account</a>
              </xml>
            | Some u => <xml>
              <form>
                <submit value="Log off" action={logoff}/>
              </form>
            </xml>)
  end
