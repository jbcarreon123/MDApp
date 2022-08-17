/*
	
	███╗░░░███╗██████╗░░█████╗░██████╗░██████╗░  ░░███╗░░░░░░█████╗░░░░░█████╗░
	████╗░████║██╔══██╗██╔══██╗██╔══██╗██╔══██╗  ░████║░░░░░██╔══██╗░░░██╔══██╗
	██╔████╔██║██║░░██║███████║██████╔╝██████╔╝  ██╔██║░░░░░██║░░██║░░░██║░░██║
	██║╚██╔╝██║██║░░██║██╔══██║██╔═══╝░██╔═══╝░  ╚═╝██║░░░░░██║░░██║░░░██║░░██║
	██║░╚═╝░██║██████╔╝██║░░██║██║░░░░░██║░░░░░  ███████╗██╗╚█████╔╝██╗╚█████╔╝ made by
	╚═╝░░░░░╚═╝╚═════╝░╚═╝░░╚═╝╚═╝░░░░░╚═╝░░░░░  ╚══════╝╚═╝░╚════╝░╚═╝░╚════╝░ jbcarreon123
	
	This uses a modified version of Macro-Deck-Web, Neutron.ahk.
	
	https://github.com/jbcarreon123/MDApp
*/

PID := DllCall("GetCurrentProcessId")
SysGet, NumMons, MonitorCount
#Include Neutron.ahk

#NoEnv
SetBatchLines, -1
CoordMode, Mouse, Screen

Gui, Conf:Add, Text, x12 y9 w320 h30 , Drag this on the window you want to use Macro Deck on and press OK.
Gui, Conf:Add, Button, gOK x202 y39 w130 h30 , OK
Gui, Conf:Show, w350 h80, MDApp
return

OK:
Loop, % NumMons {
	SysGet, Mon%a_index%, MonitorWorkArea, %a_index%
	WinGetPos, x, y, w, h, ahk_pid %PID%
	If (x > Mon%a_index%Left && x < Mon%a_index%Right && y > Mon%a_index%Top && y < Mon%a_index%Bottom)
		M := A_Index
}

title = Macro Deck WebClient Program

URLDownloadToFile, https://github.com/jbcarreon123/MDApp/archive/refs/heads/dev/update-to-2.1.4.zip, %A_Temp%\mdweb.zip
RunWait cmd.exe /c mkdir %A_Temp%\mdweb,
RunWait PowerShell.exe -Command Expand-Archive -LiteralPath '%A_Temp%\mdweb.zip' -DestinationPath '%A_Temp%\mdweb',, Hide

name := new NeutronWindow()
name.Load(A_Temp . "\mdweb\MDApp-dev-update-to-2.1.4\index.html")

name.Show(Center "x" x " y" y " w" A_ScreenWidth " h" A_ScreenHeight)
return

Clicked(neutron, event)
{
	if (event.target.innerText = "Exit")
		ExitApp
	else {
		Gui, About:Color, 2D2D2D, 2D2D2D
		Gui, About:Font, S64 CFFFFFF, Tahoma
		Gui, About:Add, Text, x12 y9 w490 h110 , MDApp 1.0.0
		Gui, About:Font, S12 CFFFFFF, Tahoma
		Gui, About:Add, Text, x502 y79 w100 h40 , by`njbcarreon123
		Gui, About:Add, Text, x-28 y-71 w50 h110 , Text
		Gui, About:Add, Button, gaOK x502 y159 w100 h30 , OK
		Gui, About:Add, Button, gGitHub x402 y159 w100 h30 , GitHub
		Gui, About:Add, Button, gMDDiscord x302 y159 w100 h30 , MD Discord
		Gui, About:Add, Text, x22 y129 w580 h20 , Idea by ABloop#0612 and Lucas Niesen#2781 in the Macro Deck Discord Server
		; Generated using SmartGUI Creator for SciTE
		Gui, About:Show, w619 h199, MDApp
		return
		
		AboutGuiClose:
		Gui, About:Destroy
		return
		
		aOK:
		Gui, About:Destroy
		return
		
		GitHub:
		Run, "https://github.com/jbcarreon123/MDWeb"
		return
		
		MDDiscord:
		Run, "https://discord.gg/AG3TeP9pAs"
		return
	}
}

#If WinActive("ahk_pid " PID)
!F4::return
#If

ConfGuiClose:
ExitApp
return