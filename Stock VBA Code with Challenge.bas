Attribute VB_Name = "Module1"
Sub Stock_Stats():

'Create variabes for ticker, number_of_tickers, open_price, close_price, Yearly_Change, Percent_ Change, Total_Stock_Volume
    Dim ticker As String
    Dim numberoftickers As Integer
    Dim openprice As Double
    Dim closeprice As Double
    Dim YearlyChange As Double
    Dim PercentChange As Double
    Dim TotalStockVolume As Double

'Loop worksheets
    For Each ws In Worksheets
    ws.Activate

'Determine last row (long since row greater than 32,767)
Dim LastRow As Long
    LastRow = Cells(Rows.Count, "A").End(xlUp).Row

'Add headers to columns
    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"

'Initial variables values
    numberoftickers = 0
    ticker = ""
    openprice = 0
    closeprice = 0
    YearlyChange = 0
    PercentChange = 0
    TotalStockVolume = 0

'Loop through row of tickers
    For i = 2 To LastRow
    
        'Find ticker value
        ticker = Cells(i, 1).Value
        
        'get open price value
        If openprice = 0 Then
            openprice = Cells(i, 3).Value
        End If
        
       'TotalStockVolume value
        TotalStockVolume = TotalStockVolume + Cells(i, 7).Value
        
       'Ticker increments
        If Cells(i + 1, 1).Value <> ticker Then
            numberoftickers = numberoftickers + 1
            Cells(numberoftickers + 1, 9) = ticker
            
            'Close price value
            closeprice = Cells(i, 6)
            
            'YearlyChange value
            YearlyChange = closeprice - openprice
            Cells(numberoftickers + 1, 10).Value = YearlyChange
        
        'Color Shading Yearly Changes
        'Change greater than 0 make green
            If YearlyChange > 0 Then
                Cells(numberoftickers + 1, 10).Interior.ColorIndex = 4
        'Change less than 0 make red
            Else
                Cells(numberoftickers + 1, 10).Interior.ColorIndex = 3
            End If
         
         'PercentChange value
            If openprice = 0 Then
                PercentChange = 0
            Else
                PercentChange = (YearlyChange / openprice)
            End If

            'Make PercentChange a percent
            Cells(numberoftickers + 1, 11).Value = Format(PercentChange, "Percent")

            
            openprice = 0
            Cells(numberoftickers + 1, 12).Value = TotalStockVolume
            TotalStockVolume = 0
        End If
        
    Next i
    'Add Greatest % Increase, Decrease and Greatest Total Volume in Column O
    Range("O2").Value = "Greatest % Increase"
    Range("O3").Value = "Greatest % Decrease"
    Range("O4").Value = "Greatest Total Volume"
    Range("P1").Value = "Ticker"
    Range("Q1").Value = "Value"
    
    ' Get the last row again
    lastRowState = ws.Cells(Rows.Count, "I").End(xlUp).Row
    
    ' Ivariables
    GreatestPercentIncrease = Cells(2, 11).Value
    GPIticker = Cells(2, 9).Value
    GreatestPercentDecrease = Cells(2, 11).Value
    GPDticker = Cells(2, 9).Value
    GreatestStockVolume = Cells(2, 12).Value
    GSVticker = Cells(2, 9).Value
    
    
    ' loop through tickers
    For i = 2 To LastRow
    
        ' Find the greatest percent increase
        If Cells(i, 11).Value > GreatestPercentIncrease Then
            GreatestPercentIncrease = Cells(i, 11).Value
            GPIticker = Cells(i, 9).Value
        End If
        
        ' Find the greatest percent decrease
        If Cells(i, 11).Value < GreatestPercentDecrease Then
            GreatestPercentDecrease = Cells(i, 11).Value
            GPDticker = Cells(i, 9).Value
        End If
        
        ' Find the greatest stock volume
        If Cells(i, 12).Value > GreatestStockVolume Then
            GreatestStockVolume = Cells(i, 12).Value
            GSVticker = Cells(i, 9).Value
        End If
        
    Next i
    
    ' Add the values to each worksheet.
    Range("P2").Value = Format(GPIticker, "Percent")
    Range("Q2").Value = Format(GreatestPercentIncrease, "Percent")
    Range("P3").Value = Format(GPDticker, "Percent")
    Range("Q3").Value = Format(GreatestPercentDecrease, "Percent")
    Range("P4").Value = GSVticker
    Range("Q4").Value = GreatestStockVolume
    
Next ws


End Sub
