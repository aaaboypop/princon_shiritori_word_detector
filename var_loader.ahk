class ini{
		
	__New(SettingPath){
		If !(FileExist(SettingPath)){
			DefaultSetting =
			(
[TestFn]
TestKey=vale
			)
			FileAppend, %DefaultSetting%, %Path%
		}

		FileRead, FileSetting, %SettingPath%
		This._List:=[]
		Loop, Parse, FileSetting, `n, `r
		{
			i := A_index
			If RegExMatch(A_LoopField, "O)^\[(.*)\]$" , ObjMatch) ; Find ProfileName > Set Default value
			{
				FnName := ObjMatch.Value(1)
				If !(This.HasKey(FnName)){
					This[FnName] := {}
					This[FnName]._List := []
					This._List.Push(FnName)
				}
				Continue
			}
			If RegExMatch(A_LoopField, "O)^(.*)=(.*)$" , ObjMatch)
			{
				KEY := ObjMatch.Value(1)
				Value := ObjMatch.Value(2)
				This[FnName][KEY] := Value
				This[FnName]._List.Push(KEY)
			}
		}
	}

	GetSetting(FnName, ByRef Obj){
		Obj := {}
		for i,v in This[FnName]._List{
			Obj[v] := This[FnName][v]
		}
		Return This[FnName]._List
	}
}