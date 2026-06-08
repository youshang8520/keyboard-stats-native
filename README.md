# Key Stats by guolei

Windows native keyboard statistics tool.

Author: guolei

License note: non-commercial use only.

Chinese documentation: [README.zh-CN.md](README.zh-CN.md)

## Start

Double-click:

```text
KeyStatsPanel.exe
```

If the app cannot start, run `install-dependencies.bat` to install .NET 8 Windows Desktop Runtime.

## Files

- `KeyStatsPanel.exe`: Control Panel, the only entry point.
- `KeyboardStatsWorker.exe`: Statistics Worker, internal only.
- `KeyboardStatsWatchdog.exe`: Watchdog, internal only.

Do not start Worker or Watchdog manually.

## Behavior

- Closing the Control Panel does not stop background statistics.
- Use `关闭统计` or `KeyStatsPanel.exe --stop` to stop everything.
- If Worker is killed in Task Manager, Watchdog restarts it.
- If Watchdog is killed, Worker starts it again.
- Background runtime is Worker plus Watchdog.

## Commands

```bat
KeyStatsPanel.exe --status
KeyStatsPanel.exe --stop
KeyStatsPanel.exe --clear --yes
KeyStatsPanel.exe --stats
KeyStatsPanel.exe --analyze
KeyStatsPanel.exe --view-log
```
