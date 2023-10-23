object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Delphi Pacesetterplus WS Test App - 23.10.2023'
  ClientHeight = 703
  ClientWidth = 1053
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 369
    Height = 703
    Align = alLeft
    Caption = '  Parameters  '
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 56
      Width = 23
      Height = 15
      AutoSize = False
      Caption = 'User'
    end
    object Label2: TLabel
      Left = 15
      Top = 82
      Width = 59
      Height = 20
      AutoSize = False
      Caption = 'Password'
    end
    object Label3: TLabel
      Left = 15
      Top = 107
      Width = 59
      Height = 20
      AutoSize = False
      Caption = 'Enterprise'
    end
    object Label4: TLabel
      Left = 15
      Top = 132
      Width = 59
      Height = 20
      AutoSize = False
      Caption = 'Access Key'
    end
    object Label5: TLabel
      Left = 15
      Top = 157
      Width = 59
      Height = 20
      AutoSize = False
      Caption = 'Protocol'
    end
    object Label6: TLabel
      Left = 16
      Top = 31
      Width = 58
      Height = 15
      AutoSize = False
      Caption = 'Endpoint'
    end
    object EditUser: TEdit
      Left = 80
      Top = 54
      Width = 285
      Height = 23
      TabOrder = 0
      Text = 'test'
    end
    object EditPass: TEdit
      Left = 80
      Top = 79
      Width = 285
      Height = 23
      TabOrder = 1
      Text = 'pass1'
    end
    object EditEnterprise: TEdit
      Left = 80
      Top = 104
      Width = 285
      Height = 23
      TabOrder = 2
      Text = 'test'
    end
    object EditAkey: TEdit
      Left = 80
      Top = 129
      Width = 285
      Height = 23
      TabOrder = 3
      Text = 'test'
    end
    object EditProtocol: TEdit
      Left = 80
      Top = 154
      Width = 285
      Height = 23
      TabOrder = 4
      Text = '0'
    end
    object Button1: TButton
      Left = 15
      Top = 183
      Width = 351
      Height = 42
      Caption = 'Execute'
      TabOrder = 5
      OnClick = Button1Click
    end
    object ComboBaseUrl: TComboBoxEx
      Left = 80
      Top = 28
      Width = 285
      Height = 24
      ItemsEx = <
        item
          Caption = 'https://pacesetterplus.com/web_stores/login'
        end
        item
          Caption = 'https://pacesetterplus.com/web_stores/stock_check'
        end>
      TabOrder = 6
      Text = 'https://pacesetterplus.com/web_stores/login'
    end
  end
  object Memo1: TMemo
    Left = 369
    Top = 0
    Width = 684
    Height = 703
    Align = alClient
    Lines.Strings = (
      '')
    TabOrder = 1
  end
end
