;设置按键和鼠标点击的随机延时
ClickDelay()
{
	return Random(175,200)
}
;设置退出游戏的随机延时
QuitDelay()
{
	return Random(200,300)
}
;设置创建游戏的随机延时,不用对话框的时候用这个设置delay
CreateDelay()
{
	return Random(1500,2000)
}
;设置加入游戏的随机延时
JoinDelay()
{
	return Random(200,300)
}
;设置切换窗口的随机延时
SwitchDelay()
{
	return Random(200,300)
}
;设置游戏末位更新，取各位数字
GetNumber(x)
{
	x++
	return SubStr(String(x), -1)
}
;创建游戏，需要有原来游戏设置，并且末位更新，0-9循环
CreateGame(num)
{
	Click Random(1400,1550),Random(170,180)
	Sleep ClickDelay()
	Send "{Backspace}"
	Sleep ClickDelay()
	Send num
	Sleep ClickDelay()
	Click Random(1420,1525),Random(655,680)
}
;加入游戏
JoinGame(num)
{
	Click Random(1300,1430),Random(145,155)
	Sleep ClickDelay()
	Send "{Backspace}"
	Sleep ClickDelay()
	Send num
	Sleep ClickDelay()
	Click Random(1425,1510),Random(660,685)
}

;退出游戏
ExitGame()
{
   	Send "{Esc}"
	Sleep QuitDelay()
	Click Random(900,1010),Random(460,485)  ;储存并离开游戏按钮的鼠标点击范围
}


#HotIf WinActive("ahk_exe D2R.exe")  ;热键仅对D2R游戏窗口生效
global count
count := 0
;F1一键加游戏
F1::
{
	global count
	gamenumber :=GetNumber(count)
	main_id := WinActive("ahk_exe D2R.exe")
	other_ids := WinGetList("ahk_exe D2R.exe")
	CreateGame(gamenumber)
	result := MsgBox(("Game ready now?"),,4 )
	if (result = "Yes")
	{
		for this_id in other_ids
		{
			if (this_id = main_id)
				continue
			WinActivate this_id
			Sleep SwitchDelay()
			ExitGame()
			Sleep QuitDelay()
		}
		for this_id in other_ids
		{
			if (this_id = main_id)
				continue
			WinActivate this_id
			Sleep SwitchDelay()
			JoinGame(gamenumber)
			Sleep JoinDelay()
		}
	}
	WinActivate main_id
	count++
}
;F4退游戏
F4::
{
	ExitGame()
}

