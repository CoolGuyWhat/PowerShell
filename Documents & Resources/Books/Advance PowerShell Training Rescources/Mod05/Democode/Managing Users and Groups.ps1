# Run this demo on LON-DC1 logged on with user name Contoso\Administrator and password Pa$$w0rd
# Virtual machines that should be running: LON-DC1



# 1
# create a new OU to put the new user in
import-module activedirectory
cd ad:
new-adorganizationalunit Test1
new-adorganizationalunit Test2

# 2
# create a simple new user
new-aduser -name TestAccount -department IT -city "New York" -organization "Contoso"

# 3
# move the user to another ou
get-aduser -filter 'Name -eq "TestAccount"' | move-adobject -targetpath "ou=Test2,dc=contoso,dc=com"

# 4
# get a group and then its members
get-adgroup -filter "Name -eq 'Domain Admins'"

# 5
get-adgroup -filter "Name -eq 'Domain Admins'" | get-adgroupmember

# 6
# add the new user to that group
# notice we don't HAVE to pipe anything, we can specify it via parameters
# parameters are positional so we'll omit their names
add-adgroupmember "domain admins" testaccount

# 7
# enable a user - we'll get the user and pipe it in
# NOTE: If you receieve an error saying account does not match minimum password length requirements 
# you can execute the following command and then re-try. 
# Get-ADFineGrainedPasswordPolicy -filter * | Remove-ADFineGrainedPasswordPolicy
# If you still receive an error proceed on through the demo steps as we will set the password within the next few steps.
get-aduser -filter 'Name -eq "TestAccount"' | enable-adaccount



# 8
# Verify the status of the account
get-aduser -filter 'Name -eq "TestAccount"'

# 9
# disable it - without piping this time
disable-adaccount testaccount

# 10 
# Verify disabled account
get-aduser -filter 'Name -eq "TestAccount"'

# 11
# set password - notice that we have to convert
# a plain text password to a securestring, and use
# the -force parameter. Note that we use parentheses
# around the cmdlet so that its results are passed to the
# -NewPassword parameter
# NOTE: If you receive and error while setting an account password during this demo you could use an 
# alternative more complex password which is different from the one used from the Administrator account for example 
# “ Set-ADAccountPassword testaccount -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "p@$$w0rd01$%" -Force) “
Set-ADAccountPassword testaccount -Reset -NewPassword (ConvertTo-SecureString -AsPlainText "pa$$w0rd01" -Force)

# 12
# let's look at a CSV file and the help for New-ADUser
# note how the column names match AD attribute names or, more accurately,
# how they match parameter names of new-aduser. This assumes
# that the CSV file is in the same folder as this demo script
# Note: if your current focus is not on the drive where this file is located 
# In steps 12, 13 and 14 you may need to specify the full path to it E:\Mod05\Democode\NewUsers.csv
# in the command below. This applies to all instances of this path below
help new-aduser
notepad ./NewUsers.csv



# 13
# notice how the column names become properties when we import the file. 
import-csv ./newusers.csv

# 14
# let's make users out of them, and enable those users
# NOTE: when creating multiple accounts from the .csv file, we didn't specify passwords 
# (there's a parameter to do so, but we didn't use it), so the accounts are created as disabled. 
# You will see an error prompt stating that the passwords do not meet the minimum requirements. This is as expected.
import-csv ./newusers.csv | `
    new-aduser -path "ou=test1,dc=contoso,dc=com" -passthru | `
    enable-adaccount -passthru 

# 15
# The IT department was consolidated in Seattle
# Let's modify the users appropriately
get-aduser -filter 'Department -like "IT"' | set-aduser -city "Seattle"

# 16
# Everyone in this OU was moved into a single division
# Let's modify the users in that OU
get-aduser -filter * -searchbase "ou=Test1,dc=contoso,dc=com" | set-aduser -division "Automotive"

# SIG # Begin signature block
# MIIbEAYJKoZIhvcNAQcCoIIbATCCGv0CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU+0Mc4aMGc7404qC5eNidrbDu
# DwagghXnMIIEhTCCA22gAwIBAgIKYQh3XwAAAAAASjANBgkqhkiG9w0BAQUFADB5
# MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVk
# bW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSMwIQYDVQQDExpN
# aWNyb3NvZnQgQ29kZSBTaWduaW5nIFBDQTAeFw0xMDA3MTkyMjUzMTBaFw0xMTEw
# MTkyMjUzMTBaMIGDMQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQ
# MA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9u
# MQ0wCwYDVQQLEwRNT1BSMR4wHAYDVQQDExVNaWNyb3NvZnQgQ29ycG9yYXRpb24w
# ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMfoB7QfqLtE2ZKUPd5vhS
# 31tCl70zGZzvtdrQwNzo8be+XOEKssI1oH7k89Q4p/IPQnKnupvPHyTeVg2Ec8zT
# Y/cXza9pb2FNTIBPyHccUWTI0wTzFCazuEI/M0Ow2yZZWJO1bYliDwdWW9USoLEJ
# zBYr+YzfYVboBnh/13OIJgNn0aP/NIKsLUzYAuztb7miMcUyTLv2/V9iW17x9mSR
# x4V3Rxz2pytHLQs3VE+2HwSNtexgJ6fzfrZ8oUyRpotx1sY1YUe8wRVL3awzIr4G
# GZZLih5uAOu+HmndWFkhAys8vuYTBRdmNaeGLRrx2TTAAYAa/JpGnW6k50jcNeo3
# AgMBAAGjggECMIH/MBMGA1UdJQQMMAoGCCsGAQUFBwMDMB0GA1UdDgQWBBTkb1/K
# iflTvvBwVwZQqsJ5DaxWmzAOBgNVHQ8BAf8EBAMCB4AwHwYDVR0jBBgwFoAUV0V0
# HF2w9shDBeCMVC2PMqf+SJYwSQYDVR0fBEIwQDA+oDygOoY4aHR0cDovL2NybC5t
# aWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVjdHMvQ29kZVNpZ1BDQS5jcmwwTQYI
# KwYBBQUHAQEEQTA/MD0GCCsGAQUFBzAChjFodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpL2NlcnRzL0NvZGVTaWdQQ0EuY3J0MA0GCSqGSIb3DQEBBQUAA4IBAQCW
# QV09XCukzrgqRS9CAl6hkBxMdCcJzgtUfXAoQXI7pBW80QRSV693dG0LVVeHNxBJ
# Htbm1MJjlLT9pC4t+l/iGVkVhNm3tulSolLeI18gL1nTqxqEfx3jveoP3wGIOSXY
# 7WRhGRt6r6YUSkZQSNlyS9VLkt3wD4R8y9PG8kx4bv28/2YQCvcDXRXqXpgMCdKZ
# jy61IL1h5slvBRQRy3v7Qgi9A/EmV2dNj1mLuETHRdNiBAwtMANYXuxI9G6oFDEE
# /TSiuAQtAt06oQlerWGxj3DAeFUjY6ifWXei27kbcSgc/C7hBI+17zS+SplH42RS
# Fjz6veDo4BQMECI0goIeMIIEyjCCA7KgAwIBAgIKYQSz9QAAAAAADTANBgkqhkiG
# 9w0BAQUFADB3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSEw
# HwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EwHhcNMDgwNzI1MTkxMzQ1
# WhcNMTEwNzI1MTkyMzQ1WjCBszELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
# bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
# b3JhdGlvbjENMAsGA1UECxMETU9QUjEnMCUGA1UECxMebkNpcGhlciBEU0UgRVNO
# OjlFNzgtODY0Qi0wMzlEMSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFtcCBT
# ZXJ2aWNlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAq0YvvKgU8vhG
# PwwFoaRjRQV/mukzcswn0zLsmMPgNIiFzqESl65IUE5IIH9w5Fkz/JlbuQeASCi8
# jbj6ZgJmtfF/HFCWKJNVjYFVqnBbpcnO7y7i5yXDdm8pC58syFOAmsEN472nRb8x
# 3+aGi32JAYsceFg4st2TSlueHdecxvDETdC/J0oHlARxAogNcOb4KucOYeOYS9Hd
# q1S2N/vGRv2kHLz/r+yyl4DcuJP9uCKonSVZcD5cexxBKf5zmSJJgddVJsDs8k4o
# VGI7cC1hkx1Q1Z8BwgXDVRpKh6QAhlSge2Ky6g/6XVzFKhGCl76GGx2rt6sKKfzM
# zTSJv0C2TwIDAQABo4IBGTCCARUwHQYDVR0OBBYEFKCFMV6Hrg+qCgTr4cDTZL08
# u2n1MB8GA1UdIwQYMBaAFCM0+NlSRnAK7UD7dvuzK7DDNbMPMFQGA1UdHwRNMEsw
# SaBHoEWGQ2h0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1Y3Rz
# L01pY3Jvc29mdFRpbWVTdGFtcFBDQS5jcmwwWAYIKwYBBQUHAQEETDBKMEgGCCsG
# AQUFBzAChjxodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY3Jv
# c29mdFRpbWVTdGFtcFBDQS5jcnQwEwYDVR0lBAwwCgYIKwYBBQUHAwgwDgYDVR0P
# AQH/BAQDAgbAMA0GCSqGSIb3DQEBBQUAA4IBAQBHcU+2SEXACOucL9MlW9tnURGS
# ptnZshSaJsL9BsHM14j1pjW1zSu2a1hqzfmd81rrRi+h+qcffXpCsrDRGgkoVGxv
# mYs4/DrkwSSqckwSBC/x1Hp2O8XPcScLbfw4Z6fFImIre3/BdqynxSZMqa+Y3Yo4
# Xc9lpIEuqe9WAky5CL5lxB6LIS1up/J1ZLTcGmvQ8SXlwueARDnULwp5fgEqp3hb
# o2tbzgnvOTo5t8RnU7mq82H/nXnjz0hn/6vIxitiCZTQH6J493NJO1hTwQmrTAYL
# 1UAofvaxZsW/UsS+Pjvg+Y50jeYiDMHGM5i1eegM9wB86rJOzICaFi3IpBAFMIIG
# BzCCA++gAwIBAgIKYRZoNAAAAAAAHDANBgkqhkiG9w0BAQUFADBfMRMwEQYKCZIm
# iZPyLGQBGRYDY29tMRkwFwYKCZImiZPyLGQBGRYJbWljcm9zb2Z0MS0wKwYDVQQD
# EyRNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwHhcNMDcwNDAz
# MTI1MzA5WhcNMjEwNDAzMTMwMzA5WjB3MQswCQYDVQQGEwJVUzETMBEGA1UECBMK
# V2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
# IENvcnBvcmF0aW9uMSEwHwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0Ew
# ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCfoWyx39tIkip8ay4Z4b3i
# 48WZUSNQrc7dGE4kD+7Rp9FMrXQwIBHrB9VUlRVJlBtCkq6YXDAm2gBr6Hu97IkH
# D/cOBJjwicwfyzMkh53y9GccLPx754gd6udOo6HBI1PKjfpFzwnQXq/QsEIEovmm
# bJNn1yjcRlOwhtDlKEYuJ6yGT1VSDOQDLPtqkJAwbofzWTCd+n7Wl7PoIZd++NIT
# 8wi3U21StEWQn0gASkdmEScpZqiX5NMGgUqi+YSnEUcUCYKfhO1VeP4Bmh1QCIUA
# EDBG7bfeI0a7xC1Un68eeEExd8yb3zuDk6FhArUdDbH895uyAc4iS1T/+QXDwiAL
# AgMBAAGjggGrMIIBpzAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBQjNPjZUkZw
# Cu1A+3b7syuwwzWzDzALBgNVHQ8EBAMCAYYwEAYJKwYBBAGCNxUBBAMCAQAwgZgG
# A1UdIwSBkDCBjYAUDqyCYEBWJ5flJRP8KuEKU5VZ5KShY6RhMF8xEzARBgoJkiaJ
# k/IsZAEZFgNjb20xGTAXBgoJkiaJk/IsZAEZFgltaWNyb3NvZnQxLTArBgNVBAMT
# JE1pY3Jvc29mdCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0eYIQea0WoUqgpa1M
# c1j0BxMuZTBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLm1pY3Jvc29mdC5j
# b20vcGtpL2NybC9wcm9kdWN0cy9taWNyb3NvZnRyb290Y2VydC5jcmwwVAYIKwYB
# BQUHAQEESDBGMEQGCCsGAQUFBzAChjhodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20v
# cGtpL2NlcnRzL01pY3Jvc29mdFJvb3RDZXJ0LmNydDATBgNVHSUEDDAKBggrBgEF
# BQcDCDANBgkqhkiG9w0BAQUFAAOCAgEAEJeKw1wDRDbd6bStd9vOeVFNAbEudHFb
# bQwTq86+e4+4LtQSooxtYrhXAstOIBNQmd16QOJXu69YmhzhHQGGrLt48ovQ7DsB
# 7uK+jwoFyI1I4vBTFd1Pq5Lk541q1YDB5pTyBi+FA+mRKiQicPv2/OR4mS4N9wfi
# cLwYTp2OawpylbihOZxnLcVRDupiXD8WmIsgP+IHGjL5zDFKdjE9K3ILyOpwPf+F
# ChPfwgphjvDXuBfrTot/xTUrXqO/67x9C0J71FNyIe4wyrt4ZVxbARcKFA7S2hSY
# 9Ty5ZlizLS/n+YWGzFFW6J1wlGysOUzU9nm/qhh6YinvopspNAZ3GmLJPR5tH4Lw
# C8csu89Ds+X57H2146SodDW4TsVxIxImdgs8UoxxWkZDFLyzs7BNZ8ifQv+AeSGA
# nhUwZuhCEl4ayJ4iIdBD6Svpu/RIzCzU2DKATCYqSCRfWupW76bemZ3KOm+9gSd0
# BhHudiG/m4LBJ1S2sWo9iaF2YbRuoROmv6pH8BJv/YoybLL+31HIjCPJZr2dHYcS
# ZAI9La9Zj7jkIeW1sMpjtHhUBdRBLlCslLCleKuzoJZ1GtmShxN1Ii8yqAhuoFuM
# Jb+g74TKIdbrHk/Jmu5J4PcBZW+JC33Iacjmbuqnl84xKf8OxVtc2E0bodj6L54/
# LlUWa8kTo/0wggaBMIIEaaADAgECAgphFQgnAAAAAAAMMA0GCSqGSIb3DQEBBQUA
# MF8xEzARBgoJkiaJk/IsZAEZFgNjb20xGTAXBgoJkiaJk/IsZAEZFgltaWNyb3Nv
# ZnQxLTArBgNVBAMTJE1pY3Jvc29mdCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0
# eTAeFw0wNjAxMjUyMzIyMzJaFw0xNzAxMjUyMzMyMzJaMHkxCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xIzAhBgNVBAMTGk1pY3Jvc29mdCBDb2Rl
# IFNpZ25pbmcgUENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAn43f
# hTeMsQZWZjZO1ArrNiORHq+rjVjpxM/BnzoKJMTExF6w7hUUxfo+mTNrGWly9HwF
# X+WZJUTXNRmKkNwojpAM79WQYa3e3BhwLYPJb6+FLPjdubkw/XF4HIP9yKm5gmcN
# erjBCcK8FpdXPxyY02nXMJCQkI0wH9gm1J57iNniCe2XSUXrBFKBdXu4tSK4Lla7
# 18+pTjwKg6KoOsWttgEOas8itCMfbNUn57d+wbTVMq15JRxChuKdhfRX2htZLy0m
# kinFs9eFo55gWpTme5x7XoI0S23/1O4n0KLc0ZAMzn0OFXyIrDTHwGyYhErJRHlo
# KN8igw24iixIYeL+EQIDAQABo4ICIzCCAh8wEAYJKwYBBAGCNxUBBAMCAQAwHQYD
# VR0OBBYEFFdFdBxdsPbIQwXgjFQtjzKn/kiWMAsGA1UdDwQEAwIBxjAPBgNVHRMB
# Af8EBTADAQH/MIGYBgNVHSMEgZAwgY2AFA6sgmBAVieX5SUT/CrhClOVWeSkoWOk
# YTBfMRMwEQYKCZImiZPyLGQBGRYDY29tMRkwFwYKCZImiZPyLGQBGRYJbWljcm9z
# b2Z0MS0wKwYDVQQDEyRNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3Jp
# dHmCEHmtFqFKoKWtTHNY9AcTLmUwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2Ny
# bC5taWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVjdHMvbWljcm9zb2Z0cm9vdGNl
# cnQuY3JsMFQGCCsGAQUFBwEBBEgwRjBEBggrBgEFBQcwAoY4aHR0cDovL3d3dy5t
# aWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNyb3NvZnRSb290Q2VydC5jcnQwdgYD
# VR0gBG8wbTBrBgkrBgEEAYI3FS8wXjBcBggrBgEFBQcCAjBQHk4AQwBvAHAAeQBy
# AGkAZwBoAHQAIACpACAAMgAwADAANgAgAE0AaQBjAHIAbwBzAG8AZgB0ACAAQwBv
# AHIAcABvAHIAYQB0AGkAbwBuAC4wEwYDVR0lBAwwCgYIKwYBBQUHAwMwDQYJKoZI
# hvcNAQEFBQADggIBADC8sCCkYqCn7zkmYT3crMaZ0IbELvWDMmVeIj6b1ob46Laf
# yovWO3ULoZE+TN1kdIxJ8oiMGGds/hVmRrg6RkKXyJE31CSx56zT6kEUg3fTyU8F
# X6MUUr+WpC8+VlsQdc5Tw84FVGm0ZckkpQ/hJbgauU3lArlQHk+zmAwdlQLuIlmt
# IssFdAsERXsEWeDYD7PrTPhg3cJ4ntG6n2v38+5+RBFA0r26m0sWCG6kvlXkpjgS
# o0j0HFV6iiDRff6R25SPL8J7a6ZkhU+j5Sw0KV0Lv/XHOC/EIMRWMfZpzoX4CpHs
# 0NauujgFDOtuT0ycAymqovwYoCkMDVxcViNX2hyWDcgmNsFEy+Xh5m+J54/pmLVz
# 03jj7aMBPHTlXrxs9iGJZwXsl521sf2vpulypcM04S+f+fRqOeItBIJb/NCcrnyd
# EfnmtVMZdLo5SjnrfUKzSjs3PcJKeyeY5+JOmxtKVDhqIze+ardI7upCDUkkkY63
# BC6Xb+TnRbuPTf1g2ddZwtiA1mA0e7ehkyD+gbiqpVwJ6YoNvihNftfoD+1leNEx
# X7lm299C5wvMAgeN3/8gBqNFZbSzMo0ukeJNtKnJ+rxrBA6yn+qf3qTJCpb0jffY
# mKjwhQIIWaQgpiwLGvJSBu1p5WQYG+Cjq97KfBRhQ7hl9TajVRMrZyxNGzBMMYIE
# kzCCBI8CAQEwgYcweTELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24x
# EDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlv
# bjEjMCEGA1UEAxMaTWljcm9zb2Z0IENvZGUgU2lnbmluZyBQQ0ECCmEId18AAAAA
# AEowCQYFKw4DAhoFAKCBwDAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgor
# BgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUEtqYWBom
# 122aIGO85UJbZHYQL1swYAYKKwYBBAGCNwIBDDFSMFCgKIAmAE8AYgBzAGUAcgB2
# AGkAbgBnACAAUwBjAG8AcABlAC4AcABzADGhJIAiaHR0cDovL3d3dy5taWNyb3Nv
# ZnQuY29tL0xlYXJuaW5nIDANBgkqhkiG9w0BAQEFAASCAQA/djFpYCXqZiJyh2R9
# Gcc3rnoLiEwTq81jrczLHaOjTDk2ijfbNh/ofJkYiMRaYlNK9vwtUufcgy/RDZDx
# HmEhD5WnTAA98NSUlZk0OgaM4NA0PQVg1darei5pfek6C+RQHxawSCEa+gtFXiFf
# IZLnygfgPlTObf4//SWaLcUI/hib/bb51mwHBGfHMJDY50vjpkX+B754BKurSldD
# aSWtE2j3wk/Lrr+uQCxFYMEqASxih7qeIr6u3Tvz+V2GtUrSi8I/wDBEZIjr123X
# 03bz986/Ukp8N61CugT9iFBu9/JgncartgRYETp/85i+zSbBIZz3RUG3CbCuCzB8
# p3ptoYICHTCCAhkGCSqGSIb3DQEJBjGCAgowggIGAgEBMIGFMHcxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xITAfBgNVBAMTGE1pY3Jvc29mdCBU
# aW1lLVN0YW1wIFBDQQIKYQSz9QAAAAAADTAHBgUrDgMCGqBdMBgGCSqGSIb3DQEJ
# AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTEwMDkxMDA0MTY1M1owIwYJ
# KoZIhvcNAQkEMRYEFHBElBEnJuRfMGYJtzdNqi5ZiggTMA0GCSqGSIb3DQEBBQUA
# BIIBAHK8qHNBSeLhk3CLA3PPWcUXEDLvbqowZTZmiCRpraYMSesdf1xTMdj6e6zF
# N8zSld5s7uW9MsRhqIfxEIP5aE8X/oM+MDtxjGBoVjK9DBxF+/Xwl7+V3jWr23eW
# Q0hfn4PeTYUCBqr06NczNnk3ApsNnEkGl4CcBkiaD7q94eVd/T9Ge+vKGFHb1Z/d
# X9iXLe3YeHVpk2jgmFYOlLpLL3sMzXh/4jEHyztko21tP2oQoXp/RHnt/XclJJ/I
# FCE/doxwBu7wRIp9fUvBU4zGSk5ykBn5ynL/W3Hibftbeku5c0a9nS/q7L9Iaqxp
# 5FZ3g+p2/WBGkBdy0eg+k3Tm2ok=
# SIG # End signature block
