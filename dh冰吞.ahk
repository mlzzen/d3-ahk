#IfWinActive,ahk_class D3 Main Window Class
#SingleInstance force ;只能启动一个ahk程序实例，防止重复启动


; 1追踪箭
; 2烟雾弹
; 3扫射
; 4蓄势待发
; 左键 宠物
; 右键 复仇

; 使用方法，按鼠标中键启动宏，按住3开始


$MButton::
{ 
    SetTimer, CheckThreeState, 300 ;检测3键状态，如果为抬起就停止
}
Return 

CheckThreeState:
{
    state := GetKeyState("3", "P")
    If (state = 1)
    {
        ReleaseSkills()
    }
    
}
return

ReleaseSkills()
{
    Send 1
    Send 2
    Send 4
    Click, Right
}
return