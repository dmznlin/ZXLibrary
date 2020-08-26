inherited fFrameIOMoney: TfFrameIOMoney
  Width = 856
  Height = 555
  inherited ToolBar1: TToolBar
    Width = 856
    inherited BtnAdd: TToolButton
      Visible = False
    end
    inherited BtnEdit: TToolButton
      Visible = False
    end
    inherited BtnDel: TToolButton
      Visible = False
    end
    inherited S1: TToolButton
      Visible = False
    end
  end
  inherited cxGrid1: TcxGrid
    Top = 202
    Width = 856
    Height = 353
  end
  inherited dxLayout1: TdxLayoutControl
    Width = 856
    Height = 135
    object cxTextEdit1: TcxTextEdit [0]
      Left = 57
      Top = 93
      Hint = 'T.M_MemName'
      ParentFont = False
      TabOrder = 2
      Width = 125
    end
    object cxTextEdit2: TcxTextEdit [1]
      Left = 221
      Top = 93
      Hint = 'T.M_Type'
      ParentFont = False
      TabOrder = 3
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
      Left = 573
      Top = 93
      Hint = 'T.M_Memo'
      ParentFont = False
      TabOrder = 5
      Width = 185
    end
    object EditDate: TcxButtonEdit [4]
      Left = 269
      Top = 36
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = EditDatePropertiesButtonClick
      TabOrder = 1
      Width = 185
    end
    object cxTextEdit4: TcxTextEdit [5]
      Left = 385
      Top = 93
      Hint = 'T.M_Money'
      ParentFont = False
      TabOrder = 4
      Width = 125
    end
    inherited dxGroup1: TdxLayoutGroup
      inherited GroupSearch1: TdxLayoutGroup
        object dxLayout1Item4: TdxLayoutItem
          Caption = #20250#21592#22995#21517':'
          Control = EditName
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
          Caption = #20250#21592':'
          Control = cxTextEdit1
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item3: TdxLayoutItem
          Caption = #31867#22411':'
          Control = cxTextEdit2
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item8: TdxLayoutItem
          Caption = #37329#39069':'
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
      Caption = #20250#21592#20805#20540#27969#27700#24080
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
end
