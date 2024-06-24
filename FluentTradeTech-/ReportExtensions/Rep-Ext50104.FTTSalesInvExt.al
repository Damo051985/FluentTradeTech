namespace FluentTradeTech.FluentTradeTech;

using Microsoft.Sales.History;

reportextension 50104 "FTTSalesInv-Ext" extends "Standard Sales - Invoice"
{
    dataset
    {
        add(Line)
        {
            //column(yAttributes; Attributes) { }
        }
    }
}
