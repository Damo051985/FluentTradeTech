pageextension 50103 ItemCard extends "Item Card"
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