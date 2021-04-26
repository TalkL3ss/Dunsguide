Add-Type -AssemblyName System.speech #Import Speech Namespace to say lound that the number has been change
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer #Create Speech Object
$minTime = 5 #Minimum of time to do the check just to make sure that we dont nodje the server set the same $minTime and $maxTime to set static time
$maxTime = 15 #Maximum of time to do the check just to make sure that we dont nodje the server set the same $minTime and $maxTime to set static time
$dunsguideSite = "https://www.dunsguide.co.il/" #Base Site of dunsguide
$dunsguideURI = "en/Cd7b8333d734ebd031fa61f94e555117f_high_tech_computing_services/microsoft_israel/" #specific uri to check
$fullSite = $dunsguideSite+$dunsguideURI #Create Varibalte with the full url
try {
	$PhoneSite = Invoke-WebRequest $fullSite #invoke the first webrequest to dunsguide to check the "base" Phone number
	$oldPhone = $PhoneSite.ParsedHtml.body.getElementsByClassName("contactInfoOptionTitle infoTableText phone") | select -ExpandProperty outerText #Parse the HTML and exract the "Pure" phone number
	if ($oldPhone -eq $null) { write-host "Problem with parsing the PhoneNumber" ; break}
} catch { Write-Host "Looks like there is some problem with the internet" -ForegroundColor Red }
while($true)
{
	$NumOfMins = Get-Random -Minimum $minTime -Maximum $maxTime #do random time 
    0..$($NumOfMins-1) | % { $percent = $_ * 100 / $NumOfMins
                        Write-Progress -Activity Break -Status "$($NumOfMins - $_) minutes remaining..." -PercentComplete $percent #Write Progress bar and move each minute
                        Sleep -Seconds 60 
    }
	$PhoneSite = Invoke-WebRequest $fullSite  #invoke the 2nd webrequest to dunsguide to check the "new" Phone number
	$Phone = $PhoneSite.ParsedHtml.body.getElementsByClassName("contactInfoOptionTitle infoTableText phone") | select -ExpandProperty outerText  #Parse the HTML and exract the "Pure" phone number
	if ($oldPhone -ne $Phone -and $Phone -ne $null) { Write-Host $(Get-date) $Phone; $speak.Speak('The Phone Has Been Fixed') ; break } else { write-host $(Get-date) $Phone "Still The Same"} #Check if the Phone number has been change, if so write the full date and the new number and then say that Phone number has been fixed and end the script. else write on screen the date and the phone number are the same and continue looping till the number has been changed
}
