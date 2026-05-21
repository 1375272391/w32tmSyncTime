# sync time by XM137 1375272391@qq.com
while ($true) {
    # $test = Test-NetConnection -ComputerName time.windows.com
    $test = Test-NetConnection -ComputerName www.msftconnecttest.com
    if ($test[0].PingSucceeded) {
        "Connected Internet, Now Sync The Time"
        Get-Service w32time | Where-Object {$_.status -eq 'Stopped'} | Start-Service
        w32tm /config /update /manualpeerlist:"ntp.aliyun.com ntp1.aliyun.com ntp2.aliyun.com"
        w32tm /resync
        w32tm /resync /force # Use when the time difference is too large
        "Have You Nice Day, SyncTime Command Successful"
        break
    } else {
        "Can't Connect to Internet"
    }
}
