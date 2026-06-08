# Key Stats by guolei

Windows 原生键盘统计工具。

作者：guolei

授权说明：仅限非商业使用。

英文文档：[README.md](README.md)

## 启动

双击：

```text
KeyStatsPanel.exe
```

如果程序无法启动，运行 `install-dependencies.bat` 安装 .NET 8 Windows Desktop Runtime。

## 文件

- `KeyStatsPanel.exe`：控制面板，唯一入口。
- `KeyboardStatsWorker.exe`：统计进程，内部组件。
- `KeyboardStatsWatchdog.exe`：守护进程，内部组件。

不要手动启动 Worker 或 Watchdog。

## 行为

- 关闭控制面板不会停止后台统计。
- 使用“关闭统计”或 `KeyStatsPanel.exe --stop` 才会停止全部进程。
- 任务管理器结束 Worker 后，Watchdog 会自动重启它。
- 任务管理器结束 Watchdog 后，Worker 会自动重启它。
- 后台运行只包含 Worker 和 Watchdog。

## 命令

```bat
KeyStatsPanel.exe --status
KeyStatsPanel.exe --stop
KeyStatsPanel.exe --clear --yes
KeyStatsPanel.exe --stats
KeyStatsPanel.exe --analyze
KeyStatsPanel.exe --view-log
```
