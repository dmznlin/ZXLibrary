inherited fFramePlayGoods: TfFramePlayGoods
  Width = 856
  Height = 555
  inherited ToolBar1: TToolBar
    Width = 856
    inherited BtnAdd: TToolButton
      Caption = #28216#29609
      ImageIndex = 24
      OnClick = BtnAddClick
    end
    inherited BtnEdit: TToolButton
      Caption = #38646#21806
      ImageIndex = 25
      OnClick = BtnEditClick
    end
    inherited BtnDel: TToolButton
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
      Left = 81
      Top = 93
      Hint = 'T.M_Name'
      ParentFont = False
      TabOrder = 3
      Width = 125
    end
    object cxTextEdit2: TcxTextEdit [1]
      Left = 269
      Top = 93
      Hint = 'T.P_GoodsName'
      ParentFont = False
      TabOrder = 4
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
      Left = 457
      Top = 93
      Hint = 'T.P_Memo'
      ParentFont = False
      TabOrder = 5
      Width = 185
    end
    object EditDate: TcxButtonEdit [4]
      Left = 457
      Top = 36
      ParentFont = False
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.ReadOnly = True
      Properties.OnButtonClick = EditDatePropertiesButtonClick
      TabOrder = 2
      Width = 185
    end
    object EditGoods: TcxButtonEdit [5]
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
    inherited dxGroup1: TdxLayoutGroup
      inherited GroupSearch1: TdxLayoutGroup
        object dxLayout1Item4: TdxLayoutItem
          Caption = #20250#21592#22995#21517':'
          Control = EditName
          ControlOptions.ShowBorder = False
        end
        object dxlytmLayout1Item1: TdxLayoutItem
          Caption = #21830#21697#21517#31216':'
          Control = EditGoods
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
          Caption = #21830#21697#21517#31216':'
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
    Width = 856
  end
  inherited TitlePanel1: TZnBitmapPanel
    Width = 856
    inherited TitleBar: TcxLabel
      Caption = #28216#29609#21306#21644#38646#21806
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
