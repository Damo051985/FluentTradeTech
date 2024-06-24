pageextension 50102 ItemAttrFactbox extends "Item Attributes Factbox"
{
    Trigger OnOpenPage()
    begin
        GetItemNo2;
        ShowValues();
    end;

    Procedure ShowValues()
    VAR
        ItemAttrValuMapping: record "Item Attribute Value Mapping";
        ItemAttr: record "item Attribute";
    Begin
        IF Rec.FIndset THEN begin
            Repeat
                ItemAttrValuMapping.RESET;
                ItemAttrValuMapping.SETRANGE("Table Id", 27);
                ItemAttrValuMapping.SETRANGE("No.", ItemAttrCode);
                ItemAttrValuMapping.SETRANGE("Item Attribute ID", Rec."Attribute ID");
                ItemAttrValuMapping.SETRANGE("Item Attribute Value ID", Rec."ID");
                IF Not ItemAttrValuMapping.IsEmpty THEN BEGIN
                    ItemAttrValuMapping.FINDFIRST;
                    IF ItemAttr.GET(ItemAttrValuMapping."Item Attribute ID") then
                        IF ItemAttr.Type = ItemAttr.Type::Option THEN BEGIN
                            Rec.Value := iTemAttrValuMapping."Value 2";
                            Rec.Modify();
                        END ELSE begin
                            //Copy Value field to "Value 2" field
                            IF ItemAttrValuMapping."Value 2" = '' then begin
                                ItemAttrValuMapping."Value 2" := Rec.Value;
                                ItemAttrValuMapping.MODIFY;
                            end;
                        end;
                end;
            Until Rec.Next = 0;
        End;
    end;

    Procedure GetItemNo(ItemNo: Code[20])
    Begin
        ItemAttrCode := ItemNo;
    End;

    Procedure GetItemNo2()
    Var
        ItemAttrValueMap: Record "Item Attribute Value Mapping";
    Begin
        ItemAttrValueMap.SETRANGE("Table Id", 27);
        ItemAttrValueMap.SETRANGE("Item Attribute ID", rec."Attribute ID");
        ItemAttrValueMap.SETRANGE("Item Attribute Value ID", REc."ID");
        IF NOT ItemAttrValueMap.IsEmpty then begin
            ItemAttrValueMap.FINDFIRST;
            ItemAttCode := ItemAttrValueMap."No.";
        end;
    End;

    var
        ItemAttrCode: Code[20];
}
