unit UFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TFrmMain = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    EditUser: TEdit;
    Label2: TLabel;
    EditPass: TEdit;
    Label3: TLabel;
    EditEnterprise: TEdit;
    Label4: TLabel;
    EditAkey: TEdit;
    Label5: TLabel;
    EditProtocol: TEdit;
    Button1: TButton;
    Memo1: TMemo;
    Label6: TLabel;
    ComboBaseUrl: TComboBoxEx;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    Function GetStockRequestJson: String;
    Function GetLoginRequestJson: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses System.JSON.Writers, System.JSON;

{$R *.dfm}

procedure TFrmMain.Button1Click(Sender: TObject);
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  UserJson, StockJson: String;
begin
  Memo1.Clear;
  try
    try
      RESTClient := TRESTClient.Create(ComboBaseUrl.Text);
      RESTClient.ContentType := 'application/json';
      RESTClient.Accept := 'text/javascript';
      RESTClient.AcceptEncoding := 'utf-8';

      RESTResponse := TRESTResponse.Create(nil);
      RESTResponse.ContentType := 'application/json';

      RESTRequest := TRESTRequest.Create(nil);
      RESTRequest.Method := TRESTRequestMethod.rmPOST;
      RESTRequest.Response := RESTResponse;
      RESTRequest.Client := RESTClient;

      if ComboBaseUrl.ItemIndex = 0 then
      begin
        UserJson := GetLoginRequestJson;
        Memo1.Lines.Add('User: ' + UserJson);
        RESTRequest.Params.AddItem('reqbody1', UserJson,
          TRESTRequestParameterKind.pkREQUESTBODY);
      end
      else if ComboBaseUrl.ItemIndex = 1 then
      begin
        StockJson := GetStockRequestJson;
        Memo1.Lines.Add('Stock: ' + StockJson);
        RESTRequest.Params.AddItem('reqbody1', StockJson,
          TRESTRequestParameterKind.pkREQUESTBODY);
      end;

      RESTRequest.Execute;
    except
      on e: exception do
        showmessage(e.Message);
    end;

    if RESTResponse.Status.SuccessOK_200 then
    begin
      showmessage('Successfully');
      Memo1.Lines.Add('Service Response: '+RESTResponse.Content);
    end
    else if RESTResponse.Status.ClientErrorUnauthorized_401 then
    begin
      showmessage('Unauthorized_401');
      Memo1.Lines.Add('Service Response: '+RESTResponse.Content);
    end
    else if RESTResponse.Status.ClientErrorBadRequest_400 then
    begin
      showmessage('BadRequest_400');
      Memo1.Lines.Add('Service Response: '+RESTResponse.Content);
    end

    // RESTResponse1.RootElement:='result[0]';
    { JsonValue := TJSONObject.ParseJSONValue(RESTResponse.Content);
      JsonObject := JsonValue as TJSONObject;
      JsonData := JsonObject.GetValue('Data') as TJSONObject;
      JsonConditions := JsonData.GetValue('AccountList') as TJSONArray;

      JsonObject := JsonConditions.Items[0] as TJSONObject;
      Str := JsonObject.GetValue('').Value;

      JsonObject := JsonConditions.Items[2] as TJSONObject;
      Str := JsonObject.GetValue('').Value; }
  finally
    RESTResponse.Free;
    RESTRequest.Free;
    RESTClient.Free;
  end;
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
ComboBaseUrl.ItemIndex:=0;
end;

Function TFrmMain.GetLoginRequestJson;
begin
  var
  wrtJSON := TJsonObjectWriter.Create();
  try
    wrtJSON.WriteStartObject;
    wrtJSON.WritePropertyName('user');
    wrtJSON.WriteValue(EditUser.Text);
    wrtJSON.WritePropertyName('password');
    wrtJSON.WriteValue(EditPass.Text);
    wrtJSON.WritePropertyName('enterprise');
    wrtJSON.WriteValue(EditEnterprise.Text);
    wrtJSON.WritePropertyName('access_key');
    wrtJSON.WriteValue(EditAkey.Text);
    wrtJSON.WritePropertyName('protocol');
    var ProtokolNo:= StrToIntDef(EditProtocol.Text,0);
    wrtJSON.WriteValue(ProtokolNo);
    Result := wrtJSON.JSON.Format;
  finally
    wrtJSON.DisposeOf;
  end;
end;

Function TFrmMain.GetStockRequestJson: String;
begin
  var
  wrtJSON := TJsonObjectWriter.Create;
  try
    // '{"nonce": "string","store": 0,"parts": [{"sequence": 0,"lineCode": "BMP","partNumber": "BZ-984:MM22"}]}'
    wrtJSON.WriteStartObject;
    wrtJSON.WritePropertyName('nonce');
    wrtJSON.WriteValue('test');
    wrtJSON.WritePropertyName('store');
    wrtJSON.WriteValue(0);
    wrtJSON.WritePropertyName('parts');
    wrtJSON.WriteStartArray;
    wrtJSON.WriteStartObject;
    wrtJSON.WritePropertyName('sequence');
    wrtJSON.WriteValue(0);
    wrtJSON.WritePropertyName('lineCode');
    wrtJSON.WriteValue('BMP');
    wrtJSON.WritePropertyName('partNumber');
    wrtJSON.WriteValue('BZ-984:MM22');
    wrtJSON.WriteEndObject;
    wrtJSON.WriteEndArray;
    Result := wrtJSON.JSON.Format;
  finally
    wrtJSON.DisposeOf;
  end;
end;

end.
