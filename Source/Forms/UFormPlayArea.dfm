inherited fFormPlayArea: TfFormPlayArea
  Left = 377
  Top = 274
  Width = 410
  Height = 460
  BorderStyle = bsSizeable
  Constraints.MinHeight = 460
  Constraints.MinWidth = 410
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited dxLayout1: TdxLayoutControl
    Width = 394
    Height = 421
    inherited BtnOK: TButton
      Left = 248
      Top = 388
      TabOrder = 16
    end
    inherited BtnExit: TButton
      Left = 318
      Top = 388
      TabOrder = 17
    end
    object EditMem: TcxLookupComboBox [2]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.ListColumns = <>
      Properties.OnEditValueChanged = EditMemPropertiesEditValueChanged
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -12
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 512
    end
    object Label1: TcxLabel [3]
      Left = 23
      Top = 86
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
      Top = 111
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
      Top = 161
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
      Top = 136
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
      Top = 86
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
      Top = 111
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
      Top = 161
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
      Top = 136
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
      Top = 186
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
      Top = 186
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
    object cxLabel1: TcxLabel [13]
      Left = 23
      Top = 61
      Caption = #20250#21592#21345#21495':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel2: TcxLabel [14]
      Left = 104
      Top = 61
      Hint = 'M_Card'
      Caption = #20250#21592#21345#21495
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object EditNum: TcxSpinEdit [15]
      Left = 81
      Top = 243
      ParentFont = False
      Properties.MaxValue = 10.000000000000000000
      Properties.MinValue = -10.000000000000000000
      TabOrder = 13
      Value = 1
      Width = 121
    end
    object Label11: TcxLabel [16]
      Left = 23
      Top = 268
      Caption = #27880':'#33509#20540#20026#36127','#34920#31034#21462#28040#20250#21592#30340#28040#36153','#26435#30410#36820#22238#21040#20250#21592#24080#25143'.'
      ParentFont = False
      Transparent = True
    end
    object EditMemo: TcxMemo [17]
      Left = 81
      Top = 289
      ParentFont = False
      Properties.MaxLength = 200
      TabOrder = 15
      Height = 89
      Width = 185
    end
    inherited dxLayout1Group_Root: TdxLayoutGroup
      inherited dxGroup1: TdxLayoutGroup
        Caption = #20250#21592#20449#24687
        object dxlytmLayout1Item3: TdxLayoutItem
          Caption = #20250#21592#32534#21495':'
          Control = EditMem
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Group2: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxLayout1Item3: TdxLayoutItem
            ShowCaption = False
            Control = cxLabel1
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item4: TdxLayoutItem
            ShowCaption = False
            Control = cxLabel2
            ControlOptions.ShowBorder = False
          end
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
        AlignVert = avClient
        Caption = #28216#29609#21306
        object dxlytmLayout1Item14: TdxLayoutItem
          Caption = #28040#36153#27425#25968':'
          Control = EditNum
          ControlOptions.ShowBorder = False
        end
        object dxlytmLayout1Item16: TdxLayoutItem
          Caption = 'cxLabel3'
          ShowCaption = False
          Control = Label11
          ControlOptions.ShowBorder = False
        end
        object dxlytmLayout1Item17: TdxLayoutItem
          AutoAligns = [aaHorizontal]
          AlignVert = avClient
          Caption = #22791#27880#20449#24687':'
          Control = EditMemo
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
end
