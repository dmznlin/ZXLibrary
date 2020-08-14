inherited fFrameBaseInfo: TfFrameBaseInfo
  Width = 780
  Height = 526
  inherited ToolBar1: TToolBar
    Width = 780
    inherited BtnAdd: TToolButton
      OnClick = BtnAddClick
    end
    inherited BtnEdit: TToolButton
      OnClick = BtnEditClick
    end
    inherited BtnDel: TToolButton
      OnClick = BtnDelClick
    end
  end
  inherited cxGrid1: TcxGrid
    Top = 202
    Width = 780
    Height = 324
  end
  inherited dxLayout1: TdxLayoutControl
    Width = 780
    Height = 135
    object EditTypes: TcxComboBox [0]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.DropDownRows = 20
      Properties.ItemHeight = 22
      Properties.OnEditValueChanged = EditTypesPropertiesEditValueChanged
      TabOrder = 0
      Width = 135
    end
    object cxTextEdit1: TcxTextEdit [1]
      Left = 81
      Top = 93
      Hint = 'T.B_GroupName'
      ParentFont = False
      TabOrder = 2
      Width = 135
    end
    object cxTextEdit2: TcxTextEdit [2]
      Left = 279
      Top = 93
      Hint = 'T.B_Text'
      TabOrder = 3
      Width = 135
    end
    object EditName: TcxButtonEdit [3]
      Left = 279
      Top = 36
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = EditNamePropertiesButtonClick
      TabOrder = 1
      OnKeyPress = OnCtrlKeyPress
      Width = 135
    end
    object cxTextEdit3: TcxTextEdit [4]
      Left = 477
      Top = 93
      Hint = 'T.B_Memo'
      TabOrder = 4
      Width = 200
    end
    inherited dxGroup1: TdxLayoutGroup
      inherited GroupSearch1: TdxLayoutGroup
        object dxLayout1Item1: TdxLayoutItem
          Caption = #26723#26696#31867#22411':'
          Control = EditTypes
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item4: TdxLayoutItem
          Caption = #26723#26696#21517#31216':'
          Control = EditName
          ControlOptions.ShowBorder = False
        end
      end
      inherited GroupDetail1: TdxLayoutGroup
        object dxLayout1Item2: TdxLayoutItem
          Caption = #26723#26696#31867#22411':'
          Control = cxTextEdit1
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item3: TdxLayoutItem
          Caption = #26723#26696#21517#31216':'
          Control = cxTextEdit2
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item5: TdxLayoutItem
          Caption = #22791#27880#20449#24687':'
          Control = cxTextEdit3
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  inherited cxSplitter1: TcxSplitter
    Top = 194
    Width = 780
  end
  inherited TitlePanel1: TZnBitmapPanel
    Width = 780
    inherited TitleBar: TcxLabel
      Caption = #31995#32479#22522#30784#26723#26696#31649#29702
      Style.IsFontAssigned = True
      Width = 780
      AnchorX = 390
      AnchorY = 11
    end
  end
  inherited SQLQuery: TADOQuery
    Top = 298
  end
  inherited DataSource1: TDataSource
    Top = 298
  end
end
