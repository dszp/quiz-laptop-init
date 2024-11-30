# SOURCE: https://www.urtech.ca/2018/11/solved-easily-script-windows-10-to-download-install-and-restart-for-windows-updates/amp/
# Restart Windows but install update while restarting, using pure PowerShell

$signature = @"
[DllImport("ntdll.dll", SetLastError = true)]
public static extern IntPtr RtlAdjustPrivilege(int Privilege, bool bEnablePrivilege, bool IsThreadPrivilege, out bool PreviousValue);
"@
$ntdll = Add-Type -MemberDefinition $signature -name "NtDll" -Namespace "Win32" -PassThru
$signature = @"
[DllImport("advapi32.dll", SetLastError = true)]
public static extern UInt32 InitiateShutdown(string lpMachineName, string lpMessage, UInt32 dwGraceperiod, UInt32 dwShutdownFlags, UInt32 dwReason);
"@
$advapi32 = Add-Type -MemberDefinition $signature -name "AdvApi32" -Namespace "Win32" -PassThru
$ntdll::RtlAdjustPrivilege(19,$true,$false,[ref]$x)
$x = $null
$advapi32::InitiateShutdown($null,"Installing updates and restarting",10,[Uint32]'0x44',[Uint32]'0x80020011')
