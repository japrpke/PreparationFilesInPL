page 50301 InputDialog
{
    ApplicationArea = All;
    Caption = 'InputDialog';
    PageType = StandardDialog;
    //SourceTable = InputPrompt;
    UsageCategory = Administration;


    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                /*field(Input; Rec.Input)
                {
                    ToolTip = 'Specifies the value of the Input field.';
                }
                */
                field(Input; input)
                {

                }
                field("Input 2"; inp2)
                {

                }
                field("StrMenu"; strMenuInt)
                {
                    trigger OnAssistEdit()
                    var
                    begin
                        //iirc StrMenu() defaults to 0 if the dialog is exited without choice
                        strMenuInt := Dialog.StrMenu('StrMenuOption1,StrMenuOption2,StrMenuOption3', 2, 'Instructions for choosing go here.'); //second argument (in this case 2), is which radio-button is pre-selected
                    end;
                }
                usercontrol(ControlName; ProgressbarTestCtrlAddin)
                {
                    ApplicationArea = All;
                }
            }
            systempart(a; Outlook)
            {

            }
        }
    }
    trigger OnOpenPage()
    var

    begin

    end;

    procedure GetCurrentInput(): Text
    var
    begin
        exit('"' + input + '"' + '\' + Format(inp2) + '\' + Format(strMenuInt));
    end;


    var
        input: Text;
        inp2: Option "Option 1","Option 2","Option 3";
        strMenuInt: Integer;
}
