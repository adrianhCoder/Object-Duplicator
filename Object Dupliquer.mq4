//+------------------------------------------------------------------+
//|                                             Object Dupliquer.mq4 |
//|                                            Copyright 2023,Adrian |
//|                                                       oleetrader |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023,Adrian"
#property link      "oleetrader"
#property version   "1.00"
#property strict
#property indicator_chart_window


string file_name = "Objects.csv";



//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   EventSetTimer(1);
uploadUpdateObjects(); // Important this is first
readObjectsFromCSV();


  //--- create the button
  string name_button = "Delete_Selected";
   ObjectCreate(0,name_button,OBJ_BUTTON,0,0,0);
   ObjectSetInteger(0,name_button,OBJPROP_XDISTANCE,190);
   ObjectSetInteger(0,name_button,OBJPROP_YDISTANCE,5);
   ObjectSetInteger(0,name_button,OBJPROP_XSIZE,160);
   ObjectSetInteger(0,name_button,OBJPROP_YSIZE,50);
   ObjectSetString(0,name_button,OBJPROP_TEXT,"Delete Selected");
   ObjectSetString(0,name_button,OBJPROP_FONT,"Courier New");
   ObjectSetInteger(0,name_button,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,name_button,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(0,name_button,OBJPROP_BGCOLOR,clrGray);
   ObjectSetInteger(0,name_button, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
   ObjectSetInteger(0,name_button,OBJPROP_BACK,false);
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---

//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
double currentTimeInDouble = (double)TimeCurrent(); // Assuming D1 timeframe
Print("Current Time in Double Value: ", currentTimeInDouble);
Print( (datetime)currentTimeInDouble );
   Comment(TimeCurrent());
   borrarBorrables();
   //TODO
  // crearNocreados();//En graficos nuevos si gvar ==1 & no esta en el grafico actual
      //tenemos que crear el objeto con gvars 
        // Ejemplo  V_line
  // updatear_modificados();
   
  }



//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void uploadUpdateObjects()
{

//Escribe todos los objetos al CSV
//TODO Trabajaremos aqui para hacer persistente el CSV
// Y agregarsolo objetos NUEVOS


   int totalObjects = ObjectsTotal();  // Get the total number of objects on the chart
   Print("Total Objects on Chart: ", totalObjects);
   
   for(int i = 0; i < totalObjects; i++)
   {
      string objectName = ObjectName(i);
      
      if( !isInTheCsv(objectName) ){
      Print("Objeto ",objectName," No esta en el CSV AGREGANDO");
      int fileHandle = FileOpen(file_name, FILE_READ|FILE_WRITE|FILE_CSV,';');
      FileSeek(fileHandle, 0, SEEK_END);
      FileWriteString(fileHandle, objectName+";"); // Separated by semicolon
      FileClose(fileHandle);
      
      }
      
   }

}


bool isInTheCsv(string object_name){
//Lee todos los objects del CSV y los asigna a variables globales como existentes
bool is_In = False;

   // Open the file for reading
   int fileHandle = FileOpen(file_name, FILE_READ|FILE_CSV,';');
   if (fileHandle == INVALID_HANDLE)
   {
      Print("Error opening file for reading!");
      
   }

   string line;
   string objectNames = "";

   // Read the lines from the file and concatenate object names
   while (FileIsEnding(fileHandle) == false)
   {
   string objectName_from_csv =  FileReadString(fileHandle);
   
   if( StringCompare(objectName_from_csv,object_name) == 0 ){
   FileClose(fileHandle);
   return true;
   }
    
   }
   FileClose(fileHandle);
   return false;
   // Close the file handle
   

   // Print the concatenated object names
   

}
//+------------------------------------------------------------------+
void readObjectsFromCSV()
{

//Lee todos los objects del CSV y los asigna a variables globales como existentes


   // Open the file for reading
   int fileHandle = FileOpen(file_name, FILE_READ|FILE_CSV,';');
   if (fileHandle == INVALID_HANDLE)
   {
      Print("Error opening file for reading! 12");
      return;
   }

   string line;
   string objectNames = "";

   // Read the lines from the file and concatenate object names
   while (FileIsEnding(fileHandle) == false)
   {
   string objectName_from_csv =  FileReadString(fileHandle);
   
   if(GlobalVariableGet(objectName_from_csv)== 3 )
   {
 
      Print("This object should be deleted");
      ObjectDelete(objectName_from_csv);
      
   }else{
   
   
   GlobalVariableSet(objectName_from_csv,1 );
   
   }
   
     
    
   }

   // Close the file handle
   FileClose(fileHandle);

   // Print the concatenated object names
   
}



void deleteSelectedObjects()
{
    int totalObjects = ObjectsTotal();
    
    for (int i = 0; i < totalObjects; i++)
    {
        string objectName = ObjectName(i);
        
        if (ObjectGetInteger(0, objectName, OBJPROP_SELECTED))
        {
                   
            Print("Selected Object: ", objectName);
            GlobalVariableSet(objectName,3);
        }
    }
}


void borrarBorrables(){

}

void agregarNuevos(string object_name){

}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {


   if(id==CHARTEVENT_OBJECT_CLICK)
     {
     
     if(sparam=="Delete_Selected")
        {
         Print("Deleting...");
         deleteSelectedObjects();
         }
     
      }
      
  }