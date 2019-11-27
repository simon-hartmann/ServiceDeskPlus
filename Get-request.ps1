
$ApiKey = "D89B534B-A2CA-4E31-A992-0D23C472EA9E" # Technician API Key
$SdpUri = "https://demo.servicedeskplus.com" # SDP URL
$header = @{TECHNICIAN_KEY=$ApiKey}

# Gets information on an existing request
function Get-Request
{
[CmdletBinding()]
param
(
[Parameter(Mandatory=$true, ValueFromPipelineByPropertyName=$true, Position=0)]
[alias ("id")]
[Int32]
$RequestID,
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
[String]
$Manager, # Manager field
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
[String]
$RequestFor # Person Request is For
)
$input= @"
{}
"@
#$params = @{input_data=$input;format='json'}
$Uri = $SdpUri + "/api/v3/requests/" + $RequestID
$result = Invoke-RestMethod -Method Get -Uri $Uri -Headers $header #-OutFile "C:\Users\pablo\source\Power1\Ticket.json"
$test = $result.request
$test
#$request.psobject.TypeNames.Insert(0, "Request")
}
Get-Request 18