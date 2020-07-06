#IfWinActive,ahk_class D3 Main Window Class
#SingleInstance force ;只能启动一个ahk程序实例，防止重复启动


; 1追踪箭
; 2烟雾弹
; 3扫射
; 4蓄势待发
; 左键 宠物
; 右键 复仇

; 使用方法，按鼠标中键启动宏，再按一次关闭宏。按住3开始旋转
masterFlag := 0  
; 1为进入烟雾弹状态，0为未进入烟雾弹状态，为1的时候将不会按追踪箭
smokeBombStatus := 0

;监听鼠标中键，按下中键则会执行大括号里面的程序
$MButton::
{ 
    ;程序如果是启动模式，
    ;       则一直检测3号键（扫射）是否按下，
    ;       如果3号键是按下的情况，
    ;           则按一次2（烟雾弹），4（蓄势待发），右键（复仇），并且一直循环按1号键
    ;否则就关闭循环检测3号键是否按下与关闭循环按1号键。
    if(masterFlag=0)
    {
        masterFlag = 1
        SetTimer, CheckThreeState, 300
        SetTimer, ReleaseOne, 1500
        ;4秒放一次烟雾弹
        SetTimer, ReleaseSmokeBomb, 6000
    }else{
        masterFlag = 0
        SetTimer, CheckThreeState, off
        SetTimer, ReleaseOne, off
        SetTimer, ReleaseSmokeBomb, off
    }
}
Return 

;如果3号键是按下的情况，
;      则按一次2（烟雾弹），4（蓄势待发），右键（复仇），并且一直循环按1号键
CheckThreeState:
{
    state := GetKeyState("3", "P")
    If (state = 1)
    {
        ReleaseSkills()
    }
}
return

;按一次2，4，右键
ReleaseSkills()
{
    Send 4
    Click, Right
}
return

;检测3号键释放是按下的
;   如果3号键是按下的，则按一次1号键
;   否则啥也不做。
ReleaseOne:
{
    ;获取3号键的状态，如果是按下的情况，且烟雾弹状态为0
    ;   则按1号键发射追踪箭
    state := GetKeyState("3", "P")
    If (state = 1 && smokeBombStatus = 0)
    {
        Send 1
    }
}

; 按2号键释放烟雾弹，并把烟雾弹状态改为1，1秒后重置为0
ReleaseSmokeBomb:
{
    state := GetKeyState("3", "P")
    If (state = 1)
    {
        Send 2
        smokeBombStatus = 1
        SetTimer, SetSmokeBombStatusZero, -1000
    }
}

;把烟雾弹状态置为0
SetSmokeBombStatusZero:
{
    smokeBombStatus = 0
}
