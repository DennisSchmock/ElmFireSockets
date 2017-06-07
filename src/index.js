
require('ace-css/css/ace.css');
require('font-awesome/css/font-awesome.css');
require('./index.html');

// Require index.html so it gets copied to dist
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
window.database = database
database.ref('users/denniz').set({
  userName : "Dennis"
})


var Elm = require('./Chat.elm');
var mountNode = document.getElementById('main');

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Chat.embed(mountNode);
