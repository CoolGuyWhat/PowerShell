<#
    ############
    Path character Length Finder
    ############

    Author   : Aaron Price
    Company  : AFG
    Purpose  : Find files with invalid file path and characters before sync to Sharepoint Groove
    Error Log: N/A  | Outputs to C:\temp\PathLengths.txt

    ############
    Change Log
    ############

    Date: 11/09/2017 | Tested on Mapped Share on Local machine 
    Date: 07/09/2017 | Get-Childitem2 Function added and Credits
    Date:         '' | Items Filtered and Formatted
    Date:         '' | Initial script added
    Date: 06/09/2017 | Project Started

    ############
    TO DO
    ############

    1. [X] Make it work
    2. [ ] Rename Prompt for % # characters

    ############
    Sources
    ############

    Build better Functions
    https://technet.microsoft.com/en-us/library/hh360993.aspx

    Get-Help
    https://msdn.microsoft.com/en-us/powershell/reference/5.1/microsoft.powershell.core/get-help

    SharePoint Online Sync Limitation
    https://support.microsoft.com/en-gb/help/2933738/restrictions-and-limitations-when-you-sync-sharepoint-libraries-to-you

    Get-Childitem
    https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-childitem?view=powershell-5.1
 
    ############
    Credits
    ############

    https://stackoverflow.com/questions/12697259/how-do-i-find-files-with-a-path-length-greater-than-260-characters-in-windows
 
    This guy wrote the Function to get items with 260+ characters
    https://gallery.technet.microsoft.com/scriptcenter/Get-ChildItemV2-to-list-29291aae

#>

Function Get-ChildItem2 {
    <#
        .SYNOPSIS
            Gets the files and folders in a file system drive beyond the 256 character limitation

        .DESCRIPTION
            Gets the files and folders in a file system drive beyond the 256 character limitation

        .PARAMETER Path
            Path to a folder/file

        .PARAMETER Filter
            Filter object by name. Accepts wildcard (*)

        .PARAMETER Recurse
            Perform a recursive scan

        .PARAMETER Depth
            Limit the depth of a recursive scan

        .PARAMETER Directory
            Only show directories

        .PARAMETER File
            Only show files

        .NOTES
            Name: Get-ChildItem2
            Author: Boe Prox
            Version History:
                1.4 //Boe Prox <21 OCt 2015>
                    - Bug fixes in output
                    - Auto conversion of path to UNC for bypassing 260 character limit w/o user input
                1.2 //Boe Prox <20 Oct 2015>
                    - Added additional parameters (File, Directory and Filter)
                    - Made output mirror Get-ChildItem
                    - Added Mode property
                1.0 //Boe Prox
                    - Initial version

        .OUTPUT
            System.Io.DirectoryInfo
            System.Io.FileInfo

        .EXAMPLE
            Get-ChildItem2 -Recurse -Depth 3 -Directory

            Description
            -----------
            Performs a scan from the current directory and recursively displays all
            directories down to 3 folder levels.
    #>
    [OutputType('System.Io.DirectoryInfo','System.Io.FileInfo')]
    [cmdletbinding(
        DefaultParameterSetName = '__DefaultParameterSet'
    )]
    Param (
        [parameter(ValueFromPipeline=$True, ValueFromPipelineByPropertyName=$True)]
        [Alias('FullName','PSPath')]
        $Path = $PWD.ToString(),
        [parameter()]
        [string]$Filter,
        [parameter()]
        [switch]$Recurse,
        [parameter()]
        [int]$Depth,
        [parameter()]
        [switch]$Directory,
        [parameter()]
        [switch]$File
    )
    Begin {
        Try{
            [void][PoshFile]
        } Catch {
            #region Module Builder
            $Domain = [AppDomain]::CurrentDomain
            $DynAssembly = New-Object System.Reflection.AssemblyName('SomeAssembly')
            $AssemblyBuilder = $Domain.DefineDynamicAssembly($DynAssembly, [System.Reflection.Emit.AssemblyBuilderAccess]::Run) # Only run in memory
            $ModuleBuilder = $AssemblyBuilder.DefineDynamicModule('SomeModule', $False)
            #endregion Module Builder
 
            #region Structs            
            $Attributes = 'AutoLayout,AnsiClass, Class, Public, SequentialLayout, Sealed, BeforeFieldInit'
            #region WIN32_FIND_DATA STRUCT
            $UNICODEAttributes = 'AutoLayout,AnsiClass, UnicodeClass, Class, Public, SequentialLayout, Sealed, BeforeFieldInit'
            $STRUCT_TypeBuilder = $ModuleBuilder.DefineType('WIN32_FIND_DATA', $UNICODEAttributes, [System.ValueType], [System.Reflection.Emit.PackingSize]::Size4)
            [void]$STRUCT_TypeBuilder.DefineField('dwFileAttributes', [int32], 'Public')
            [void]$STRUCT_TypeBuilder.DefineField('ftCreationTime', [long], 'Public')
            [void]$STRUCT_TypeBuilder.DefineField('ftLastAccessTime', [long], 'Public')
            [void]$STRUCT_TypeBuilder.DefineField('ftLastWriteTime', [long], 'Public')
            [void]$STRUCT_TypeBuilder.DefineField('nFileSizeHigh', [int32], 'Public')
            [void]$STRUCT_TypeBuilder.DefineField('nFileSizeLow', [int32], 'Public')
            [void]$STRUCT_TypeBuilder.DefineField('dwReserved0', [int32], 'Public')
            [void]$STRUCT_TypeBuilder.DefineField('dwReserved1', [int32], 'Public')
 
            $ctor = [System.Runtime.InteropServices.MarshalAsAttribute].GetConstructor(@([System.Runtime.InteropServices.UnmanagedType]))
            $CustomAttribute = [System.Runtime.InteropServices.UnmanagedType]::ByValTStr
            $SizeConstField = [System.Runtime.InteropServices.MarshalAsAttribute].GetField('SizeConst')
            $CustomAttributeBuilder = New-Object System.Reflection.Emit.CustomAttributeBuilder -ArgumentList $ctor, $CustomAttribute, $SizeConstField, @(260)
            $cFileNameField = $STRUCT_TypeBuilder.DefineField('cFileName', [string], 'Public')
            $cFileNameField.SetCustomAttribute($CustomAttributeBuilder)
 
            $CustomAttributeBuilder = New-Object System.Reflection.Emit.CustomAttributeBuilder -ArgumentList $ctor, $CustomAttribute, $SizeConstField, @(14)
            $cAlternateFileName = $STRUCT_TypeBuilder.DefineField('cAlternateFileName', [string], 'Public')
            $cAlternateFileName.SetCustomAttribute($CustomAttributeBuilder)
            [void]$STRUCT_TypeBuilder.CreateType()
            #endregion WIN32_FIND_DATA STRUCT
            #endregion Structs
 
            #region Initialize Type Builder
            $TypeBuilder = $ModuleBuilder.DefineType('PoshFile', 'Public, Class')
            #endregion Initialize Type Builder
 
            #region Methods
            #region FindFirstFile METHOD
            $PInvokeMethod = $TypeBuilder.DefineMethod(
                'FindFirstFile', #Method Name
                [Reflection.MethodAttributes] 'PrivateScope, Public, Static, HideBySig, PinvokeImpl', #Method Attributes
                [IntPtr], #Method Return Type
                [Type[]] @(
                    [string],
                    [WIN32_FIND_DATA].MakeByRefType()
                ) #Method Parameters
            )
            $DllImportConstructor = [Runtime.InteropServices.DllImportAttribute].GetConstructor(@([String]))
            $FieldArray = [Reflection.FieldInfo[]] @(
                [Runtime.InteropServices.DllImportAttribute].GetField('EntryPoint'),
                [Runtime.InteropServices.DllImportAttribute].GetField('SetLastError')
                [Runtime.InteropServices.DllImportAttribute].GetField('ExactSpelling')
                [Runtime.InteropServices.DllImportAttribute].GetField('CharSet')
            )
 
            $FieldValueArray = [Object[]] @(
                'FindFirstFile', #CASE SENSITIVE!!
                $True,
                $False,
                [System.Runtime.InteropServices.CharSet]::Unicode
            )
 
            $SetLastErrorCustomAttribute = New-Object Reflection.Emit.CustomAttributeBuilder(
                $DllImportConstructor,
                @('kernel32.dll'),
                $FieldArray,
                $FieldValueArray
            )
 
            $PInvokeMethod.SetCustomAttribute($SetLastErrorCustomAttribute)
            #endregion FindFirstFile METHOD
 
            #region FindNextFile METHOD
            $PInvokeMethod = $TypeBuilder.DefineMethod(
                'FindNextFile', #Method Name
                [Reflection.MethodAttributes] 'PrivateScope, Public, Static, HideBySig, PinvokeImpl', #Method Attributes
                [bool], #Method Return Type
                [Type[]] @(
                    [IntPtr],
                    [WIN32_FIND_DATA].MakeByRefType()
                ) #Method Parameters
            )
            $DllImportConstructor = [Runtime.InteropServices.DllImportAttribute].GetConstructor(@([String]))
            $FieldArray = [Reflection.FieldInfo[]] @(
                [Runtime.InteropServices.DllImportAttribute].GetField('EntryPoint'),
                [Runtime.InteropServices.DllImportAttribute].GetField('SetLastError')
                [Runtime.InteropServices.DllImportAttribute].GetField('ExactSpelling')
                [Runtime.InteropServices.DllImportAttribute].GetField('CharSet')
            )
 
            $FieldValueArray = [Object[]] @(
                'FindNextFile', #CASE SENSITIVE!!
                $True,
                $False,
                [System.Runtime.InteropServices.CharSet]::Unicode
            )
 
            $SetLastErrorCustomAttribute = New-Object Reflection.Emit.CustomAttributeBuilder(
                $DllImportConstructor,
                @('kernel32.dll'),
                $FieldArray,
                $FieldValueArray
            )
 
            $PInvokeMethod.SetCustomAttribute($SetLastErrorCustomAttribute)
            #endregion FindNextFile METHOD

            #region FindClose METHOD
            $PInvokeMethod = $TypeBuilder.DefineMethod(
                'FindClose', #Method Name
                [Reflection.MethodAttributes] 'PrivateScope, Public, Static, HideBySig, PinvokeImpl', #Method Attributes
                [bool], #Method Return Type
                [Type[]] @(
                    [IntPtr]
                ) #Method Parameters
            )
            $DllImportConstructor = [Runtime.InteropServices.DllImportAttribute].GetConstructor(@([String]))
            $FieldArray = [Reflection.FieldInfo[]] @(
                [Runtime.InteropServices.DllImportAttribute].GetField('EntryPoint'),
                [Runtime.InteropServices.DllImportAttribute].GetField('SetLastError')
                [Runtime.InteropServices.DllImportAttribute].GetField('ExactSpelling')
            )
 
            $FieldValueArray = [Object[]] @(
                'FindClose', #CASE SENSITIVE!!
                $True,
                $True
            )
 
            $SetLastErrorCustomAttribute = New-Object Reflection.Emit.CustomAttributeBuilder(
                $DllImportConstructor,
                @('kernel32.dll'),
                $FieldArray,
                $FieldValueArray
            )
 
            $PInvokeMethod.SetCustomAttribute($SetLastErrorCustomAttribute)
            #endregion FindClose METHOD
            #endregion Methods
 
            #region Create Type
            [void]$TypeBuilder.CreateType()
            #endregion Create Type    
        }

        #region Inititalize Data
        $Found = $True    
        $findData = New-Object WIN32_FIND_DATA 
        #endregion Inititalize Data
    }
    Process {
        If ($Path -notmatch '^[a-z]:|^\\\\') {
            $Path = Convert-Path $Path
        }
        If ($Path.Endswith('\')) {
            $SearchPath = "$($Path)*"
        } ElseIf ($Path.EndsWith(':')) {
            $SearchPath = "$($Path)\*"
            $Path = "$($Path)\"
        } ElseIf ($Path.Endswith('*')) {
            $SearchPath = $Path
        } Else {
            $SearchPath = "$($Path)\*"
            $path = "$($Path)\"
        }
        If (-NOT $Path.StartsWith('\\')) {
            $Path = "\\?\$($Path)"
            $SearchPath = "\\?\$($SearchPath)"
        }
        If ($PSBoundParameters.ContainsKey('Recurse') -AND (-NOT $PSBoundParameters.ContainsKey('Depth'))) {
            $PSBoundParameters.Depth = [int]::MaxValue
            $Depth = [int]::MaxValue
        }
        If (-NOT $PSBoundParameters.ContainsKey('Recurse') -AND ($PSBoundParameters.ContainsKey('Depth'))) {
            Throw 'Cannot set Depth without Recurse parameter!'
        }
        Write-Verbose "Search: $($SearchPath)"
        Write-Verbose "Depth: $($Script:Count)"
        $Handle = [poshfile]::FindFirstFile("$SearchPath",[ref]$findData)
        If ($Handle -ne -1) {
            While ($Found) {
                If ($findData.cFileName -notmatch '^(\.){1,2}$') {
                    $IsDirectory =  [bool]($findData.dwFileAttributes -BAND 16)  
                    $FullName = "$($Path)$($findData.cFileName)"
                    $Mode = New-Object System.Text.StringBuilder                    
                    If ($findData.dwFileAttributes -BAND [System.IO.FileAttributes]::Directory) {
                        [void]$Mode.Append('d')
                    } Else {
                        [void]$Mode.Append('-')
                    }
                    If ($findData.dwFileAttributes -BAND [System.IO.FileAttributes]::Archive) {
                        [void]$Mode.Append('a')
                    } Else {
                        [void]$Mode.Append('-')
                    }
                    If ($findData.dwFileAttributes -BAND [System.IO.FileAttributes]::ReadOnly) {
                        [void]$Mode.Append('r')
                    } Else {
                        [void]$Mode.Append('-')
                    }
                    If ($findData.dwFileAttributes -BAND [System.IO.FileAttributes]::Hidden) {
                        [void]$Mode.Append('h')
                    } Else {
                        [void]$Mode.Append('-')
                    }
                    If ($findData.dwFileAttributes -BAND [System.IO.FileAttributes]::System) {
                        [void]$Mode.Append('s')
                    } Else {
                        [void]$Mode.Append('-')
                    }
                    If ($findData.dwFileAttributes -BAND [System.IO.FileAttributes]::ReparsePoint) {
                        [void]$Mode.Append('l')
                    } Else {
                        [void]$Mode.Append('-')
                    }
                    $Fullname = ([string]$FullName).replace('\\?\','')
                    $Object = New-Object PSObject -Property @{
                        Name = [string]$findData.cFileName
                        FullName = $Fullname
                        Length = $Null                       
                        Attributes = [System.IO.FileAttributes]$findData.dwFileAttributes
                        LastWriteTime = [datetime]::FromFileTime($findData.ftLastWriteTime)
                        LastAccessTime = [datetime]::FromFileTime($findData.ftLastAccessTime)
                        CreationTime = [datetime]::FromFileTime($findData.ftCreationTime)
                        PSIsContainer = [bool]$IsDirectory
                        Mode = $Mode.ToString()
                    }    
                    If ($Object.PSIsContainer) {
                        $Object.pstypenames.insert(0,'System.Io.DirectoryInfo')
                    } Else {
                        $Object.Length = [int64]('0x{0:x}' -f $findData.nFileSizeLow)
                        $Object.pstypenames.insert(0,'System.Io.FileInfo')
                    }
                    If ($PSBoundParameters.ContainsKey('Directory') -AND $Object.PSIsContainer) {                            
                        $ToOutPut = $Object
                    } ElseIf ($PSBoundParameters.ContainsKey('File') -AND (-NOT $Object.PSIsContainer)) {
                        $ToOutPut = $Object
                    }
                    If (-Not ($PSBoundParameters.ContainsKey('Directory') -OR $PSBoundParameters.ContainsKey('File'))) {
                        $ToOutPut = $Object
                    } 
                    If ($PSBoundParameters.ContainsKey('Filter')) {
                        If (-NOT ($ToOutPut.Name -like $Filter)) {
                            $ToOutPut = $Null
                        }
                    }
                    If ($ToOutPut) {
                        $ToOutPut
                        $ToOutPut = $Null
                    }
                    If ($Recurse -AND $IsDirectory -AND ($PSBoundParameters.ContainsKey('Depth') -AND [int]$Script:Count -lt $Depth)) {                        
                        #Dive deeper
                        Write-Verbose 'Recursive'
                        $Script:Count++
                        $PSBoundParameters.Path = $FullName
                        Get-ChildItem2 @PSBoundParameters
                        $Script:Count--
                    }
                }
                $Found = [poshfile]::FindNextFile($Handle,[ref]$findData)
            }
            [void][PoshFile]::FindClose($Handle)
        }
    }
} 

Set-Alias GCI2 Get-ChildItem2

# Variables
# The Directory to scan. Scans down linearly
$pathToScan = Read-Host 'For Network Share please Enter the Share name ( \\srv-name\Share )
Directory to Scan '

# This must be a file in a directory that exists and does not require admin rights to write to
$outputFilePath = 'C:\temp\PathLengths.txt' 

# Writing to the console will be much slower depending on the Depth of Scan. Chews up all your Console space.
$writeToConsole = $true  

# Tests the Output Directory 
$outputFileDirectory = Split-Path $outputFilePath -Parent
if(!(Test-Path $outputFileDirectory)){
    New-Item $outputFileDirectory -ItemType Directory
}

# Opens hidden writable file in background we can enter data into
$stream = New-Object System.IO.StreamWriter($outputFilePath, $false)

# Character Length Finder
Get-ChildItem2 -Path $pathToScan -Recurse | Select-Object -Property FullName, @{L='PathLength';E={$_.FullName.length}} | Sort-Object -Property FullNameLength -Descending | ForEach-Object {
    $filePath = $_.FullName
    $length = $_.PathLength
    $string = "$length : $filePath"

    # Write to the Console
    if ($writeToConsole) { Write-Host $string }

    # Write to the file
    if ($length -gt 10) { $stream.WriteLine($string) }
}

# Filter files with % as well
Get-Childitem2 -Path $pathToScan -Recurse -Filter *%* | Select-Object -Property FullName | ForEach-Object {
    $filePathfilter1 = $_.FullName 
    $filterString1 = "$filePathfilter1"

    # Write new string to file
    $stream.WriteLine($filterString1)
}

# Ctrl + V | Unfortunately you can only -filter one thing at a time as far as im aware | Could setup a Foreach($item in $Collection){ -filter x2 }
Get-Childitem2 -Path $pathToScan -Recurse -Filter *#* | Select-Object -Property FullName | ForEach-Object {
    $filePathfilter2 = $_.FullName 
    $filterString2 = "$filePathfilter2"

    # Write new string to file
    $stream.WriteLine($filterString2)
}
$stream.Close()

# Rename Section

# Saved
#Get-ChildItem2 -Path $pathToScan -Recurse | Select-Object -Property FullName, @{Name="FullNameLength";Expression={($_.FullName.Length)}} | Sort-Object -Property FullNameLength -Descending | ForEach-Object { }
#Get-Childitem2 -Path $pathToScan -Recurse | Format-List Fullname, @{L='PathLength';E={$_.FullName.length}} | Out-File C:\temp\zdrivescan.txt


<# Error Handling

    $ErrorMessage = $_.Exception.Message
    $Time = Get-Date
    Write-Verbose "Error log Written to C:\Logs\RemoteDetails.Log" -Verbose

    $path = "C:\Logs"
    if(!(Test-Path $path))
    {
    New-Item -ItemType Directory -Force -Path $path
    }
    # Writes Log File
    "$Time 
    $ErrorMessage" | Out-File C:\Logs\RemoteDetails.log -Append

#>
