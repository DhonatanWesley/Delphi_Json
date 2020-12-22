object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Testanto como trabalhar com JSon dentro o do Delphi'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 299
    Align = alClient
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 1
      Top = 98
      Width = 633
      Height = 200
      Align = alClient
      DataSource = DataSource1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 633
      Height = 97
      Align = alTop
      TabOrder = 1
      DesignSize = (
        633
        97)
      object Button1: TButton
        Left = 224
        Top = 14
        Width = 185
        Height = 67
        Anchors = []
        Caption = 'CARREGAR'
        TabOrder = 0
        OnClick = Button1Click
      end
      object Button2: TButton
        Left = 432
        Top = 14
        Width = 185
        Height = 67
        Caption = 'AJUSTAR CAMPO'
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 16
        Top = 14
        Width = 185
        Height = 67
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Anchors = [akTop, akRight]
        Caption = 'LER ARQUIVO TEXTO'
        TabOrder = 2
        OnClick = Button3Click
      end
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 408
  end
end
