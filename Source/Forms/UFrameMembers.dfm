inherited fFrameMembers: TfFrameMembers
  Width = 856
  Height = 555
  inherited ToolBar1: TToolBar
    Width = 856
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
    Width = 856
    Height = 353
    inherited cxView1: TcxGridDBTableView
      PopupMenu = PMenu1
    end
  end
  inherited dxLayout1: TdxLayoutControl
    Width = 856
    Height = 135
    object cxTextEdit1: TcxTextEdit [0]
      Left = 81
      Top = 93
      Hint = 'T.M_Name'
      ParentFont = False
      TabOrder = 4
      Width = 125
    end
    object cxTextEdit2: TcxTextEdit [1]
      Left = 269
      Top = 93
      Hint = 'T.M_Card'
      ParentFont = False
      TabOrder = 5
      Width = 125
    end
    object EditName: TcxButtonEdit [2]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = EditNamePropertiesButtonClick
      TabOrder = 0
      OnKeyPress = OnCtrlKeyPress
      Width = 125
    end
    object cxTextEdit3: TcxTextEdit [3]
      Left = 645
      Top = 93
      Hint = 'T.B_Memo'
      ParentFont = False
      TabOrder = 7
      Width = 185
    end
    object EditPhone: TcxButtonEdit [4]
      Left = 457
      Top = 36
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = EditNamePropertiesButtonClick
      TabOrder = 2
      OnKeyPress = OnCtrlKeyPress
      Width = 125
    end
    object EditCard: TcxButtonEdit [5]
      Left = 269
      Top = 36
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = EditNamePropertiesButtonClick
      TabOrder = 1
      OnKeyPress = OnCtrlKeyPress
      Width = 125
    end
    object EditDate: TcxButtonEdit [6]
      Left = 645
      Top = 36
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = EditDatePropertiesButtonClick
      TabOrder = 3
      Width = 185
    end
    object cxTextEdit4: TcxTextEdit [7]
      Left = 457
      Top = 93
      Hint = 'T.M_Phone'
      ParentFont = False
      TabOrder = 6
      Width = 125
    end
    inherited dxGroup1: TdxLayoutGroup
      inherited GroupSearch1: TdxLayoutGroup
        object dxLayout1Item4: TdxLayoutItem
          Caption = #20250#21592#22995#21517':'
          Control = EditName
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item6: TdxLayoutItem
          Caption = #20250#21592#21345#21495':'
          Control = EditCard
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item1: TdxLayoutItem
          Caption = #25163#26426#21495#30721':'
          Control = EditPhone
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item7: TdxLayoutItem
          Caption = #26085#26399#31579#36873':'
          Control = EditDate
          ControlOptions.ShowBorder = False
        end
      end
      inherited GroupDetail1: TdxLayoutGroup
        object dxLayout1Item2: TdxLayoutItem
          Caption = #20250#21592#22995#21517':'
          Control = cxTextEdit1
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item3: TdxLayoutItem
          Caption = #20250#21592#21345#21495':'
          Control = cxTextEdit2
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item8: TdxLayoutItem
          Caption = #25163#26426#21495#30721':'
          Control = cxTextEdit4
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
    Width = 856
  end
  inherited TitlePanel1: TZnBitmapPanel
    Width = 856
    inherited TitleBar: TcxLabel
      Caption = #20250#21592#20449#24687#31649#29702
      Style.IsFontAssigned = True
      Width = 856
      AnchorX = 428
      AnchorY = 11
    end
  end
  inherited SQLQuery: TADOQuery
    Top = 298
  end
  inherited DataSource1: TDataSource
    Top = 298
  end
  object PMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 62
    Top = 298
    object N1: TMenuItem
      Caption = #20250#21592#20132#36153
      OnClick = N1Click
    end
  end
end
