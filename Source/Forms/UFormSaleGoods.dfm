inherited fFormSaleGoods: TfFormSaleGoods
  Left = 377
  Top = 274
  Width = 410
  Height = 460
  BorderStyle = bsSizeable
  Constraints.MinHeight = 460
  Constraints.MinWidth = 410
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited dxLayout1: TdxLayoutControl
    Width = 394
    Height = 421
    inherited BtnOK: TButton
      Left = 248
      Top = 388
      TabOrder = 17
    end
    inherited BtnExit: TButton
      Left = 318
      Top = 388
      TabOrder = 18
    end
    object EditMem: TcxLookupComboBox [2]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.DropDownWidth = 450
      Properties.ListColumns = <>
      Properties.OnEditValueChanged = EditMemPropertiesEditValueChanged
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -12
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      Width = 512
    end
    object Label1: TcxLabel [3]
      Left = 23
      Top = 86
      Caption = #20250#21592#22995#21517':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label2: TcxLabel [4]
      Left = 23
      Top = 111
      Caption = #25163#26426#21495#30721':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label3: TcxLabel [5]
      Left = 23
      Top = 161
      Caption = #20250#21592#31561#32423':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label4: TcxLabel [6]
      Left = 23
      Top = 136
      Caption = #21040#26399#26102#38388':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label5: TcxLabel [7]
      Left = 104
      Top = 86
      Hint = 'M_Name'
      Caption = #20250#21592#22995#21517
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label6: TcxLabel [8]
      Left = 104
      Top = 111
      Hint = 'M_Phone'
      Caption = #25163#26426#21495#30721
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label7: TcxLabel [9]
      Left = 104
      Top = 161
      Hint = 'M_Level'
      Caption = #20250#21592#31561#32423
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label8: TcxLabel [10]
      Left = 104
      Top = 136
      Hint = 'M_ValidDate'
      Caption = #21040#26399#26102#38388
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel1: TcxLabel [11]
      Left = 23
      Top = 61
      Caption = #20250#21592#21345#21495':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel2: TcxLabel [12]
      Left = 104
      Top = 61
      Hint = 'M_Card'
      Caption = #20250#21592#21345#21495
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object EditNum: TcxSpinEdit [13]
      Left = 81
      Top = 243
      ParentFont = False
      Properties.MaxValue = 100.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 12
      Value = 1
      OnKeyPress = EditNameKeyPress
      Width = 80
    end
    object EditMemo: TcxMemo [14]
      Left = 81
      Top = 331
      ParentFont = False
      Properties.MaxLength = 200
      TabOrder = 16
      Height = 45
      Width = 399
    end
    object EditName: TcxLookupComboBox [15]
      Left = 81
      Top = 218
      ParentFont = False
      Properties.DropDownAutoSize = True
      Properties.DropDownWidth = 450
      Properties.ListColumns = <>
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -12
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 11
      OnKeyPress = EditNameKeyPress
      Width = 296
    end
    object ListDetail: TcxListView [16]
      Left = 23
      Top = 270
      Width = 536
      Height = 123
      Columns = <
        item
          Caption = #21830#21697#32534#21495
          Width = 65
        end
        item
          Caption = #21830#21697#21517#31216
          Width = 65
        end
        item
          Caption = #21333#20215
          Width = 65
        end
        item
          Caption = #25968#37327
          Width = 65
        end
        item
          Caption = #37329#39069
          Width = 65
        end>
      HideSelection = False
      ParentFont = False
      ReadOnly = True
      RowSelect = True
      SmallImages = cxImageList1
      Style.Edges = []
      TabOrder = 15
      ViewStyle = vsReport
    end
    object BtnAdd: TcxButton [17]
      Left = 262
      Top = 243
      Width = 52
      Height = 22
      Caption = #28155#21152
      TabOrder = 13
      OnClick = BtnAddClick
      SpeedButtonOptions.Flat = True
    end
    object BtnDel: TcxButton [18]
      Left = 319
      Top = 243
      Width = 52
      Height = 22
      Caption = #21024#38500
      TabOrder = 14
      OnClick = BtnDelClick
      SpeedButtonOptions.Flat = True
    end
    inherited dxLayout1Group_Root: TdxLayoutGroup
      inherited dxGroup1: TdxLayoutGroup
        Caption = #20250#21592#20449#24687
        object dxlytmLayout1Item3: TdxLayoutItem
          Caption = #20250#21592#32534#21495':'
          Control = EditMem
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Group2: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxLayout1Item3: TdxLayoutItem
            ShowCaption = False
            Control = cxLabel1
            ControlOptions.ShowBorder = False
          end
          object dxLayout1Item4: TdxLayoutItem
            ShowCaption = False
            Control = cxLabel2
            ControlOptions.ShowBorder = False
          end
        end
        object dxGroupLayout1Group6: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxlytmLayout1Item4: TdxLayoutItem
            Caption = 'cxLabel1'
            ShowCaption = False
            Control = Label1
            ControlOptions.ShowBorder = False
          end
          object dxlytmLayout1Item8: TdxLayoutItem
            ShowCaption = False
            Control = Label5
            ControlOptions.ShowBorder = False
          end
        end
        object dxGroupLayout1Group2: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object dxGroupLayout1Group5: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxlytmLayout1Item5: TdxLayoutItem
              Caption = 'cxLabel1'
              ShowCaption = False
              Control = Label2
              ControlOptions.ShowBorder = False
            end
            object dxlytmLayout1Item9: TdxLayoutItem
              ShowCaption = False
              Control = Label6
              ControlOptions.ShowBorder = False
            end
          end
          object dxGroupLayout1Group3: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxGroupLayout1Group4: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxlytmLayout1Item7: TdxLayoutItem
                ShowCaption = False
                Control = Label4
                ControlOptions.ShowBorder = False
              end
              object dxlytmLayout1Item11: TdxLayoutItem
                ShowCaption = False
                Control = Label8
                ControlOptions.ShowBorder = False
              end
            end
            object dxGroupLayout1Group7: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxlytmLayout1Item6: TdxLayoutItem
                ShowCaption = False
                Control = Label3
                ControlOptions.ShowBorder = False
              end
              object dxlytmLayout1Item10: TdxLayoutItem
                ShowCaption = False
                Control = Label7
                ControlOptions.ShowBorder = False
              end
            end
          end
        end
      end
      object dxGroup2: TdxLayoutGroup [1]
        AutoAligns = [aaHorizontal]
        AlignVert = avClient
        Caption = #38646#21806#26126#32454
        object dxlytmLayout1Item15: TdxLayoutItem
          Caption = #21830#21697#21517#31216':'
          Control = EditName
          ControlOptions.ShowBorder = False
        end
        object dxGroupLayout1Group10: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxlytmLayout1Item14: TdxLayoutItem
            Caption = #21830#21697#25968#37327':'
            Control = EditNum
            ControlOptions.ShowBorder = False
          end
          object dxlytmLayout1Item18: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahRight
            ShowCaption = False
            Control = BtnAdd
            ControlOptions.ShowBorder = False
          end
          object dxlytmLayout1Item19: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahRight
            ShowCaption = False
            Control = BtnDel
            ControlOptions.ShowBorder = False
          end
        end
        object dxlytmLayout1Item16: TdxLayoutItem
          AutoAligns = [aaHorizontal]
          AlignVert = avClient
          Control = ListDetail
          ControlOptions.ShowBorder = False
        end
        object dxlytmLayout1Item17: TdxLayoutItem
          AutoAligns = [aaHorizontal]
          AlignVert = avBottom
          Caption = #22791#27880#20449#24687':'
          Control = EditMemo
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  object cxImageList1: TcxImageList
    Height = 18
    Width = 18
    FormatVersion = 1
    DesignInfo = 19398688
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
