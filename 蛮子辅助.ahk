#IfWinActive,ahk_class D3 Main Window Class
#SingleInstance force ;只能启动一个ahk程序实例，防止重复启动


SetKeyDelay, 50
SetMouseDelay, 50
;宏控制变量
masterFlag := 0  
;控制释放技能的
autoClickFlag := 0 
;控制左键连点的变量
clickFlag := 0 

$MButton::  ;鼠标中键为宏开关键，可修改为其它键
{ 
    if(masterFlag=0){
        masterFlag = 1
        autoClickFlag = 1 
        clickFlag = 1
    }else{
        masterFlag = 0
        autoClickFlag = 0
    }

    if (masterFlag=0) 
    {
        SetTimer, ReleasesSkills, off  ;关闭
        SetTimer, MouseLButton, off
    }
    else 
    {
        SetTimer, ReleasesSkills, 1000
        SetTimer, MouseLButton, 50
    }
}
Return 

$XButton1::  ;开关鼠标连点，键时鼠标第四键，可修改
{ 
    clickFlag = !clickFlag
}
Return 

closeClick:  ;开关鼠标连点
{ 
    clickFlag = 0
}
Return 

MouseLButton:   ;左键连点计时器设置
{
    if(clickFlag = 1){
        send h   ;点击强制移动键
    }
}
Return


~Enter::  ;回车打字关闭宏
~T::   ;按T回城关闭宏
~S::   ;按S查看技能关闭宏
~B::   ;按B查看装备关闭宏
~M::   ;按M查看悬赏关闭宏
{
    SetTimer, ReleasesSkills, off  ;关闭
    SetTimer, MouseLButton, off  ;关闭
    masterFlag = 0
}
Return

ReleasesSkills:
{
    If (autoClickFlag = 1)
    {
        Send 2
        Send 4
        Click, , right
    }
}
return

~=::Pause  ;宏暂停或继续