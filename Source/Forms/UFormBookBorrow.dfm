inherited fFormBookBorrow: TfFormBookBorrow
  Left = 378
  Top = 301
  Width = 624
  Height = 653
  BorderStyle = bsSizeable
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited dxLayout1: TdxLayoutControl
    Width = 608
    Height = 614
    inherited BtnOK: TButton
      Left = 462
      Top = 581
      TabOrder = 11
    end
    inherited BtnExit: TButton
      Left = 532
      Top = 581
      TabOrder = 12
    end
    object EditMem: TcxLookupComboBox [2]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.ListColumns = <>
      Properties.OnEditValueChanged = EditMemPropertiesEditValueChanged
      TabOrder = 0
      Width = 145
    end
    object Label1: TcxLabel [3]
      Left = 23
      Top = 61
      Caption = #20250#21592#22995#21517':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label2: TcxLabel [4]
      Left = 23
      Top = 86
      Caption = #25163#26426#21495#30721':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label3: TcxLabel [5]
      Left = 23
      Top = 136
      Caption = #20250#21592#31561#32423':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label4: TcxLabel [6]
      Left = 23
      Top = 111
      Caption = #21040#26399#26102#38388':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label5: TcxLabel [7]
      Left = 104
      Top = 61
      Hint = 'M_Name'
      Caption = #20250#21592#22995#21517
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label6: TcxLabel [8]
      Left = 104
      Top = 86
      Hint = 'M_Phone'
      Caption = #25163#26426#21495#30721
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label7: TcxLabel [9]
      Left = 104
      Top = 136
      Hint = 'M_Level'
      Caption = #20250#21592#31561#32423
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label8: TcxLabel [10]
      Left = 104
      Top = 111
      Hint = 'M_ValidDate'
      Caption = #21040#26399#26102#38388
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label9: TcxLabel [11]
      Left = 23
      Top = 161
      Caption = #20250#21592#26435#30410':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label10: TcxLabel [12]
      Left = 104
      Top = 161
      Hint = 'M_Quanyi'
      Caption = #20250#21592#26435#30410
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    inherited dxLayout1Group_Root: TdxLayoutGroup
      inherited dxGroup1: TdxLayoutGroup
        Caption = #20250#21592#20449#24687
        object dxlytmLayout1Item3: TdxLayoutItem
          Caption = #20250#21592#32534#21495':'
          Control = EditMem
          ControlOptions.ShowBorder = False
        end
        object dxGroupLayout1Group6: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxlytmLayout1Item4: TdxLayoutItem
            Caption = 'cxLabel1'
            ShowCaption = False
            Control = Label1
            ControlOptions.ShowBorder = False
          end
          object dxlytmLayout1Item8: TdxLayoutItem
            ShowCaption = False
            Control = Label5
            ControlOptions.ShowBorder = False
          end
        end
        object dxGroupLayout1Group2: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object dxGroupLayout1Group5: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxlytmLayout1Item5: TdxLayoutItem
              Caption = 'cxLabel1'
              ShowCaption = False
              Control = Label2
              ControlOptions.ShowBorder = False
            end
            object dxlytmLayout1Item9: TdxLayoutItem
              ShowCaption = False
              Control = Label6
              ControlOptions.ShowBorder = False
            end
          end
          object dxGroupLayout1Group3: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxGroupLayout1Group4: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxlytmLayout1Item7: TdxLayoutItem
                ShowCaption = False
                Control = Label4
                ControlOptions.ShowBorder = False
              end
              object dxlytmLayout1Item11: TdxLayoutItem
                ShowCaption = False
                Control = Label8
                ControlOptions.ShowBorder = False
              end
            end
            object dxGroupLayout1Group7: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              ShowBorder = False
              object dxGroupLayout1Group8: TdxLayoutGroup
                ShowCaption = False
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                object dxlytmLayout1Item6: TdxLayoutItem
                  ShowCaption = False
                  Control = Label3
                  ControlOptions.ShowBorder = False
                end
                object dxlytmLayout1Item10: TdxLayoutItem
                  ShowCaption = False
                  Control = Label7
                  ControlOptions.ShowBorder = False
                end
              end
              object dxGroupLayout1Group9: TdxLayoutGroup
                ShowCaption = False
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                object dxlytmLayout1Item12: TdxLayoutItem
                  ShowCaption = False
                  Control = Label9
                  ControlOptions.ShowBorder = False
                end
                object dxlytmLayout1Item13: TdxLayoutItem
                  ShowCaption = False
                  Control = Label10
                  ControlOptions.ShowBorder = False
                end
              end
            end
          end
        end
      end
      object dxGroup2: TdxLayoutGroup [1]
        AutoAligns = [aaHorizontal]
        Caption = #26723#26696#21442#25968
      end
    end
  end
end
