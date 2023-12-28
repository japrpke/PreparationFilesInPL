codeunit 50301 "Confluence Management"
{
    var
        GlobalAuthKey: Text;

    procedure INIT()
    var
    begin
        SetGlobalAuthKey('TkFWOiNOQVYySmlyYSE=');
    end;


    procedure SetGlobalAuthKey(authKey: Text)
    begin
        GlobalAuthKey := authKey;
    end;


    //intended for testing, GetPageBody() will probably fulfill all your needs
    [TryFunction]
    procedure GetPage(URL: Text; var PageResponseBody: Text)
    var
        LocHttpClient: HttpClient;
        LocHttpRespMsg: HttpResponseMessage;
    begin
        LocHttpClient.DefaultRequestHeaders.Clear();
        LocHttpClient.DefaultRequestHeaders.Add('Content-Type', 'Application/json');
        LocHttpClient.DefaultRequestHeaders.Add('Accept', 'application/json');
        LocHttpClient.DefaultRequestHeaders.Add('Authorization', 'Basic ' + GlobalAuthKey);

        LocHttpClient.Get(URL, LocHttpRespMsg);
        LocHttpRespMsg.Content.ReadAs(PageResponseBody);
    end;



    procedure GetPageBody(pageID: Text; var PageBody: Text): Boolean
    var
        LocHttpClient: HttpClient;
        LocHttpRespMsg: HttpResponseMessage;
        baseUrlAPI: Text;
        queryParam: List of [Text];
        fullURL: Text;
    begin
        //intended for copying the html-body of the specified page

        baseUrlAPI := 'https://confluence.pke.at/rest/api/content/';
        queryParam.Add('?expand=body.view');
        fullURL := baseUrlAPI + pageID;
        fullURL := AddQueryParametersToURL(fullURL, queryParam);

        LocHttpClient.DefaultRequestHeaders.Clear();
        LocHttpClient.DefaultRequestHeaders.Add('Content-Type', 'application/json');
        LocHttpClient.DefaultRequestHeaders.Add('Accept', 'application/json');
        //Authorization header was not necessary at the time of development,
        //but could look like this:
        //LocHttpClient.DefaultRequestHeaders.Add('Authorization', 'Basic ' + GlobalAuthKey);

        if LocHttpClient.Get(fullURL, LocHttpRespMsg) then
            exit(GetValueOfJSONTokenAtJPath_In_ResponseMessage(LocHttpRespMsg, '$.body.view.value', PageBody));
    end;



    procedure GetSpace(spaceKey: Text; var SpaceResponseBody: Text): Boolean
    var
        LocHttpClient: HttpClient;
        LocHttpResponseMsg: HttpResponseMessage;
        baseUrlAPI: Text;
        UrlWithFilterForSpaceKey: Text;

        QueryParams: list of [Text];
    begin
        baseUrlAPI := 'https://confluence.pke.at/rest/api/space';
        UrlWithFilterForSpaceKey := baseUrlAPI + '?spaceKey=' + spaceKey;

        LocHttpClient.DefaultRequestHeaders.Clear();
        LocHttpClient.DefaultRequestHeaders.Add('Content-Type', 'Application/json');
        LocHttpClient.DefaultRequestHeaders.Add('Accept', 'application/json');
        LocHttpClient.DefaultRequestHeaders.Add('Authorization', 'Basic ' + GlobalAuthKey);

        if LocHttpClient.Get(UrlWithFilterForSpaceKey, LocHttpResponseMsg) then
            exit(LocHttpResponseMsg.Content.ReadAs(SpaceResponseBody));
    end;



    procedure CreateSpace(spaceKey: Text; spaceName: Text; var httpRespMsg: HttpResponseMessage): Boolean
    var
        LocHttpClient: HttpClient;
        LocHttpContent: HttpContent;
        LocHttpHdrs: HttpHeaders;
        LocHttpRespMsg: HttpResponseMessage;
        jsonObj: JsonObject;
        jsonArr: JsonArray;
        requestBodyAsText: Text;
        LocUrl: Text;
    begin

        if (spaceKey = '') or (spaceName = '') then
            exit(false);

        LocUrl := 'https://confluence.pke.at/rest/api/space';
        LocHttpClient.DefaultRequestHeaders.Clear();
        LocHttpClient.DefaultRequestHeaders.Add('Authorization', StrSubstNo('Basic %1', GlobalAuthKey));

        jsonObj.Add('key', spaceKey);
        jsonObj.Add('name', spaceName);
        jsonObj.WriteTo(requestBodyAsText);

        LocHttpContent.WriteFrom(requestBodyAsText);
        LocHttpContent.GetHeaders(LocHttpHdrs);
        LocHttpHdrs.Clear();
        LocHttpHdrs.Add('Content-Type', 'application/json');

        if LocHttpClient.Post(LocUrl, LocHttpContent, LocHttpRespMsg) then begin
            httpRespMsg := LocHttpRespMsg;
            exit(LocHttpRespMsg.IsSuccessStatusCode);
        end;
    end;



    procedure CreatePageInSpace(spaceKey: Text; PageTitle: Text; var httpRespMsg: HttpResponseMessage): Boolean
    var
        LocHttpClient: HttpClient;
        LocHttpContent: HttpContent;
        LocHttpHdrs: HttpHeaders;
        LocHttpRespMsg: HttpResponseMessage;
        jsonObj: JsonObject;
        nestedJsonObj: JsonObject;
        requestBodyAsText: Text;
        LocURL: Text;
    begin
        if (spaceKey = '') or (PageTitle = '') then
            exit(false);

        LocUrl := 'https://confluence.pke.at/rest/api/space';
        LocHttpClient.DefaultRequestHeaders.Clear();
        LocHttpClient.DefaultRequestHeaders.Add('Authorization', StrSubstNo('Basic %1', GlobalAuthKey));

        nestedJsonObj.Add('key', spaceKey);
        //space is a property with a jsonObject as it's value
        jsonObj.Add('space', nestedJsonObj);
        jsonObj.Add('type', 'page');
        jsonObj.Add('title', PageTitle);
        jsonObj.WriteTo(requestBodyAsText);

        LocHttpContent.WriteFrom(requestBodyAsText);
        LocHttpContent.GetHeaders(LocHttpHdrs);
        LocHttpHdrs.Clear();
        LocHttpHdrs.Add('Content-Type', 'application/json');

        if LocHttpClient.Post(LocUrl, LocHttpContent, LocHttpRespMsg) then begin
            httpRespMsg := LocHttpRespMsg;
            exit(LocHttpRespMsg.IsSuccessStatusCode);
        end;

    end;



    procedure CreateChildPageInSpace(spaceKey: Text; TitleOfNewChildPage: Text; AncestorId: Text; var httpRespMsg: HttpResponseMessage): Boolean
    var
        LocHttpClient: HttpClient;
        LocHttpContent: HttpContent;
        LocHttpHdrs: HttpHeaders;
        LocHttpRespMsg: HttpResponseMessage;
        jsonObj: JsonObject;
        nestedJsonObj: JsonObject;
        jsonArr: JsonArray;
        requestBodyAsText: Text;
        LocURL: Text;
    begin
        if (spaceKey = '') or (TitleOfNewChildPage = '') or (AncestorId = '') then
            exit(false);

        LocUrl := 'https://confluence.pke.at/rest/api/space';
        LocHttpClient.DefaultRequestHeaders.Clear();
        LocHttpClient.DefaultRequestHeaders.Add('Authorization', StrSubstNo('Basic %1', GlobalAuthKey));

        /*        
        //requestbody should look like this:
        {
            "space":{                                     
                "key":"spaceKey"
            },                                            
            "type":"page",
            "title":"TitleOfNewChildPage",
            "ancestors": [
                {                                         
                    "id":"AncestorId"
                }
            ]                                            
        }                                                
        */

        nestedJsonObj.Add('key', spaceKey);
        jsonObj.Add('space', nestedJsonObj);
        jsonObj.Add('type', 'page');
        jsonObj.Add('title', TitleOfNewChildPage);

        Clear(nestedJsonObj);
        nestedJsonObj.Add('id', AncestorId);
        jsonArr.Add(nestedJsonObj);

        jsonObj.Add('ancestors', jsonArr);
        jsonObj.WriteTo(requestBodyAsText);

        LocHttpContent.WriteFrom(requestBodyAsText);
        LocHttpContent.GetHeaders(LocHttpHdrs);
        LocHttpHdrs.Clear();
        LocHttpHdrs.Add('Content-Type', 'application/json');

        if LocHttpClient.Post(LocUrl, LocHttpContent, LocHttpRespMsg) then begin
            httpRespMsg := LocHttpRespMsg;
            exit(LocHttpRespMsg.IsSuccessStatusCode);
        end;

    end;




    procedure GetValueOfJSONTokenAtJPath_In_Text(source: Text; JPathExpression: Text; var result: Text): Boolean
    var
        LocJToken: JsonToken;
        LocJTokenResult: JsonToken;
    begin
        //for JPath Expressions: 
        // https://goessner.net/articles/JsonPath/
        // https://jsonpath.com/
        // https://jsonpathfinder.com/

        LocJToken.ReadFrom(source);
        if LocJToken.SelectToken(JPathExpression, LocJTokenResult) then
            exit(LocJTokenResult.WriteTo(result));
    end;

    procedure GetValueOfJSONTokenAtJPath_In_JsonObject(source: JsonObject; JPathExpression: Text; var result: Text): Boolean
    var
        LocJTok: JsonToken;
    begin
        //for JPath Expressions: 
        // https://goessner.net/articles/JsonPath/
        // https://jsonpath.com/
        // https://jsonpathfinder.com/       

        if source.SelectToken(JPathExpression, LocJTok) then
            exit(LocJTok.WriteTo(result));
    end;

    procedure GetValueOfJSONTokenAtJPath_In_JsonToken(jsonTok: JsonToken; JPathExpression: Text; var result: Text): Boolean
    var
        LocJTok: JsonToken;
    begin
        //for JPath Expressions: 
        // https://goessner.net/articles/JsonPath/
        // https://jsonpath.com/
        // https://jsonpathfinder.com/

        if jsonTok.SelectToken(JPathExpression, LocJTok) then
            exit(LocJTok.WriteTo(result));
    end;

    procedure GetValueOfJSONTokenAtJPath_In_ResponseMessage(httpResponseMsg: HttpResponseMessage; JPathExpression: Text; var result: Text): Boolean
    var
        ResponseMsgTextBuffer: Text;
        jTok: JsonToken;
        jTok2: JsonToken;
    begin
        //for JPath Expressions: 
        // https://goessner.net/articles/JsonPath/
        // https://jsonpath.com/
        // https://jsonpathfinder.com/

        httpResponseMsg.Content.ReadAs(ResponseMsgTextBuffer);

        jTok.ReadFrom(ResponseMsgTextBuffer);
        if jTok.SelectToken(JPathExpression, jTok2) then
            exit(jTok2.WriteTo(result));
    end;


    procedure AddQueryParametersToURL(URL: Text; QueryParams: List of [Text]): Text
    var
        QueryPar: Text;
    begin
        foreach QueryPar in QueryParams do
            if QueryPar <> '' then begin

                if not URL.Contains('?') then begin
                    URL += '?';
                    URL += QueryPar;
                end else begin
                    URL += '&';
                    URL += QueryPar;
                end;
            end;
    end;
}
