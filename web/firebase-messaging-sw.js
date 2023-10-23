importScripts("https://www.gstatic.com/firebasejs/10.1.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/10.1.0/firebase-messaging.js");
firebase.initializeApp({
  apiKey: "AIzaSyAAwKUZg21Bz4zAHwdrtWA_p_COPP8JliA",
  authDomain: "hope-gaming.firebaseapp.com",
  projectId: "hope-gaming",
  storageBucket: "hope-gaming.appspot.com",
  messagingSenderId: "470004766738",
  appId: "1:470004766738:web:e94dbbf0bd742858ec20cb",
  measurementId: "G-CGXP0QH3FB"
  databaseURL: "https://chopstore-347c2-default-rtdb.firebaseio.com/",
});
const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});