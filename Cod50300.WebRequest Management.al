codeunit 50300 "WebRequest Management"
{
    var

    trigger OnRun()
    var
    begin
    end;


    procedure GetExample()
    var
        httpCl: HttpClient;
        httpResp: HttpResponseMessage;
        respBody: Text;
        JsonMan: Codeunit "JSON Management";

        txt: Text;

        jsonobj: JsonObject;
        jsonArr: JsonArray;
        jsonTok: JsonToken;

        v: Variant;

    begin
        //clearing the headers is usually optional,
        //though there are some default headers which can lead to errors
        //httpCl.DefaultRequestHeaders.Clear();


        httpCl.Get('https://catfact.ninja/fact', httpResp);
        if not httpResp.IsSuccessStatusCode then
            Message(httpResp.ReasonPhrase)
        else begin
            httpResp.Content.ReadAs(respBody);
            //Message(respBody);
        end;

        if jsonobj.ReadFrom(respBody) then begin
            jsonobj.Get('fact', jsonTok);
            jsonTok.WriteTo(txt);
            Message(txt);
        end;

        if JsonMan.InitializeFromString(respBody) then
            if JsonMan.GetPropertyValueByName('fact', v) then
                //if v.IsText then
                Message('getPropValByName: ' + Format(v));


        if JsonMan.InitializeFromString(respBody) then begin
            txt := JsonMan.WriteObjectToString();
            //writeObjectToString serializes it(= complete json-syntax):
            Message('initFromString: ' + txt);
        end;

    end;


    //get value of specific token from a HttpResponseMessage:
    procedure GetValueOfJSONTokenAtJPath(httpResponseMsg: HttpResponseMessage; JPathExpression: Text; var result: Text): Boolean
    var
        ResponseMsgTextBuffer: Text;
        jTok: JsonToken;
        jTok2: JsonToken;
    begin
        //for JPath Expressions: https://goessner.net/articles/JsonPath/

        httpResponseMsg.Content.ReadAs(ResponseMsgTextBuffer);

        //jObject.ReadFrom(ResponseMsgTextBuffer);        
        jTok.ReadFrom(ResponseMsgTextBuffer);

        if jTok.SelectToken(JPathExpression, jTok2) then begin
            jTok2.WriteTo(result);
            exit(true);
        end;

        exit(false);
    end;

    procedure GetExampleCopyForTestingOtherStuff(): HttpResponseMessage
    var
        httpCl: HttpClient;
        httpResp: HttpResponseMessage;
        respBody: Text;
        JsonMan: Codeunit "JSON Management";

        txt: Text;

        jsonobj: JsonObject;
        jsonArr: JsonArray;
        jsonTok: JsonToken;

        v: Variant;

    begin

        httpCl.Get('https://catfact.ninja/fact', httpResp);
        if not httpResp.IsSuccessStatusCode then
            Message(httpResp.ReasonPhrase)
        else begin
            httpResp.Content.ReadAs(respBody);
        end;
        exit(httpResp);
    end;


}
