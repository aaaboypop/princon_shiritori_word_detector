;---------------------------------------------------------------------------------------------------------
; Header
#NoEnv
SetWorkingDir %A_ScriptDir%
FileEncoding, UTF-8

#Include, Log_System.ahk
LoadLogSetting( A_ScriptDir . "\Setting.ini")
CreateLogGUI()
gdipToken := Gdip_Startup()

global setting := new ini("config.ini")
;---------------------------------------------------------------------------------------------------------
; BlueStack Title Setting
global title = setting.WordFind.window_title

;---------------------------------------------------------------------------------------------------------
; Telegram Bot Notification Setting
Telegram_Notification := setting.Telegram.Telegram_Notification
chatid := setting.Telegram.chatid
bot_id := setting.Telegram.bot_id
bot_token := setting.Telegram.bot_token






