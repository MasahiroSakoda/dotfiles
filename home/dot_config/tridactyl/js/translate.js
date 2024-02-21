// -*-mode:javascript-*- vim:ft=javascript

//jshint esversion:6
const googleTranslateCallback = document.createElement('script');
googleTranslateCallback.innerHTML = "function googleTranslateElementInit(){ new google.translate.TranslateElement(); }";
document.body.insertBefore(googleTranslateCallback, document.body.firstChild);

//jshint esversion:6
const googleTranslateScript = document.createElement('script');
googleTranslateScript.charset="UTF-8";
googleTranslateScript.src = "https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit&tl=&sl=&hl=";
document.body.insertBefore(googleTranslateScript, document.body.firstChild);
