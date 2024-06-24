PageExtension 50105 "PostSalesInvSub-Ext" Extends "Posted Sales Invoice Subform"
{
    Layout
    {
        AddAfter(Description)
        {
            Field(Attributes; rec.Attributes)
            {
                ApplicationArea = All;
                Editable = False;
                Caption = 'Item Attributes';
            }
        }
    }
}
