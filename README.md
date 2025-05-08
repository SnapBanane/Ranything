# Ctrl Quick Launcher (AutoHotkey)

This AutoHotkey script adds a minimal Spotlight-style launcher to Windows using a **double-tap of the `Ctrl` key**.

---

## 🚀 How to Use

1. **Double-tap the `Ctrl` key** quickly (within 300ms)  
   → A minimal input box appears at the top of your screen.

2. **Type a command** and press `Enter`:
   - `google something` → Searches Google  
   - `cmd ipconfig` → Runs the command in a terminal  
   - `gpt how to cook rice` → Opens ChatGPT in browser  
   - `shut` → Shuts down your PC  
   - *(any other input)* → Google search

3. The launcher will close automatically after submitting.

---

## ⚙️ Auto-Start on Boot

To run the script automatically every time you log in:

1. **Create a shortcut** of the `.ahk` script  
2. Press `Win + R`, type `shell:startup`, press Enter  
3. Move the shortcut into that folder  

✅ Done — the launcher will now start with Windows.

---

## 🧠 Behavior Summary

- **Double-tap detection**: Ctrl must be tapped **twice within 300ms**
- **Spamming Ctrl or holding it** won’t trigger anything
- **Timeout**: Detection resets **1 second** after last press
- **Clean UI**: Apple-style input field with no window border

---

## 📝 Requirements

- [AutoHotkey v1.x](https://www.autohotkey.com/)
- Works on **Windows 10/11**

---

## 📄 License

Free for personal and educational use.
