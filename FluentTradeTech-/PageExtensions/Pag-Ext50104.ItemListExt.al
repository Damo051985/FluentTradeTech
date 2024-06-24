pageextension 50104 ItemListExt extends "Item List"
{
    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.ItemAttributesFactbox.Page.GetItemNo(Rec."No.");
        CurrPage.ItemAttributesFactbox.Page.ShowValues;
    end;

    trigger OnOpenPage()
    begin
        CurrPage.ItemAttributesFactbox.Page.GetItemNo(Rec."No.");
        CurrPage.ItemAttributesFactbox.Page.ShowValues;
    end;
}
