# PowerNSX-Scripts

## Copy-NsxSecurityTag
PowerNSX Script to Copy NSX Security Tags

Syntax for Copy-NsxSecurityTag.ps1
```Powershell
.\Copy-NsxSecurityTag.ps1 -CopyFromVM SourceVMName -CopyToVM DestinationVMName
```

Sample output
```Powershell
.\Copy-NsxSecurityTag.ps1 -CopyFromVM Linux03 -CopyToVM Linux04
WARNING: Copying Security Tags from Linux03 to Linux04

Are you sure you want to proceed? [y/n]: y

Running Copy-NsxSecurityTag.ps1 script ...

Retrieving Security Tags from Linux03
ST.WEB
ST.LINUX
ST.DEV


Assigning Security Tag ST.WEB to Linux04
Assigning Security Tag ST.LINUX to Linux04
Assigning Security Tag ST.DEV to Linux04

Retrieving Security Tags from Linux04
ST.WEB
ST.LINUX
ST.DEV
```
