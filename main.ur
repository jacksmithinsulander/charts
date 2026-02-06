open User

type sidePanelArgs = {Sidepanel : source int, Nam : string, Email : string}

fun sidePanel (r : sidePanelArgs) : xtr = <xml>
  <td>
    <fieldset>
      <dyn signal={active <- signal r.Sidepanel;
        return <xml>
          <figure>
            <figcaption>Spaces</figcaption>
            <ul>
              <li style={if active = 0 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 0}>Projects</li>
              <li style={if active = 1 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 1}>Data Room</li>
              <li style={if active = 2 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 2}>Funding</li>
              <li style={if active = 3 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 3}>Legal</li>
            </ul>
          </figure>
          <figure>
            <figcaption>Funding</figcaption>
            <ul>
              <li style={if active = 4 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 4}>Account</li>
              <li style={if active = 5 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 5}>Loans</li>
              <li style={if active = 6 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 6}>KYC / AML</li>
            </ul>
          </figure>
          <figure>
            <figcaption>Data</figcaption>
            <ul>
              <li style={if active = 7 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 7}>Sources</li>
              <li style={if active = 8 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 8}>Validation</li>
              <li style={if active = 9 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 9}>Key financials</li>
            </ul>
          </figure>
          <figure>
            <figcaption>Tools</figcaption>
            <ul>
              <li style={if active = 10 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set r.Sidepanel 10}>Forecasting studio</li>
            </ul>
          </figure>
          <hr/>
        </xml>}/>
      <h3>{[r.Nam]}</h3>
      <p>{[r.Email]}</p>
    </fieldset>
  </td>
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
            <th><nav style={if active = 0 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set tabs 0}>Overview</nav></th>
            <th><nav style={if active = 1 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set tabs 1}>My Loans</nav></th>
            <th><nav style={if active = 2 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set tabs 2}>Properties</nav></th>
            <th><nav style={if active = 3 then STYLE "background: #333; color: #fff" else STYLE "background: #fff; color: #333"} onclick={fn _ => set tabs 3}>Documents</nav></th>
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
          {(sidePanel {Sidepanel = sidepanel, Nam = info.Nam, Email = info.Email})}
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
  (* Getting UserId, this will be used to check if a user is logged in*)
  userid <- User.userId ();
  blurb <- User.blurb ();
  case userid of
    None => return <xml><head><title>Charts</title></head><body><h1>Please log in</h1>{blurb}</body></xml>
    | Some uid =>
      info_opt <- User.currentUserInfo ();
      case info_opt of
        None => return <xml><head><title>Charts</title></head><body><h1>Error loading user info</h1></body></xml>
        | Some info => return <xml>
          <head><title>Charts</title></head>
          <body>
            {blurb}
            {mainContent tabs sidepanel info}
          </body>
        </xml>
