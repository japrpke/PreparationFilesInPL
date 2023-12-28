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
