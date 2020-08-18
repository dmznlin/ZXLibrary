inherited fFormIOMoney: TfFormIOMoney
  Left = 395
  Top = 342
  ClientHeight = 437
  ClientWidth = 390
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited dxLayout1: TdxLayoutControl
    Width = 390
    Height = 437
    inherited BtnOK: TButton
      Left = 244
      Top = 404
      TabOrder = 14
    end
    inherited BtnExit: TButton
      Left = 314
      Top = 404
      TabOrder = 15
    end
    object EditMemo: TcxMemo [2]
      Left = 81
      Top = 342
      ParentFont = False
      Properties.MaxLength = 200
      TabOrder = 13
      Height = 89
      Width = 185
    end
    object EditPayment: TcxComboBox [3]
      Left = 81
      Top = 292
      ParentFont = False
      Properties.DropDownRows = 20
      Properties.ImmediateDropDown = False
      Properties.IncrementalSearch = False
      Properties.ItemHeight = 20
      Properties.MaxLength = 100
      TabOrder = 10
      Width = 121
    end
    object EditCard: TcxTextEdit [4]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 121
    end
    object EditName: TcxTextEdit [5]
      Left = 81
      Top = 61
      ParentFont = False
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 121
    end
    object EditPhone: TcxTextEdit [6]
      Left = 81
      Top = 86
      ParentFont = False
      Properties.ReadOnly = True
      TabOrder = 2
      Width = 121
    end
    object EditLevel: TcxTextEdit [7]
      Left = 81
      Top = 111
      ParentFont = False
      Properties.ReadOnly = True
      TabOrder = 3
      Width = 121
    end
    object EditMoney: TcxTextEdit [8]
      Left = 81
      Top = 317
      ParentFont = False
      TabOrder = 11
      Text = '0'
      Width = 121
    end
    object RadioPay: TcxRadioButton [9]
      Left = 86
      Top = 270
      Width = 52
      Height = 17
      Caption = #20184#27454
      Checked = True
      ParentColor = False
      TabOrder = 8
      TabStop = True
      OnClick = RadioPayClick
    end
    object RadioTui: TcxRadioButton [10]
      Left = 143
      Top = 270
      Width = 52
      Height = 17
      Caption = #36864#27454
      ParentColor = False
      TabOrder = 9
      OnClick = RadioPayClick
    end
    object cxLabel1: TcxLabel [11]
      Left = 23
      Top = 270
      Caption = #19994#21153#31867#22411':'
      ParentFont = False
      Transparent = True
    end
    object EditValid: TcxDateEdit [12]
      Left = 81
      Top = 230
      ParentFont = False
      Properties.Kind = ckDateTime
      TabOrder = 5
      Width = 121
    end
    object GroupDate: TcxRadioGroup [13]
      Left = 23
      Top = 168
      Caption = #20250#21592#26377#25928#26085#26399':'
      ParentFont = False
      Properties.Columns = 3
      Properties.Items = <
        item
          Caption = #19981#25913#21464
        end
        item
          Caption = '06'#20010#26376
          Tag = 6
        end
        item
          Caption = '12'#20010#26376
          Tag = 12
        end
        item
          Caption = '18'#20010#26376
          Tag = 18
        end
        item
          Caption = '24'#20010#26376
          Tag = 24
        end
        item
          Caption = #33258#23450#20041
          Tag = -1
        end>
      Properties.OnEditValueChanged = GroupDatePropertiesEditValueChanged
      ItemIndex = 0
      Style.Edges = []
      TabOrder = 4
      Transparent = True
      Height = 57
      Width = 344
    end
    object cxLabel2: TcxLabel [14]
      Left = 189
      Top = 317
      Caption = #20803' '#27880':'#20184#27454#12289#36864#27454#37329#39069#37117#20026#27491#20540'.'
      ParentFont = False
      Transparent = True
    end
    object cxLabel3: TcxLabel [15]
      Left = 23
      Top = 255
      AutoSize = False
      ParentFont = False
      Properties.LineOptions.Alignment = cxllaBottom
      Transparent = True
      Height = 10
      Width = 344
    end
    inherited dxLayout1Group_Root: TdxLayoutGroup
      inherited dxGroup1: TdxLayoutGroup
        Caption = #20250#21592#20449#24687
        object dxLayout1Item4: TdxLayoutItem
          Caption = #20250#21592#21345#21495':'
          Control = EditCard
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item7: TdxLayoutItem
          Caption = #20250#21592#22995#21517':'
          Control = EditName
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item8: TdxLayoutItem
          Caption = #25163#26426#21495#30721':'
          Control = EditPhone
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item9: TdxLayoutItem
          Caption = #20250#21592#31561#32423':'
          Control = EditLevel
          ControlOptions.ShowBorder = False
        end
      end
      object dxLayout1Group2: TdxLayoutGroup [1]
        AutoAligns = [aaHorizontal]
        AlignVert = avClient
        Caption = #20250#36153#25805#20316
        object dxLayout1Group4: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object dxLayout1Item14: TdxLayoutItem
            Caption = 'cxRadioGroup1'
            ShowCaption = False
            Control = GroupDate
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item3: TdxLayoutItem
            Caption = #26085#26399#35774#23450':'
            Control = EditValid
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item16: TdxLayoutItem
            Caption = 'cxLabel3'
            ShowCaption = False
            Control = cxLabel3
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Group5: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxLayout1Item13: TdxLayoutItem
              Caption = 'cxLabel1'
              ShowCaption = False
              Control = cxLabel1
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item11: TdxLayoutItem
              Caption = 'cxRadioButton1'
              ShowCaption = False
              Control = RadioPay
              ControlOptions.AutoColor = True
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item12: TdxLayoutItem
              Caption = 'cxRadioButton2'
              ShowCaption = False
              Control = RadioTui
              ControlOptions.AutoColor = True
              ControlOptions.ShowBorder = False
            end
          end
          object dxLayout1Group6: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxLayout1Item6: TdxLayoutItem
              Caption = #25903#20184#26041#24335':'
              Control = EditPayment
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Group3: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxLayout1Item10: TdxLayoutItem
                AutoAligns = [aaVertical]
                AlignHorz = ahClient
                Caption = #25903#20184#37329#39069':'
                Control = EditMoney
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item15: TdxLayoutItem
                AutoAligns = [aaVertical]
                AlignHorz = ahRight
                Caption = 'cxLabel2'
                ShowCaption = False
                Control = cxLabel2
                ControlOptions.ShowBorder = False
              end
            end
          end
        end
        object dxLayout1Item5: TdxLayoutItem
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
