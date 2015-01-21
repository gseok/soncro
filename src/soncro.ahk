#NoEnv ; 변수명이 환경변수인지 체크하는걸 무시, 스크립트 속도 상승과 환경변수 혼동으로 인한 버그 방지
; 컴파일시 그림파일을 실행파일에 저장
FileInstall, res\640x480\addgiftokbt.bmp, %A_Temp%\addgiftokbt.bmp, 1
FileInstall, res\640x480\addgiftview.bmp, %A_Temp%\addgiftview.bmp, 1
FileInstall, res\640x480\bearitem.bmp, %A_Temp%\bearitem.bmp, 1
FileInstall, res\640x480\bearitem2.bmp, %A_Temp%\bearitem2.bmp, 1
FileInstall, res\640x480\bearitem3.bmp, %A_Temp%\bearitem3.bmp, 1
FileInstall, res\640x480\beforegameresultok.bmp, %A_Temp%\beforegameresultok.bmp, 1
FileInstall, res\640x480\beforegameresultview.bmp, %A_Temp%\beforegameresultview.bmp, 1
FileInstall, res\640x480\bluestackview.bmp, %A_Temp%\bluestackview.bmp, 1
FileInstall, res\640x480\buybutton.bmp, %A_Temp%\buybutton.bmp, 1
FileInstall, res\640x480\dailygiftpopupview.bmp, %A_Temp%\dailygiftpopupview.bmp, 1
FileInstall, res\640x480\episode1main.bmp, %A_Temp%\episode1main.bmp, 1
FileInstall, res\640x480\episodemapbutton.bmp, %A_Temp%\episodemapbutton.bmp, 1
FileInstall, res\640x480\expItem.bmp, %A_Temp%\expItem.bmp, 1
FileInstall, res\640x480\giftpopupokbutton.bmp, %A_Temp%\giftpopupokbutton.bmp, 1
FileInstall, res\640x480\networkstop.bmp, %A_Temp%\networkstop.bmp, 1
FileInstall, res\640x480\networkstopokbutton.bmp, %A_Temp%\networkstopokbutton.bmp, 1
FileInstall, res\640x480\notiCloseBt.bmp, %A_Temp%\notiCloseBt.bmp, 1
FileInstall, res\640x480\runitemstoreview.bmp, %A_Temp%\runitemstoreview.bmp, 1
FileInstall, res\640x480\runresultboxok.bmp, %A_Temp%\runresultboxok.bmp, 1
FileInstall, res\640x480\runresultboxopen.bmp, %A_Temp%\runresultboxopen.bmp, 1
FileInstall, res\640x480\runresultboxview.bmp, %A_Temp%\runresultboxview.bmp, 1
FileInstall, res\640x480\runresultboxview2.bmp, %A_Temp%\runresultboxview2.bmp, 1
FileInstall, res\640x480\runresultokbutton.bmp, %A_Temp%\runresultokbutton.bmp, 1
FileInstall, res\640x480\runresultview.bmp, %A_Temp%\runresultview.bmp, 1
FileInstall, res\640x480\startgamebutton.bmp, %A_Temp%\startgamebutton.bmp, 1
FileInstall, res\640x480\startgamebutton2.bmp, %A_Temp%\startgamebutton2.bmp, 1
FileInstall, res\640x480\touchbearview.bmp, %A_Temp%\touchbearview.bmp, 1
FileInstall, res\640x480\unknownbutton.bmp, %A_Temp%\unknownbutton.bmp, 1
FileInstall, res\640x480\unknownbutton2.bmp, %A_Temp%\unknownbutton2.bmp, 1
FileInstall, res\640x480\lankchangeview.bmp, %A_Temp%\lankchangeview.bmp, 1
FileInstall, res\640x480\lankchangeok.bmp, %A_Temp%\lankchangeok.bmp, 1
FileInstall, res\640x480\sendlifeview.bmp, %A_Temp%\sendlifeview.bmp, 1
FileInstall, res\640x480\sendlifeok.bmp, %A_Temp%\sendlifeok.bmp, 1

/*
	util function 
*/
DebugMessage(str)
{
 global h_stdout
 DebugConsoleInitialize()  ; start console window if not yet started
 str .= "`n" ; add line feed
 DllCall("WriteFile", "uint", h_Stdout, "uint", &str, "uint", StrLen(str), "uint*", BytesWritten, "uint", NULL) ; write into the console
 WinSet, Bottom,, ahk_id %h_stout%  ; keep console on bottom
}

DebugConsoleInitialize()
{
   global h_Stdout     ; Handle for console
   static is_open = 0  ; toogle whether opened before
   if (is_open = 1)     ; yes, so don't open again
     return
	 
   is_open := 1	
   ; two calls to open, no error check (it's debug, so you know what you are doing)
   DllCall("AttachConsole", int, -1, int)
   DllCall("AllocConsole", int)

   dllcall("SetConsoleTitle", "str","Paddy Debug Console")    ; Set the name. Example. Probably could use a_scriptname here 
   h_Stdout := DllCall("GetStdHandle", "int", -11) ; get the handle
   WinSet, Bottom,, ahk_id %h_stout%      ; make sure it's on the bottom
   WinActivate,Lightroom   ; Application specific; I need to make sure this application is running in the foreground. YMMV
   return
}

/*
	global variable
*/
mainView = "mainView"
runItemStoreView = "runItemStoreView"
runView = "runView"
runResultView = "runResultView"
runResultBoxView = "runResultBoxView"
networkStopView = "networkStopView"
beforeGameResultView = "beforeGameResultView"
bluestackMainView = "bluestackMainView"
notiView = "notiView"
dailygiftpopupview = "dailyGiftPopupView"
addgiftview = "addgiftview"
touchBearView = "touchBearView"
lankChangeView = "lankChangeView"
sendLifeView = "sendLifeView"
currentView := mainView
jumpX = 25
jumpY = 410
jumpRandomX = 25
jumpRandomY = 410
; gui option values
opRunViewWaitTime = 360 ; run view wait time, default 360 (6min)
opBuyExpItem = 0 ; default not checked
opAutoJump = 0 ; default not checked

/*
	GUI
*/
showSoncroDialog()
{
	global

	;; create soncro GUI ;;
	; add title
	Gui, Add, Text, w150 Center, hello cookierun soncro!
	
	;; WAIT TIME option GUI ;;
	; run view waitTime
	Gui, Add, Text,, "Run View Wait Time(sec): "
	Gui, Add, Edit
	Gui, Add, UpDown, vopRunViewWaitTime Range60-600, %opRunViewWaitTime%
	
	;; ITEM option GUI ;;
	Gui, Add, Text,, "Buy Item"
	Gui, Add, Checkbox, vopBuyExpItem, "ITEM Exp"
	
	;; Auto jump option GUI ;;
	Gui, Add, Text,, "Auto Jump"
	Gui, Add, Checkbox, vopAutoJump, "Auto Jump"
	
	;; game button
	; add run button
	Gui, Add, Button, Default, RUN
	
	; show soncro dialog
	Gui, Show, w200 h200, Soncro
	return
	
	;; event handler ;;
	; RUN button click
	ButtonRUN:
		DebugMessage( "RUN click" )
		Gui, Submit
		runSoncro()
		return
		
	; windows title x button click
	GuiClose:
		exitapp
}

/*
	wait time
*/
waitTime( sec, noMessage )
{
	if ( noMessage != true )
	{
		DebugMessage( "wait " sec "sec..." )
	}
	
	; sleep time sec
	time = % sec * 1000
	sleep %time%

	if ( noMessage != true )
	{	
		DebugMessage( "wait " sec "sec... complete" )
	}
}


/*
	common click function
*/
commonClick( message, targetImg, wMin, wMax, hMin, hMax )
{
	DebugMessage( message )

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *50 %A_Temp%\%targetImg%
	if ( ErrorLevel = 0 )
	{
		Random, n, wMin, wMax
		FoundX := ( FoundX + n )
		
		Random, n, hMin, hMax
		FoundY := ( FoundY + n )

		Click %FoundX% %FoundY%

		DebugMessage( "X> " FoundX ", Y> " FoundY )
		waitTime( 5, true )
	}
}

commonClickNoImage( message, x, y, wMin, wMax, hMin, hMax )
{
	DebugMessage( message )
	
	Random, n, wMin, wMax
	x := ( x + n )
	
	Random, n, hMin, hMax
	y := ( y + n )
	
	Click %x% %y%
	
	DebugMessage( "X> " x ", Y> " y )
	waitTime( 5, true )	
}

/*
	update current view
*/
updateCurrnetView()
{
    global

	DebugMessage( "updateCurrnetView is called" )

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\episode1main.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := mainView
		DebugMessage( "current view > main" )
		waitTime( 5, true )
		return
	}

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\runresultview.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := runResultView
		DebugMessage( "current view > run result" )
		waitTime( 5, true )
		return
	}

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\runitemstoreview.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := runItemStoreView
		DebugMessage( "current view > run item store" )
		waitTime( 5, true )
		return
	}
	
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\runresultboxview.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := runResultBoxView
		DebugMessage( "current view > run result box view" )
		waitTime( 5, true )
		return
	}

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\runresultboxview2.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := runResultBoxView
		DebugMessage( "current view > run result box view2" )
		waitTime( 5, true )
		return
	}
	
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\networkstop.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := networkStopView
		DebugMessage( "current view > network stop view" )
		waitTime( 5, true )
		return
	}

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\bluestackview.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := bluestackMainView
		DebugMessage( "current view > blue stack view" )
		waitTime( 5, true )
		return
	}

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\notiCloseBt.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := notiView
		DebugMessage( "current view > cookie run noti view" )
		waitTime( 5, true )
		return
	}
	
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\dailygiftpopupview.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := dailygiftpopupview
		DebugMessage( "current view > cookie run dailygiftpopup view" )
		waitTime( 5, true )
		return
	}

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\addgiftview.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := addgiftview
		DebugMessage( "current view > cookie run addgift view" )
		waitTime( 5, true )
		return
	}
	
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\beforegameresultview.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := beforeGameResultView
		DebugMessage( "current view > beforeGameResultView" )
		waitTime( 5, true )
		return
	}

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\touchbearview.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := touchBearView
		DebugMessage( "current view > touchBearView" )
		waitTime( 5, true )
		return
	}
	
	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\lankchangeview.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := lankChangeView
		DebugMessage( "current view > lankChangeView" )
		waitTime( 5, true )
		return
	}

	ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, %A_Temp%\sendlifeview.bmp
	if ( ErrorLevel = 0 )
	{
		currentView := sendLifeView
		DebugMessage( "current view > sendLifeView" )
		waitTime( 5, true )
		return
	}
	currentView := runView
}


/*
	start app player window
*/
runAppPlayer()
{
	WinWait, BlueStacks App Player,
	IfWinNotActive, BlueStacks App Player, , WinActivate, BlueStacks App Player, 
	WinWaitActive, BlueStacks App Player, 
	waitTime( 1, true )
}


/*
	click cookie start game button
*/
clickStartGameButton()
{
	message := "clickStartGameButton is called"
	commonClick( message, "startgamebutton.bmp", 45, 75, 5, 20 )
	commonClick( message, "startgamebutton2.bmp", 45, 75, 5, 20 )
}

/*
	click network ok button
*/
clickNetworkOkButton()
{
	message := "clickNetworkOkButton is called"
	commonClick( message, "networkstopokbutton.bmp", 5, 40, 5, 20 )
}

/*
	click result view ok button
*/
clickResultOkButton()
{
	message := "clickResultOkButton is called"
	commonClick( message, "runresultokbutton.bmp", 5, 40, 5, 20 )
}

/*
	click result box view box open and ok button
*/
clickResultBoxOpenAndOkButton()
{
	message := "clickResultBoxOpenAndOkButton is called"
	commonClick( message, "runresultboxopen.bmp", 20, 80, 5, 20 )

	message := "Result Box Ok Button is called"
	commonClick( message, "runresultboxok.bmp", 10, 50, 5, 20 )
}

/*
	buy exp item
*/
buyExpItem()
{
	DebugMessage( "buyExpItem is called" )
	
	message := "exp item select"
	commonClick( message, "expItem.bmp", 5, 10, 5, 10 )

	message := "buy button click"
	commonClick( message, "buybutton.bmp", 5, 20, 5, 20 )
	
	return
}

/*
	click cookierun
*/
clickCookieRun()
{	
	message := "clickCookieRun is called"
	commonClick( message, "bluestackview.bmp", 20, 80, 20, 80 )

	return
}

/*
	click noti close
*/
clickNotiClose()
{
	message := "clickNotiClose is called"
	commonClick( message, "notiCloseBt.bmp", 2, 20, 2, 20 )

	return
}

/*
	click gift popup close
*/
clickGiftPopupClose()
{
	message := "clickGiftPopupClose is called"
	commonClick( message, "giftpopupokbutton.bmp", 2, 50, 2, 30 )

	return
}

/*
	click add gift popup close
*/
clickAddGiftPopupClose()
{
	message := "clickAddGiftPopupClose is called"
	commonClick( message, "addgiftokbt.bmp", 2, 50, 2, 30 )

	return
}

jump()
{
	global
	Random, n, 1, 20
	jumpRandomX := ( jumpX + n )
	jumpRandomY := ( jumpY + n )
	MouseClick, left,%jumpRandomX%, %jumpRandomY%,,, D
	Sleep 350
	MouseClick, left,%jumpRandomX%, %jumpRandomY%,,, U
}

checkUnknownOkButton()
{
	global
	DebugMessage( "clickUnknownOkButton is called" )

	message := "find unknown button"
	commonClick( message, "unknownokbutton.bmp", 45, 75, 5, 20 )
	
	message := "find unknown button2"
	commonClick( message, "unknownokbutton2.bmp", 2, 20, 2, 20 )

	; using coordinate
	message := "unknown button coordinate 1"
	commonClickNoImage( message, 295, 415, 0, 5, 0, 5 )
	
	message := "unknown button coordinate 2" ; time gift
	commonClickNoImage( message, 290, 380, 0, 5, 0, 5 )
	
	message := "unknown button coordinate 3" ; message box
	commonClickNoImage( message, 300, 315, 0, 5, 0, 5 )
}

touchBear()
{
	global
	DebugMessage( "touchBear is called" )

	message := "bear click"
	commonClick( message, "bearitem.bmp", 45, 75, 5, 20 )

	message := "bear click2"
	commonClick( message, "bearitem2.bmp", 45, 75, 5, 20 )

	message := "bear click3"
	commonClick( message, "bearitem3.bmp", 45, 75, 5, 20 )
}

/*
	auto jump
*/
autoJump()
{
	global
	i = 0
	jumpCnt := % opRunViewWaitTime / 1.35 ; auto's one jump 1.35sec
	jumpCnt := Round( jumpCnt )
	
	Loop
	{
		jump() ; sleep 350
		sleep 150
		jump() ; sleep 350
		
		sleep 500
		i := i + 1
		if ( i = jumpCnt )
		{
			return
		}
	}
}

/*
	start soncro
*/
runSoncro()
{
	global

	message = "soncro start"
	DebugMessage( message )
	
	; loop
	Loop
	{
		; active app player window
		runAppPlayer()

		; check current view
		updateCurrnetView()
		
		if ( currentView = mainView )
		{
			; current view is main then
			; move to run item store view
			message := "click game start button in Main View"
			commonClick( message, "startgamebutton.bmp", 45, 75, 5, 20 )
		}
		else if ( currentView = runItemStoreView )
		{
			; buy exp item			
			if ( opBuyExpItem = 1 )
			{
				DebugMessage( "buy exp item" )
				buyExpItem()
			}
			else if ( opBuyExpItem = 0 )
			{
				DebugMessage( "don't buy exp item" )
			}
			
			; current view is run item store then
			; start game
			clickStartGameButton()
			DebugMessage( "running... play episod1" )

			; wait game end
			if ( opAutoJump = 1 )
			{
				autoJump()
			}
			else if ( opAutoJump = 0 )
			{
				waitTime( opRunViewWaitTime, false )
			}
		}
		else if ( currentView = runResultView )
		{
			; current view is run result then
			; result ok
			clickResultOkButton()
			
			; wait result complete, 20sec
			waitTime( 20, false )
			
			; heart charging wait
			DebugMessage( "heart charging wait" )
			waitTime( 120, false )
		}
		else if ( currentView = runResultBoxView )
		{
			; box open and ok
			clickResultBoxOpenAndOkButton()
			
			; wait result complete, 20sec
			waitTime( 20, false )
		}
		else if ( currentView = networkStopView )
		{
			; network ok button
			clickNetworkOkButton()
			
			; wait 10 sec
			waitTime( 10, false )
		}
		else if ( currentView = bluestackMainView )
		{
			; start cookierun
			clickCookieRun()
			
			; wait 20 sec
			waitTime( 30, false )
		}
		else if ( currentView = notiView )
		{
			; close noti popup
			clickNotiClose()
			
			; wait 10 sec
			waitTime( 10, false )
		}
		else if ( currentView = dailygiftpopupview )
		{
			; close popup
			clickGiftPopupClose()
			
			; wait 10 sec
			waitTime( 10, false )
		}
		else if ( currentView = addgiftview )
		{
			; close popup
			clickAddGiftPopupClose()
			
			; wait 10 sec
			waitTime( 10, false )
		}
		else if ( currentView = beforeGameResultView )
		{
			; before game result ok
			commonClick( "before game result ok", "beforegameresultok.bmp", 5, 60, 5, 35 )

			; wait 10 sec
			waitTime( 10, false )
		}
		else if ( currentView = touchBearView )
		{
			; before game result ok
			touchBear()

			; wait 3 sec
			waitTime( 3, false )
		}
		else if ( currentView = lankChangeView )
		{
			; lank change ok
			commonClick( "click lank change ok", "lankchangeok.bmp", 5, 40, 5, 20 )

			; wait 10 sec
			waitTime( 10, false )
		}
		else if ( currentView = sendLifeView )
		{
			; send life ok
			commonClick( "click send life ok", "sendlifeok.bmp", 5, 50, 5, 20 ) 
			
			; wait 10 sec
			waitTime( 10, false )
		}
		else
		{
			; check unknown button
			checkUnknownOkButton()

			; wait 10 sec
			waitTime( 10, false )
		}
	}

	DebugMessage( "soncro end.." )
}

/*
	start
*/
showSoncroDialog()
