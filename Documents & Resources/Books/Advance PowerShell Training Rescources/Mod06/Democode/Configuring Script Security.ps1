# Run this demo on LON-DC1 logged on with user name Contoso\Administrator and password Pa$$w0rd
# Virtual machines that should be running: LON-DC1
# You also need to make sure that the script E:\Mod06\Democode\script.ps1 is loaded into this PowerShell ISE 
# and is available to be executed. The focus by default for scripts runnignin the ISE wil be the users default location
# displayed below in the executin window. If you change the focus to the E:\Mod06\Democode\ folder you do not need to specify the full path



# 1
# Once you set the execution policy to restricted as per the next line, the script called in the subsequent line won't run. Run the following command
Set-ExecutionPolicy Restricted
# Click yes in the Execution Policy Change dialogue to accept the changes.
# running the command  "./script" calls the script.ps1 or you can type the full path
E:\Mod06\Democode\script

# 2
# Again run the command on the next line and change the execution policy and accept the changes in the Execution Policy Chatge dialogue.
Set-ExecutionPolicy AllSigned
#Run the following command. The script won't run, but you get a different error to the last time.
E:\Mod06\Democode\script

# 3
# Again run the command on the next line and change the execution policy and accept the changes in the Execution Policy Chatge dialogue. 
Set-ExecutionPolicy RemoteSigned
#run the following command. Now the script will run
E:\Mod06\Democode\script

# 4
# Also, We must specify a path to execute. Run the following commands in sequence. 
# The first two commands will not execute successfully but the last one will as a relative path has been provided.
# If the ./scrtip does not run you need to define the location where the PowerShell cursor is focused.
# Including the full path above will also run
script
script.ps1
./script

# 5
# double-click script.ps1 in Explorer - it won't execute

# 6
# show changing ExecutionPolicy in a Group Policy object
# 1. Open Group Policy Management console from Start > Administrative Tools > Group Policy Management
# 2. Go to Forest:Contoso.com > Domains > Contoso.com 
# 3. Right-click Default Domain Policy and select Edit
# 4. Computer Configuration > Policies > Administrative Templates > Windows Components > Windows PowerShell
# 5. Right Click Turn on Script Execution and go to Edit
# 6. Check the Enable radio button and set to "Allow local scripts and remote signed scripts" (corresponds to RemoteSigned)
# 7. Close dialog and save changes

# 7  
# Update GPO
gpupdate /force

# 8
# Verify local policy
get-executionpolicy

# 9
# Try to change local policy by running the below command and clicking yes in the execution policy change dialogue
set-executionpolicy allsigned 
# notice error - GPO overrides
# SIG # Begin signature block
# MIIa/wYJKoZIhvcNAQcCoIIa8DCCGuwCAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUquEgNCofW88ypmQ2glwbAj6G
# e7GgghXYMIIEhTCCA22gAwIBAgIKYQX3HgAAAAAAMjANBgkqhkiG9w0BAQUFADB5
# MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVk
# bW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSMwIQYDVQQDExpN
# aWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQTAeFw0wOTA3MTMyMzAwMThaFw0xMDEw
# MTMyMzEwMThaMIGDMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQ
# MA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
# MQ0wCwYDVQQLEwRNT1BSMR4wHAYDVQQDExVNaWNyb3NvZnQgQ29ycG9yYXRpb24w
# ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC1jKmclIRhGswuIsSgk2QJ
# 3oWhsJBd/MlsaLXx7/yOa/T4oG7XUd5goydj1PbftkzSRQunPdhv/u2nGGPTH8aB
# 1L8HN5dAK3/nX1o12ZNPq/MqkvCmjYHsBSTc27hhY1NhAjU41rj17ntUpslYNen0
# Fe/aB2wFLU2ktrqbO7gxMH5FvKmhJTkMQ6RHO5ecIERyN89QoE1N9MNl3ETRCDs4
# 3T7FF2xGx61zJMCPicHq6rrNaKkS1lgMUxYM/jkD1oHyPlxX83rbZuEHGNkZAxT2
# 5kWZKlFMkNda76+3OwwpTW0grge3ki7oacqfMELnwzKKCyJKMuicDMZRAyYBbZJz
# AgMBAAGjggECMIH/MBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBSHgbff
# 7vp3+lkFYzcECtfp2qDg4DAOBgNVHQ8BAf8EBAMCB4AwHwYDVR0jBBgwFoAUV0V0
# HF2w9shDBeCMVC2PMqf+SJYwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDovL2NybC5t
# aWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVjdHMvQ29kZVNpZ1BDQS5jcmwwTQYI
# KwYBBQUHAQEEQTA/MD0GCCsGAQUFBzAChjFodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpL2NlcnRzL0NvZGVTaWdQQ0EuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQA2
# IYT1j4MhTYeoP4vnxaQPTDBuWXSbC5d0Fqmx83Ckr8IMMyTzoEr6weQhxrbZ6lxb
# kWH3Im3/MfwXTtfNQOOd0uW00vqNbAfad5rKK+4NWUfPBMIQZ/rq6UM7t+bRnNmO
# I2BuEpvD2X5cVzLdlA3ffcVIkk1IdreiwFOVPvw6o5N88oUEx8aFOJc2+BKTIgCZ
# TnmvlutaIIOs0FxaMLAA4ms5jySJ2j0MpEZ5YjZTatfJzZII+4flVPV8WcXEd32w
# wSyYx5dsQ6f4IPiDVGSeYPjiSqVn1Em/VIh9UkTzUcAm0cV88InWEQkowkVFgB2Q
# Ir2OogU+PLNPvdc54IiTMIIEuzCCA6OgAwIBAgIKYQTKaQAAAAAACDANBgkqhkiG
# 9w0BAQUFADB3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSEw
# HwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EwHhcNMDcwNjA1MjIwMzIx
# WhcNMTIwNjA1MjIxMzIxWjCBpDELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
# bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
# b3JhdGlvbjEnMCUGA1UECxMebkNpcGhlciBEU0UgRVNOOkE1QjAtQ0RFMC1EQzk0
# MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBTZXJ2aWNlMIIBIjANBgkq
# hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAr/ha9jSxog+OrM/8GPCtJQ1xu19btzs3
# QRMkHOojxa6smcDcpiPwyqkzMDJqL5ohQgIJJlmbUOlXcYtn65foBHOLeLGYQEaj
# WgEoABag2sVOi6kJVJExnP/EkJVFBx2AKAUGcYDLrDhnYezCXxadf7A/0Sr3Mm9z
# PXxumDaahu4AOO4X7E9VM0aBekDcpfXSI4ZdKzNPJEiTGrG0fs/fMxu/1VvGLxPz
# 5oS3TpOYvADrXB1pxcjI0sQ8sAAU47Kc+aEeCdzV9W18MjEzso9Zm/7KH10iTroS
# HfBnwwSJS38D/X3XVIEDXUn1HqsgftJltHEZ6Ex9xpS9hZFtUFrDqQIDAQABo4IB
# GTCCARUwHQYDVR0OBBYEFJ6PqHTBQu4YzT296dbuJ7DHNTRnMB8GA1UdIwQYMBaA
# FCM0+NlSRnAK7UD7dvuzK7DDNbMPMFQGA1UdHwRNMEswSaBHoEWGQ2h0dHA6Ly9j
# cmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY3Jvc29mdFRpbWVT
# dGFtcFBDQS5jcmwwWAYIKwYBBQUHAQEETDBKMEgGCCsGAQUFBzAChjxodHRwOi8v
# d3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY3Jvc29mdFRpbWVTdGFtcFBD
# QS5jcnQwEwYDVR0lBAwwCgYIKwYBBQUHAwgwDgYDVR0PAQH/BAQDAgbAMA0GCSqG
# SIb3DQEBBQUAA4IBAQBnpd8oUdxIg/3GZfld+maqso2nVp2iSL4yrG2XD08MRLu7
# GPSQ5+J9xXQA1obzkcDQ0QWJXmKL+mj3Zc/mU6nfdBIhrYwVtKbKQ5PJa+FKsu0P
# zrSKOn/3tcy8Epp7zwTEP9kKLHU8kp7PBjZiDgIX5pkn9/tx7/9aemFVurqYh+tx
# rHb16IafNmdQQXj8M6TVaXMByHAja3yjV8hoB+RbQcH4Jv1pSQOZ1q/JP6T1nEz5
# Cp3SzUu/ffoWkOw7cUn+BBXK4mraaQu0kz40/srsgEnksnQYzJHnPk63e/VAj2Rb
# 1FDVOU1Tzb7UXkeCW9FaepkuRnBrB4UNbAkTYw91MIIGBzCCA++gAwIBAgIKYRZo
# NAAAAAAAHDANBgkqhkiG9w0BAQUFADBfMRMwEQYKCZImiZPyLGQBGRYDY29tMRkw
# FwYKCZImiZPyLGQBGRYJbWljcm9zb2Z0MS0wKwYDVQQDEyRNaWNyb3NvZnQgUm9v
# dCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwHhcNMDcwNDAzMTI1MzA5WhcNMjEwNDAz
# MTMwMzA5WjB3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSEw
# HwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EwggEiMA0GCSqGSIb3DQEB
# AQUAA4IBDwAwggEKAoIBAQCfoWyx39tIkip8ay4Z4b3i48WZUSNQrc7dGE4kD+7R
# p9FMrXQwIBHrB9VUlRVJlBtCkq6YXDAm2gBr6Hu97IkHD/cOBJjwicwfyzMkh53y
# 9GccLPx754gd6udOo6HBI1PKjfpFzwnQXq/QsEIEovmmbJNn1yjcRlOwhtDlKEYu
# J6yGT1VSDOQDLPtqkJAwbofzWTCd+n7Wl7PoIZd++NIT8wi3U21StEWQn0gASkdm
# EScpZqiX5NMGgUqi+YSnEUcUCYKfhO1VeP4Bmh1QCIUAEDBG7bfeI0a7xC1Un68e
# eEExd8yb3zuDk6FhArUdDbH895uyAc4iS1T/+QXDwiALAgMBAAGjggGrMIIBpzAP
# BgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBQjNPjZUkZwCu1A+3b7syuwwzWzDzAL
# BgNVHQ8EBAMCAYYwEAYJKwYBBAGCNxUBBAMCAQAwgZgGA1UdIwSBkDCBjYAUDqyC
# YEBWJ5flJRP8KuEKU5VZ5KShY6RhMF8xEzARBgoJkiaJk/IsZAEZFgNjb20xGTAX
# BgoJkiaJk/IsZAEZFgltaWNyb3NvZnQxLTArBgNVBAMTJE1pY3Jvc29mdCBSb290
# IENlcnRpZmljYXRlIEF1dGhvcml0eYIQea0WoUqgpa1Mc1j0BxMuZTBQBgNVHR8E
# STBHMEWgQ6BBhj9odHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9k
# dWN0cy9taWNyb3NvZnRyb290Y2VydC5jcmwwVAYIKwYBBQUHAQEESDBGMEQGCCsG
# AQUFBzAChjhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY3Jv
# c29mdFJvb3RDZXJ0LmNydDATBgNVHSUEDDAKBggrBgEFBQcDCDANBgkqhkiG9w0B
# AQUFAAOCAgEAEJeKw1wDRDbd6bStd9vOeVFNAbEudHFbbQwTq86+e4+4LtQSooxt
# YrhXAstOIBNQmd16QOJXu69YmhzhHQGGrLt48ovQ7DsB7uK+jwoFyI1I4vBTFd1P
# q5Lk541q1YDB5pTyBi+FA+mRKiQicPv2/OR4mS4N9wficLwYTp2OawpylbihOZxn
# LcVRDupiXD8WmIsgP+IHGjL5zDFKdjE9K3ILyOpwPf+FChPfwgphjvDXuBfrTot/
# xTUrXqO/67x9C0J71FNyIe4wyrt4ZVxbARcKFA7S2hSY9Ty5ZlizLS/n+YWGzFFW
# 6J1wlGysOUzU9nm/qhh6YinvopspNAZ3GmLJPR5tH4LwC8csu89Ds+X57H2146So
# dDW4TsVxIxImdgs8UoxxWkZDFLyzs7BNZ8ifQv+AeSGAnhUwZuhCEl4ayJ4iIdBD
# 6Svpu/RIzCzU2DKATCYqSCRfWupW76bemZ3KOm+9gSd0BhHudiG/m4LBJ1S2sWo9
# iaF2YbRuoROmv6pH8BJv/YoybLL+31HIjCPJZr2dHYcSZAI9La9Zj7jkIeW1sMpj
# tHhUBdRBLlCslLCleKuzoJZ1GtmShxN1Ii8yqAhuoFuMJb+g74TKIdbrHk/Jmu5J
# 4PcBZW+JC33Iacjmbuqnl84xKf8OxVtc2E0bodj6L54/LlUWa8kTo/0wggaBMIIE
# aaADAgECAgphFQgnAAAAAAAMMA0GCSqGSIb3DQEBBQUAMF8xEzARBgoJkiaJk/Is
# ZAEZFgNjb20xGTAXBgoJkiaJk/IsZAEZFgltaWNyb3NvZnQxLTArBgNVBAMTJE1p
# Y3Jvc29mdCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0eTAeFw0wNjAxMjUyMzIy
# MzJaFw0xNzAxMjUyMzMyMzJaMHkxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xIzAhBgNVBAMTGk1pY3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBMIIB
# IjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAn43fhTeMsQZWZjZO1ArrNiOR
# Hq+rjVjpxM/BnzoKJMTExF6w7hUUxfo+mTNrGWly9HwFX+WZJUTXNRmKkNwojpAM
# 79WQYa3e3BhwLYPJb6+FLPjdubkw/XF4HIP9yKm5gmcNerjBCcK8FpdXPxyY02nX
# MJCQkI0wH9gm1J57iNniCe2XSUXrBFKBdXu4tSK4Lla718+pTjwKg6KoOsWttgEO
# as8itCMfbNUn57d+wbTVMq15JRxChuKdhfRX2htZLy0mkinFs9eFo55gWpTme5x7
# XoI0S23/1O4n0KLc0ZAMzn0OFXyIrDTHwGyYhErJRHloKN8igw24iixIYeL+EQID
# AQABo4ICIzCCAh8wEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFFdFdBxdsPbI
# QwXgjFQtjzKn/kiWMAsGA1UdDwQEAwIBxjAPBgNVHRMBAf8EBTADAQH/MIGYBgNV
# HSMEgZAwgY2AFA6sgmBAVieX5SUT/CrhClOVWeSkoWOkYTBfMRMwEQYKCZImiZPy
# LGQBGRYDY29tMRkwFwYKCZImiZPyLGQBGRYJbWljcm9zb2Z0MS0wKwYDVQQDEyRN
# aWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHmCEHmtFqFKoKWtTHNY
# 9AcTLmUwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC5taWNyb3NvZnQuY29t
# L3BraS9jcmwvcHJvZHVjdHMvbWljcm9zb2Z0cm9vdGNlcnQuY3JsMFQGCCsGAQUF
# BwEBBEgwRjBEBggrBgEFBQcwAoY4aHR0cDovL3d3dy5taWNyb3NvZnQuY29tL3Br
# aS9jZXJ0cy9NaWNyb3NvZnRSb290Q2VydC5jcnQwdgYDVR0gBG8wbTBrBgkrBgEE
# AYI3FS8wXjBcBggrBgEFBQcCAjBQHk4AQwBvAHAAeQByAGkAZwBoAHQAIACpACAA
# MgAwADAANgAgAE0AaQBjAHIAbwBzAG8AZgB0ACAAQwBvAHIAcABvAHIAYQB0AGkA
# bwBuAC4wEwYDVR0lBAwwCgYIKwYBBQUHAwMwDQYJKoZIhvcNAQEFBQADggIBADC8
# sCCkYqCn7zkmYT3crMaZ0IbELvWDMmVeIj6b1ob46LafyovWO3ULoZE+TN1kdIxJ
# 8oiMGGds/hVmRrg6RkKXyJE31CSx56zT6kEUg3fTyU8FX6MUUr+WpC8+VlsQdc5T
# w84FVGm0ZckkpQ/hJbgauU3lArlQHk+zmAwdlQLuIlmtIssFdAsERXsEWeDYD7Pr
# TPhg3cJ4ntG6n2v38+5+RBFA0r26m0sWCG6kvlXkpjgSo0j0HFV6iiDRff6R25SP
# L8J7a6ZkhU+j5Sw0KV0Lv/XHOC/EIMRWMfZpzoX4CpHs0NauujgFDOtuT0ycAymq
# ovwYoCkMDVxcViNX2hyWDcgmNsFEy+Xh5m+J54/pmLVz03jj7aMBPHTlXrxs9iGJ
# ZwXsl521sf2vpulypcM04S+f+fRqOeItBIJb/NCcrnydEfnmtVMZdLo5SjnrfUKz
# Sjs3PcJKeyeY5+JOmxtKVDhqIze+ardI7upCDUkkkY63BC6Xb+TnRbuPTf1g2ddZ
# wtiA1mA0e7ehkyD+gbiqpVwJ6YoNvihNftfoD+1leNExX7lm299C5wvMAgeN3/8g
# BqNFZbSzMo0ukeJNtKnJ+rxrBA6yn+qf3qTJCpb0jffYmKjwhQIIWaQgpiwLGvJS
# Bu1p5WQYG+Cjq97KfBRhQ7hl9TajVRMrZyxNGzBMMYIEkTCCBI0CAQEwgYcweTEL
# MAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1v
# bmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEjMCEGA1UEAxMaTWlj
# cm9zb2Z0IENvZGUgU2lnbmluZyBQQ0ECCmEF9x4AAAAAADIwCQYFKw4DAhoFAKCB
# vjAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgorBgEEAYI3AgELMQ4wDAYK
# KwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUgeznWiv13c2iStYdlFr+KEKwtXsw
# XgYKKwYBBAGCNwIBDDFQME6gJoAkAE0AaQBjAHIAbwBzAG8AZgB0ACAATABlAGEA
# cgBuAGkAbgBnoSSAImh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbS9sZWFybmluZyAw
# DQYJKoZIhvcNAQEBBQAEggEAfZCoTlO7qGlfLhiG2F7X41EIqsvRsnoBA/SXQOvl
# W0zj9z1ouMziqCCEtLdDtcQYCxWVubrLwdHbB49DuUX9AzVM9GbybkZeRk2gWKc1
# FDQuATpwapLQvptDlThbgRUsXNMwzPn7sgmacnDqC9M+3EWkFA2+BlxlEYAfNnyh
# Aq5YUxehG0z1y5KSSXhr0v367PkWteL/1LF5WMBRNuhz5CRICyaZupl0+Y52yIbb
# VtvwzJ3h+xNdfw/Tn+I/7EQhksuuvtWJhX9ki93KUZwyaqQPovCN7qjsOLM83eWA
# nyHwDOPn2f2ZPWYOcUuLEuZMQO+Ec2irNK8xsILPb78xMKGCAh0wggIZBgkqhkiG
# 9w0BCQYxggIKMIICBgIBATCBhTB3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2Fz
# aGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENv
# cnBvcmF0aW9uMSEwHwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0ECCmEE
# ymkAAAAAAAgwBwYFKw4DAhqgXTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
# CSqGSIb3DQEJBTEPFw0xMDA4MDkxNzM2MTRaMCMGCSqGSIb3DQEJBDEWBBQVc9/y
# ntYfT4M0pMsVlz9++gXNWDANBgkqhkiG9w0BAQUFAASCAQCbKxUeSkkzSreBpkSR
# La00y0yXP/5GEGcpPUajbzEwnmg5+8jgXmI5t/869tcwSPj/kijokxMpoL67jaDt
# +wiHxH/MkNLyBhXizCit0wIThwSHIHY/HD0hoPzp+CUa/B57LVvo9cmCb11BZbLc
# zG47bJQXNf3CYb3aHp69SXEDXCk/BLf4p7N5zmC/uFal2lLE88UzaxDpSKYpaf6n
# QiYvEhWTrDIHZHyJL3Tbx3klaGiznDU2iBdxcQ+qnPVm4Pgp1hKJUZT3D5bV2pHq
# Mesr/grlHZ1bz4EI30t+a4t+jiVdU5KGs3bEFF3V4aGkPQ6i2vCfPVXNuo9NBucw
# 3Bee
# SIG # End signature block
