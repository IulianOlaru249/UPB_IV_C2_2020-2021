/**
 * @license
 * Copyright Akveo. All Rights Reserved.
 * Licensed under the MIT License. See License.txt in the project root for license information.
 */
// The file contents for the current environment will overwrite these during build.
// The build system defaults to the dev environment which uses `environment.ts`, but if you do
// `ng build --env=prod` then `environment.prod.ts` will be used instead.
// The list of which env maps to which file can be found in `.angular-cli.json`.

export const environment = {
  firebase: {
    // add your Firebase config here
    apiKey: "AIzaSyAL7b4OG_g_Tik6aIr5XKzNXrWoa59DTts",
    authDomain: "isi-lab05.firebaseapp.com",
    databaseURL: "https://isi-lab05-default-rtdb.europe-west1.firebasedatabase.app",
    projectId: "isi-lab05",
    storageBucket: "isi-lab05.appspot.com",
    messagingSenderId: "268192102196",
    appId: "1:268192102196:web:47ffe9dea9e1123d339761",
    measurementId: "G-1NNQYCLN05"
  },
  production: false,
};
