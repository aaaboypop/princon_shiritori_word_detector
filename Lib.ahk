
~F12::ExitApp

GuiClose:
ExitApp
Return

GuiSubmit:
Gui, Submit, NoHide
Return

UpdateImage:
GuiControl, -Redraw, Preview1
GuiControl, -Redraw, Preview2
GuiControl,, Preview1, 1.png
GuiControl,, Preview2, 2.png
GuiControl, +Redraw, Preview1
GuiControl, +Redraw, Preview2
Return

#Include, var_loader.ahk

#Include, Gdip_ImageSearch.ahk

;---------------------------------------------------------------------------------------------------------

ImageS(ImgPath, X1, Y1, X2, Y2, v=0){
bmpHaystack := Gdip_BitmapFromHWND(WinExist(title))
bmpNeedle := Gdip_CreateBitmapFromFile(ImgPath)
RET := Gdip_ImageSearch(bmpHaystack,bmpNeedle,LIST, X1, Y1, X2, Y2, v,0xFFFFFF,1,0)
Gdip_disposeImage( bmpHaystack )
Gdip_disposeImage( bmpNeedle )
;LogAdd("User",[1], RET)
Return RET
}

ClickNA(x,y){
    global title
    ControlClick, x%x% y%y%, %title%, , , , NA
    Sleep, 10
}

RandClick(){
    global arr_bt_pos
    new_bt_pos := shuffle_arr(arr_bt_pos)

    for i,v in new_bt_pos {
        StringSplit, pos, v, |
        ClickNA(pos1,pos2)
    }
}

UpdateCharMatch(){
	global CharMatch := ".*(["
	wordbuck := setting.WordFind.character_match

	Loop, Parse, wordbuck , `,
	{
		CharMatch .= A_LoopField "|"
	}
	CharMatch := RegExReplace(CharMatch, "\|$")
	CharMatch .= "]).*"
}

;---------------------------------------------------------------------------------------------------------
shuffle_arr(arr){
	loop {
		c := arr.Length()
		if (c = 0)
			Break
		Random, n1 , 1, % c
		new_arr.Push(arr[n1])
		arr.RemoveAt(n1)
	}
	Return new_arr
}

;---------------------------------------------------------------------------------------------------------
Telegram_Notification(text)
{
    global
	setting.Telegram.Telegram_Notification

    str=https://api.telegram.org/bot%bot_id%:%bot_token%/sendmessage?
    param := "chat_id=" chatid "&text=" text
    If (Telegram_Notification = "True")
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
