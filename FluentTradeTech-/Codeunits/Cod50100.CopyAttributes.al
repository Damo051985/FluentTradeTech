codeunit 50100 CopyAttributes
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesInvLineInsert', '', false, false)]
    local procedure OnBeforeSalesInvLineInsert(var SalesInvLine: Record "Sales Invoice Line"; SalesInvHeader: Record "Sales Invoice Header"; SalesLine: Record "Sales Line"; CommitIsSuppressed: Boolean; var IsHandled: Boolean);
    var
        ItemAttValue: Record "Item Attribute Value";
        ItemAttMapping: Record "Item Attribute Value Mapping";
        TextAttributes: Text;
    begin
        //Concatenate all Attributes
        TextAttributes := '';
        ItemAttMapping.RESET;
        ItemAttMapping.SETRANGE("Table ID", Database::Item);
        ItemAttMapping.SETRANGE("No.", SalesInvLine."No.");
        IF NOT ItemAttMapping.IsEmpty THEN
            IF ItemAttMapping.FINDSET then BEGIN
                repeat
                    IF ItemAttMapping."Value 2" <> '' THEN BEGIN
                        IF TextAttributes <> '' then
                            TextAttributes += ',';
                        TextAttributes += '(' + ItemAttMapping."Value 2" + ')';
                    END;
                until itemAttMapping.Next = 0;
            END;
        SalesInvLine."Attributes" := TextAttributes;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', True, True)]
    local procedure MyProcedure(ReportID: Integer; var NewReportID: Integer)
    begin
        //Replace printing of original Sales invoice report.
        IF ReportID = 1306 THEN
            NewReportID := Report::"FTT Sales Invoice";
    end;
}