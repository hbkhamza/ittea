# 🤝 How to Contribute

### Project Structure:
```
├── itt/
│   ├── Initialize/  > Scripts to set up default registry keys and launch the WPF app window
│   ├── locales/     > Localization files for different languages
│   ├── scripts/     > Core functionality scripts (e.g., install, script blocks, utility scripts)
│   ├── static/      > Static files (e.g., apps, settings, images, etc.)
│   ├── .templates/  > Template files (e.g., README.md or other templates)
│   ├── themes/      > Theme files that define the application's visual style
│   ├── xaml/        > UI elements and windows (XAML files)
│   ├── build.ps1    > Builds the project and generates the final output script
│   └── itt.ps1      > This is the script that you run using the commands above
```
---

> [!NOTE]  
>  Make sure you have PowerShell 7 installed (recommended) for building. is available on ITT
1. **[Fork the repository](https://github.com/emadadeldev/ittea/fork)**
3. **Open ITT Directory in PowerShell 7 (Run as Administrator):**
```PowerShell
Set-Location "C:\Users\$env:USERNAME\Documents\Github\ittea"
```
4. **Choose what you want to add.**

<h3>📦 Add a New App</h3>

```PowerShell
.\newApp.ps1
```

<h3>⚙️ Add a New Tweak/Settings</h3>

[➕ Add your script here](https://github.com/emadadeldev/itt-tweaks)

> Ensure you understand the tweak you are adding and test it before PR.

---

### 🌐 Add your native language  

```PowerShell
.\newLocale.ps1
```

> Edit `locale.csv` file using [edit-csv extension](https://marketplace.visualstudio.com/items?itemName=janisdd.vscode-edit-csv)

---

### 🎨 Create your own theme

```PowerShell
.\newTheme.ps1
```

---

### 📜 Add a New Quote

```PowerShell
.\newQuote.ps1
```

---

### 🛠️ Build and debug

```PowerShell
.\build.ps1 -Debug
```

> [!NOTE]  
> Test your changes before you submit the Pull Request
