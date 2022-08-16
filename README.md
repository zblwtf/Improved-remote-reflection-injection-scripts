# Improved-remote-reflection-injection-scripts
# 背景
___
> 由于PowerSploit的远程反射注入已经多年没有维护了,而且它也不能在x64的powershell上注入x86的代码  
> 而且它每一个IAT表的函数都要创建一个线程来调用,导致了大量的开销在创建线程 
> stephenfewer ReflectiveDLLInjection 则使用了用C以汇编的方式编写函数使其编写的反射加载器函数能够与位置无关从而能够在未重定向未修复导入表的PE文件里正常工作  
  但是 stephenfewer 的ReflectiveLoader函数 必须在这个要被反射加载的dll的之中,这无疑导致了 stephenfewer 的加载器只能加载 具有这个函数的dll  
  于是乎我按照他的思路把 ReflectiveLoader 写成了ShellCode 这样子只需要在调用的时候 push dwDllFileaddress 就能反射加载dll    

#Usage
___
`Invoke-ReflectDllInjection $id $PEBytes $is64` 
