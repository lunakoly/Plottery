unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, LiteButton, StdCtrls, LiteLabel, LiteBackground, uUtils,
  LiteEdit, LitePathSelector, LiteScrollBox, LiteScrollbar, uParser, uColorTheme, FileData,
  uMaths, ThemeSelector, uArrayList, uScene, jpeg;


const AppName = 'PLottery';


{
    Used to switch menu
}
type MenuDiscarder = class(Discarder)
        procedure OnSelect(o: TObject); override;
        procedure OnUnselect(o: TObject); override;
end;


{
    Used to switch buttons
}
type ButtonDiscarder = class(Discarder)
        procedure OnSelect(o: TObject); override;
        procedure OnUnselect(o: TObject); override;
end;


type
  TForm1 = class(TForm, IUnknown, IThemeSupporter)
    CreateButton: TLiteButton;
    OpenButton: TLiteButton;
    SettingsButton: TLiteButton;
    ThemeButton: TLiteButton;
    CreatePanel: TLiteBackground;
    MMTitle: TLiteLabel;
    OpenPanel: TLiteBackground;
    SettingsPanel: TLiteBackground;
    CreatePanelSelectPath: TLitePathSelector;
    CreateButtonNext: TLiteButton;
    CreatePanelFileName: TLiteEdit;
    OpenPanelFileName: TLiteEdit;
    OpenPathSelectFile: TLitePathSelector;
    OpenPanelNext: TLiteButton;
    ThemesPanel: TLiteScrollBox;
    ThemesScroll: TLiteScrollbar;
    DropSaveDataTrigger: TLiteButton;
    settingsPanelMenu: TLiteButton;
    settingsPanelClose: TLiteButton;
    settingsPanelAsk: TLiteButton;
    ThemeCreationScroll: TLiteScrollbar;
    ThemeCreationPanel: TThemeSelector;
    ThemesPanelPathSelection: TLitePathSelector;
    ThemesPanelImport: TLiteButton;
    ThemesPanelExport: TLiteButton;
    ThemesPanelNew: TLiteButton;
    ThemesPanelRemove: TLiteButton;
    ThemesPanelThemesHolder: TLiteBackground;
    Image1: TImage;
    ShowBannerTrigger: TLiteButton;

        // IThemeSupporter
        procedure setTheme(theme: ColorTheme);
        function getTheme(): ColorTheme;
        procedure updateColors();

    procedure FormCreate(Sender: TObject);
    procedure CreateButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OpenButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DemosButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SettingsButtonMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ThemeButtonMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure CreatePanelSelectPathPathSelected(path, name: String);
    procedure OpenPanelSelectPathPathSelected(path, name: String);
    procedure FormShow(Sender: TObject);
    procedure DropSaveDataTriggerMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure settingsPanelAskMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure settingsPanelCloseMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure settingsPanelMenuMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    procedure importTheme(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure exportTheme(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure newTheme(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure deleteTheme(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
    procedure updateThemesList();
    procedure ThemeCreationPanelVisibilityChanged(isVisible: Boolean);

    procedure useTheme(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateButtonNextMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ThemeCreationPanelApply(theme: ColorTheme);
    procedure updateScrollVisibility(Sender: TObject;
      isVisible: Boolean);
    function addThemeSelectionButton(tag, i: integer; themes: ArrayList): TLiteButton;
    procedure ThemeCreationPanelColorUpdate(theme: ColorTheme);
    procedure OpenPanelNextMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShowBannerTriggerMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  mainMenu: MenuDiscarder;
  settingsCloseAction: ButtonDiscarder;
  projectName, projectPath: String;

implementation

uses Unit2, Unit3;

{$R *.DFM}


procedure setGlobalTheme(theme: ColorTheme);
begin
    Form1.setTheme(theme);
    Form2.setTheme(theme);
    Form3.setTheme(theme);
end;


procedure updateGlobalColors();
begin
    Form1.updateColors();
    Form2.updateColors();
    Form3.updateColors();
end;


// MenuDiscarder
procedure MenuDiscarder.OnSelect(o: TObject);
begin
    if o is TLiteScrollBox then               // because I need to call TLiteScrollBox::OnVisibilityChanged
        (o as TLiteScrollBox).Visible := true
    else if o is TWinControl then
        (o as TWinControl).Visible := true;
end;


// MenuDiscarder
procedure MenuDiscarder.OnUnselect(o: TObject);
begin
    if o is TLiteScrollBox then               // because I need to call TLiteScrollBox::OnVisibilityChanged
        (o as TLiteScrollBox).Visible := false
    else if o is TWinControl then
        (o as TWinControl).Visible := false;
end;


// ButtonDiscarder
procedure ButtonDiscarder.OnSelect(o: TObject);
begin
    if o is TLiteButton then begin
        (o as TLiteButton).setActive(true);
        (o as TLiteButton).updateColors();
    end;
end;


// ButtonDiscarder
procedure ButtonDiscarder.OnUnselect(o: TObject);
begin
    if o is TLiteButton then begin
        (o as TLiteButton).setActive(false);
        (o as TLiteButton).updateColors();
    end;
end;


// Override
procedure TForm1.setTheme(theme: ColorTheme);
var
    i: integer;
    supporter: IThemeSupporter;

begin
    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.setTheme(theme);
end;


// Override
function TForm1.getTheme(): ColorTheme;
begin
    getTheme := settings.theme;
end;


// Override
procedure TForm1.updateColors();
var
    i: integer;
    supporter: IThemeSupporter;

begin
    for i := 0 to ControlCount - 1 do
        if Supports(controls[i], IThemeSupporter, supporter) then
            supporter.updateColors();
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
    // DOLOAD
    // 500 x 291
    appdir := extractFilePath(Application.ExeName);

    ThemeCreationPanel.setSubTheme(settings.theme);

    if settings.dropSettings then
        DropSaveDataTrigger.setActive(true)
    else
        DropSaveDataTrigger.setActive(false);

    if settings.showBanner then
        ShowBannerTrigger.setActive(true)
    else
        ShowBannerTrigger.setActive(false);

    // menu
    mainMenu := MenuDiscarder.Create();
    mainMenu.objects.add('create', CreatePanel);
    mainMenu.objects.add('open', OpenPanel);
    mainMenu.objects.add('settings', SettingsPanel);
    mainMenu.objects.add('themes', ThemesPanel);
    mainMenu.objects.add('create_theme', ThemeCreationPanel);
    mainMenu.switch('create');

    // reposition
    OpenPanel.Top := CreatePanel.Top;
    OpenPanel.Left := CreatePanel.Left;
    SettingsPanel.Top := CreatePanel.Top;
    SettingsPanel.Left := CreatePanel.Left;
    ThemesPanel.Top := CreatePanel.Top;
    ThemesPanel.Left := CreatePanel.Left;
    ThemeCreationPanel.Top := CreatePanel.Top;
    ThemeCreationPanel.Left := CreatePanel.Left;

    ThemesScroll.Top := CreatePanel.Top;
    ThemesScroll.Left := ThemesPanel.Left + ThemesPanel.Width - ThemesScroll.Width;
    ThemeCreationScroll.Top := CreatePanel.Top;
    ThemeCreationScroll.Left := ThemesPanel.Left + ThemesPanel.Width - ThemeCreationScroll.Width;

    Width := 500;
    Height := 291;

    // settings
    settingsCloseAction := ButtonDiscarder.Create();
    settingsCloseAction.objects.add('menu', settingsPanelMenu);
    settingsCloseAction.objects.add('close', settingsPanelClose);
    settingsCloseAction.objects.add('ask', settingsPanelAsk);

    if settings.exitAction = 'ask' then
        settingsCloseAction.switch('ask')
    else if settings.exitAction = 'menu' then
        settingsCloseAction.switch('menu')
    else if settings.exitAction = 'close' then
        settingsCloseAction.switch('close');

    setTheme(settings.theme);
    updateColors();
end;

procedure TForm1.CreateButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    MMTitle.Caption := ' Create scene';
    mainMenu.switch('create');
    setGlobalTheme(Form1.ThemeCreationPanel.getSubTheme());
    updateGlobalColors();
end;

procedure TForm1.OpenButtonMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    MMTitle.Caption := ' Load scene';
    mainMenu.switch('open');
    setGlobalTheme(Form1.ThemeCreationPanel.getSubTheme());
    updateGlobalColors();
end;

procedure TForm1.DemosButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    MMTitle.Caption := ' Demos';
    mainMenu.switch('demos');
    setGlobalTheme(Form1.ThemeCreationPanel.getSubTheme());
    updateGlobalColors();
end;

procedure TForm1.SettingsButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    MMTitle.Caption := ' Settings';
    mainMenu.switch('settings');
    setGlobalTheme(Form1.ThemeCreationPanel.getSubTheme());
    updateGlobalColors();
end;


procedure TForm1.importTheme(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
    th: ColorTheme;

begin
    if ThemesPanelPathSelection.isSelected then begin
        th := ctImport(ThemesPanelPathSelection.path);
        settings.userThemes.add(th);
        updateThemesList();
        ThemesPanel.validateState();
    end;
end;


procedure TForm1.exportTheme(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if ThemesPanelPathSelection.isSelected then begin
        ctExport(ThemesPanelPathSelection.path, settings.theme);
    end;
end;


procedure TForm1.newTheme(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    MMTitle.Caption := ' New theme';
    mainMenu.switch('create_theme');
    ThemeCreationpanel.setSubTheme(settings.theme);
    ThemeCreationpanel.setTheme(ctCopy(settings.theme));
    ThemeCreationPanel.validateState();
    ThemeCreationPanel.updateColors();
end;


procedure TForm1.deleteTheme(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if settings.builtinThemes.find(settings.theme) <> -1 then begin
        pout('You cannot remove a built-in theme');
        (Sender as TLiteButton).MouseUp(Button, Shift, X, Y);  // to uncolor (bug)
    end else begin
        settings.userThemes.remove(settings.theme);
        settings.theme := settings.builtinThemes.get(0) as ColorTheme;
        setTheme(settings.theme);
        updateThemesList();
        ThemesPanel.validateState();
        updateColors();
    end;
end;


procedure TForm1.useTheme(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var tag: integer;

begin
    if (Sender as TLiteButton).Tag < settings.builtinThemes.size() then begin
        tag := (Sender as TLiteButton).Tag;
        settings.theme := settings.builtinThemes.get(tag) as ColorTheme;

    end else begin
        tag := (Sender as TLiteButton).Tag - settings.builtinThemes.size();
        settings.theme := settings.userThemes.get(tag) as ColorTheme;
    end;

    setGlobalTheme(settings.theme);
    updateGlobalColors();
    ThemeCreationPanel.setSubTheme(settings.theme);
    updateThemesList();
    ThemesPanel.validateState();
end;


function TForm1.addThemeSelectionButton(tag, i: integer; themes: ArrayList): TLiteButton;
var b: TLiteButton;

begin
    b := TLiteButton.Create(ThemesPanelThemesHolder);
    b.Parent := ThemesPanelThemesHolder;
    b.Caption := (themes.get(i) as ColorTheme).name;

    if themes.get(i) as ColorTheme = settings.theme then
        b.Caption := '> ' + b.Caption + ' <';

    b.setTheme(themes.get(i) as ColorTheme);
    b.updateColors();
    b.Width := 190;
    b.Height := 24;
    b.AutoReact := false;

    b.Tag := tag;
    b.OnMouseDown := useTheme;
    addThemeSelectionButton := b;
end;


procedure TForm1.updateThemesList();
var
    i, top, tag: integer;
    b: TLiteButton;

begin
    clearChildren(ThemesPanelThemesHolder);
    top := 0;
    tag := 0;

    for i := 0 to settings.builtinThemes.size() - 1 do begin
        b := addThemeSelectionButton(tag, i, settings.builtinThemes);
        b.Top := top;
        top := top + b.Height + 8;
        tag := tag + 1;
    end;

    for i := 0 to settings.userThemes.size() - 1 do begin
        b := addThemeSelectionButton(tag, i, settings.userThemes);
        b.Top := top;
        top := top + b.Height + 8;
        tag := tag + 1;
    end;

    ThemesPanelThemesHolder.Height := top;
end;


procedure TForm1.ThemeButtonMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    MMTitle.Caption := ' Themes';
    mainMenu.switch('themes');

    setGlobalTheme(ThemeCreationPanel.getSubTheme());
    updateGlobalColors();

    updateThemesList();
    ThemesPanel.validateState();
end;

procedure TForm1.CreatePanelSelectPathPathSelected(path, name: String);
begin
    CreatePanelFileName.Text := ' ' + name;
end;

procedure TForm1.OpenPanelSelectPathPathSelected(path, name: String);
begin
    OpenPanelFileName.Text := ' ' + name;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
    ThemesPanel.setScrollBar(ThemesScroll);
    ThemeCreationPanel.setScrollBar(ThemeCreationScroll);
    mainMenu.switch('create');      // hide scrols
end;


procedure TForm1.DropSaveDataTriggerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    settings.dropSettings := DropSaveDataTrigger.isActive();
end;

procedure TForm1.settingsPanelAskMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    settingsCloseAction.switch('ask');
    settings.exitAction := 'ask';
end;

procedure TForm1.settingsPanelCloseMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    settingsCloseAction.switch('close');
    settings.exitAction := 'close';
end;

procedure TForm1.settingsPanelMenuMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    settingsCloseAction.switch('menu');
    settings.exitAction := 'menu';
end;

procedure TForm1.ThemeCreationPanelVisibilityChanged(isVisible: Boolean);
begin
    ThemeCreationScroll.Visible := isVisible;
end;


procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if DropSaveDataTrigger.isActive then
        dropSettings(appdir + 'plottery.set', settings);
    Application.Terminate();
end;


procedure startNewScene();
begin
    currentScene := Scene.Create();
    projectName := Form1.CreatePanelSelectPath.name;
    projectPath := Form1.CreatePanelSelectPath.path;

    Form2.CoordNet1.theScene := currentScene;
    Form2.Caption := 'Plottery - New Project - ' + projectName;
    Form2.show();
    Form1.hide();
end;


procedure loadScene();
begin
    projectName := Form1.OpenPathSelectFile.name;
    projectPath := Form1.OpenPathSelectFile.path;
    currentScene := restoreProject(projectPath);

    if currentScene <> nil then begin
        Form2.CoordNet1.theScene := currentScene;
        Form2.Caption := 'Plottery - Project - ' + projectName;
        Form2.show();
        Form1.hide();
    end;
end;


procedure TForm1.CreateButtonNextMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if CreatePanelSelectPath.isSelected then
        startNewScene();
end;

procedure TForm1.ThemeCreationPanelApply(theme: ColorTheme);
begin
    settings.userThemes.add(theme);
    MMTitle.Caption := ' Themes';
    mainMenu.switch('themes');

    setGlobalTheme(ThemeCreationPanel.getSubTheme());
    updateGlobalColors();

    updateThemesList();
    ThemesPanel.validateState();
end;

procedure TForm1.updateScrollVisibility(Sender: TObject;
  isVisible: Boolean);
begin
    if (Sender as TLiteScrollBox).getScrollBar <> nil then
        (Sender as TLiteScrollBox).getScrollBar.Visible := isVisible;
end;

procedure TForm1.ThemeCreationPanelColorUpdate(theme: ColorTheme);
begin
    setGlobalTheme(theme);
    updateGlobalColors();
end;

procedure TForm1.OpenPanelNextMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    if OpenPathSelectFile.isSelected then
        loadScene();
end;

procedure TForm1.ShowBannerTriggerMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
    settings.showBanner := ShowBannerTrigger.isActive();
end;

end.
