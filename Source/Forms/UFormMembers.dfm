inherited fFormMembers: TfFormMembers
  Left = 391
  Top = 380
  Width = 689
  Height = 411
  BorderIcons = [biSystemMenu, biMinimize]
  Constraints.MinHeight = 320
  Constraints.MinWidth = 600
  OldCreateOrder = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object dxLayout1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 673
    Height = 372
    Align = alClient
    TabOrder = 0
    TabStop = False
    AutoContentSizes = [acsWidth, acsHeight]
    LookAndFeel = FDM.dxLayoutWeb1
    object BtnOK: TButton
      Left = 527
      Top = 339
      Width = 65
      Height = 22
      Caption = #20445#23384
      TabOrder = 16
      OnClick = BtnOKClick
    end
    object BtnExit: TButton
      Left = 597
      Top = 339
      Width = 65
      Height = 22
      Caption = #21462#28040
      TabOrder = 17
      OnClick = BtnExitClick
    end
    object EditLevel: TcxComboBox
      Left = 81
      Top = 133
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.DropDownRows = 20
      Properties.ItemHeight = 20
      Properties.MaxLength = 100
      TabOrder = 6
      Width = 215
    end
    object EditMemo: TcxMemo
      Left = 81
      Top = 208
      ParentFont = False
      Properties.MaxLength = 50
      TabOrder = 9
      Height = 145
      Width = 215
    end
    object Check1: TcxCheckBox
      Left = 11
      Top = 339
      Caption = #36830#32493#28155#21152':'#20445#23384#21518#19981#20851#38381#31383#21475'.'
      ParentFont = False
      TabOrder = 15
      Transparent = True
      Width = 185
    end
    object EditName: TcxTextEdit
      Left = 81
      Top = 61
      ParentFont = False
      Properties.MaxLength = 32
      TabOrder = 1
      Width = 215
    end
    object EditCard: TcxTextEdit
      Left = 81
      Top = 36
      ParentFont = False
      Properties.MaxLength = 32
      TabOrder = 0
      Width = 215
    end
    object EditPhone: TcxTextEdit
      Left = 81
      Top = 86
      ParentFont = False
      Properties.MaxLength = 32
      TabOrder = 2
      Width = 215
    end
    object EditJoin: TcxDateEdit
      Left = 81
      Top = 158
      ParentFont = False
      Properties.Kind = ckDateTime
      Properties.ReadOnly = True
      TabOrder = 7
      Width = 215
    end
    object EditValid: TcxDateEdit
      Left = 81
      Top = 183
      ParentFont = False
      Properties.Kind = ckDateTime
      Properties.ReadOnly = True
      TabOrder = 8
      Width = 215
    end
    object RadioMan: TcxRadioButton
      Left = 80
      Top = 111
      Width = 52
      Height = 17
      Caption = #30007
      ParentColor = False
      TabOrder = 4
    end
    object RadioWoman: TcxRadioButton
      Left = 137
      Top = 111
      Width = 52
      Height = 17
      Caption = #22899
      Checked = True
      ParentColor = False
      TabOrder = 5
      TabStop = True
    end
    object cxLabel1: TcxLabel
      Left = 23
      Top = 111
      Caption = #24615'   '#21035':'
      ParentFont = False
      Transparent = True
    end
    object EditBorrowNum: TcxTextEdit
      Left = 383
      Top = 36
      ParentFont = False
      Properties.ReadOnly = True
      TabOrder = 10
      Width = 100
    end
    object EditBorrowBooks: TcxTextEdit
      Left = 546
      Top = 36
      ParentFont = False
      Properties.ReadOnly = True
      TabOrder = 11
      Width = 121
    end
    object EditBuyBooks: TcxTextEdit
      Left = 546
      Top = 61
      ParentFont = False
      Properties.ReadOnly = True
      TabOrder = 13
      Width = 121
    end
    object cxListView1: TcxListView
      Left = 325
      Top = 86
      Width = 121
      Height = 97
      Columns = <
        item
          Caption = #26102#38388
          Width = 120
        end
        item
          Caption = #20250#21592#35760#24405
          Width = 120
        end>
      ParentFont = False
      TabOrder = 14
      ViewStyle = vsReport
    end
    object EditBuyNum: TcxTextEdit
      Left = 383
      Top = 61
      ParentFont = False
      Properties.ReadOnly = True
      TabOrder = 12
      Width = 100
    end
    object dxLayoutGroup1: TdxLayoutGroup
      ShowCaption = False
      Hidden = True
      ShowBorder = False
      object dxLayout1Group8: TdxLayoutGroup
        AutoAligns = [aaHorizontal]
        AlignVert = avClient
        ShowCaption = False
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        object dxGroup1: TdxLayoutGroup
          AutoAligns = [aaHorizontal]
          AlignVert = avClient
          Caption = #20250#21592#20449#24687
          object dxLayout1Group2: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxLayout1Item8: TdxLayoutItem
              Caption = #20250#21592#21345#21495':'
              Control = EditCard
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item7: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              Caption = #20250#21592#22995#21517':'
              Control = EditName
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item9: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              Caption = #25163#26426#21495#30721':'
              Control = EditPhone
              ControlOptions.ShowBorder = False
            end
          end
          object dxLayout1Group3: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxLayout1Group5: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxLayout1Item14: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel1
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item12: TdxLayoutItem
                Caption = 'cxRadioButton1'
                ShowCaption = False
                Control = RadioMan
                ControlOptions.AutoColor = True
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item13: TdxLayoutItem
                Caption = 'cxRadioButton2'
                ShowCaption = False
                Control = RadioWoman
                ControlOptions.AutoColor = True
                ControlOptions.ShowBorder = False
              end
            end
            object dxLayout1Item3: TdxLayoutItem
              Caption = #20250#21592#31561#32423':'
              Control = EditLevel
              ControlOptions.ShowBorder = False
            end
          end
          object dxLayout1Group4: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxLayout1Item10: TdxLayoutItem
              Caption = #20837#20250#26102#38388':'
              Control = EditJoin
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item11: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              Caption = #26377#25928#25130#27490':'
              Control = EditValid
              ControlOptions.ShowBorder = False
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
        object dxLayout1Group6: TdxLayoutGroup
          AutoAligns = [aaVertical]
          AlignHorz = ahClient
          Caption = #20511#38405#20449#24687
          object dxLayout1Group1: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxLayout1Item1: TdxLayoutItem
              Caption = #20511#38405#27425#25968':'
              Control = EditBorrowNum
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item6: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              Caption = #20511#38405#20070#26412':'
              Control = EditBorrowBooks
              ControlOptions.ShowBorder = False
            end
          end
          object dxLayout1Group7: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxLayout1Item17: TdxLayoutItem
              Caption = #36141#20080#27425#25968':'
              Control = EditBuyNum
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item15: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              Caption = #36141#20080#20070#26412':'
              Control = EditBuyBooks
              ControlOptions.ShowBorder = False
            end
          end
          object dxLayout1Item16: TdxLayoutItem
            AutoAligns = [aaHorizontal]
            AlignVert = avClient
            Caption = #20511#38405#35760#24405':'
            ShowCaption = False
            Control = cxListView1
            ControlOptions.ShowBorder = False
          end
        end
      end
      object dxLayoutGroup2: TdxLayoutGroup
        AutoAligns = [aaHorizontal]
        AlignVert = avBottom
        ShowCaption = False
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        object dxLayout1Item4: TdxLayoutItem
          Caption = 'cxCheckBox1'
          ShowCaption = False
          Control = Check1
          ControlOptions.ShowBorder = False
        end
        object dxLayoutItem1: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = 'Button1'
          ShowCaption = False
          Control = BtnOK
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item2: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = 'Button2'
          ShowCaption = False
          Control = BtnExit
          ControlOptions.ShowBorder = False
        end
      end
    end
    object TdxLayoutGroup
    end
  end
end
