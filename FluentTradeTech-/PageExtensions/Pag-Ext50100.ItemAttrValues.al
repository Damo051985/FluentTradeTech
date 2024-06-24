pageextension 50100 ItemAttrValues extends "Item Attribute Values"
{
    layout
    {
        AddAfter(Blocked)
        {
            field("Enabled"; Rec.Enabled)
            {
                ApplicationArea = All;
                Editable = True;
                Trigger Onvalidate();
                Begin

                End;
            }
        }
    }
    Trigger OnOpenPage()
    var
        ItemAttrValue: Record "Item Attribute Value";
    Begin
        IF ItemAttrValue.Findset THEN
            ItemAttrValue.ModifyAll(Enabled, False);
    End;
}
