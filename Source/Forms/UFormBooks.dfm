inherited fFormBooks: TfFormBooks
  Left = 371
  Top = 300
  ClientHeight = 670
  ClientWidth = 692
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited dxLayout1: TdxLayoutControl
    Width = 692
    Height = 670
    inherited BtnOK: TButton
      Left = 546
      Top = 637
      TabOrder = 27
    end
    inherited BtnExit: TButton
      Left = 616
      Top = 637
      TabOrder = 28
    end
    object EditISBN: TcxTextEdit [2]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.MaxLength = 32
      Properties.ReadOnly = False
      TabOrder = 0
      OnKeyPress = EditISBNKeyPress
      Width = 245
    end
    object EditName: TcxTextEdit [3]
      Left = 389
      Top = 36
      ParentFont = False
      Properties.MaxLength = 100
      Properties.ReadOnly = False
      TabOrder = 1
      OnKeyPress = EditNameKeyPress
      Width = 121
    end
    object Check1: TcxCheckBox [4]
      Left = 11
      Top = 637
      Caption = #36830#32493#28155#21152':'#20445#23384#21518#19981#20851#38381#31383#21475'.'
      ParentFont = False
      TabOrder = 26
      Transparent = True
      Width = 200
    end
    object EditClass: TcxComboBox [5]
      Left = 81
      Top = 86
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.DropDownRows = 20
      Properties.ItemHeight = 20
      TabOrder = 3
      Width = 245
    end
    object EditLang: TcxComboBox [6]
      Left = 389
      Top = 86
      ParentFont = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.DropDownRows = 20
      Properties.ItemHeight = 20
      TabOrder = 4
      Width = 286
    end
    object EditMemo: TcxMemo [7]
      Left = 81
      Top = 111
      ParentFont = False
      Properties.MaxLength = 200
      TabOrder = 5
      Height = 45
      Width = 586
    end
    object EditAuthor: TcxLookupComboBox [8]
      Left = 81
      Top = 61
      ParentFont = False
      Properties.DropDownListStyle = lsEditList
      Properties.ListColumns = <>
      Properties.MaxLength = 80
      TabOrder = 2
      Width = 145
    end
    object EditDISBN: TcxTextEdit [9]
      Left = 81
      Top = 237
      ParentFont = False
      Properties.MaxLength = 32
      TabOrder = 6
      OnKeyPress = EditDISBNKeyPress
      Width = 245
    end
    object EditDName: TcxTextEdit [10]
      Left = 389
      Top = 237
      ParentFont = False
      Properties.MaxLength = 100
      TabOrder = 7
      OnKeyPress = EditDNameKeyPress
      Width = 121
    end
    object EditPubPrice: TcxTextEdit [11]
      Left = 81
      Top = 347
      ParentFont = False
      TabOrder = 12
      Text = '0'
      OnKeyPress = EditDNameKeyPress
      Width = 152
    end
    object EditGetPrice: TcxTextEdit [12]
      Left = 296
      Top = 347
      ParentFont = False
      TabOrder = 13
      Text = '0'
      OnKeyPress = EditDNameKeyPress
      Width = 152
    end
    object EditSalePrice: TcxTextEdit [13]
      Left = 511
      Top = 347
      ParentFont = False
      TabOrder = 14
      Text = '0'
      OnKeyPress = EditDNameKeyPress
      Width = 90
    end
    object cxLabel2: TcxLabel [14]
      Left = 23
      Top = 337
      AutoSize = False
      ParentFont = False
      Properties.LineOptions.Alignment = cxllaBottom
      Transparent = True
      Height = 5
      Width = 500
    end
    object EditNumOut: TcxTextEdit [15]
      Left = 511
      Top = 372
      ParentFont = False
      TabOrder = 17
      Text = '0'
      OnKeyPress = EditDNameKeyPress
      Width = 90
    end
    object EditNumAll: TcxTextEdit [16]
      Left = 81
      Top = 372
      ParentFont = False
      TabOrder = 15
      Text = '0'
      OnKeyPress = EditDNameKeyPress
      Width = 152
    end
    object EditNumIn: TcxTextEdit [17]
      Left = 296
      Top = 372
      ParentFont = False
      TabOrder = 16
      Text = '0'
      OnKeyPress = EditDNameKeyPress
      Width = 152
    end
    object ListDetail: TcxListView [18]
      Left = 23
      Top = 434
      Width = 121
      Height = 97
      Columns = <
        item
          Caption = 'ISBN'
          Width = 65
        end
        item
          Caption = #21517#31216
          Width = 65
        end
        item
          Caption = #20986#29256#21830
          Width = 65
        end
        item
          Caption = #20379#24212#21830
          Width = 65
        end
        item
          Caption = #20986#29256#23450#20215
          Width = 65
        end
        item
          Caption = #24635#37327
          Width = 65
        end
        item
          Caption = #29366#24577
          Width = 65
        end>
      HideSelection = False
      ParentFont = False
      ReadOnly = True
      RowSelect = True
      SmallImages = cxImageList1
      TabOrder = 25
      ViewStyle = vsReport
      OnDblClick = ListDetailDblClick
    end
    object EditProvider: TcxLookupComboBox [19]
      Left = 81
      Top = 287
      ParentFont = False
      Properties.DropDownListStyle = lsEditList
      Properties.ListColumns = <>
      Properties.MaxLength = 80
      TabOrder = 9
      Width = 456
    end
    object EditPublisher: TcxLookupComboBox [20]
      Left = 81
      Top = 262
      ParentFont = False
      Properties.DropDownListStyle = lsEditList
      Properties.ListColumns = <>
      Properties.MaxLength = 80
      TabOrder = 8
      Width = 175
    end
    object cxLabel3: TcxLabel [21]
      Left = 23
      Top = 407
      Caption = #20511#38405#29366#24577':'
      ParentFont = False
      Transparent = True
    end
    object RadioNormal: TcxRadioButton [22]
      Left = 86
      Top = 407
      Width = 95
      Height = 17
      Caption = #27491#24120#20511#38405
      Checked = True
      ParentColor = False
      TabOrder = 20
      TabStop = True
    end
    object RadioForbid: TcxRadioButton [23]
      Left = 186
      Top = 407
      Width = 95
      Height = 17
      Caption = #31105#27490#20511#38405
      ParentColor = False
      TabOrder = 21
    end
    object BtnDel: TcxButton [24]
      Left = 617
      Top = 407
      Width = 52
      Height = 22
      Caption = #21024#38500
      TabOrder = 24
      OnClick = BtnDelClick
      SpeedButtonOptions.Flat = True
    end
    object cxLabel4: TcxLabel [25]
      Left = 23
      Top = 397
      AutoSize = False
      ParentFont = False
      Properties.LineOptions.Alignment = cxllaBottom
      Transparent = True
      Height = 5
      Width = 514
    end
    object BtnAdd: TcxButton [26]
      Left = 503
      Top = 407
      Width = 52
      Height = 22
      Caption = #28155#21152
      TabOrder = 22
      OnClick = BtnAddClick
      SpeedButtonOptions.Flat = True
    end
    object EditDMemo: TcxTextEdit [27]
      Left = 81
      Top = 312
      ParentFont = False
      TabOrder = 10
      Width = 121
    end
    object BtnEdit: TcxButton [28]
      Left = 560
      Top = 407
      Width = 52
      Height = 22
      Caption = #35206#30422
      TabOrder = 23
      OnClick = BtnAddClick
      SpeedButtonOptions.Flat = True
    end
    inherited dxLayout1Group_Root: TdxLayoutGroup
      inherited dxGroup1: TdxLayoutGroup
        Caption = #22270#20070#20449#24687
        object dxLayout1Group2: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxLayout1Item4: TdxLayoutItem
            Caption = 'ISBN'#30721':'
            Control = EditISBN
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item7: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahClient
            Caption = #22270#20070#21517#31216':'
            Control = EditName
            ControlOptions.ShowBorder = False
          end
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
        object dxLayout1Item8: TdxLayoutItem
          AutoAligns = [aaHorizontal]
          AlignVert = avClient
          Caption = #22791#27880#20449#24687':'
          Control = EditMemo
          ControlOptions.ShowBorder = False
        end
      end
      object dxGroup2: TdxLayoutGroup [1]
        AutoAligns = [aaHorizontal]
        AlignVert = avClient
        Caption = #22270#20070#26126#32454
        object dxLayout1Group5: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object dxLayout1Group11: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxLayout1Group6: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxLayout1Item3: TdxLayoutItem
                Caption = 'ISBN'#30721':'
                Control = EditDISBN
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item13: TdxLayoutItem
                AutoAligns = [aaVertical]
                AlignHorz = ahClient
                Caption = #22270#20070#21517#31216':'
                Control = EditDName
                ControlOptions.ShowBorder = False
              end
            end
            object dxLayout1Item26: TdxLayoutItem
              Caption = #20986' '#29256' '#21830':'
              Control = EditPublisher
              ControlOptions.ShowBorder = False
            end
          end
          object dxLayout1Item25: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahClient
            Caption = #20379' '#24212' '#21830':'
            Control = EditProvider
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item10: TdxLayoutItem
            Caption = #22791#27880#20449#24687':'
            Control = EditDMemo
            ControlOptions.ShowBorder = False
          end
        end
        object dxLayout1Item20: TdxLayoutItem
          Caption = 'cxLabel2'
          ShowCaption = False
          Control = cxLabel2
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Group7: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object dxLayout1Group9: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxLayout1Item16: TdxLayoutItem
              Caption = #20986#29256#23450#20215':'
              Control = EditPubPrice
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item18: TdxLayoutItem
              Caption = #37319#36141#20215#26684':'
              Control = EditGetPrice
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item19: TdxLayoutItem
              AutoAligns = []
              AlignHorz = ahClient
              Caption = #38144#21806#20215#26684':'
              Control = EditSalePrice
              ControlOptions.ShowBorder = False
            end
          end
          object dxLayout1Group10: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxLayout1Group8: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              ShowBorder = False
              object dxLayout1Group13: TdxLayoutGroup
                ShowCaption = False
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                object dxLayout1Item22: TdxLayoutItem
                  Caption = #37319#36141#24635#37327':'
                  Control = EditNumAll
                  ControlOptions.ShowBorder = False
                end
                object dxLayout1Item23: TdxLayoutItem
                  Caption = #22312#39302#25968#37327':'
                  Control = EditNumIn
                  ControlOptions.ShowBorder = False
                end
                object dxLayout1Item21: TdxLayoutItem
                  AutoAligns = [aaVertical]
                  AlignHorz = ahClient
                  Caption = #20511#20986#25968#37327':'
                  Control = EditNumOut
                  ControlOptions.ShowBorder = False
                end
              end
              object dxLayout1Item30: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel4
                ControlOptions.ShowBorder = False
              end
            end
            object dxLayout1Group12: TdxLayoutGroup
              AutoAligns = [aaHorizontal]
              AlignVert = avBottom
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxLayout1Item14: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel3
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item15: TdxLayoutItem
                ShowCaption = False
                Control = RadioNormal
                ControlOptions.AutoColor = True
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item27: TdxLayoutItem
                ShowCaption = False
                Control = RadioForbid
                ControlOptions.AutoColor = True
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item9: TdxLayoutItem
                AutoAligns = [aaVertical]
                AlignHorz = ahRight
                ShowCaption = False
                Control = BtnAdd
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item11: TdxLayoutItem
                AutoAligns = [aaVertical]
                AlignHorz = ahRight
                ShowCaption = False
                Control = BtnEdit
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item29: TdxLayoutItem
                AutoAligns = [aaVertical]
                AlignHorz = ahRight
                Caption = 'cxButton2'
                ShowCaption = False
                Control = BtnDel
                ControlOptions.ShowBorder = False
              end
            end
          end
        end
        object dxLayout1Item24: TdxLayoutItem
          AutoAligns = [aaHorizontal]
          AlignVert = avClient
          Caption = 'cxListView1'
          ShowCaption = False
          Control = ListDetail
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
  object cxImageList1: TcxImageList
    Height = 18
    Width = 18
    FormatVersion = 1
    DesignInfo = 28311576
    ImageInfo = <
      item
        Image.Data = {
          46050000424D4605000000000000360000002800000012000000120000000100
          2000000000001005000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000000000030000000D0000
          00150000000E0000000300000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000020000
          0013030B1E68275BA6FF030B1F6C000000150000000300000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000200000011040C1F663D7DBEFF6ACCFFFF3D7EBFFF040C1F6C000000140000
          0003000000000000000000000000000000000000000000000000000000000000
          0000000000020000000F040C1D5D427EBDFF66CAFFFF53C3FFFF63C8FFFF4282
          C0FF060D206F100A08572214119C241511A50C07063900000000000000000000
          000000000000000000020000000D050D1E594984BFFF70CFFFFF5CC6FFFF5BC6
          FFFF5AC5FFFF6BCDFFFF4986C2FF0A102176010100160C0706352C1A17C10D08
          063900000000000000000000000000000007060D1C4E4E87BFFF7CD5FFFF65CB
          FFFF63CAFFFF62CBFFFF62CBFFFF62C9FFFF74D1FFFF4F8AC4FF060E22660000
          0011100A08432F1E17BD0000000000000000000000000000000A3670B3FFB0E9
          FFFF6CCFFFFF6CCFFFFF6BCEFFFF6BCDFFFF6ACFFFFF6ACCFFFF68CEFFFF7CD5
          FFFF548CC4FF0C1E3B890302021B40291FF30000000000000000000000000000
          00060E1C2C5282B2DAFFA4E5FFFF74D4FFFF74D4FFFF72D3FFFF71D1FFFF72D2
          FFFF70D2FFFF70D1FFFF82D5FCFF3E70A8FF0A132567462D24F3000000000000
          00000000000000000001000000080E1D2D5285B4DBFFAAE7FFFF79D6FFFF79D6
          FFFF78D5FFFF77D7FFFF94E0FFFFAEE9FFFF83CAEEFF72ABD3FF3C5F8EFF3927
          1FBE0000000000000000000000000000000000000001000000070F1E2D4F88B6
          DCFFB0E9FFFF80D9FFFF7FDAFFFF7EDAFFFF6EA6D3FF3169ABFF4F7FAFFF89B0
          C1FF584E53FF130D0B4500000000000000000000000000000000000000000000
          000100000007101E2E4D8BB8DDFFB4EBFFFF86DDFFFF86DCFFFF3269A9FF0000
          00245D453DFF766C68FF5E7EA5FF0000000D0000000000000000000000000000
          000000000000000000000000000100000006101F2E4C8EBBDEFFBAEDFFFF8DE1
          FFFF599CCDFF295D9FFF7EB3D8FFD5F5FFFF6193C7FF0000000A000000000000
          0000000000000000000000000000000000000000000000000001000000051120
          2F4990BDDFFFDEF8FFFFDDF8FFFFDDF7FFFFDDF7FFFF769AC6FF040F224E0000
          0005000000000000000000000000000000000000000000000000000000000000
          0000000000000000000411212F474787C1FF4785C1FF4686C1FF4684C1FF0510
          234B000000060000000100000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000200000004000000050000
          0005000000050000000300000001000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00000000000000000000}
      end>
  end
end
