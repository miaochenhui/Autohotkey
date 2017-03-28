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
 SetBatchLines -1
 ;Menu, Tray, Icon,C:\Users\Administrator\Desktop\1.ico, ,1

/*
╔═══════════════════════════════════════════════════════════════╗
║	                       <<<<退出提示>>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/

F9::
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
!8::Send {Volume_Down 1}
!9::Send {Volume_Up 1}
!0::Send {Volume_Mute}

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
<!v::
	Click %A_CaretX% , %A_CaretY% ,2
	MouseMove ,2222,0 ,0,R
	return

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
<!=::WinSet AlwaysOnTop,on,A


;----------------------------------------alt+- 当前窗口取消置顶
<!-::WinSet AlwaysOnTop,off,A

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
switch = 0
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
║	                    <<<<快速打开软件>>>>                    ║
╚═══════════════════════════════════════════════════════════════╝
*/

;----------------------------------------打开Everything.exe
<!e::
	Run,Everything.exe, D:\m\mm_install\Everything
	return

/*
╔═══════════════════════════════════════════════════════════════╗
║	                     <<<<通用的方式>>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/

;----------------------------------------打开notepad（win自带的记事本）
::mopn::
	run,notepad, , max
	return

;添加ahk的注释
::mahkcomment::
	sendraw,;***********************************************************************************************************`n;***                                                                                                     ***`n;***                                                                                                     ***`n;***********************************************************************************************************`n
	send {up 3}{right 5}
	return

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
║	            <<<<复制文字并在notepad++中打开>>>>             ║
╚═══════════════════════════════════════════════════════════════╝
*/

;----------------------------------------按 Win - S ，复制文字用记事本查看
	 
#s::
	clipboard=
	Send ^c
	IfWinExist ahk_class Notepad++
	{
		WinActivate
		send ^n
	}
	else
	{
		Run notepad++.exe ,D:\Notepad++
		WinWait ahk_class Notepad++
		WinActivate
	}
	Send ^a^v   ;^a是为了替换可能在已打开的记事本中存在的文字，如果你只想跟随复制，那么去掉它即可
	return


;----------------------------------------按 Win - a ，复制文字用记事本查看 
#a::
	clipboard=
	Send ^c
	IfWinExist ahk_class Notepad++
	{
		WinActivate
		send {enter}
	}
	else
	{
		Run notepad++.exe ,D:\Notepad++
		WinWait ahk_class Notepad++
		WinActivate
	}
	Send ^v   ;^a是为了替换可能在已打开的记事本中存在的文字，如果你只想跟随复制，那么去掉它即可
	return

/*
╔═══════════════════════════════════════════════════════════════╗
║	                      <<<<长按方式>>>>                      ║
╚═══════════════════════════════════════════════════════════════╝
*/

;	$a::
;	KeyWait,a
;	If (A_TimeSinceThisHotkey > 300)
;		SetTimer, mainp, -1
;	Else
;		SendInput, % GetKeyState("CapsLock", "A") ? "A" : "a"
;	Return
;	 
;	mainp:
;		Run, https://autohotkey.com/docs
;	Return


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

~LShift::
	IfWinNotActive, ahk_class SunAwtFrame
	{
		Keywait, LShift, , t0.5
		if errorlevel = 1
			return
		else
			Keywait, LShift, d, t0.1
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

~Rshift::
	IfWinNotActive, ahk_class SunAwtFrame
	{
		Keywait, Rshift, , t0.5
		if errorlevel = 1
			return
		else
			Keywait, Rshift, d, t0.1
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
			FoundPos := RegExMatch(output,"i)^(http://|https://|www.)")
            IfGreaterOrEqual,FoundPos,1
			{
				Sleep 50
				Run , %output%
				return
			}else{
				Sleep 50
				Run, https://www.baidu.com/baidu?wd=%output%
				return
			}
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
			FoundPos := RegExMatch(output,"i)^(http://|https://|www.)")
            IfGreaterOrEqual,FoundPos,1
			{
				Sleep 50
				Run , %output%
				return
			}else{
				Sleep 50
				Run, http://www.google.com/search?q=%output%
				return
			}
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
║	                   <<<<自动向上翻页>>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/

;自动向上翻页

~RAlt::
	Keywait, RAlt, , t0.5
	if errorlevel = 1
	    return
	else
	    Keywait, RAlt, d, t0.1
	    WinGetPos, X, Y, Width, Height, A
	    xx := Width - 15
	    yy := Height/2
	    if errorlevel = 0
	    {
	        mouseMove , %xx%, %yy%, 0, 
	        send {MButton}
	        mouseMove , 0, -20, 0, R 
	        return
	    }else{
	        mouseMove , %xx%, %yy%, 0, 
	        send {MButton}
	        mouseMove , 0, 20, 0, R
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
║	                       <<<<计时器>>>>                       ║
╚═══════════════════════════════════════════════════════════════╝
*/

 ::opentimer::
InputBox, time,　　　　　　　　　　奔跑的火车,目的地（里程单位：秒）
; 弹出一个输入框，标题是“煎蛋牌泡面专用计时器”，内容是“请输入一个时间（单位是秒）”
time := time*1000
; 如果一个变量要做计算的话，一定要像这样写，和平常的算式相比，多了一个冒号。sleep 的时间是按照千分之一秒算的，这里乘以 1000 就变成秒了。
Sleep,%time%
MsgBox 到站了~~~~~~~
return

/*
╔═══════════════════════════════════════════════════════════════╗
║	                     <<<<格式化时间>>>>                     ║
╚═══════════════════════════════════════════════════════════════╝
*/

::timer::
	FormatTime, now_date, %A_Now%, yyyyMMdd HH:mm:ss ;格式化当前时间
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
║     <<<<alt+1有道查单词（需要配置有道软件中的快捷键）>>>>     ║
╚═══════════════════════════════════════════════════════════════╝
*/

~!1::
	clipboard=
	Send ^c!2
	Sleep 100
	Send ^v{Enter 2}
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
	#InstallKeybdHook
	<!r::AppsKey

	#Persistent
;----------------------------------------映射   alt + c ,v , s , y ,x , w , f     ,b ,g ,t
;----------------------------------------分别为 ctrl + c, v , s , y ,x , w , f     ,z ,a,h
;<!c::send ^{c}
;<!v::send ^{v}
<!s::send ^{s}
<!b::send ^{y}
;<!x::send ^{x}
<!w::send ^{w}
;<!f::send ^{f}
;<!b::send ^{z}
;<!g::send ^{a}
;<!t::send ^{h}

;----------------------------------------映射  alt + n，m 分别为 ctrl + shift + left , right
<!n::send ^+{left}
<!m::send ^+{right}

;----------------------------------------y映射 alt + ，。分别为 shift + PgUp PgDn
<!,::send +{PgUp}
<!.::send +{PgDn}

;----------------------------------------映射 alt+p 为 Delete
<!p::send {Delete}

/*
;----------------------------------------上下左右
<!j::send {left}
<!l::send {right}
<!i::send {up}
<!k::send {down}
*/

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
;^+j::send ^+{left}
;^+l::send ^+{right}

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

;----------------------------------------禁止键盘和鼠标输入
::mmforbidinput::
    BlockInput, on
    return 
;----------------------------------------禁止键盘和鼠标输入(解除)


;---------------------------------------- 打开/关闭,键盘状态灯
::mmcsl::
    SetNumlockState, off
    SetCapsLockState , off
    SetScrollLockState, off
    return
::mmopl:: 
    SetNumlockState, on
    SetCapsLockState , on
    SetScrollLockState, on
    return


;----------------------------------------暂时无效
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

::shutdown -ahk::
	ExitApp
::mmcl::
	Suspend
	return


/*
╔═══════════════════════════════════════════════════════════════╗
║	      <<<<鼠标移动到任务栏上时，滚轮调节音量>>>>            ║
╚═══════════════════════════════════════════════════════════════╝
*/
#If MouseIsOver("ahk_class Shell_TrayWnd")
WheelUp::Send {Volume_Up}
WheelDown::Send {Volume_Down}

MouseIsOver(WinTitle) {
    MouseGetPos,,, Win
    return WinExist(WinTitle . " ahk_id " . Win)
}


/*
╔═══════════════════════════════════════════════════════════════╗
║	   <<<<在所有的编辑控件中的轻松删除单词的快捷键>>>>         ║
╚═══════════════════════════════════════════════════════════════╝
*/
#If ActiveControlIsOfClass("Edit")
![::Send ^+{Left}{Del}
!]::Send ^+{Right}{Del}

ActiveControlIsOfClass(Class) {
    ControlGetFocus, FocusedControl, A
    ControlGet, FocusedControlHwnd, Hwnd,, %FocusedControl%, A
    WinGetClass, FocusedControlClass, ahk_id %FocusedControlHwnd%
    return (FocusedControlClass=Class)
}

