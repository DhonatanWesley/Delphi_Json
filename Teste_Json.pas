unit Teste_Json;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    ClientDataSet1: TClientDataSet;
    Button1: TButton;
    DataSource1: TDataSource;
    Button2: TButton;
    Button3: TButton;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  MeuArquivo : TextFile;
  JSon       : String;


implementation

{$R *.dfm}

uses
   REST.Response.Adapter, System.JSON;


procedure JsonToDataset(aDataset : TDataSet; aJSON : string);
var
  JObj  : TJSONArray;
  vConv : TCustomJSONDataSetAdapter;
begin
  if (aJSON = EmptyStr) then
  begin
    Exit;
  end;

  JObj  := TJSONObject.ParseJSONValue(aJSON) as TJSONArray;
  vConv := TCustomJSONDataSetAdapter.Create(Nil);

  try
    vConv.Dataset := aDataset;
    vConv.UpdateDataSet(JObj);
  finally
    vConv.Free;
    JObj.Free;
  end;
end;


{* REDIMENCIONAR DB GRID AUTOMARICAMENTE *}
procedure AjustarColunas(DBGrid : TDBgrid);
var
  ColumnCount,
  RowCount,
  contRow,
  contCol,
  AValue         : Integer;

  DataSetTemp    : TDataSet;
  DataSourceTemp : TDataSource;

  MStrValue,
  AStrValue,
  vNomeCampo     : String;

  Canvas         : TCanvas;

begin
   //captura colunas do dbgrid
   ColumnCount := DBGrid.Columns.Count;

   //verifica se existem colunas
   if (ColumnCount = 0) then Exit;

   //verifica se o TDataSet do DataSource referenciado no DBGrid está ativo (haha)
   if not DBGrid.DataSource.DataSet.Active  then Exit;

   //captura em variáveis temporárias o dataset e datasource, e também a quantidade de linhas que sua query retornou no record count
   DataSetTemp    := DBGrid.DataSource.DataSet;
   DataSourceTemp := DBGrid.DataSource;

   //esta instrução foi feita para evitar que o usuário veja o processo de redimensionamento do dbgrid.
   //Não pode limpar o DataSource do DBGrid.
   //DBGrid.DataSource := nil;
   RowCount := DataSetTemp.RecordCount;

   //varre todas as colunas do dbgrid
   for contCol := 0 to ColumnCount-1 do
   begin
      AValue    := 0;
      AStrValue := '';

      DataSetTemp.First;

      //Seta o primeiro valor como o TÍTULO da coluna para evitar que os campos fiquem "invisíveis", quando não houver campo preenchido.
      MStrValue := DBGrid.Columns[contCol].Title.Caption;

      while not DataSetTemp.Eof do
      begin

         vNomeCampo := DBGrid.Columns[contCol].FieldName;

         //ShowMessage(vNomeCampo);

         //captura valor e o length do campo atual
         AValue    := Length(DataSetTemp.FieldByName(DBGrid.Columns[contCol].FieldName).AsString);
         AStrValue := DataSetTemp.FieldByName(DBGrid.Columns[contCol].FieldName).AsString;
         DataSetTemp.Next;

         //verifica se a próxima variável é maior que a anterior
         //e mantém a maior.
         if length(MStrValue) < AValue then
            MStrValue := AStrValue;
      end;

      //seta a largura atual com o tamanho do campo maior capturado
      //anteriormente (Observe que há uma conversão de texto para Width,
      //isto é para capturar o valor real da largura do texto.)


      //DBGrid.Columns[contCol].Width := Canvas.TextWidth(MStrValue)+15;

      //ShowMessage( FloatToStr( Form1.Canvas.TextWidth( MStrValue ) ) );

      DBGrid.Columns[contCol].Width := DBGrid.Canvas.TextWidth( MStrValue )+10;
   end;

   //DataSource novamente referenciado, para evitar Acess Violation.
   DBGrid.DataSource := DataSourceTemp;
end;

procedure TForm1.Button1Click(Sender: TObject);
//const
  //MEU_JSON = '[{"pgemp_codigo":1,"eqpdg_codigo":"010101011","eqund_codigo":"UN","eqpgu_descricaocomplementar":null,"eqpgu_fatorconversaoembalagem":1.000000,"eqpgu_situacao":"A","eqpgu_situacaoforcavenda":"A"}]';


  //MEU_JSON =
  //'[{'+
	//'"Titulo": "Ate que a sorte nos separe",'+
	//'"Duracao": "120 min",'+
  //'"Genero": "Comedia Romantica" '+
  //'}, {'+
	//'"Titulo": "Matrix",'+
	//'"Duracao": "140 min",'+
  //'"Genero": "Ficcao Cientifica"'+
  //'}]';

var MEU_JSON : String;

  begin

   MEU_JSON := JSon;

   JsonToDataset(ClientDataSet1, MEU_JSON);
   ClientDataSet1.Active := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
var vNomeCampo : String;
begin
   AjustarColunas(DBGrid1);
end;

procedure TForm1.Button3Click(Sender: TObject);
var Arquivo,
    vRead   : String;
begin
   // Ler aquivo de texto com o Json dentro.

   JSon    := '';
   Arquivo := 'C:\Temp\ArquivoTesteJson.txt';

   AssignFile( MeuArquivo, Arquivo );

   Reset(MeuArquivo);

   while not Eof( MeuArquivo ) do
   begin
      ReadLn(MeuArquivo, vRead);
      JSon := JSon + vRead;
   end;
end;

end.
