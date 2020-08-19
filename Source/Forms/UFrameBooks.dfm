inherited fFrameBooks: TfFrameBooks
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
    LevelTabs.Slants.Kind = skCutCorner
    LevelTabs.Style = 9
    RootLevelOptions.DetailTabsPosition = dtpTop
    inherited cxView1: TcxGridDBTableView
      PopupMenu = PMenu1
    end
    object cxView2: TcxGridDBTableView [1]
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = DataSource2
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
    end
    inherited cxLevel1: TcxGridLevel
      Caption = #22270#20070#26723#26696
    end
    object cxLevel2: TcxGridLevel
      Caption = #22270#20070#26126#32454
      GridView = cxView2
    end
  end
  inherited dxLayout1: TdxLayoutControl
    Width = 856
    Height = 135
    object Edit1: TcxTextEdit [0]
      Left = 81
      Top = 93
      Hint = 'T.B_Name'
      ParentFont = False
      TabOrder = 4
      Width = 112
    end
    object Edit2: TcxTextEdit [1]
      Left = 256
      Top = 93
      Hint = 'T.B_Author'
      ParentFont = False
      TabOrder = 5
      Width = 112
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
      Width = 112
    end
    object Edit4: TcxTextEdit [3]
      Left = 594
      Top = 93
      Hint = 'T.B_Memo'
      ParentFont = False
      TabOrder = 7
      Width = 185
    end
    object EditPublisher: TcxButtonEdit [4]
      Left = 419
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
      Width = 112
    end
    object EditAuthor: TcxButtonEdit [5]
      Left = 256
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
      Width = 112
    end
    object EditDate: TcxButtonEdit [6]
      Left = 594
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
    object Edit3: TcxTextEdit [7]
      Left = 419
      Top = 93
      Hint = 'T.B_ISBN'
      ParentFont = False
      TabOrder = 6
      Width = 112
    end
    inherited dxGroup1: TdxLayoutGroup
      inherited GroupSearch1: TdxLayoutGroup
        object dxLayout1Item4: TdxLayoutItem
          Caption = #22270#20070#21517#31216':'
          Control = EditName
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item6: TdxLayoutItem
          Caption = #22270#20070#20316#32773':'
          Control = EditAuthor
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item1: TdxLayoutItem
          Caption = #20986#29256#21830':'
          Control = EditPublisher
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
          Control = Edit1
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item3: TdxLayoutItem
          Caption = #22270#20070#20316#32773':'
          Control = Edit2
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item8: TdxLayoutItem
          Caption = 'ISBN'#30721':'
          Control = Edit3
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item5: TdxLayoutItem
          Caption = #22791#27880#20449#24687':'
          Control = Edit4
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
      Caption = #22270#20070#20449#24687#31649#29702
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
  object QueryDtl: TADOQuery
    Connection = FDM.ADOConn
    Parameters = <>
    Left = 6
    Top = 270
  end
  object DataSource2: TDataSource
    DataSet = QueryDtl
    Left = 34
    Top = 270
  end
  object PMenu1: TPopupMenu
    AutoHotkeys = maManual
    OnPopup = PMenu1Popup
    Left = 62
    Top = 298
    object N3: TMenuItem
      Caption = #26597#30475#26126#32454
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Tag = 10
      Caption = #20801#35768#20511#38405
      OnClick = N5Click
    end
    object N6: TMenuItem
      Tag = 20
      Caption = #31105#27490#20511#38405
      OnClick = N5Click
    end
  end
end
