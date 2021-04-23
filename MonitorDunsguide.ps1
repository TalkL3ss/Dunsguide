Add-Type -AssemblyName System.speech #Import Speech Namespace to say lound that the number has been change
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer #Create Speech Object
$minTime = 10 #Minimum of time to do the check just to make sure that we dont nodje the server set the same $minTime and $maxTime to set static time
$maxTime = 60 #Maximum of time to do the check just to make sure that we dont nodje the server set the same $minTime and $maxTime to set static time
$dunsguideSite = "https://www.dunsguide.co.il/" #Base Site of dunsguide
$dunsguideURI = "en/Cd7b8333d734ebd031fa61f94e555117f_high_tech_computing_services/microsoft_israel/" #specific uri to check
$fullSite = $dunsguideSite+$dunsguideURI #Create Varibalte with the full url
$PhoneSite = iwr $fullSite #invoke the first webrequest to dunsguide to check the "base" Phone number
$oldPhone = $PhoneSite.ParsedHtml.body.getElementsByClassName("contactInfoOptionTitle infoTableText phone") | select -ExpandProperty outerText #Parse the HTML and exract the "Pure" phone number
while($true)
{
	$NumOfMins = Get-Random -Minimum $minTime -Maximum $maxTime #do random time 
	sleep -Seconds (60*$NumOfMins) #sleep for random time in minutes
	$PhoneSite = iwr $fullSite  #invoke the 2nd webrequest to dunsguide to check the "new" Phone number
	$Phone = $PhoneSite.ParsedHtml.body.getElementsByClassName("contactInfoOptionTitle infoTableText phone") | select -ExpandProperty outerText  #Parse the HTML and exract the "Pure" phone number
	if ($oldPhone -ne $Phone) { write-host $(Get-date) $Phone; $speak.Speak('The Phone Has Been Fixed') ; break } else { write-host $(Get-date) $Phone "Still The Same"} #Check if the Phone number has been change, if so write the full date and the new number and then say that Phone number has been fixed and end the script. else write on screen the date and the phone number are the same and continue looping till the number has been changed
}
