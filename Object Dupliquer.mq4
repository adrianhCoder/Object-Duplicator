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
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- indicator buffers mapping
   EventSetTimer(1);
uploadUpdateObjects();
readObjectsFromCSV();

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
   Comment(TimeCurrent());
   
  }



//+------------------------------------------------------------------+


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void uploadUpdateObjects()
{
   int totalObjects = ObjectsTotal();  // Get the total number of objects on the chart
   Print("Total Objects on Chart: ", totalObjects);

   // Specify the file path where you want to save the CSV file
   string filePath = "hihehe.CSV";

   // Open the file for writing  filehandle = FileOpen(FileName, FILE_WRITE | FILE_CSV);
   int fileHandle = FileOpen(filePath, FILE_WRITE|FILE_CSV,';');
   if (fileHandle == INVALID_HANDLE)
   {
      Print("Error opening file for writing!");
      return;
   }

   for(int i = 0; i < totalObjects; i++)
   {
      string objectName = ObjectName(i);
      
      // Write the object name to the file
      FileWriteString(fileHandle, objectName+";"); // Separated by semicolon
       }

   // Close the file handle
   FileClose(fileHandle);
}

//+------------------------------------------------------------------+
void readObjectsFromCSV()
{
   // Open the file for reading
   int fileHandle = FileOpen("hihehe.CSV", FILE_READ|FILE_CSV,';');
   if (fileHandle == INVALID_HANDLE)
   {
      Print("Error opening file for reading!");
      return;
   }

   string line;
   string objectNames = "";

   // Read the lines from the file and concatenate object names
   while (FileIsEnding(fileHandle) == false)
   {
     GlobalVariableSet( FileReadString(fileHandle),1 );
     
   }

   // Close the file handle
   FileClose(fileHandle);

   // Print the concatenated object names
   
}

