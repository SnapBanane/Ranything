#SingleInstance force  ; Only allow one instance of the script to run

~Ctrl:: ; This captures the Ctrl key
    if (A_PriorHotkey = "~Ctrl" and A_TimeSincePriorHotkey < 200) { ; Check if Ctrl is pressed twice within 200 ms
        ; Create the input box with a fixed gray outline
        Gui, Add, Edit, vUserInput w250 h25,  ; Create an editable input box with gray outline (Border)

        ; Customize the appearance of the window to look clean and Apple-like
        Gui, -Caption  ; Remove the window title
        Gui, Font,, Segoe UI  ; Set the font to Segoe UI
        Gui, Margin, 1, 1

        Gui, Color, F2F2F2  ; Light gray background color
        Gui, Show, w270 h40,  ; Show the GUI with a default size initially
        WinSet, Region, 0-0 w270, h40 R20-20
        ; Flag to track that Ctrl double-press has happened
        ctrlPressed := true
        return
    }
return

~Enter:: ; Submit when Enter is pressed
    if (ctrlPressed) { ; Only submit if Ctrl was pressed twice
        Gui, Submit  ; Save the input value to the variable
        UserInput := UserInput  ; Store the value in the variable

        ; Trim any extra spaces
        StringTrimRight, UserInput, UserInput, 0

        ; Dynamically calculate the height based on the content
        StringLen, textLength, UserInput
        linesRequired := Ceil(textLength / 30)  ; Assuming 30 characters per line
        GuiHeight := Max(80, 25 + (linesRequired * 30))  ; Dynamically adjust height based on lines

        ; Show the GUI with the calculated height
        Gui, Show, w250 h%GuiHeight%,  ; Adjust the height of the window accordingly

        ; Check the input prefix and perform actions accordingly
        if (SubStr(UserInput, 1, 3) = "cmd") { ; If input starts with "cmd"
            CmdInput := SubStr(UserInput, 5) ; Remove "cmd "
            Run, % "cmd.exe /K " CmdInput
        }
        else if (UserInput = "") { ; If input is empty (just Enter pressed)
            MsgBox, Please enter something to search.
        }
        else if (SubStr(UserInput, 1, 3) = "gpt") { ; If input starts with "gpt"
            GptQuery := SubStr(UserInput, 5)
            Run, https://chat.openai.com/?q=%GptQuery%  ; Open ChatGPT with the query
        }
        else if (UserInput = "shut") { ; If input is "shut"
            Run, %ComSpec% /C shutdown /s /t 0, , Hide  ; Execute immediate shutdown
        }
        else { ; If input is a search term, search it on Google
            Run, https://www.google.com/search?q=%UserInput% ; Google search
        }

        ; Close the current window
        Gui, Destroy
        ctrlPressed := false  ; Reset flag so the function can be triggered again
    }
return
