inherited fFrameBookBorrow: TfFrameBookBorrow
  Width = 856
  Height = 555
  inherited ToolBar1: TToolBar
    Width = 856
    inherited BtnAdd: TToolButton
      Caption = #20511#38405
      ImageIndex = 22
      OnClick = BtnAddClick
    end
    inherited BtnEdit: TToolButton
      Visible = False
    end
    inherited BtnDel: TToolButton
      Caption = #24402#36824
      ImageIndex = 23
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
      Hint = 'T.D_Name'
      ParentFont = False
      TabOrder = 3
      Width = 125
    end
    object cxTextEdit2: TcxTextEdit [1]
      Left = 269
      Top = 93
      Hint = 'T.D_Publisher'
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
      Left = 645
      Top = 93
      Hint = 'T.I_Memo'
      ParentFont = False
      TabOrder = 6
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
    object cxTextEdit4: TcxTextEdit [5]
      Left = 457
      Top = 93
      Hint = 'T.D_Provider'
      ParentFont = False
      TabOrder = 5
      Width = 125
    end
    object EditMem: TcxButtonEdit [6]
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
          Caption = #22270#20070#21517#31216':'
          Control = EditName
          ControlOptions.ShowBorder = False
        end
        object dxlytmLayout1Item1: TdxLayoutItem
          Caption = #20250#21592#21517#31216':'
          Control = EditMem
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
          Caption = #22270#20070#21517#31216':'
          Control = cxTextEdit1
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item3: TdxLayoutItem
          Caption = #20986' '#29256' '#21830':'
          Control = cxTextEdit2
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item8: TdxLayoutItem
          Caption = #20379' '#24212' '#21830':'
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
      Caption = #22270#20070#20511#38405#31649#29702
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
    Left = 63
    Top = 298
    object MenuAll: TMenuItem
      Caption = #20840#37096#26410#24402#36824
      OnClick = MenuAllClick
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object MenuWeek: TMenuItem
      Caption = #19971#22825#21069#20511#38405
      OnClick = MenuAllClick
    end
    object MenuNDays: TMenuItem
      Caption = 'N'#22825#21069#20511#38405
      OnClick = MenuAllClick
    end
    object MenuInclude: TMenuItem
      Caption = #21253#21547#24050#24402#36824
      OnClick = MenuAllClick
    end
  end
end
