inherited fFormBookSaleReturn: TfFormBookSaleReturn
  Left = 377
  Top = 274
  Width = 659
  Height = 674
  BorderStyle = bsSizeable
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  inherited dxLayout1: TdxLayoutControl
    Width = 651
    Height = 647
    inherited BtnOK: TButton
      Left = 505
      Top = 614
      TabOrder = 17
    end
    inherited BtnExit: TButton
      Left = 575
      Top = 614
      TabOrder = 18
    end
    object EditMem: TcxLookupComboBox [2]
      Left = 81
      Top = 36
      ParentFont = False
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
    object Label9: TcxLabel [11]
      Left = 23
      Top = 186
      Caption = #36141#20070#32479#35745':'
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object Label10: TcxLabel [12]
      Left = 104
      Top = 186
      Hint = 'M_Total'
      Caption = #36141#20070#32479#35745
      ParentFont = False
      Style.Font.Charset = GB2312_CHARSET
      Style.Font.Color = clBlack
      Style.Font.Height = -16
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      Transparent = True
    end
    object cxLabel1: TcxLabel [13]
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
    object cxLabel2: TcxLabel [14]
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
    object EditISDN: TcxTextEdit [15]
      Left = 81
      Top = 254
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -21
      Style.Font.Name = #23435#20307
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 13
      OnKeyPress = EditISDNKeyPress
      Width = 512
    end
    object ListBooks: TcxListView [16]
      Left = 23
      Top = 288
      Width = 544
      Height = 108
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
          Caption = #35821#31181
          Width = 65
        end
        item
          Caption = #20998#31867
          Width = 65
        end
        item
          Caption = #21487#36864#22238
          Width = 65
        end>
      HideSelection = False
      ParentFont = False
      ReadOnly = True
      RowSelect = True
      SmallImages = cxImageList1
      Style.Edges = []
      TabOrder = 14
      ViewStyle = vsReport
      OnDblClick = ListBooksDblClick
    end
    object ListDetail: TcxListView [17]
      Left = 23
      Top = 433
      Width = 544
      Height = 108
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
          Caption = #35821#31181
          Width = 65
        end
        item
          Caption = #20998#31867
          Width = 65
        end
        item
          Caption = #36864#36824#25968#37327
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
      OnDblClick = ListDetailDblClick
    end
    object EditMemo: TcxMemo [18]
      Left = 81
      Top = 557
      ParentFont = False
      Properties.MaxLength = 200
      TabOrder = 16
      Height = 45
      Width = 489
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
              ShowBorder = False
              object dxGroupLayout1Group8: TdxLayoutGroup
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
              object dxGroupLayout1Group9: TdxLayoutGroup
                ShowCaption = False
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                object dxlytmLayout1Item12: TdxLayoutItem
                  ShowCaption = False
                  Control = Label9
                  ControlOptions.ShowBorder = False
                end
                object dxlytmLayout1Item13: TdxLayoutItem
                  ShowCaption = False
                  Control = Label10
                  ControlOptions.ShowBorder = False
                end
              end
            end
          end
        end
      end
      object dxGroup2: TdxLayoutGroup [1]
        Caption = #22270#20070#20449#24687': '#21452#20987#30830#35748#36864#22238'.'
        object dxLayout1Item7: TdxLayoutItem
          Caption = #35831#25195#26465#30721':'
          Control = EditISDN
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item8: TdxLayoutItem
          Control = ListBooks
          ControlOptions.ShowBorder = False
        end
      end
      object dxGroup3: TdxLayoutGroup [2]
        AutoAligns = [aaHorizontal]
        AlignVert = avClient
        Caption = #38144#21806#26126#32454': '#21452#20987#21462#28040#36864#22238'.'
        object dxLayout1Item9: TdxLayoutItem
          AutoAligns = [aaHorizontal]
          AlignVert = avClient
          Control = ListDetail
          ControlOptions.ShowBorder = False
        end
        object dxLayout1Item11: TdxLayoutItem
          Caption = #22791#27880#20449#24687':'
          Control = EditMemo
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  object cxImageList1: TcxImageList
    FormatVersion = 1
    DesignInfo = 22544440
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000926E4DB7CB9767FFC99465FFC89162FFC78F5FFF8D6441B7000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000C19269ECD09D70FFCE9C6DFFCC996AFFCB9668FFB8865BEC000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000080000
          000F000000130000001600000017000000110000000400000000000000000000
          0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF0C498EBF1165
          C6FF0F63C5FF0E61C4FF0D60C3FF09438BC80000001100000000552D12810000
          00009B7754BDD09D70FFCE9C6DFFCC996AFFCB9668FF956D49BD1268C8FFA3DA
          FFFF59BCFFFF56BBFFFF53BAFFFF0E60C3FF0000001700000000A95A25FF552D
          12810000000000000000000000000000000000000000000000001369C9FFB5E1
          FFFF5BBDFFFF59BBFFFF56BAFFFF0F61C3FFAD5E2AFFAC5D28FFAA5B27FFAA59
          24FF2C1709420000000000000000000000000000000000000000146ACAFFC6E8
          FFFFB7E2FFFFA7DCFFFF97D5FFFF0F63C5FF0000001200000000AC5D28FF542D
          137E0000000000000000000000000000000000000000000000000F4F97BF136A
          CAFF1368C9FF1267C7FF1065C6FF0C4A93C60000000A00000000552F157E0000
          0000926E4DB7CB9767FFC99465FFC89162FFC78F5FFF8D6441B7000000010000
          0003000000050000000700000008000000070000000200000000000000000000
          0000CE9B6EFFFBF8F3FFF6EBE1FFF4E8DDFFF2E5D8FFC68F5FFF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000D09E70FFFCFAF7FFFBF7F3FFFAF4EEFFF8F0E9FFC79161FF000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          00009B7754BDD09D70FFCE9C6DFFCC996AFFCB9668FF956D49BD000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end>
  end
end
