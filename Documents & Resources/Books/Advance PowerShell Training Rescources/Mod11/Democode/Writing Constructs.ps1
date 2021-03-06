# Run this demo on LON-DC1 logged on with user name Contoso\Administrator and password Pa$$w0rd
# Virtual machines that should be running: LON-DC1


# 1
# if construct
$server = read-host "Enter Server name"
if ($server -like 'SRV*') {
    write-host "Server name accepted."
}


# 2
# if...elseif...else
$server = read-host "Enter proposed server name"
if ($server -like '*LON*') {
    write-host "Server located in London"
} elseif ($server -like 'TOK*') {
    write-host "Server located in Tokyo"
} elseif ($server -like 'SEA*') {
    write-host "Server located in Seattle"
} else {
    write-host "Server name format not recognized"
}


# 3
# switch
$subnet = read-host "Enter subnet (2-5)"
switch ($subnet) {
    2 {
        write-host "Server subnet 2"
        break
      }
    3 {
        write-host "Server subnet 3"
        break
      }
    4 {
        write-host "Client subnet 4, Building 1"
        break
      }
    5 {
        write-host "Printer subnet, Building 1"
        break
      }
    default {
        write-host "Unknown subnet"
            }
}


# 4
# switch with wildcard - try entering LAXDCA
# notice no "break" statements
$server = read-host "Enter proposed server name"
switch -wildcard ($server) {
    "*LON*" {
        write-host "Server in London"
      }
    "*TOK*" {
        write-host "Server in Tokyo"
      }
    "*SEA*" {
        write-host "Server in Seattle, WA"
      }
}


# 5
# same thing with "break" added - enter LONTOK
$server = read-host "Enter proposed server name"
switch -wildcard ($server) {
    "*LON*" {
        write-host "Server in London"
        break
      }
    "*TOK*" {
        write-host "Server in Tokyo"
        break
      }
    "*SEA*" {
        write-host "Server in Seattle, WA"
        break
      }
}


# 6
# for loop
for ($i=0; $i -lt 10; $i++) {
    write-host $i
}


# 7
# always make sure to SET the counter variable
# try setting $x to 10 in the shell and then
# run this
for ($x; $x -lt 10; $x++) {
    write-host $x
}

# it doesn't run because it read $x from the gloabl
# scope - $x wasn't less than 10 so the loop never
# executed


# 8
# while loop
$server = ''
while ($server -eq '') {
    $server = read-host "Enter server name"
}


# 9
# again - notice that if the starting
# condition isn't true to begin with,
# the loop won't execute at all
$server = 'server1'
while ($server -eq '') {
    $server = read-host "Enter server name"
}


# 10
# endless loop - press Ctrl+C to break out
$i = 0
while ($i -lt 10) {
    write-host $i
}

# 11
# move the logic to the end of the loop
$subnet = 0
do {
    $subnet = read-host "Enter subnet (1-10)"
} while ($subnet -lt 1 -or $subnet -gt 11)


# 12
# note that with the logic at the end, the 
# construct will ALWAYS execute at least once
$i = 10
do {
    write-host $i
    $i++
} while ($i -lt 10)


# 13
# until reverses the logic, continuing
# only UNTIL the condition is true,
# rather than until it is false
$i = 15
do {
    write-host $i
    $i--
} until ($i -lt 10)

# note that UNTIL only works at the
# END... you can't put it at the
# beginning as you can with WHILE


# 14
# enumerate through a collection
# we'll make up a variable $item that will
# contain one item from the collection at a time
$coll = 1,2,3,4,5,6,7,8,9,10
foreach ($item in $coll) {
    write-host ($item * 10) -fore yellow -back black
}


# 15
# this is really similar to using the ForEach-Object cmdlet
# in a pipeline
$coll | foreach-object { write-host ($_ * 10) }
# SIG # Begin signature block
# MIIbEQYJKoZIhvcNAQcCoIIbAjCCGv4CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUER8M/PbDz1qnMHnv6i1QDhnY
# GMqgghXqMIIEhTCCA22gAwIBAgIKYQX3HgAAAAAAMjANBgkqhkiG9w0BAQUFADB5
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
# Ir2OogU+PLNPvdc54IiTMIIEzTCCA7WgAwIBAgIKYRa1KQAAAAAAEDANBgkqhkiG
# 9w0BAQUFADB3MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4G
# A1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSEw
# HwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EwHhcNMTAwMTA0MjExMjAz
# WhcNMTMwMTA0MjEyMjAzWjCBtjELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hp
# bmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jw
# b3JhdGlvbjEQMA4GA1UECxMHbkNpcGhlcjEnMCUGA1UECxMebkNpcGhlciBEU0Ug
# RVNOOkFDRDMtQUU2Ni1FMEI1MSUwIwYDVQQDExxNaWNyb3NvZnQgVGltZS1TdGFt
# cCBTZXJ2aWNlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4yiq2TxD
# QvgGE7rix/nBL1nLPJXnVJBsw1iVYrMPbL2D2y1YiAiSC9vNdsdWxuDuKtOIO1zK
# qXCjACMiLFM46FDH8RQJjR3LfIv1pjNrr8hGX0t7XvnnpscvQoVnNo1gSvITZtyw
# OW3OEMrdcgVYcp3yADsAOe0mUz4eze5Qks2F9Dr9gaEFXwvpRA7v1VlAJijLgk5O
# K8gUIrtwHeQ90f1gdlRMOezvdziLjP50r+cW9HAxuMut1N2LtvoAre10FLBFvvxl
# iOGt/EnbX9HUznR51I2Gb7P1lwchLZphyfy6G0zS6Ku5UOTTK/TB2U3WQKwUp4iF
# c15oPmO3QdRmvQIDAQABo4IBGTCCARUwHQYDVR0OBBYEFOHwrg8NBfwy8xx9GX/P
# xMW/kVVNMB8GA1UdIwQYMBaAFCM0+NlSRnAK7UD7dvuzK7DDNbMPMFQGA1UdHwRN
# MEswSaBHoEWGQ2h0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3Byb2R1
# Y3RzL01pY3Jvc29mdFRpbWVTdGFtcFBDQS5jcmwwWAYIKwYBBQUHAQEETDBKMEgG
# CCsGAQUFBzAChjxodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01p
# Y3Jvc29mdFRpbWVTdGFtcFBDQS5jcnQwEwYDVR0lBAwwCgYIKwYBBQUHAwgwDgYD
# VR0PAQH/BAQDAgbAMA0GCSqGSIb3DQEBBQUAA4IBAQCNW0koVIfJiqmT/pv4jVRx
# IJ3AOJMnKbnLllOKizW1lDcWWL2ePhcnX1kv5F1+HeJZ3Af7YhjlY7/0C89N2lsw
# 9sia/yZZvxnDELLw4x7BDJnaVZLGzBLfwFhM3ZrUHSP5hhJE5yYC6IBBaBZUNh2n
# ZbPEM6HjpJjZvmKQT5I3tqmIF1RIH53CIthyKrnDMJM+N+wpqbnOC9XCyRam515V
# DcyBhGHpLAPbm6YbUwI4iwpYkRfIcXAWzi7GY/x5n4MEgrSB5y9Xaa24pR8jNnb2
# FZSGCh7q3RE7ZkTSFVrPpisoH07FCnNXS5UDYKLr6TJ+vT2Ppr1JKinBVzHAEN9R
# MIIGBzCCA++gAwIBAgIKYRZoNAAAAAAAHDANBgkqhkiG9w0BAQUFADBfMRMwEQYK
# CZImiZPyLGQBGRYDY29tMRkwFwYKCZImiZPyLGQBGRYJbWljcm9zb2Z0MS0wKwYD
# VQQDEyRNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRob3JpdHkwHhcNMDcw
# NDAzMTI1MzA5WhcNMjEwNDAzMTMwMzA5WjB3MQswCQYDVQQGEwJVUzETMBEGA1UE
# CBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9z
# b2Z0IENvcnBvcmF0aW9uMSEwHwYDVQQDExhNaWNyb3NvZnQgVGltZS1TdGFtcCBQ
# Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCfoWyx39tIkip8ay4Z
# 4b3i48WZUSNQrc7dGE4kD+7Rp9FMrXQwIBHrB9VUlRVJlBtCkq6YXDAm2gBr6Hu9
# 7IkHD/cOBJjwicwfyzMkh53y9GccLPx754gd6udOo6HBI1PKjfpFzwnQXq/QsEIE
# ovmmbJNn1yjcRlOwhtDlKEYuJ6yGT1VSDOQDLPtqkJAwbofzWTCd+n7Wl7PoIZd+
# +NIT8wi3U21StEWQn0gASkdmEScpZqiX5NMGgUqi+YSnEUcUCYKfhO1VeP4Bmh1Q
# CIUAEDBG7bfeI0a7xC1Un68eeEExd8yb3zuDk6FhArUdDbH895uyAc4iS1T/+QXD
# wiALAgMBAAGjggGrMIIBpzAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBQjNPjZ
# UkZwCu1A+3b7syuwwzWzDzALBgNVHQ8EBAMCAYYwEAYJKwYBBAGCNxUBBAMCAQAw
# gZgGA1UdIwSBkDCBjYAUDqyCYEBWJ5flJRP8KuEKU5VZ5KShY6RhMF8xEzARBgoJ
# kiaJk/IsZAEZFgNjb20xGTAXBgoJkiaJk/IsZAEZFgltaWNyb3NvZnQxLTArBgNV
# BAMTJE1pY3Jvc29mdCBSb290IENlcnRpZmljYXRlIEF1dGhvcml0eYIQea0WoUqg
# pa1Mc1j0BxMuZTBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLm1pY3Jvc29m
# dC5jb20vcGtpL2NybC9wcm9kdWN0cy9taWNyb3NvZnRyb290Y2VydC5jcmwwVAYI
# KwYBBQUHAQEESDBGMEQGCCsGAQUFBzAChjhodHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpL2NlcnRzL01pY3Jvc29mdFJvb3RDZXJ0LmNydDATBgNVHSUEDDAKBggr
# BgEFBQcDCDANBgkqhkiG9w0BAQUFAAOCAgEAEJeKw1wDRDbd6bStd9vOeVFNAbEu
# dHFbbQwTq86+e4+4LtQSooxtYrhXAstOIBNQmd16QOJXu69YmhzhHQGGrLt48ovQ
# 7DsB7uK+jwoFyI1I4vBTFd1Pq5Lk541q1YDB5pTyBi+FA+mRKiQicPv2/OR4mS4N
# 9wficLwYTp2OawpylbihOZxnLcVRDupiXD8WmIsgP+IHGjL5zDFKdjE9K3ILyOpw
# Pf+FChPfwgphjvDXuBfrTot/xTUrXqO/67x9C0J71FNyIe4wyrt4ZVxbARcKFA7S
# 2hSY9Ty5ZlizLS/n+YWGzFFW6J1wlGysOUzU9nm/qhh6YinvopspNAZ3GmLJPR5t
# H4LwC8csu89Ds+X57H2146SodDW4TsVxIxImdgs8UoxxWkZDFLyzs7BNZ8ifQv+A
# eSGAnhUwZuhCEl4ayJ4iIdBD6Svpu/RIzCzU2DKATCYqSCRfWupW76bemZ3KOm+9
# gSd0BhHudiG/m4LBJ1S2sWo9iaF2YbRuoROmv6pH8BJv/YoybLL+31HIjCPJZr2d
# HYcSZAI9La9Zj7jkIeW1sMpjtHhUBdRBLlCslLCleKuzoJZ1GtmShxN1Ii8yqAhu
# oFuMJb+g74TKIdbrHk/Jmu5J4PcBZW+JC33Iacjmbuqnl84xKf8OxVtc2E0bodj6
# L54/LlUWa8kTo/0wggaBMIIEaaADAgECAgphFQgnAAAAAAAMMA0GCSqGSIb3DQEB
# BQUAMF8xEzARBgoJkiaJk/IsZAEZFgNjb20xGTAXBgoJkiaJk/IsZAEZFgltaWNy
# b3NvZnQxLTArBgNVBAMTJE1pY3Jvc29mdCBSb290IENlcnRpZmljYXRlIEF1dGhv
# cml0eTAeFw0wNjAxMjUyMzIyMzJaFw0xNzAxMjUyMzMyMzJaMHkxCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xIzAhBgNVBAMTGk1pY3Jvc29mdCBD
# b2RlIFNpZ25pbmcgUENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
# n43fhTeMsQZWZjZO1ArrNiORHq+rjVjpxM/BnzoKJMTExF6w7hUUxfo+mTNrGWly
# 9HwFX+WZJUTXNRmKkNwojpAM79WQYa3e3BhwLYPJb6+FLPjdubkw/XF4HIP9yKm5
# gmcNerjBCcK8FpdXPxyY02nXMJCQkI0wH9gm1J57iNniCe2XSUXrBFKBdXu4tSK4
# Lla718+pTjwKg6KoOsWttgEOas8itCMfbNUn57d+wbTVMq15JRxChuKdhfRX2htZ
# Ly0mkinFs9eFo55gWpTme5x7XoI0S23/1O4n0KLc0ZAMzn0OFXyIrDTHwGyYhErJ
# RHloKN8igw24iixIYeL+EQIDAQABo4ICIzCCAh8wEAYJKwYBBAGCNxUBBAMCAQAw
# HQYDVR0OBBYEFFdFdBxdsPbIQwXgjFQtjzKn/kiWMAsGA1UdDwQEAwIBxjAPBgNV
# HRMBAf8EBTADAQH/MIGYBgNVHSMEgZAwgY2AFA6sgmBAVieX5SUT/CrhClOVWeSk
# oWOkYTBfMRMwEQYKCZImiZPyLGQBGRYDY29tMRkwFwYKCZImiZPyLGQBGRYJbWlj
# cm9zb2Z0MS0wKwYDVQQDEyRNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0ZSBBdXRo
# b3JpdHmCEHmtFqFKoKWtTHNY9AcTLmUwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDov
# L2NybC5taWNyb3NvZnQuY29tL3BraS9jcmwvcHJvZHVjdHMvbWljcm9zb2Z0cm9v
# dGNlcnQuY3JsMFQGCCsGAQUFBwEBBEgwRjBEBggrBgEFBQcwAoY4aHR0cDovL3d3
# dy5taWNyb3NvZnQuY29tL3BraS9jZXJ0cy9NaWNyb3NvZnRSb290Q2VydC5jcnQw
# dgYDVR0gBG8wbTBrBgkrBgEEAYI3FS8wXjBcBggrBgEFBQcCAjBQHk4AQwBvAHAA
# eQByAGkAZwBoAHQAIACpACAAMgAwADAANgAgAE0AaQBjAHIAbwBzAG8AZgB0ACAA
# QwBvAHIAcABvAHIAYQB0AGkAbwBuAC4wEwYDVR0lBAwwCgYIKwYBBQUHAwMwDQYJ
# KoZIhvcNAQEFBQADggIBADC8sCCkYqCn7zkmYT3crMaZ0IbELvWDMmVeIj6b1ob4
# 6LafyovWO3ULoZE+TN1kdIxJ8oiMGGds/hVmRrg6RkKXyJE31CSx56zT6kEUg3fT
# yU8FX6MUUr+WpC8+VlsQdc5Tw84FVGm0ZckkpQ/hJbgauU3lArlQHk+zmAwdlQLu
# IlmtIssFdAsERXsEWeDYD7PrTPhg3cJ4ntG6n2v38+5+RBFA0r26m0sWCG6kvlXk
# pjgSo0j0HFV6iiDRff6R25SPL8J7a6ZkhU+j5Sw0KV0Lv/XHOC/EIMRWMfZpzoX4
# CpHs0NauujgFDOtuT0ycAymqovwYoCkMDVxcViNX2hyWDcgmNsFEy+Xh5m+J54/p
# mLVz03jj7aMBPHTlXrxs9iGJZwXsl521sf2vpulypcM04S+f+fRqOeItBIJb/NCc
# rnydEfnmtVMZdLo5SjnrfUKzSjs3PcJKeyeY5+JOmxtKVDhqIze+ardI7upCDUkk
# kY63BC6Xb+TnRbuPTf1g2ddZwtiA1mA0e7ehkyD+gbiqpVwJ6YoNvihNftfoD+1l
# eNExX7lm299C5wvMAgeN3/8gBqNFZbSzMo0ukeJNtKnJ+rxrBA6yn+qf3qTJCpb0
# jffYmKjwhQIIWaQgpiwLGvJSBu1p5WQYG+Cjq97KfBRhQ7hl9TajVRMrZyxNGzBM
# MYIEkTCCBI0CAQEwgYcweTELMAkGA1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0
# b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3Jh
# dGlvbjEjMCEGA1UEAxMaTWljcm9zb2Z0IENvZGUgU2lnbmluZyBQQ0ECCmEF9x4A
# AAAAADIwCQYFKw4DAhoFAKCBvjAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAc
# BgorBgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAjBgkqhkiG9w0BCQQxFgQUdc5i
# 0RkB7SqUS2KTAhjaiWnqG/8wXgYKKwYBBAGCNwIBDDFQME6gJoAkAE0AaQBjAHIA
# bwBzAG8AZgB0ACAATABlAGEAcgBuAGkAbgBnoSSAImh0dHA6Ly93d3cubWljcm9z
# b2Z0LmNvbS9sZWFybmluZyAwDQYJKoZIhvcNAQEBBQAEggEAK7BJIE0SlOdBqRmM
# WGmadaFbseypaD0CTawqFAUyp7aRCHOEmbkzmjrW0bnWyj6jtD4czVYc7A0qSqlO
# jmZlid1oACuJdIvCpH0613i1tdgYAxcKXt0IxSs3eFlK4qFMJvNWQ7wLiqPlxRIZ
# l9a1OhGg3mJSOkXANSt7oUQ+X+AxwJyI9O13zyb13FqwE2YniaJK6GgdVTGxcoiE
# Fw96xl4ROX4on6oovS+YPomuh1bPUHLc5hfk0AJ6WMZ8wIKnU8LKF3jQVVQ6q+0x
# IBdEqxaB0ChsRYLgkqNS5VfNX5lX41cRp7CK1FpVDfNPt0KjPD/gv0LNcoK9mi7a
# WrYr6aGCAh0wggIZBgkqhkiG9w0BCQYxggIKMIICBgIBATCBhTB3MQswCQYDVQQG
# EwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwG
# A1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSEwHwYDVQQDExhNaWNyb3NvZnQg
# VGltZS1TdGFtcCBQQ0ECCmEWtSkAAAAAABAwBwYFKw4DAhqgXTAYBgkqhkiG9w0B
# CQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xMDA4MDkxNzM2MjZaMCMG
# CSqGSIb3DQEJBDEWBBRsNUW+Ydbjgt6sVWJ8E7/RGFuPsjANBgkqhkiG9w0BAQUF
# AASCAQASZz17+HGeIuilSxJY19PPcvOdYanOp5AmHRKlAtrcTrMBsggyj5iIfbqz
# Evj+hvSEhh1+tDYF878ow4ILpuf/CUj7Y5WQH3N9g46PnNSqPurXHGBXg9LJvd7I
# xrziSX7rcEqe5WlwdLNTWDy/rZxv5j+I8ezuzofGvtB1rUv3igJ1sc2DziWwohC/
# nqRfA/9xEER89pINDmnvBP0GuFMEAwkY8KktAVabQI/mNCY4eFozy4wo9xU8eXup
# yN0lhPMWMFNPfsUTcpF/QlGulsMc3TthD9+sj1GMUfBY1xa8dRIaSNkI37drFsCL
# vIDz60MZkbcUz1bwOh9pM6EPE8YH
# SIG # End signature block
