inherited fFormBaseInfo: TfFormBaseInfo
  ClientHeight = 260
  ClientWidth = 420
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited dxLayout1: TdxLayoutControl
    Width = 420
    Height = 260
    inherited BtnOK: TButton
      Left = 274
      Top = 227
      TabOrder = 4
    end
    inherited BtnExit: TButton
      Left = 344
      Top = 227
      TabOrder = 5
    end
    object EditTypes: TcxComboBox [2]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.DropDownRows = 20
      Properties.ItemHeight = 20
      Properties.OnEditValueChanged = EditTypesPropertiesEditValueChanged
      TabOrder = 0
      Width = 121
    end
    object EditMemo: TcxMemo [3]
      Left = 81
      Top = 86
      ParentFont = False
      Properties.MaxLength = 50
      TabOrder = 2
      Height = 89
      Width = 185
    end
    object EditName: TcxComboBox [4]
      Left = 81
      Top = 61
      ParentFont = False
      Properties.DropDownRows = 20
      Properties.ItemHeight = 20
      Properties.MaxLength = 100
      TabOrder = 1
      Width = 121
    end
    object Check1: TcxCheckBox [5]
      Left = 11
      Top = 227
      Caption = #36830#32493#28155#21152':'#20445#23384#21518#19981#20851#38381#31383#21475'.'
      ParentFont = False
      TabOrder = 3
      Transparent = True
      Width = 185
    end
    inherited dxLayout1Group_Root: TdxLayoutGroup
      inherited dxGroup1: TdxLayoutGroup
        Caption = #22522#26412#26723#26696
        object dxLayout1Item3: TdxLayoutItem
          Caption = #26723#26696#31867#22411':'
          Control = EditTypes
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item6: TdxLayoutItem
          Caption = #26723#26696#21517#31216':'
          Control = EditName
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item5: TdxLayoutItem
          AutoAligns = [aaHorizontal]
          AlignVert = avClient
          Caption = #22791#27880#20449#24687':'
          Control = EditMemo
          ControlOptions.ShowBorder = False
        end
      end
      inherited dxLayout1Group1: TdxLayoutGroup
        object dxLayout1Item4: TdxLayoutItem [0]
          Caption = 'cxCheckBox1'
          ShowCaption = False
          Control = Check1
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
end
