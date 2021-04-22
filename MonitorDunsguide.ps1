Add-Type -AssemblyName System.speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$dunsguideSite = "https://www.dunsguide.co.il/"
$dunsguideURI = "en/Cd7b8333d734ebd031fa61f94e555117f_high_tech_computing_services/microsoft_israel/"
$fullSite = $dunsguideSite+$dunsguideURI
$PhoneSite = iwr $fullSite
$oldPhone = $PhoneSite.ParsedHtml.body.getElementsByClassName("contactInfoOptionTitle infoTableText phone") | select -ExpandProperty outerText
while($true)
{
$PhoneSite = iwr $fullSite
$Phone = $PhoneSite.ParsedHtml.body.getElementsByClassName("contactInfoOptionTitle infoTableText phone") | select -ExpandProperty outerText
if ($oldPhone -ne $Phone) { write-host $(Get-date) $Phone; $speak.Speak('The Phone Has Been Fixed') ; break } else { write-host $(Get-date) $Phone "Still The Same"}
sleep -Seconds (60*10)
}
