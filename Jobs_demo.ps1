$Source_="C:\PS_Task_demo\OnPrem"
$Source=dir $Source_
$Exch="C:\PS_Task_demo\StorageBucket"
$Target="C:\PS_Task_demo\Cloud"
$Count=(Get-ChildItem $Source_ ).Count
Start-Job -Name j1 –ScriptBlock{
    Param($p_Source,$p_Exch)

    foreach($f in   $p_Source )
    { 
       Write-Host $f.name
       Start-Sleep -s 3
       Copy-Item $f.fullname -Destination   $p_Exch -Force
    }
}-ArgumentList $Source, $Exch
 
 #  Code here will run async
Start-Job -name j2  –ScriptBlock{
    Param($p_Exch,$p_Target,$p_Count)

    while ($p_Count -gt (Get-ChildItem $p_Target ).Count )
    {

        $source = dir $p_Exch
        foreach($f in   $source )
        { 
           Write-Host $f.name
           Start-Sleep -s 3
           Move-Item $f.fullname -Destination   $p_Target -Force
         }
     }
}-ArgumentList $Exch, $Target, $Count
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