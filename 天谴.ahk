#IfWinActive,ahk_class D3 Main Window Class
#SingleInstance force ;只能启动一个ahk程序实例，防止重复启动


SetKeyDelay, 50
SetMouseDelay, 50
;宏控制变量
masterFlag := 0  
;控制天谴 挑衅 律法的
tianQianFlag := 0 
;控制左键连点的变量
clickFlag := 0 
;控制勇士变身的
warriorFlag :=0
;强制移动
forceMove := 1
tempMove := 1

$MButton::  ;鼠标中键为宏开关键，可修改为其它键
{ 
	if(masterFlag=0){
		masterFlag = 1
        tianQianFlag = 1 
		clickFlag = 1
		warriorFlag = 1
	}else{
		masterFlag = 0
        tianQianFlag = 0
		warriorFlag = 0
	}

	if (masterFlag=0) 
	{
		SetTimer, TianQian, off  ;关闭
		SetTimer, MouseLButton, off
		SetTimer, Warrior, off
	}
	else 
	{
		SetTimer, TianQian, 300
		SetTimer, MouseLButton, 50
		SetTimer, Warrior, 50
	}
}
Return 

$1::  ;按1键跑马后 停止自动天谴循环直到跑马结束
{ 
    Send 1
    tianQianFlag = 0
	;上马后 鼠标连点 改为强制移动
	tempMove := forceMove
	forceMove := 1
    SetTimer, openTianQian, -2000   ;跑马完自动开启天谴
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

; 开启天谴
openTianQian:
{ 
	tianQianFlag = 1
	forceMove := tempMove
    Return 
}

MouseLButton:   ;左键连点计时器设置
{
	if(clickFlag = 1){
		if(forceMove = 1)
		{
			send h   ;点击强制移动键
		}
		else
		{
			Click
		}
	}
}
Return


~Enter::  ;回车打字关闭宏
~T::   ;按T回城关闭宏
~S::   ;按S查看技能关闭宏
~B::   ;按B查看装备关闭宏
~M::   ;按M查看悬赏关闭宏
{
	SetTimer, TianQian, off  ;关闭
	SetTimer, MouseLButton, off  ;关闭
	masterFlag = 0
}
Return

; 天谴相关
TianQian:
{
    If (tianQianFlag = 1)
    {
        Send 2
        Send 3
        Send 4
    }
}
return

;勇士变身连点
Warrior:
{
	if(warriorFlag = 1)
	{
		Click, , right
	}

}
return

;切换 强制移动与左键连点
Shift::
{
	if(forceMove = 1)
	{
		forceMove = 0
	}
	else
	{
		forceMove = 1
	}
}
return

~=::Pause  ;宏暂停或继续