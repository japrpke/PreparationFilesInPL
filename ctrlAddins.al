controladdin OpenMailTo
{
    RequestedHeight = 200;
    RequestedWidth = 200;


    StartupScript = 'jsScripts\mailTo.js';

    //event EventMailTo(txt: Text);
    procedure TestFunction(someText: Text);
}

controladdin GeoLoc
{
    RequestedHeight = 300;
    RequestedWidth = 300;

    StartupScript = 'jsScripts\geoloc.js';

    event geoLocEvent();
}

//progressbartest
controladdin ProgressbarTestCtrlAddin
{
    RequestedHeight = 100;
    RequestedWidth = 200;

    //Scripts = 'script1.js','script2.js';
    //StyleSheets = 'style.css';
    StartupScript = 'jsScripts/ProgBar.js';
    //RecreateScript = 'recreateScript.js';
    //RefreshScript = 'refreshScript.js';
    //Images = 'image1.png','image2.png';

    event MyEvent()

    procedure MyProcedure()
}

controladdin CtrlAddinCommunicateWithAL
{
    RequestedHeight = 200;
    RequestedWidth = 200;

    StartupScript = 'jsScripts/CommunicateWithAL.js';

    event SomeEvent(firstParam: Text; secondParam: Text);
    event MessageTheOutput(output: Text);

}

