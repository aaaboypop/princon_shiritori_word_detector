#NoEnv
SetWorkingDir %A_ScriptDir%
FileEncoding, UTF-8
SetTitleMatchMode, 2

#Include, Log_System.ahk
LoadLogSetting( A_ScriptDir . "\Setting.ini", 1)
CreateLogGUI()
gdipToken := Gdip_Startup()



;---------------------------------------------------------------------------------------------------------
; Telegram Bot Notification Setting
Telegram_Notification := False ; True for enable
chatid := "your_chat_ID"
bot_id := "your_bot_ID"
bot_token := "your_bot_Token"

; BlueStack Title Setting
global title = BlueStacks 4 ; Set Title name here

; character match setting 
ChaMatch = .*([ค]).*

;---------------------------------------------------------------------------------------------------------













; Click image position setting
bt_pos =
(
303|203
303|324
303|441
423|203
423|324
423|441
543|203
543|324
543|441
)

WinActivate, % title
WinMove, %title%, , , ,1282 , 754
WinGetPos, , , , Height, %title%
if (Height != 754)
    WinMove, %title%, , , ,1314 , 754

arr_bt_pos := []
Loop, Parse, bt_pos , `n, `r 
{
    arr_bt_pos.Push(A_LoopField)
}

loop
{
    WinGetPos, X, Y,,, % title
    x1 := X+893
    y1 := Y+357
    x2 := X+930
    y2 := Y+393

    x3 := X+757
    y3 := Y+414
    x4 := X+948
    y4 := Y+450
    option = -l "Thai"

    cap_pos1 = %x1% %y1% %x2% %y2%
    cap_pos2 = %x3% %y3% %x4% %y4%


    loop {
        If (ImageS( A_ScriptDir . "\try.png", 890, 674, 916, 705, 24)){
            LogAdd("User",[1], "Try to Restart ..")
            ClickNA(932, 688)
            ClickNA(932, 688)
            Sleep, 1000
        }
        If (ImageS( A_ScriptDir . "\try2.png", 573, 519, 600, 550, 24)){
            ClickNA(642,528) ; Restart
            ClickNA(642,528)
        }
        R := ImageS( A_ScriptDir . "\findcha.png", 894, 360, 905, 394, 4)
        Sleep, 100
    }	
    Until (R)

    pBitmap := Gdip_BitmapFromHWND(WinExist(title))
    bm_cropped1:=Gdip_CloneBitmapArea(pBitmap, x1, y1, x2-x1, y2-y1)
    Gdip_SaveBitmapToFile(bm_cropped1,  A_ScriptDir . "\1.png")
    bm_cropped2:=Gdip_CloneBitmapArea(pBitmap, x3, y3, x4-x3, y4-y3)
    Gdip_SaveBitmapToFile(bm_cropped2,  A_ScriptDir . "\2.png")
    

    out_file_path1 = %A_ScriptDir%\cha1.txt
    out_file_path2 = %A_ScriptDir%\cha2.txt
    cmd1 = ""%A_ScriptDir%\Capture2Text\Capture2Text_CLI.exe" -i "%A_ScriptDir%\1.png" -o "%out_file_path1%" %option%
    cmd2 = ""%A_ScriptDir%\Capture2Text\Capture2Text_CLI.exe" -i "%A_ScriptDir%\2.png" -o "%out_file_path2%" %option%
    RunWait, %ComSpec% /c %cmd1%,,hide
    RunWait, %ComSpec% /c %cmd2%,,hide

    FileRead, OutputText1, % out_file_path1
    FileRead, OutputText2, % out_file_path2

    If (LastW != OutputText2){
        LastW := OutputText2
        LogAdd("User",[1],OutputText2)
    }    
    
    RegExMatch(OutputText1, "O).*([ก-ฮ]).*" , obj)
    OutputCha1 := obj.value(1)

    RegExMatch(OutputText2, "O).*([ก-ฮ]).*" , obj)
    OutputCha2 := obj.value(1)

    If (RegExMatch(OutputCha1, ChaMatch) or RegExMatch(OutputCha2, ChaMatch)){
        Skip := False
        FileRead, IgnoreWord, %A_ScriptDir%\BanWord.txt
        Loop, Parse, IgnoreWord, `n ,`r
        {
            If RegExMatch(OutputText2, A_LoopField){
                RandClick()
                Skip := True
            }
        }
        If (Skip){
            Continue            
        }

        ClickNA(1216,697) ; pause
        ClickNA(1216,697) ; pause
        log("princon_shiritori.ahk : " . "1 : " OutputCha1 "`n2 : " OutputCha2 "`n3 : " OutputText2)

        MsgBox,0x4,Ban,% "1 : " OutputCha1 "`n2 : " OutputCha2 "`n : " OutputText2
        IfMsgBox Yes 
        {
            AddText := "`n" RegExReplace(OutputText2, "\n|\r", "")
            FileAppend, %AddText%, %A_ScriptDir%\BanWord.txt
        }
    }
    Else
    {
        ClickNA(1216,697) ; pause
        ClickNA(1216,697)
        Sleep, 500
        ClickNA(642,528) ; Restart
        ClickNA(642,528)
    }
}


ExitApp

~F12::ExitApp

#Include, Gdip_ImageSearch.ahk

;---------------------------------------------------------------------------------------------------------

ImageS(ImgPath, X1, Y1, X2, Y2, v=0){
bmpHaystack := Gdip_BitmapFromHWND(WinExist(title))
bmpNeedle := Gdip_CreateBitmapFromFile(ImgPath)
RET := Gdip_ImageSearch(bmpHaystack,bmpNeedle,LIST, X1, Y1, X2, Y2, v,0xFFFFFF,1,0)
;LogAdd("User",[1], RET)
Return RET
}

ClickNA(x,y){
    global title
    ControlClick, x%x% y%y%, %title%, , , , NA
    Sleep, 100
}

RandClick(){
    global arr_bt_pos
    new_bt_pos := shuffle_arr(arr_bt_pos)

    for i,v in new_bt_pos {
        StringSplit, pos, v, |
        ClickNA(pos1,pos2)
    }
}

;---------------------------------------------------------------------------------------------------------
shuffle_arr(arr){
	c := arr.Length()
	If (c) {
		Random, n , 1, % c
		new_arr := []
		for i,v in arr {
			(i != n) ? new_arr.Push(v)
		}
		r_arr := Func(A_ThisFunc).Bind(new_arr).Call()
		If (r_arr = null) {
			r_arr := []
		}
		r_arr.Push(arr[n]) 
		Return r_arr
	}	
}

;---------------------------------------------------------------------------------------------------------
log(text)
{
    global

    str=https://api.telegram.org/bot%bot_id%:%bot_token%/sendmessage?
    param := "chat_id=" chatid "&text=" text
    If (Telegram_Notification = True)
        url_tovar(str, param)
}

;---------------------------------------------------------------------------------------------------------
url_tovar(URL, param) { 
    WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    WebRequest.Open("POST", URL)
    WebRequest.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
    WebRequest.Send(param)
    res := WebRequest.ResponseText
    return res
}    

;---------------------------------------------------------------------------------------------------------
