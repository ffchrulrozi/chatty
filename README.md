# My Budget

<p>A financial notes app, write all our daily transaction, both income or outcome, and see it report based on type and date range.</p>
<p>There are several libraries used in this app, like: </p>
<table>
  <thead>
    <tr>
      <th>Library</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>flutter_riverpod</t>
      <td>State management</td>
    </tr>
    <tr>
      <td>google_sign_in</td>
      <td>Login with Google</td>
    </tr>
    <tr>
      <td>cloud_firestore</td>
      <td>Firestore database</td>
    </tr>
    <tr>
      <td colspan="2">and more (see pubspec.yaml)</td>
    </tr>
  </tbody>
</table>
<p>These are several screens and it explanation:</p>
<ul>
  <li>
    <b>Splash Screen</b>
    <p>Show splash screen for 2 seconds, then go to login page.</p>
    <img src="./git-img/1-splash.png" style="height:200px; width: 115px; object-fit:cover" />  
  </li>
  <li>
    <b>Login</b>
    <p>Enable user login to this app use Google SignIn</p>
    <img src="./git-img/2-login.png" style="height:200px; width: 115px; object-fit:cover" />  
  </li>
  <li>
    <b>Drawer</b>
    <p>Show profile a little of user's account detail and show list of menus.</p>
    <img src="./git-img/3-drawer.png" style="height:200px; width: 115px; object-fit:cover" />
  </li>
  <li>
    <b>Chat List</b>
    <p>List of chats by current user, integrated to firestore.</p>
    <img src="./git-img/4-chat-list.png" style="height:200px; width: 115px; object-fit:cover" />
  </li>
  <li>
    <b>Chat Detail</b>
    <p>Show messages between current user and target user. Enable user to send new chat.</p>
    <img src="./git-img/5-chat-detail.png" style="height:200px; width: 115px; object-fit:cover" />
  </li>
  <li>
    <b>Contact List</b>
    <p>Show list of current user's contacts. Integrated to firestore.</p>
    <img src="./git-img/6-contact-list.png" style="height:200px; width: 115px; object-fit:cover" />
  </li>
  <li>
    <b>Contact Detail</b>
    <p>Show detail of a contact, enable to update data or remove it.</p>
    <img src="./git-img/7-contact-detail.png" style="height:200px; width: 115px; object-fit:cover" />
  </li>
</ul>
