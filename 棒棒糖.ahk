#IfWinActive,ahk_class D3 Main Window Class 
#SingleInstance force ;只能启动一个ahk程序实例，防止重复启动

/*暗黑3 棒棒糖AHK宏

1. 鼠标左键连点，可用鼠标第四个键开启或关闭
2. 启动黑人后，自动放罩子，启用鼠标左键连点，黑人结束后，停止左键连点，方便走A
3. 黑人的时候自动连续释放第一个技能，白人的时候停止
5. 按Enter聊天，T回城，S技能，B装备，M地图的时候会自动停止宏
6. 黑人死亡后自动停止左键连点

鼠标中键启动，关闭宏

鼠标第四个键控制鼠标左键连点启动与停止。
 
键位 
1 黑洞 
2 黑人 
3 魔法武器
4 风暴护甲 
鼠标左键 奥数洪流 
鼠标右键 传送 
*/ 

SetKeyDelay, 50
SetMouseDelay, 50

;宏控制变量 0 关闭宏 1 启动宏
masterFlag := 0  
;控制左键连点的变量 0 不点击 1 点击
clickFlag := 0 
;0 白人 1 黑人
blackFalg := 0 

;鼠标中键为宏开关键，可修改为其它键
$MButton::  
{ 
    if(masterFlag=0){
        masterFlag = 1
    }else{
        masterFlag = 0
    }

    if (masterFlag=0) 
    {
        ;关闭左键连点计时器，off不可改动
        SetTimer, MouseLButton, off  
        ;关闭 棒棒糖相关的
        SetTimer, Lollipop, off  
    }
    else 
    {
        ;左键连点计时器，会自动拾取
        SetTimer, MouseLButton, 50   
        ;棒棒糖相关的     
        SetTimer, Lollipop, 50             
    }
}
Return 

;按2键手动开黑人后，自动开罩子
$2::  
{ 
    send 2
    if (masterFlag = 1) 
    {
        ;开启黑人后启动左键连点
        clickFlag = 1         
        blackFalg = 1 
        sleep 600
        send 2
        ;黑人结束后关闭连点
        SetTimer, closeClick, -20000   
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
    blackFalg = 0
}
Return 

~Enter::  ;回车打字关闭宏
~T::   ;按T回城关闭宏
~S::   ;按S查看技能关闭宏
~I::   ;按I查看装备关闭宏
~M::   ;按M查看悬赏关闭宏
{
    SetTimer, MouseLButton, off  ;关闭左键连点计时器，off不可改动
    SetTimer, Lollipop, off  ;关闭
    masterFlag := 0
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
    ;如果 是黑人状态 连续点击 1
    if (blackFalg = 1)
    {
        ;s为变身后无脑使用的寒冰轰击的快捷键，可自行修改
        send 1
    }
}
return
