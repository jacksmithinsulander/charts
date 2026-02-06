open User

fun listItem (active : int, status : source int, index : int, text : string) : xbody = <xml>
  <li style={if active = index then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set status index}>{[text]}</li>
</xml>

fun sidePanel (status : source int, nam : string, email : string) : xtr = <xml>
  <td>
    <fieldset>
      <dyn signal={active <- signal status;
        return <xml>
          <figure>
            <figcaption>Spaces</figcaption>
            <ul>
              {(listItem (active, status, 0, "Projects"))}
              {(listItem (active, status, 1, "Data Room"))}
              {(listItem (active, status, 2, "Legal"))}
              {(listItem (active, status, 3, "Funding"))}
            </ul>
          </figure>
          <figure>
            <figcaption>Funding</figcaption>
            <ul>
              {(listItem (active, status, 4, "Account"))}
              {(listItem (active, status, 5, "Loans"))}
              {(listItem (active, status, 6, "KYC / AML"))}
            </ul>
          </figure>
          <figure>
            <figcaption>Data</figcaption>
            <ul>
              {(listItem (active, status, 7, "Sources"))}
              {(listItem (active, status, 8, "Validation"))}
              {(listItem (active, status, 9, "Key financials"))}
            </ul>
          </figure>
          <figure>
            <figcaption>Tools</figcaption>
            <ul>
              {(listItem (active, status, 10, "Forecasting studio"))}
            </ul>
          </figure>
          <hr/>
        </xml>}/>
      <h3>{[nam]}</h3>
      <p>{[email]}</p>
    </fieldset>
  </td>
</xml>

fun headerItem (active : int, status : source int, index : int, text : string) : xtr = <xml>
  <th><nav style={if active = index then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set status index}>{[text]}</nav></th>
</xml>

fun headerMenuTabs (tabs : source int) : xbody = <xml>
  <table>
    <thead>
      <tr>
        <th>
          <fieldset>
            <h1>Size</h1>
          </fieldset>
        </th>
        <dyn signal={active <- signal tabs;
          return <xml>
            {(headerItem (active, tabs, 0, "Overview"))}
            {(headerItem (active, tabs, 1, "My Loans"))}
            {(headerItem (active, tabs, 2, "Properties"))}
            {(headerItem (active, tabs, 3, "Documents"))}
          </xml>}/>
      </tr>
    </thead>
  </table>
</xml>

fun overview () : xtr = <xml>
  <td>
    <table>
      <thead>
        <tr>
          <th>
            <h2>Property Portfolio</h2>
            <p>Manage your properties and financing</p>
          </th>
          <th>
            <button>Submit Loan</button>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>
            <fieldset>
              <h3>Total Property Value</h3>
              <p>$10.2M</p>
              <p>+8.3% from last month</p>
            </fieldset>
          </td>
          <td>
            <fieldset>
              <h3>Total Outstanding Loans</h3>
              <p>$6.8M</p>
              <p>4 active loans</p>
            </fieldset>
          </td>
          <td>
            <fieldset>
              <h3>Available Credit</h3>
              <p>$2.4M</p>
              <p>Based on current LTV</p>
            </fieldset>
          </td>
          <td>
            <fieldset>
              <h3>Next Payment</h3>
              <p>$18.5K</p>
              <p>Due Feb 15, 2026</p>
            </fieldset>
          </td>
        </tr>
      </tbody>
      <tbody>
        <tr>
          <td>
            <fieldset>
              <h3>Property Portfolio Value</h3>
              <p>6 month valuation trend</p>
            </fieldset>
          </td>
          <td>
            <fieldset>
              <h3>Recent Activity</h3>
              <ul>
                <li>
                  <h4>Payment Made</h4>
                  <p>Riverside Apartments</p>
                  <time>2 hours ago</time>
                </li>
                <li>
                  <h4>Loan Approved</h4>
                  <p>Industrial Warehouse</p>
                  <time>1 day ago</time>
                </li>
                <li>
                  <h4>Application</h4>
                  <p>Downtown Office Tower</p>
                  <time>3 days ago</time>
                </li>
                <li>
                  <h4>Valuation Complete</h4>
                  <p>Suburban Retail Center</p>
                  <time>5 days ago</time>
                </li>
              </ul>
            </fieldset>
          </td>
        </tr>
      </tbody>
    </table>
  </td>
</xml>

fun overviewTestDifferentPage () : xtr = <xml>
  <td>
    <table>
      <thead>
        <tr>
          <th>
            <h2>Test different page</h2>
            <p>Test different page</p>
          </th>
          <th>
            <button>Submit Loan</button>
          </th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>
            <fieldset>
              <h3>Test different page</h3>
              <p>Test different page</p>
            </fieldset>
          </td>
        </tr>
      </tbody>
      <tbody>
        <tr>
          <td>
            <fieldset>
              <h3>Test different page</h3>
              <ul>
                <li>Test different page</li>
              </ul>
            </fieldset>
          </td>
        </tr>
      </tbody>
    </table>
  </td>
</xml>

fun mainPageSelector (tabs : source int) : xtr = <xml>
  <dyn signal={active <- signal tabs;
    return (case active of
      0 => overview ()
      | 1 => overviewTestDifferentPage ()
      | _ => <xml><td><h1>Contact</h1><p>Get in touch...</p></td></xml>)}/>
</xml>

(* Separate function so the main page is not one giant inline expression (reduces IR size for compiler). *)
fun mainContent (tabs : source int) (sidepanel : source int) (info : {Nam : string, Email : string}) : xbody = <xml>
  <section>
    {headerMenuTabs tabs}
    <table>
      <tbody>
        <tr>
          {(sidePanel (sidepanel, info.Nam, info.Email))}
          {(mainPageSelector tabs)}
        </tr>
      </tbody>
    </table>
  </section>
</xml>

fun main () =
  (* Initialize source for tabs*)
  tabs <- source 0;
  (* Initialize source for sidepanel*)
  sidepanel <- source 0;
  blurb_result <- User.blurb ();
  case blurb_result.LoggedIn of
    False => return <xml><head><title>Charts</title></head><body><h1>Please log in</h1>{blurb_result.Content}</body></xml>
    | True =>
      info_opt <- User.currentUserInfo ();
      case info_opt of
        None => return <xml><head><title>Charts</title></head><body><h1>Error loading user info</h1></body></xml>
        | Some info => return <xml>
          <head><title>Charts</title></head>
          <body>
            {blurb_result.Content}
            {mainContent tabs sidepanel info}
          </body>
        </xml>
