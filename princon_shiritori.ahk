#Include, config.ahk

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

x1 := 897
y1 := 357
x2 := 934
y2 := 397
x3 := 765
y3 := 420
x4 := 956
y4 := 456
option = -l "Thai"

while !(WinExist(title)){
    InputBox, title , Title Name not found, ไม่พบหน้าต่าง %title% โปรดใส่ชื่อของหน้าต่างใหม่, ,, ,,,,,%title%
}

UpdateCharMatch()

Gui, Add, Text, , ชื่อหน้าต่าง BlueStack
Gui, Add, Edit, w200 ReadOnly, %title%
Gui, Add, Text, , เงื่อนไข
Gui, Add, Edit, w200 ReadOnly, %CharMatch%

Gui, Add, Checkbox, w200 vMode gGuiSubmit, "ลองใหม่อีกครั้ง" เมื่อไม่พบคำที่ต้องการ
Gui, Add, Text, , ภาพล่าสุด
Gui, Add, Pic, w37 h40 vPreview1,
Gui, Add, Pic, w191 h36 vPreview2,

Gui, Show,, Princon Shiritori Word Detector
Gui, Submit, NoHide

WinActivate, % title
WinMove, %title%, , , ,1282 , 754
WinGetPos, , , , Height, %title%
if (Height != 754)
    WinMove, %title%, ,0,0,1314 , 754

arr_bt_pos := []
Loop, Parse, bt_pos , `n, `r 
{
    arr_bt_pos.Push(A_LoopField)
}

loop
{
    loop {
        If (ImageS( A_ScriptDir . "\try.png", 890, 674, 916, 705, 24)){
            LogAdd("User",[1], "Try to Restart ..")
            ClickNA(932, 688)
            ClickNA(932, 688)
            Sleep, 1000
        }
        R := ImageS( A_ScriptDir . "\findcha.png", 894, 360, 905, 394, 4)
        Sleep, 100
    }	
    Until (R)

    pBitmap := Gdip_BitmapFromHWND(WinExist(title))
    t1 := Gdip_CloneBitmapArea(pBitmap, x1, y1, x2-x1, y2-y1)
    Gdip_SaveBitmapToFile(t1,  A_ScriptDir . "\1.png")
    t2 := Gdip_CloneBitmapArea(pBitmap, x3, y3, x4-x3, y4-y3)
    Gdip_SaveBitmapToFile(t2,  A_ScriptDir . "\2.png")

    Gdip_disposeImage( t1 )
    Gdip_disposeImage( t2 )
    Gdip_disposeImage( pBitmap )

    Gosub, UpdateImage

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

    If (Mode = 0){
        If (RegExMatch(OutputCha1, CharMatch) or RegExMatch(OutputCha2, CharMatch)){
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

            ClickNA(1216,697)
            ClickNA(1216,697)
            Telegram_Notification("พบคำที่ต้องการ `n1 : " OutputCha1 "`n2 : " OutputText2)

            MsgBox,0x4,Ban,% "1 : " OutputCha1 "`n2 : " OutputCha2 "`n : " OutputText2
            IfMsgBox Yes 
            {
                AddText := "`n" RegExReplace(OutputText2, "\n|\r", "")
                FileAppend, %AddText%, %A_ScriptDir%\BanWord.txt
            }
        }
        Else
        {
            RandClick()
        }
    }
    Else If (Mode = 1){
        If (RegExMatch(OutputCha1, CharMatch) or RegExMatch(OutputCha2, CharMatch)){
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
            Telegram_Notification("พบคำที่ต้องการ `n1 : " OutputCha1 "`n2 : " OutputText2)

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
}
ExitApp

#Include, Lib.ahk