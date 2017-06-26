Sub data_import()
    Dim s_name(10) As String, s_num As Integer, c_name As String
    Dim i As Integer
    Dim pr_txt As String
    s_num = ThisWorkbook.Worksheets.Count
    pr_txt = "select sheets" & vbCr
    For i = 1 To s_num
        s_name(i) = ThisWorkbook.Worksheets(i).Name
        pr_txt = pr_txt & i & ":" & s_name(i) & vbCr
    Next
    i = InputBox(pr_txt, "sheet selection", 1)
    s_name(0) = s_name(i)
    pr_txt = "sheet:" & s_name(0) & vbCr & vbCr
    c_name = InputBox(pr_txt & "select cells by ""A1""", "cell selection", ActiveCell.Address(False, False))
    d_name = Application.GetOpenFilename("TEXTデータ,*.txt,CSVデータ,*.csv")
    If d_name = "False" Then
        Exit Sub
    End If
    With Worksheets(s_name(0)).QueryTables.Add(Connection:="TEXT;" & d_name, Destination:=Worksheets(s_name(0)).Range(c_name))
        .AdjustColumnWidth = False
        .TextFilePlatform = 932
        .TextFileParseType = xlDelimited
        .RefreshStyle = xlOverwriteCells
        If LCase(Mid(d_name, InStrRev(d_name, ".") + 1)) = "txt" Then
            .TextFileTabDelimiter = True
        Else
            .TextFileCommaDelimiter = True
        End If
        .Refresh()
        .Delete()
    End With
End Sub

