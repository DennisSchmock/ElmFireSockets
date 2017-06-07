/*
 * A websocket server in node.
 * Documentation available here: https://www.npmjs.com/package/nodejs-websocket
 */

var ws = require("nodejs-websocket");
var port = process.env.PORT || 3000;

var firebase = require('firebase')
var config = {
    apiKey: "AIzaSyBqvi-TX20Lk5hLgxw0miknqWdntiEtv6g",
    authDomain: "itemlist-84222.firebaseapp.com",
    databaseURL: "https://itemlist-84222.firebaseio.com",
    projectId: "itemlist-84222",
    storageBucket: "itemlist-84222.appspot.com",
    messagingSenderId: "530107007231"
  };
  firebase.initializeApp(config);

var database = firebase.database();
 var ref = database.ref()


ref.child('messages').limitToLast(1).on('value',function(snapshot){
  snapshot.forEach(function(childSnapshot){
    console.log(childSnapshot.toJSON())

    var userName = childSnapshot.child("userName");
    var content = childSnapshot.child("content");

    broadcast("send", content,userName);

  })
})



var server = ws.createServer(function (conn) {
  conn.on("text", function (str) {
    //console.log("Got text" + str)
    try {
      //console.log("Test");
      var object = JSON.parse(str);
      console.log( object)
      if (object.command == "login") {
        ref.child('users').push({
          userName : object.userName
        })
        //broadcast("login", object.content)
      } else {
        ref.child('messages').push(object)
        //broadcast("send", object.content,object.userName)
      }
    } catch (exception) {
      // JSON deserialisation failed
      console.log ("parse failed :" + str)
      //broadcast("send", str)
    }
  })

  conn.on("close", function (code, reason) {
    console.log("Connection closed", code, reason)
  })
});
server.listen(port);
console.log("Listening on port ", port)

function jsonMessage(command, content,userName) {
  return JSON.stringify({
    command: command,
    content: content,
    userName: userName
  });
}

function broadcast(command, content,userName) {
  server.connections.forEach(function (connection) {
    console.log("Sending ", jsonMessage(command, content))
    connection.sendText(jsonMessage(command, content,userName));
  });
}
