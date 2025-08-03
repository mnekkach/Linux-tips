# Linux Tips

**Linux Tips** is a small tool that provides useful command-line tips.  
It installs a script accessible as `tips <tool/command>` from anywhere in your terminal.

---

## 📦 Installation

1. Clone the repository:

```bash
git clone https://github.com/<your-username>/linux-tips.git
cd linux-tips

```
2. Run the installation script:

```bash
./install
```

## 📂 Installation paths

. Executable: ~/.local/bin/tips

. Shared files: ~/.local/share/linux-tips/

If ~/.local/bin is in your PATH (it is on most modern distributions),
you can now run:

```bash
tips --version
```

## 🔄 Updating the program

To update to the latest version:

```bash
cd linux-tips
git pull
./install
```

The installation script will overwrite old files with the new version.

## ❌ Uninstallation

A script is provided to cleanly remove Linux Tips.

1. Normal uninstall (asks for confirmation):
```bash
./uninstall_linux_tips.sh
```

2. Simulate the uninstall (dry-run, no files are removed):
```bash
./uninstall_linux_tips.sh --dry-run
```

## ⚙️ Requirements

* Bash 4+

* Standard Linux user environment (~/.local/bin in PATH)

No sudo is required: the program is installed in the current user's space.