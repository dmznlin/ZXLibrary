inherited fFormBooks: TfFormBooks
  Left = 371
  Top = 300
  ClientHeight = 262
  ClientWidth = 442
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited dxLayout1: TdxLayoutControl
    Width = 442
    Height = 262
    inherited BtnOK: TButton
      Left = 296
      Top = 229
      TabOrder = 10
    end
    inherited BtnExit: TButton
      Left = 366
      Top = 229
      TabOrder = 11
    end
    object EditISBN: TcxTextEdit [2]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.MaxLength = 32
      Properties.ReadOnly = False
      TabOrder = 0
      Width = 121
    end
    object EditName: TcxTextEdit [3]
      Left = 81
      Top = 61
      ParentFont = False
      Properties.MaxLength = 100
      Properties.ReadOnly = False
      TabOrder = 1
      Width = 121
    end
    object Check1: TcxCheckBox [4]
      Left = 11
      Top = 229
      Caption = #36830#32493#28155#21152'.'
      ParentFont = False
      TabOrder = 9
      Transparent = True
      Width = 95
    end
    object EditClass: TcxComboBox [5]
      Left = 81
      Top = 111
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.DropDownRows = 20
      Properties.ItemHeight = 20
      TabOrder = 3
      Width = 135
    end
    object EditLang: TcxComboBox [6]
      Left = 279
      Top = 111
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.DropDownRows = 20
      Properties.ItemHeight = 20
      TabOrder = 4
      Width = 286
    end
    object EditMemo: TcxMemo [7]
      Left = 81
      Top = 158
      ParentFont = False
      Properties.MaxLength = 200
      TabOrder = 8
      Height = 131
      Width = 215
    end
    object cxLabel1: TcxLabel [8]
      Left = 23
      Top = 136
      Caption = #20511#38405#29366#24577':'
      ParentFont = False
      Transparent = True
    end
    object RadioNormal: TcxRadioButton [9]
      Left = 86
      Top = 136
      Width = 113
      Height = 17
      Caption = #27491#24120#20511#38405
      Checked = True
      ParentColor = False
      TabOrder = 6
      TabStop = True
    end
    object RadioForbid: TcxRadioButton [10]
      Left = 204
      Top = 136
      Width = 85
      Height = 17
      Caption = #31105#27490#20511#38405
      ParentColor = False
      TabOrder = 7
    end
    object EditAuthor: TcxLookupComboBox [11]
      Left = 81
      Top = 86
      ParentFont = False
      Properties.AutoSelect = False
      Properties.DropDownListStyle = lsEditList
      Properties.ListColumns = <>
      Properties.MaxLength = 80
      TabOrder = 2
      Width = 145
    end
    inherited dxLayout1Group_Root: TdxLayoutGroup
      inherited dxGroup1: TdxLayoutGroup
        Caption = #22270#20070#20449#24687
        object dxLayout1Item4: TdxLayoutItem
          Caption = 'ISBN'#30721':'
          Control = EditISBN
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item7: TdxLayoutItem
          Caption = #22270#20070#21517#31216':'
          Control = EditName
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item12: TdxLayoutItem
          Caption = #22270#20070#20316#32773':'
          Control = EditAuthor
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Group3: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxLayout1Item5: TdxLayoutItem
            Caption = #22270#20070#20998#31867':'
            Control = EditClass
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item6: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahClient
            Caption = #25152#23646#35821#31181':'
            Control = EditLang
            ControlOptions.ShowBorder = False
          end
        end
        object dxLayout1Group2: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxLayout1Item9: TdxLayoutItem
            Caption = 'cxLabel1'
            ShowCaption = False
            Control = cxLabel1
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item10: TdxLayoutItem
            ShowCaption = False
            Control = RadioNormal
            ControlOptions.AutoColor = True
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item11: TdxLayoutItem
            Caption = 'cxRadioButton2'
            ShowCaption = False
            Control = RadioForbid
            ControlOptions.AutoColor = True
            ControlOptions.ShowBorder = False
          end
        end
        object dxLayout1Item8: TdxLayoutItem
          AutoAligns = [aaHorizontal]
          AlignVert = avClient
          Caption = #22791#27880#20449#24687':'
          Control = EditMemo
          ControlOptions.ShowBorder = False
        end
      end
      inherited dxLayout1Group1: TdxLayoutGroup
        object dxLayout1Item17: TdxLayoutItem [0]
          ShowCaption = False
          Control = Check1
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
end
