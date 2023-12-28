table 50300 TestTable
{
    Caption = 'TestTable';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; ID; Integer)
        {
            Caption = 'ID';
        }
        field(2; "Value"; Text[2048])
        {
            Caption = 'Value';
        }
    }
    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
}
