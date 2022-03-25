# Princon shiritori word detector

**princon shiritori word detector** คือสคริปที่สร้างด้วย AHK ที่ใช้กับโปรแกรมจำลองแอนดรอย Bluestacks กับเกม Princess Connect Re:Dive! ในมินิเกมของกิจกรรม นักสำรวจมังกร สำหรับการหาคำลงท้ายที่สงมาจากบอท (คายะ) ตามที่คุณต้องการ~

## การทำงาน
เมื่อเจอการปรากฏของคำจะเรียกใช้การ OCR ให้เป็นข้อความ แล้วทำการตรวจสอบว่าตรงกับเงื่อนไขหรือไม่ หากไม่จะกดแผ่นป้ายแบบสุ่มๆ แต่ถ้าหากตรงกับเงื่อนไขจะกดปุ่มหยุดเกมแล้วแสดงหน้าต่าง Ban เพื่อรอผู้ใช้งานมาเลือกแผ่นป้ายหรือ Ban คำที่ ocr ผิดพลาด และหากพบปุ่ม ลองใหม่ เมื่อแพ้หรือชนะ จะกดให้ทันที

## สิ่งจำเป็น
คอม x86/x64 ที่ใช้ windows 10\
Bluestacks 5/4\
AHK

## การใช้งาน
1. หากคุณยังไม่มี bluestacks 5 ก็ไปหามาลงซะ เพราะผมไม่ได้ใช้ตัวอื่น เลยมิอาจคาดเดาผลของการค้นหาได้ แต่หากคุณจะเอาไปใช้กับตัวอื่นก็สามารถไปแก้ไขตำแหน่งหรือภาพได้ตามสบาย~
2. ดาวน์โหลด AHK มาลงเครื่อง https://www.autohotkey.com/ กดตรง Current Version นะเออ~\
	2.1   หลังลงแล้ว ให้เข้าไปตั้งค่ารันด้วย admin \
ในโฟลเดอร์ `C:\Program Files\AutoHotkey`\
โดยการกดเข้า `properties > compatibility > run this program as an administrator` \
	2.2   ทำทุกไฟล์ที่เป็น exe ในนั้นแหล่ะ เพื่อความชัวร์\
  ![image](https://user-images.githubusercontent.com/38764429/160011894-6b2c84fa-c170-4f9a-b144-5ddd03abbb76.png)



## ดาวน์โหลดได้ที่นี่
https://github.com/aaaboypop/princon_shiritori_word_detector/archive/refs/heads/main.zip



## เตรียมความพร้อม Bluestacks ของคุณ~ 
ในหัวข้อ Display ให้ตั้งค่าเป็น 1280x720\
![image](https://user-images.githubusercontent.com/38764429/160011941-7354b31f-df1f-4a85-a873-1bd3837c02f7.png)



ตั้งค่าการทำงานของสคริปก่อนใช้งาน

 
    ; Telegram Bot Notification Setting
    Telegram_Notification := False ; True for enable
    chatid := "your_chat_ID"
    bot_id := "your_bot_ID"
    bot_token := "your_bot_Token"
     
    ; BlueStack Title Setting
    title = BlueStacks ; Set Title name here
     
    ; character match setting
    ChaMatch = .*([ค|ป|น]).*
 

**Telegram_Notification** *(True/False)* \
ตั้งค่าเป็น True หากต้องการใช้งานบอทแจ้งเตือนของ Telegram โดนต้องตั้งค่า chatid, bot_id และ bot_token ให้ถูกต้อง

**title** *(String)* \
หากชื่อของโปรแกรม/หน้าต่างจำลองที่ใช้นั้นไม่ใช่ BlueStacks ให้เปลี่ยนชื่อตามหน้าต่างที่คุณใช้งาน

**ChaMatch** *(String RegEX)* \
เงื่อนไขที่ต้องการค้นหา


เริ่มใช้งาน หากคุณตั้งค่า title ได้ถูกต้อง หน้าต่าง bluestacks จะถูกเรียนขึ้นมา และจะทำการเปลี่ยนขนาดไปเป็น 1282x754 (1287x764 สำหรับ BS4) หากไม่มีเครื่องมือด้านข้าง หรือ 1314x754 (1346x764 สำหรับ BS4) หากมีเครื่องมือด้านข้าง

> *เมื่อใช้งานโปรดคลิ๊กที่หน้าต่าง bluestacks เพื่อให้มั่นใจว่ามันกำลัง active ก่อนที่คุณจะหนีปายยย\
การตั้งค่า BanWord คุณสามารถเข้าไปดูได้ในไฟล์ BanWord.txt\
โดยคำเหล่านี้จะถูกเพิกเฉยแม้เงื่อนไขการตรวจจับจะเป็นจริง

## Library ที่ใช้
[Capture2Text](http://capture2text.sourceforge.net/ "Capture2Text")


## วีดีโอประกอบ
https://www.youtube.com/watch?v=Y0j0SZxH6BA


## Sheet ประกอบในการหาคำศัพท์
https://t.ly/j0cl



## ข้อมูลติดต่อ
**By pond_pop (ผู้ดูแลแคลน KuroYami และ ShiroYoru)**\
**By Nicezki (ผู้ดูแลแคลน KuroYami)**

**Discord:**\
https://yami.page.link/dis
