# 改进的远程反射PE注入脚本
# 背景
___
> 由于PowerSploit的远程反射注入已经多年没有维护了,而且它也不能在x64的powershell上注入x86的代码  
* 而且它每一个IAT表的函数都要创建一个线程来调用,导致了大量的开销在创建线程 
* stephenfewer ReflectiveDLLInjection 则使用了用C以汇编的方式编写函数使其编写的反射加载器函数能够与位置无关从而能够在未重定向未修复导入表的PE文件里正常工作  
* 但是 stephenfewer 的ReflectiveLoader函数 必须自身在这个要被反射加载的dll的,这无疑导致了 stephenfewer 的加载器只能加载 具有这个函数的dll  
____
* 于是乎我按照他的思路在他的基础上把 ReflectiveLoader 写成了ShellCode 就诞生这个比PowerSploit少2600多行,还能同时兼容32位的脚本（也比他快的多）同时也用C++/CLI 写了一个.Net程序集

# Invoke-ReflectDllInjection.ps1 Usage
___
`Invoke-ReflectiveDllInjection -id $id -PEBytes $PEBytes -is64 <$true or $false>` 

# ReflectPEInject_x64.dll x64 Usage
___
`import-module -path <dllPath> and use [Mr_Robot.oneshot]::RemoteReflectPEInjection(byte[] PEBytes,int processId)` 

# ReflectPEInject_x64.dll x32 Usage
___
`import-module -path <dllPath> and use [Mr_Robot.oneshot]::RemoteReflectPEInjection32(byte[] PEBytes,int processId)` 

* 这个.Net程序集还有其他的方块可以用（除了InvokeMimikatz,InvokeBypassUAC,GetSystem 因为他们用到了过期的资源地址）

