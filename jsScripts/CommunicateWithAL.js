
//AL controlAddins always land in a div named with id 'controlAddin'
var someDiv = document.getElementById('controlAddIn');

//TODO: figure out how to use a normal html file, instead of literals like this:
someDiv.innerHTML = 
  '<div style="border: solid;">'
+ '<form>'
+ '<input id="quantity" class="qty" type="text" placeholder="quantity" />'
+ '</form>' 
//+ ' <!--display total cost here--> '
//+ 'The Cost is: <span></span>'
+ '</div>'
;


var cost = 22;
var input = someDiv.getElementsByTagName('input')[0],
    span = someDiv.getElementsByTagName('span')[0];

function update(value){
    var totalCost = (cost * value);
    span.innerHTML = totalCost;
}

input.oninput = function(){
    var val = parseFloat(input.value, 10);
    //update(val);    
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('MessageTheOutput',['Cost = ' + cost + ', cost*input = ' + val*cost]);
}

//Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('SomeEvent',['a','b']);
