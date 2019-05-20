#IfWinActive,ahk_class D3 Main Window Class 
#SingleInstance force ;只能启动一个ahk程序实例，防止重复启动

SetKeyDelay, 50
SetMouseDelay, 50

masterFlag=0  ;宏控制变量
clickFlag=0 ;控制左键连点的变量

$MButton::  ;鼠标中键为宏开关键
{ 
	if(masterFlag=0){
		masterFlag := 1
		clickFlag := 1
	}else{
		masterFlag := 0
		clickFlag := 0
	}

	if (masterFlag=0) 
	{
		SetTimer, MouseLButton, off  ;关闭左键连点计时器，off不可改动
		SetTimer, Lollipop, off  ;关闭
	}
	else 
	{
		SetTimer, MouseLButton, 50         ;左键连点计时器，会自动拾取
		SetTimer, Lollipop, 50         ;
	}
}
Return 

$d::  ;手动开黑人后，自动开罩子
{ 
	if (masterFlag=1) 
	{
		clickFlag := 1         ;开启黑人后启动左键连点
		send d
		sleep 600
		send d
		SetTimer, closeClick, -20000   ;黑人结束后关闭连点
	}	
}
Return 

$XButton1::  ;开关鼠标连点
{ 
	clickFlag := !clickFlag
}
Return 

closeClick:  ;开关鼠标连点
{ 
	clickFlag := 0
}
Return 

~Enter::  ;回车打字关闭宏
~T::   ;按T回城关闭宏
~E::   ;按E查看技能关闭宏
~B::   ;按B查看装备关闭宏
~M::  ;按M查看悬赏关闭宏
{
	SetTimer, MouseLButton, off  ;关闭左键连点计时器，off不可改动
	SetTimer, Lollipop, off  ;关闭
	masterFlag:=0
}
Return

MouseLButton:   ;左键连点计时器设置
{
	if(clickFlag = 1){
		Click    ;点击鼠标左键，对应主要技能
	}
}

Lollipop:
{
	PixelGetColor, colorH, 848, 1034
	scolor := SubStr(colorH, 3, 1)
	
	if (scolor = 1)
	{
		send s ;s为变身后无脑使用的寒冰轰击的快捷键，可自行修改
	}

	PixelGetColor, colorB, 691, 949
	if (colorB = 0xFFFFFF)           ;判断第一个buff那里是否是白色的（棒棒糖buff20层，那里为白色
	{
		clickFlag := 1
		send d ;d为变身的快捷键，可自行修改
		sleep 600 ;延迟600ms，可自行修改
		send d ;d为变身黑人后罩子的快捷键，可自行修改
		SetTimer, closeClick, -20000
	}
	return
}

~=::Pause  ;宏暂停或继续