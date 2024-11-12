Set WshShell = CreateObject("WScript.Shell")

' 获取当前脚本目录
currentDir = Left(WScript.ScriptFullName, InStrRev(WScript.ScriptFullName, "\"))
' 设置 Python 可执行文件路径
pythonPath = "envs\Scripts\Python.exe"
' 设置 Python 脚本路径
pythonScriptPath = currentDir & "HAREngine\HAREngine.py"

' 运行 Python 脚本，0 表示静默运行，False 表示不等待
WshShell.Run pythonPath & " " & pythonScriptPath, 0, True
