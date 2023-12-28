table 50301 InputPrompt
{
    Caption = 'InputPrompt';
    DataClassification = ToBeClassified;
    //TableType = Temporary;

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
