$Source=dir "C:\PS_Task_demo\OnPrem"
$Exch="C:\PS_Task_demo\StorageBucket"
$Target="C:\PS_Task_demo\Cloud"
Start-Job -Name j1 –ScriptBlock{
    Param($p_Source,$p_Exch)
    $source = $p_Source
    $target = $p_Exch
    foreach($f in   $source )
    { Write-Host $f.name
     Start-Sleep -s 3
    Copy-Item $f.fullname -Destination   $target -Force
    }
     
    #Get-ChildItem -Path $source -Destination $target -Recurse  #| Start-Sleep -s 30
}-ArgumentList $Source, $Exch
 #  Code here will run async

Start-Job -name j2  –ScriptBlock{
    Param($p_Exch,$p_Target)
    while ((Get-ChildItem $p_Exch ).Count -gt 0 )
    {

        $source = dir $p_Exch

    foreach($f in   $source )
    { Write-Host $f.name
     Start-Sleep -s 3
    Move-Item $f.fullname -Destination   $p_Target -Force
    }
  }
}-ArgumentList $Exch, $Target
#  Code here will run async
#Wait-Job -Name j1
#Wait-Job -name j2
#receive-Job -Name j1
  
#receive-Job -name j2
#get-job -name j1
#get-job -name j2
#stop-job -name j2
#stop-job -name j1
#Remove-Job -Name j1
#Remove-Job -Name j2