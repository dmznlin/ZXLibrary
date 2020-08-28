inherited fFormBookQuery: TfFormBookQuery
  Left = 347
  Top = 364
  Width = 598
  Height = 593
  BorderStyle = bsSizeable
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited dxLayout1: TdxLayoutControl
    Width = 582
    Height = 554
    ParentFont = False
    inherited BtnOK: TButton
      Left = 436
      Top = 521
      TabOrder = 20
    end
    inherited BtnExit: TButton
      Left = 506
      Top = 521
      Caption = #20851#38381
      TabOrder = 21
    end
    object EditISDN: TcxTextEdit [2]
      Left = 81
      Top = 36
      ParentFont = False
      Properties.ReadOnly = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -21
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      OnKeyPress = EditISDNKeyPress
      Width = 423
    end
    object cxLabel1: TcxLabel [3]
      Left = 23
      Top = 70
      Caption = #22270#20070#21517#31216':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object LabelName: TcxLabel [4]
      Left = 104
      Top = 70
      Hint = 'D_Name'
      Caption = #22270#20070#21517#31216
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel4: TcxLabel [5]
      Left = 23
      Top = 145
      Caption = #20986' '#29256' '#21830':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel5: TcxLabel [6]
      Left = 23
      Top = 120
      Caption = #22270#20070#20316#32773':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel6: TcxLabel [7]
      Left = 23
      Top = 245
      Caption = #38144' '#21806' '#20215':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel7: TcxLabel [8]
      Left = 23
      Top = 220
      Caption = #37319' '#36141' '#20215':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel8: TcxLabel [9]
      Left = 23
      Top = 195
      Caption = #21457#34892#23450#20215':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel9: TcxLabel [10]
      Left = 23
      Top = 170
      Caption = #20379' '#24212' '#21830':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel10: TcxLabel [11]
      Left = 23
      Top = 95
      Caption = #25152#23646#31995#21015':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel11: TcxLabel [12]
      Left = 104
      Top = 220
      Hint = 'D_GetPrice'
      Caption = #37319#36141#20215
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel12: TcxLabel [13]
      Left = 104
      Top = 195
      Hint = 'D_PubPrice'
      Caption = #23450#20215
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel13: TcxLabel [14]
      Left = 104
      Top = 170
      Hint = 'D_Provider'
      Caption = #20379#24212#21830
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel14: TcxLabel [15]
      Left = 104
      Top = 145
      Hint = 'D_Publisher'
      Caption = #20986#29256#21830
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel15: TcxLabel [16]
      Left = 104
      Top = 120
      Hint = 'D_Author'
      Caption = #22270#20070#20316#32773
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel16: TcxLabel [17]
      Left = 104
      Top = 95
      Hint = 'B_Name'
      Caption = #25152#23646#31995#21015
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel17: TcxLabel [18]
      Left = 104
      Top = 245
      Hint = 'D_SalePrice'
      Caption = #38144#21806#20215
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object ListDetail: TcxListView [19]
      Left = 23
      Top = 386
      Width = 121
      Height = 97
      Columns = <
        item
          Caption = #22270#20070#21517#31216
          Width = 65
        end
        item
          Caption = #25152#23646#31995#21015
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
          Caption = #23450#20215
          Width = 65
        end
        item
          Caption = #37319#36141#20215
          Width = 65
        end
        item
          Caption = #38144#21806#20215
          Width = 65
        end
        item
          Caption = #24403#21069#24211#23384
          Width = 65
        end>
      HideSelection = False
      ParentFont = False
      ReadOnly = True
      RowSelect = True
      SmallImages = cxImageList1
      TabOrder = 19
      ViewStyle = vsReport
      OnSelectItem = ListDetailSelectItem
    end
    object cxLabel19: TcxLabel [20]
      Left = 23
      Top = 270
      Caption = #24403#21069#24211#23384':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object LabelKuCun: TcxLabel [21]
      Left = 104
      Top = 270
      Hint = 'D_NumAll'
      Caption = #24211#23384
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    inherited dxLayout1Group_Root: TdxLayoutGroup
      inherited dxGroup1: TdxLayoutGroup
        Caption = #22270#20070#20449#24687
        object dxLayout1Item4: TdxLayoutItem
          Caption = #35831#25195#26465#30721':'
          Control = EditISDN
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Group3: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object dxLayout1Group4: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object dxLayout1Item3: TdxLayoutItem
              Caption = 'cxLabel1'
              ShowCaption = False
              Control = cxLabel1
              ControlOptions.ShowBorder = False
            end
            object dxLayout1Item5: TdxLayoutItem
              ShowCaption = False
              Control = LabelName
              ControlOptions.ShowBorder = False
            end
          end
          object dxLayout1Group5: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxLayout1Group6: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxLayout1Item12: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel10
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item19: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel16
                ControlOptions.ShowBorder = False
              end
            end
            object dxLayout1Group7: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxLayout1Item7: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel5
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item18: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel15
                ControlOptions.ShowBorder = False
              end
            end
            object dxLayout1Group8: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxLayout1Item6: TdxLayoutItem
                Caption = #25152#23646#31995#21015':'
                ShowCaption = False
                Control = cxLabel4
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item17: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel14
                ControlOptions.ShowBorder = False
              end
            end
            object dxLayout1Group9: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxLayout1Item11: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel9
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item15: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel13
                ControlOptions.ShowBorder = False
              end
            end
            object dxLayout1Group10: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxLayout1Item10: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel8
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item14: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel12
                ControlOptions.ShowBorder = False
              end
            end
            object dxLayout1Group11: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object dxLayout1Item9: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel7
                ControlOptions.ShowBorder = False
              end
              object dxLayout1Item13: TdxLayoutItem
                ShowCaption = False
                Control = cxLabel11
                ControlOptions.ShowBorder = False
              end
            end
            object dxLayout1Group12: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              ShowBorder = False
              object dxLayout1Group2: TdxLayoutGroup
                ShowCaption = False
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                object dxLayout1Item8: TdxLayoutItem
                  ShowCaption = False
                  Control = cxLabel6
                  ControlOptions.ShowBorder = False
                end
                object dxLayout1Item20: TdxLayoutItem
                  ShowCaption = False
                  Control = cxLabel17
                  ControlOptions.ShowBorder = False
                end
              end
              object dxLayout1Group15: TdxLayoutGroup
                ShowCaption = False
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                object dxLayout1Item25: TdxLayoutItem
                  ShowCaption = False
                  Control = cxLabel19
                  ControlOptions.ShowBorder = False
                end
                object dxLayout1Item26: TdxLayoutItem
                  ShowCaption = False
                  Control = LabelKuCun
                  ControlOptions.ShowBorder = False
                end
              end
            end
          end
        end
      end
      object dxGroup2: TdxLayoutGroup [1]
        AutoAligns = [aaHorizontal]
        AlignVert = avClient
        Caption = #22270#20070#21015#34920
        object dxLayout1Item22: TdxLayoutItem
          AutoAligns = [aaHorizontal]
          AlignVert = avClient
          Caption = 'cxListView1'
          ShowCaption = False
          Control = ListDetail
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  object cxImageList1: TcxImageList
    Height = 18
    Width = 18
    FormatVersion = 1
    DesignInfo = 27787296
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
