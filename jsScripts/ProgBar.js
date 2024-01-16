var someDiv = document.getElementById("controlAddIn");

//below fetch() does not work, "we could not find the page you were looking for"
fetch('jsScripts/ProgressbarTest.html').then(response => response.text()).then(text => someDiv.innerHTML = text)
