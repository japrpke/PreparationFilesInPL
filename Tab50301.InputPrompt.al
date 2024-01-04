table 50301 InputPrompt
{
    Caption = 'InputPrompt';
    DataClassification = ToBeClassified;
    //TableType = Temporary;

    //new irrelevant line to test commit compare

    fields
    {
        field(1; Input; Text[2048])
        {
            Caption = 'Input';
        }
        field(2; Text; Text[2048])
        {

        }
    }
    keys
    {
        key(PK; Input)
        {
            Clustered = true;
        }
    }
}
