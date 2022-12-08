;双击桌面显示隐藏桌面图标

#Persistent
CoordMode, Pixel, Screen
CoordMode, Mouse, Screen
;~ 桌面Progman|WorkerW
GroupAdd, Desktop, ahk_class ExploreWClass
GroupAdd, Desktop, ahk_class WorkerW
WaitTime := DllCall("GetDoubleClickTime")/1000
;屏幕左上
x1:=0
y1:=0
;任务栏高度
WinGetPos,,,, h,ahk_class Shell_TrayWnd
;屏幕右下
x2:=A_ScreenWidth
y2:=A_ScreenHeight-h
;OutputDebug %x2%,%y2%
#IfWinActive, ahk_group Desktop
	~LButton::
		KeyWait,LButton
		KeyWait, LButton, d T %WaitTime%+200
		If ! Errorlevel
		{
			MouseGetPos,x,y
			;OutputDebug %x%-%y%
			if (x > 600)
				HideOrShowDesktopIcons()
			Else If DesktopIconsIsHidden()
				HideOrShowDesktopIcons()
		}
	return

	DesktopIconsIsHidden()
	{
		ControlGet, class, Hwnd,, SysListView321, ahk_class Progman
		If class =
			ControlGet, class, Hwnd,, SysListView321, ahk_class WorkerW
		return !DllCall("IsWindowVisible", UInt,class)
	}

	HideOrShowDesktopIcons()
	{
		ControlGet, class, Hwnd,, SysListView321, ahk_class Progman
		If class =
			ControlGet, class, Hwnd,, SysListView321, ahk_class WorkerW
		If DesktopIconsIsHidden()
			WinShow, ahk_id %class%
		Else
			WinHide, ahk_id %class%
	}
