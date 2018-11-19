;****************************************************************
;***                                                          ***
;***                        Author MCH                        ***
;***                                                          ***
;****************************************************************

/*
╔═══════════════════════════════════════════════════════════════╗
║	                      <<<<程序头部>>>>                      ║
╚═══════════════════════════════════════════════════════════════╝
*/

 Process, Priority, , High
 #NoEnv
 #NoTrayIcon
 #Persistent
 #SingleInstance force
 #WinActivateForce
 #HotkeyInterval 2000  ; This is  the default value (milliseconds).
 #MaxHotkeysPerInterval 200
 SetBatchLines -1
 ;Menu, Tray, Icon,C:\Users\Administrator\Desktop\1.ico, ,1

switch = 0
switch_keyboard = 0
switch_transparent = 0

dat() {
    FormatTime, date, %A_Now%, yyyyMMdd ;格式化当前日期
    FormatTime, time, %A_Now%, yyyy-MM-dd HH:mm:ss ;格式化当前时间
    Array := {}
    Array["date"] := date
    Array["time"] := time
    return Array 
}
dirs() {
    Array := {}
    Array["word"]   := "d:\mch_daily_word_log\"
    Array["search"] := "d:\mch_daily_search_log\"
    return Array 
}
exts() {
    Array := {}
    Array["word"]   := ".WORD"
    Array["search"] := ".SEARCH"
    return Array 
}
/*
╔═══════════════════════════════════════════════════════════════╗
║	                       <<<<退出提示>>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/

Pause::
	msgbox ,3,欢迎您再次光临！,很高兴为您服务！  如有疑问欢迎致电：010-56293582,5
	IfMsgBox Yes
		exitapp
	else
		;MsgBox , ,脑子里装的是x , 没事没乱搞！再乱点打断你的腿/touxiao,5
		Reload
		TrayTip, ,有我在你放心。,5,1
	return

/*
╔═══════════════════════════════════════════════════════════════╗
║	                 <<<<快捷键调节音量>>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/

;----------------------------------------将alt+ 8，9，0 分别设置为音量+ ，-，和静音
>!8::Send {Volume_Down 1}
>!9::Send {Volume_Up 1}
>!0::Send {Volume_Mute}

/*
╔═══════════════════════════════════════════════════════════════╗
║	                      <<<<鼠标手势>>>>                      ║
╚═══════════════════════════════════════════════════════════════╝
*/

rbutton::
mousegetpos xpos1,ypos1
settimer,gtrack,1
return

rbutton up::
settimer,gtrack,off
if (gtrack = ""){
	Click, Right
}else{
	IfEqual,gtrack,l
		send ,{Browser_Back}
	IfEqual,gtrack,r
		send ,{Browser_Forward}
	IfEqual,gtrack,d
		send ,^{End}
	IfEqual,gtrack,u
		send ,^{Home}
}
gtrack=
return

gtrack:
mousegetpos xpos2,ypos2
track:=(abs(ypos1-ypos2)>abs(xpos1-xpos2)) ? (ypos1>ypos2 ? "u" : "d") : (xpos1>xpos2 ? "l" : "r")
if (track<>SubStr(gtrack, 0)) and (abs(ypos1-ypos2)>4 or abs(xpos1-xpos2)>4)
   gtrack.=track
xpos1:=xpos2,ypos1:=ypos2
return

/*
╔═══════════════════════════════════════════════════════════════╗
║	                       <<<<鼠标操作>>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/

<+w::
	MouseMove,0,-10,0,r
	return
<+s::
	MouseMove,0,10,0,r
	return
<+a::
	MouseMove,-10,0,0,r
	return
<+d::
	MouseMove,10,0,0,r
	return

;----------------------------------------鼠标处单双击
<+q::
	Click 
	return
<+e::
	Click 2
	return
;----------------------------------------鼠标处单双击
/*
<!v::
	Click %A_CaretX% , %A_CaretY% ,2
	MouseMove ,2222,0 ,0,R
	return
*/
/*
<!c::
	Click %A_CaretX% , %A_CaretY%
	MouseMove ,2222,0 ,0,R
	return
*/

;----------------------------------------暂时无效
	
/*
 CapsLock  & e::
	MouseMove,0,-10,0,r
	return
CapsLock  & d::
	MouseMove,0,10,0,r
	return
CapsLock  & s::
	MouseMove,-10,0,0,r
	return
CapsLock  & f::
	MouseMove,10,0,0,r
	return
*/
	
;----------------------------------------暂时无效

/*
CapsLock  & e & f::
	MouseMove,10,-10,0,r
	return
CapsLock  & d & f::
	MouseMove,10,10,0,r
	return
CapsLock  & e & s::
	MouseMove,-10,-10,0,r
	return
CapsLock  & d & s::
	MouseMove,-10,10,0,r
	return
*/

/*
╔═══════════════════════════════════════════════════════════════╗
║	                       <<<<窗口管理>>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/

;----------------------------------------alt+= 当前窗口置顶
<!=::WinSet, AlwaysOnTop,on,A


;----------------------------------------alt+- 当前窗口取消置顶
<!-::WinSet, AlwaysOnTop,off,A

;----------------------------------------将窗口最小化
<!c::
	WinMinimize ,A
	return
/*
<!g::
	WinMaximize ,A
	return
<!t::
	WinRestore  ,A
	return
*/	

;----------------------------------------窗口最大化和还原

<!g::
	if switch = 0
	{
		WinMaximize ,A
		switch = 1
		return
	}else{
		WinRestore  ,A
		switch = 0
		return
	}
	return


;----------------------------------------移动窗口到固定位置和大小
!z::
    SetFormat, float, 0.0
    wx := A_ScreenWidth * 3 / 4
    wy := A_ScreenHeight * 4 / 5
    ix := A_ScreenWidth - wx + 8
    iy := A_ScreenHeight - wy
    WinMove,A,,%ix%,30 , %wx%, %wy%
    return



/*
╔═══════════════════════════════════════════════════════════════╗
║	                     <<<<通用的方式>>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/
/*
;----------------------------------------打开notepad（win自带的记事本）
::mopn::
	run,notepad, , max
	return

;添加ahk的注释
::mahkcomment::
	sendraw,;***********************************************************************************************************`n;***                                                                                                     ***`n;***                                                                                                     ***`n;***********************************************************************************************************`n
	send {up 3}{right 5}
	return
*/
/*
╔═══════════════════════════════════════════════════════════════╗
║                   <<<< chrome当做记事本 >>>>                  ║
╚═══════════════════════════════════════════════════════════════╝
*/
::mmwn::
	run , www.baidu.com
	sleep 100
	send ^l
	clipboard = 
	clipboard = data:text/html,<html contenteditable>
	sleep 300
	send ^v{enter}
	sleep 300
	send ^l
	clipboard = %A_YYYY%%A_MM%%A_DD%_mch的专属记事本
	send ^v
	sleep 300
	clipboard = 
	send !!
	sleep 300
	send ^l
	sleep 1000
	send {tab}
	return


/*
╔═══════════════════════════════════════════════════════════════╗
║	                <<<<双击CapsLock搜索>>>>                    ║
╚═══════════════════════════════════════════════════════════════╝
*/

~CapsLock::
	Keywait, CapsLock, , t0.5
	if errorlevel = 1
		return
	else
		Keywait, CapsLock, d, t0.1
		if errorlevel = 0
		{
			inputBox, output, What you want !, ,  , 360, 100,  ,  ,  
				if ErrorLevel
				{	
					;2种方法获取字符长度
					;StringLen,len,output
					len:=StrLen(output)
					if (len>0)
					{
						FoundPos := RegExMatch(output, "i)w{3}" )
						if FoundPos
						{
							Sleep 50
							Run , %output%
							return
						}else{
							google(output)
						}
					}
				}
				else
				{
					FoundPos := RegExMatch(output, "i)w{3}" )
					if FoundPos
					{
						Sleep 50
						Run , %output%
						return
					}else{
						baidu(output)
					}
				}
			return	
		}
	return


/*
╔═══════════════════════════════════════════════════════════════╗
║	          <<<<双击shift搜索 [baidu && google]>>>>           ║
╚═══════════════════════════════════════════════════════════════╝
*/

;搜索

~LCtrl::
	;IfWinNotActive, ahk_class SunAwtFrame
	IfWinNotActive, ahk_class mch
	{
		Keywait, LCtrl, , t0.5
		if errorlevel = 1
			return
		else
			Keywait, LCtrl, d, t0.1
			if errorlevel = 0
			{
				clipboard=
				send ^c
				sleep 50
				output = %clipboard%
				baidu(output)
			}
		return
	}
    return

~RCtrl::
	;IfWinNotActive, ahk_class SunAwtFrame
	IfWinNotActive, ahk_class mch
	{
		Keywait, RCtrl, , t0.5
		if errorlevel = 1
			return
		else
			Keywait, RCtrl, d, t0.1
			if errorlevel = 0
			{
				clipboard=
				send ^c
				sleep 50
				output = %clipboard%
				google(output)
			}
		return
	}
    return
		
		
	baidu(output)
	{
		IfEqual,output 
		{
			Sleep 50
			Run , https://www.baidu.com
			return
		}else{
            Sleep 50
            Run, https://www.baidu.com/baidu?wd=%output%
            return
		}
	}

	google(output)
	{
		IfEqual,output
		{
			Sleep 50
			Run, https://www.google.com
			return
		}else{
            Sleep 50
            Run, http://www.google.com/search?q=%output%
            return
		}			
	}
 

/*
╔═══════════════════════════════════════════════════════════════╗
║	                 <<<<双击esc实现alt+F4>>>>                  ║
╚═══════════════════════════════════════════════════════════════╝
*/

;双击esc实现alt+F4
	~Esc::
		Keywait, Escape, , t0.5
		if errorlevel = 1
			return
		else
			Keywait, Escape, d, t0.1
			if errorlevel = 0
			{
				WinGetActiveTitle, Title
				WinClose, %Title%
			return
			}
		return

/*
╔═══════════════════════════════════════════════════════════════╗
║	          <<<<实现LShift + Wheel  左右滚动>>>>              ║
╚═══════════════════════════════════════════════════════════════╝
*/

;实现LShift + Wheel  左右滚动
~LShift & WheelUp::  ; 向左滚动.
	ControlGetFocus, fcontrol, A
	Loop 2  ; <-- 增加这个值来加快滚动速度.
	    SendMessage, 0x114, 0, 0, %fcontrol%, A  ; 0x114 是 WM_HSCROLL, 它后面的 0 是 SB_LINELEFT.
	return

~LShift & WheelDown::  ; 向右滚动.
	ControlGetFocus, fcontrol, A
	Loop 2  ; <-- 增加这个值来加快滚动速度.
	    SendMessage, 0x114, 1, 0, %fcontrol%, A  ; 0x114 是 WM_HSCROLL, 它后面的 1 是 SB_LINERIGHT.
	return

/*
╔═══════════════════════════════════════════════════════════════╗
║	                     <<<<格式化时间>>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/

::timer::
	FormatTime, now_date, %A_Now%, yyyyMMddHHmmss ;格式化当前时间
	Sleep, 200
	Send, % now_date ;发送
	Return

::timerf::
	FormatTime, now_date, %A_Now%, yyyy-MM-dd HH:mm:ss ;格式化当前时间
	Sleep, 200
	Send, % now_date ;发送
	Return

::dater::
	FormatTime, now_date, %A_Now%, yyyyMMdd ;格式化当前日期
	Sleep, 200
	Send, % now_date ;发送
	Return

::daterf::
	FormatTime, now_date, %A_Now%, yyyy-MM-dd ;格式化当前日期
	Sleep, 200
	Send, % now_date ;发送
	Return

/*
╔═══════════════════════════════════════════════════════════════╗
║	                  <<<<快速新建文件夹>>>>                    ║
╚═══════════════════════════════════════════════════════════════╝
*/

<#f::
    ; 第一行增加快捷键
	Send, ^+n
	Sleep, 200
	        ; 把暂停时间改小
	clipboard = %A_YYYY%%A_MM%%A_DD%
			; 增加上面这句，把当前的系统日期发送到剪贴板
	Send, ^v{Enter}
			; 发送 Ctrl + v 和回车
	return


/*
╔═══════════════════════════════════════════════════════════════╗
║	                      <<<<映射按键>>>>                      ║
╚═══════════════════════════════════════════════════════════════╝
*/


;----------------------------------------将alt+`映射为alt+left
!`::Send !{left}

;----------------------------------------win + c 复制文件路径
#c::
	send ^c
	clipboard = %clipboard% 
	return
	
  
;----------------------------------------将alt+r  映射为 菜单键
	;#InstallKeybdHook
	<!r::AppsKey

;----------------------------------------映射  alt + n，m 分别为 ctrl + shift + left , right
<!,::send ^+{left}
<!.::send ^+{right}




;----------------------------------------上下左右
~CapsLock & e::
<!i::
    send {Up}
    return
~CapsLock & d::
<!k::
    send {Down}
    return
~CapsLock & s::
<!j::
    send {Left}
    return
~CapsLock & f::
<!l::
    send {Right}
    return

;----------------------------------------选取到行首或者行末
<!u::send +{home}
<!o::send +{end}

;----------------------------------------跳转到行首或者行末
<!h::send {home}
<!;::send {end}

;----------------------------------------
^+i::send ^+{up}
^+k::send ^+{down}

;----------------------------------------选取上下左右
+<!i::send +{up}
+<!k::send +{down}
+<!j::send +{left}
+<!l::send +{right}

;----------------------------------------光标移动
CapsLock  & i::send ,{up}
CapsLock  & k::send ,{down}
CapsLock  & j::send ,{left}
CapsLock  & l::send ,{right}

;----------------------------------------锁定/解锁 键盘
;switch_keyboard = 0
~#`::
    if switch_keyboard = 0
    {
        BlockInput, on
        switch_keyboard = 1
        return
    }else{
        BlockInput, off
        switch_keyboard = 0
        return
    }
    return

;---------------------------------------- 窗口透明化

#v::
    if switch_transparent = 0
    {
        winactivate,A ; 激活此窗口
        WinSet,Transparent,220,A
        switch_transparent += 1
    }
    else if  switch_transparent = 1
    {
        winactivate,A ; 激活此窗口
        WinSet,Transparent,200,A
        switch_transparent += 1
    } 
    else if  switch_transparent = 2
    {
        winactivate,A ; 激活此窗口
        WinSet,Transparent,180,A
        switch_transparent += 1
    } 
    else if  switch_transparent = 3
    {
        winactivate,A ; 激活此窗口
        WinSet,Transparent,100,A
        switch_transparent += 1
    }
    else if  switch_transparent = 4
    {
        winactivate,A ; 激活此窗口
        WinSet,Transparent,0,A
        switch_transparent += 1
    } 
    else 
    {
        winactivate,A ; 激活此窗口
        WinSet,Transparent,255,A
        switch_transparent = 0
    }
    return



;----------------------------------------
;将右alt 映射为 右ctrl
;RCtrl::RAlt
;RAlt::RCtrl

;将alt+`映射为backspace
;!`::Send {vk08sc00E}



/*
╔═══════════════════════════════════════════════════════════════╗
║	                     <<<< 程序结束 >>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/

::mmshutdown::
	ExitApp
::mmcl::
	Suspend
	return


/*
╔═══════════════════════════════════════════════════════════════╗
║	      <<<<鼠标移动到任务栏上时，滚轮调节音量>>>>            ║
╚═══════════════════════════════════════════════════════════════╝
*/
#If MouseIsOver("ahk_class Shell_TrayWnd") || MouseIsOver("ahk_class Shell_SecondaryTrayWnd")
WheelUp::Send {Volume_Up}
WheelDown::Send {Volume_Down}

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}

/*
╔═══════════════════════════════════════════════════════════════╗
║         <<<<桌面，调节音量>>>>                                ║
╚═══════════════════════════════════════════════════════════════╝
*/
#If OnDesktop("ahk_class WorkerW")
F2::Send {Volume_Down 1}
F3::Send {Volume_Up 1}
F4::Send {Volume_Mute}

OnDesktop(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}

/*
╔═══════════════════════════════════════════════════════════════╗
║	   <<<<在所有的编辑控件中的轻松删除单词的快捷键>>>>         ║
╚═══════════════════════════════════════════════════════════════╝
*/

/*
#If ActiveControlIsOfClass("Edit")
![::Send ^+{Left}{Del}
!]::Send ^+{Right}{Del}

ActiveControlIsOfClass(Class) {
    ControlGetFocus, FocusedControl, A
    ControlGet, FocusedControlHwnd, Hwnd,, %FocusedControl%, A
    WinGetClass, FocusedControlClass, ahk_id %FocusedControlHwnd%
    return (FocusedControlClass=Class)
}
*/