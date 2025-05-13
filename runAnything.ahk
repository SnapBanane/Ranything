#SingleInstance force

lastCtrlTime := 0
ctrlTapCount := 0
ctrlTapTimerRunning := false

~Ctrl up::
{
    now := A_TickCount
    elapsed := now - lastCtrlTime
    lastCtrlTime := now

    ; If more than 300ms passed, reset tap count
    if (elapsed > 300) {
        ctrlTapCount := 0
    }

    ctrlTapCount += 1

    ; Ignore if more than 2 taps
    if (ctrlTapCount > 2)
        return

    ; Start/reset 1s timer to clear state
    SetTimer, ResetCtrlTap, -1000
    ctrlTapTimerRunning := true

    ; Trigger GUI if second tap within 300ms
    if (ctrlTapCount = 2) {
        ctrlTapCount := 99  ; prevent further triggers until reset
        ShowInputGui()
    }
}
return

ResetCtrlTap:
ctrlTapCount := 0
ctrlTapTimerRunning := false
return

ShowInputGui() {
    global
    Gui, Destroy
    Gui, -Caption +AlwaysOnTop
    Gui, Font, s10, Segoe UI
    Gui, Margin, 1, 1
    Gui, Color, F2F2F2
    Gui, Add, Edit, vUserInput w250 h25
    Gui, Show, w270 h40
    WinSet, Region, 0-0 w270 h40 R20-20
}

~Enter::
    Gui, Submit
    UserInput := Trim(UserInput)

    if (UserInput = "") {
        return
    } else if (SubStr(UserInput, 1, 3) = "cmd") {
        CmdInput := SubStr(UserInput, 5)
        Run, % "cmd.exe /K " CmdInput
    } else if (SubStr(UserInput, 1, 3) = "gpt") {
        GptQuery := SubStr(UserInput, 5)
        Run, https://chat.openai.com/?q=%GptQuery%
    } else if (UserInput = "shut") {
        Run, %ComSpec% /C shutdown /s /t 0, , Hide
    } else if (UserInput = "pen") {
        Run, "C:\Users\Julius\Documents\_DevDrive\Weylus\weylus.exe"
    } else if (UserInput = "gh" ) {
        Run, https://github.com/SnapBanane    
    } else {
        Run, https://www.google.com/search?q=%UserInput%
    }

    Gui, Destroy
    ctrlTapCount := 0
    ctrlTapTimerRunning := false

    UserInput := ""
    GptQuery := ""
    CmdInput := ""
return
