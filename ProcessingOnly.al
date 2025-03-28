report 50100 "Processing Only"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {
        dataitem(Customer; Customer)
        {
            trigger OnPreDataItem()
            begin
                clear(Customer);
                clear(Counter);
                if not ReplacingExisting then
                    Customer.SetRange("Name 2", '');
            end;
            trigger OnAfterGetRecord()
            begin
                if Customer2.get(Customer."No.")then begin
                    Customer2."Name 2" := Name2ToApply;
                    Customer2.Modify();
                    Counter += 1;
                end;
            end;
            trigger OnPostDataItem();
            begin
                Message('Ready!, %1 Customers were updated.', Counter);
            end;
        }
    }

    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Name2ToApply; Name2ToApply)
                    {
                        ApplicationArea = All;
                        Caption = 'Name2 To Apply';
                        ToolTip = 'Specifies the Name2 To Apply.';
                    }
                    field(ReplaceExisting; ReplacingExisting)
                    {
                        ApplicationArea = All;
                        Caption = 'Replace Existing?';
                        ToolTip = 'Replace Existing?';
                    }
                }
            }
        }
    }

    var
       Name2ToApply: Text;
       Customer2: Record Customer;
       ReplacingExisting: Boolean;
       Counter: Integer;
}