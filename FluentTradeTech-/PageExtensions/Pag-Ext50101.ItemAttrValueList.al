pageextension 50101 ItemAttrValueList extends "Item Attribute Value List"
{
    Layout
    {
        Modify(Value)
        {
            Visible = False;
        }
        addafter("Value")
        {
            Field("Value 2"; rec."Value 2")
            {
                ApplicationArea = all;
                Visible = True;
                Caption = 'Value';

                Trigger OnLookup(var Text: Text): Boolean
                VAr
                    ItemAttr: Record "Item Attribute";
                    ItemAttrValue: Record "Item Attribute Value";
                    ItemAttrValueMap: Record "Item Attribute Value Mapping";
                    MultipleValues: Text;
                Begin

                    IF Rec."Attribute Type" <> Rec."Attribute Type"::Option THEN
                        EXIT;

                    ItemAttrValue.RESET;
                    ItemAttrValue.SETRANGE("Attribute ID", Rec."Attribute ID");
                    IF NOT ItemAttrValue.IsEmpty THEN BEGIN
                        ItemAttrValue.FINDSET;
                        if Page.RunModal(Page::"Item Attribute Values", ItemAttrvalue) = Action::LookupOK then begin
                            SingleValue := ItemAttrValue.Value;
                            ItemAttrValue.RESET;
                            ItemAttrValue.SETRANGE(Enabled, True);
                            ItemAttrValue.SetRange(Blocked, FALSE);
                            IF NOT ItemAttrValue.IsEmpty THEN BEGIN
                                ItemAttrValue.Findset;
                                repeat
                                    IF MultipleValues <> '' then
                                        MultipleValues += ',';
                                    MultipleValues += ItemAttrValue.Value;
                                Until ItemAttrValue.next = 0;

                                ItemAttrValueMap.SETRANGE("Table ID", DATABASE::ITEM);
                                ItemAttrValueMap.SETRANGE("no.", RelatedRecordCode);
                                ItemAttrValueMap.SETRANGE("Item Attribute ID", ItemAttrValue."Attribute ID");
                                IF NOT ItemAttrValueMap.IsEmpty THEN BEGIN
                                    ItemAttrValueMap.FINDFIRST;
                                    ItemAttrValueMap."Value 2" := MultipleValues;
                                    ItemAttrValueMap.Modify;
                                END;

                                Rec."Value 2" := MultipleValues;
                                Rec.VALIDATE(Rec.Value, SingleValue);
                                Rec.modify(True);
                            END;
                        END;
                    END
                End;

                trigger OnValidate();
                var
                    ItemAttributeValue: Record "Item Attribute Value";
                    ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
                    ItemAttribute: Record "Item Attribute";
                begin
                    Rec.Value := Rec."Value 2";
                    Rec.Modify(True);

                    if not rec.FindAttributeValue(ItemAttributeValue) then
                        rec.InsertItemAttributeValue(ItemAttributeValue, Rec);

                    ItemAttributeValueMapping.SetRange("Table ID", DATABASE::Item);
                    ItemAttributeValueMapping.SetRange("No.", RelatedRecordCode);
                    ItemAttributeValueMapping.SetRange("Item Attribute ID", ItemAttributeValue."Attribute ID");
                    IF NOT ItemAttributeValueMapping.IsEmpty THEN BEGIN
                        ItemAttributeValueMapping.FindFirst;
                        ItemAttributeValueMapping."Item Attribute Value ID" := ItemAttributeValue.ID;
                        ItemAttributeValueMapping."Value 2" := Rec."Value 2";
                        ItemAttributeValueMapping.Modify();
                    end;

                    ItemAttribute.Get(Rec."Attribute ID");
                    if ItemAttribute.Type <> ItemAttribute.Type::Option then
                        if Rec.FindAttributeValueFromRecord(ItemAttributeValue, xRec) then
                            if not ItemAttributeValue.HasBeenUsed then
                                ItemAttributeValue.Delete();
                end;
            }
        }
    }
    Trigger OnClosePage()
    Begin

    End;

    var
        SingleValue: Text;

    Trigger OnOpenPage()
    var
        ItemAttrValMap: Record "Item Attribute Value Mapping";
    BEGIN
        IF Rec.Findset THEN
            Repeat
                IF ItemAttrValMap.GET(Rec."Inherited-From Table ID", REc."Inherited-From Key Value", Rec."Attribute ID") then Begin
                    Rec."Value 2" := iTemAttrValMap."Value 2";
                    Rec.Modify;
                END;
            Until Rec.Next = 0;
    END;

    var

}