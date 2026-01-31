const firebaseConfig = {
apiKey: "AIzaSyDYDiVYGJWYWKHZi7T24Fk2xuBm4g6JiNI",
authDomain: "ebomedikal-80da4.firebaseapp.com",
databaseURL: "https://ebomedikal-80da4-default-rtdb.europe-west1.firebasedatabase.app",
projectId: "ebomedikal-80da4",
storageBucket: "ebomedikal-80da4.firebasestorage.app",
messagingSenderId: "542996689822",
appId: "1:542996689822:web:914896a23260be76b61c8f"
};

firebase.initializeApp(firebaseConfig);
const auth = firebase.auth();
const database = firebase.database();
