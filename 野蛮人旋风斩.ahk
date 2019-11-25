#IfWinActive,ahk_class D3 Main Window Class
#SingleInstance force ;只能启动一个ahk程序实例，防止重复启动


; 1技能冲锋
; 4技能赛亚人

SetKeyDelay, 50
SetMouseDelay, 50
;宏控制变量
masterFlag := 0  

$MButton::  ;鼠标中键为宏开关键，可修改为其它键
{ 
    if(masterFlag=0){
        masterFlag = 1
    }else{
        masterFlag = 0
    }

    if (masterFlag=0) 
    {
        SetTimer, ReleaseFirstSkills, off
        SetTimer, ReleaseFourthSkills, off
    }
    else 
    {
        Send 1
        Send 4
        SetTimer, ReleaseFirstSkills, 6000
        SetTimer, ReleaseFourthSkills, 1000
    }
}
Return 

~Enter::  ;回车打字关闭宏
~T::   ;按T回城关闭宏
~S::   ;按S查看技能关闭宏
~B::   ;按B查看装备关闭宏
~M::   ;按M查看悬赏关闭宏
{
    SetTimer, ReleaseFirstSkills, off  ;关闭循环释放1技能
    SetTimer, ReleaseFourthSkills, off ;关闭循环释放4技能
    masterFlag = 0
}
Return

ReleaseFirstSkills:
{
    Send 1 ;释放1技能
}
return

ReleaseFourthSkills:
{
    Send 4 ;释放4技能
}
return

~=::Pause  ;宏暂停或继续