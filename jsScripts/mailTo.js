function getInputValue(){
    inpElement = document.getElementById('inp');
    return inpElement.value;
}


var somePerson = "x";

var someDiv = document.getElementById('controlAddIn');
//someDiv.innerHTML = "<br><input type='text' id='inp'>";
someDiv.innerHTML = "<a href='mailto:" +somePerson+ "'>MailLink</a>";
//someDiv.innerHTML += "<a href='mailto:" +""+getInputValue()+ "'>MailLink</a>";


/*
var clickedAlready = false;
someDiv.addEventListener('click', event => {
    if (!cliclickedAlready){
        someDiv.innerHTML += "<br><input type='text' id='inp'>";
    }
    clickedAlready = true;
});
*/


/*
someDiv.addEventListener('click', event =>{
    someDiv.innerHTML = '<a href="mailto:test">'+SomeText+'</a>';
});
*/

