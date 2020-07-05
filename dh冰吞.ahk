#IfWinActive,ahk_class D3 Main Window Class
#SingleInstance force ;只能启动一个ahk程序实例，防止重复启动


; 1追踪箭
; 2烟雾弹
; 3扫射
; 4蓄势待发
; 左键 宠物
; 右键 复仇

; 使用方法，按鼠标中键启动宏，按住3开始
masterFlag := 0  

$MButton::
{ 
    if(masterFlag=0)
    {
        masterFlag = 1
        SetTimer, CheckThreeState, 300
        SetTimer, ReleaseOne, 1500
    }else{
        masterFlag = 0
        SetTimer, CheckThreeState, off
        SetTimer, ReleaseOne, off
    }
}
Return 

CheckThreeState:
{
    state := GetKeyState("3", "P")
    If (state = 1)
    {
        SetTimer, ReleaseOne, 1500
        ReleaseSkills()
    } else
    {
        SetTimer, ReleaseOne, off
    }
    
}
return

ReleaseSkills()
{
    Send 2
    Send 4
    Click, Right
}
return

ReleaseOne:
{
    Send 1
}
