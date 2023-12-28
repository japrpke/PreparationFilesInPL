page 50300 "TestPage"
{
    ApplicationArea = All;
    Caption = 'TestPage';
    PageType = Card;
    SourceTable = 50300;
    UsageCategory = Tasks;

    layout
    {
        area(Content)
        {
            field(ID; Rec.ID)
            { }
            field(Value; Rec.Value)
            { }

            group(General)
            {
                Caption = 'General';

                ShowCaption = true;
            }

            grid(gridSuper)
            {
                GridLayout = Columns;
                Caption = 'User Controls';

                grid(subGrid1)
                {
                    grid(gridGeoLoc)
                    {
                        usercontrol(geoLoc; GeoLoc)
                        {
                            ApplicationArea = All;
                            trigger geoLocEvent()
                            begin

                            end;
                        }
                    }
                }
                grid(subgrid2)
                {
                    grid(gridMailTo)
                    {
                        usercontrol(ControlName; OpenMailTo)
                        {
                            ApplicationArea = All;

                            /*trigger EventMailTo(someText: Text)
                            begin                                                    
                            end;
                            */
                        }
                    }
                    grid(gridCg)
                    {
                        cuegroup(cuegrp)
                        {

                            actions
                            {
                                action(cgAction1)
                                {
                                    ApplicationArea = All;

                                    trigger OnAction()
                                    var
                                    //x: ControlAddIn OpenMailTo;
                                    begin

                                        //CurrPage.ControlName.MyProcedure('123');
                                        //Message('cgAction1');
                                    end;
                                }
                                action(cgAction2)
                                {
                                    ApplicationArea = All;

                                    trigger OnAction()
                                    begin
                                        Message('cgAction2');
                                    end;
                                }

                            }
                        }
                    }
                }
            }


        }
    }

    actions
    {
        area(Processing)
        {
            action(action1)
            {
                ApplicationArea = All;
                Caption = 'action1Caption';
                Image = Action;
                trigger OnAction()
                var
                    myInt: Integer;
                begin
                    Message('buttonPress');
                end;
            }
            action("Test Progressbar")
            {

                trigger OnAction()
                var
                    WebRMan: Codeunit "WebRequest Management";
                    ProcessingWindow: Dialog;
                    Cust: Record Customer;
                    someDec: Decimal;
                    CustCount: Decimal;
                    intDIV: Integer;

                    currIterator: Integer;
                begin
                    someDec := 10000;
                    CustCount := Cust.count;
                    intDIV := 10000 div CustCount;

                    ProcessingWindow.Open('Zeile1 #1######\'
                                         + 'Zeile 2 #2######\'
                                         + 'Zeile3 \@3@@@@@@'
                                         );

                    if cust.FindFirst() then
                        repeat
                            currIterator += 1;
                            Sleep(500);
                            ProcessingWindow.Update(1, FORMAT((currIterator * intDIV) / 100) + '%');
                            ProcessingWindow.Update(2, FORMAT((currIterator * intDIV) / 100) + '%');
                            ProcessingWindow.Update(3, (currIterator * intDIV));

                        until Cust.Next() = 0;
                    ProcessingWindow.Close();
                end;
            }
            action(GetRequest)
            {
                Image = Web;
                trigger OnAction()
                var
                    WebReqMan: Codeunit "WebRequest Management";
                begin
                    WebReqMan.GetExample();
                end;
            }
            action(TestJPathInWebRequest)
            {
                image = TestFile;
                trigger OnAction()
                var
                    webreqman: Codeunit "WebRequest Management";
                    ConfMan: Codeunit "Confluence Management";
                    httprespmsg: HttpResponseMessage;
                    txt: Text;
                begin
                    httprespmsg := webreqman.GetExampleCopyForTestingOtherStuff();
                    ConfMan.GetValueOfJSONTokenAtJPath_In_ResponseMessage(httprespmsg, '$.fact', txt);
                    Message(txt);
                end;
            }

            action(Open2ndTestPage)
            {
                Image = BarCode;
                trigger OnAction()
                var
                    diaPage: Page InputDialog;
                    act: Action;
                    txt: Text;
                begin
                    if diaPage.RunModal() = Action::OK then begin
                        txt := diaPage.GetCurrentInput();
                        Message(txt);
                    end;
                end;
            }

            action(TryCtrlAddin)
            {
                Image = Web;
            }

            group(group1)
            {
                Image = Group;
                action(groupAction1)
                {
                    trigger OnAction()
                    begin
                        Message('groupAction1');
                    end;
                }
                action(groupAction2)
                {
                    trigger OnAction()
                    begin
                        Message('groupAction2');
                    end;
                }
                action("groupAction3 Excel Test")
                {
                    trigger OnAction()
                    var
                        xl: Record "Excel Buffer";
                    begin
                        xl.CreateNewBook('sheetname');
                        xl.CloseBook();
                        xl.SetFriendlyFilename('friendlyFileName');

                        xl.OpenExcel();
                    end;
                }
            }
        }
    }


    trigger OnOpenPage()
    var

    begin
        if not rec.FindFirst() then begin
            rec.Init();
            rec.ID := 1;
            rec.Insert();
        end
    end;

    var
        txt1: Text;
        txt2: Text;

}
