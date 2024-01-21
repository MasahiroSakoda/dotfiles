// -*-mode:javascript-*- vim:ft=javascript

let googleTranslateCallback = document.createElement('script');
googleTranslateCallback.innerHTML = "function googleTranslateElementInit(){ new google.translate.TranslateElement(); }";
document.body.insertBefore(googleTranslateCallback, document.body.firstChild);

let googleTranslateScript = document.createElement('script');
googleTranslateScript.charset="UTF-8";
googleTranslateScript.src = "https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit&tl=&sl=&hl=";
document.body.insertBefore(googleTranslateScript, document.body.firstChild);
