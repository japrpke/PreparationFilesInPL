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
            }
            systempart(a; Outlook)
            {

            }
        }
    }
    trigger OnOpenPage()
    var
        InputTable: Record InputPrompt;
    begin
        InputTable.DeleteAll();
        InputTable.Init();
        InputTable.Insert();
    end;

    procedure GetCurrentInput(): Text
    var
    begin
        //exit(Rec.Input);
        exit(input);
    end;


    var
        input: Text;

}
