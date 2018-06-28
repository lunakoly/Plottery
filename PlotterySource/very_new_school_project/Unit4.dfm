object Form4: TForm4
  Left = 1482
  Top = 400
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Task'
  ClientHeight = 233
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object LiteBackground1: TLiteBackground
    Left = 0
    Top = 0
    Width = 297
    Height = 233
    BevelOuter = bvNone
    Color = clBtnShadow
    TabOrder = 0
    object LiteLabel1: TLiteLabel
      Left = 0
      Top = 0
      Width = 297
      Height = 33
      Alignment = taCenter
      AutoSize = False
      Caption = 'TASK'
      Color = clHighlight
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Consolas'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object LiteMemo1: TLiteMemo
      Left = 8
      Top = 40
      Width = 281
      Height = 185
      BorderStyle = bsNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Consolas'
      Font.Style = []
      Lines.Strings = (
        'Find the line that crosses 2 '
        'points and devides other ones '
        'into 2 groups with equal or '
        'nearly equal amount of points '
        'in each')
      ParentColor = True
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
end
