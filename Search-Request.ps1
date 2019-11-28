
$ApiKey = "FE305333-9BBB-40FD-A93F-6E5719586C54" # Technician API Key
$SdpUri = "https://demo.servicedeskplus.com" # SDP URL
$header = @{TECHNICIAN_KEY=$ApiKey}
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
function Search-Request
{
[CmdletBinding()]
param
(
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true, Position=0)]
[alias ("id")]
[Int32]
$RequestID,
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
[String]
$subject,
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
[String]
$priority,
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
[String]
$Group,
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
[String]
$status
)
$filterby = @{
    name = "open_system"
}
#$search =search_fields =@{}
$input = @{
    list_info = @{
        "row_count"= "500"
        "start_index"= "1"
        "sort_field"= "subject"
        "sort_order"= "asc"
        "get_total_count"= $true
        search_fields =@{}

    }
}
if($status -eq "open") {
    $input.list_info.Add("filter_by", $filterby)
}
if(!$subject -eq "") {
    $input.list_info.search_fields.add("subject", $subject)
}

$inputJson = $input| ConvertTo-Json -Depth 10
#$inputJson
$params = @{input_data=$inputJson;format='json'}
#$params
$Uri = $SdpUri + "/api/v3/requests"
$result = Invoke-RestMethod -Method Get -Uri $Uri -Headers $header -Body $params #-OutFile "C:\Users\pablo\source\Power1\Ticket.json"
#$result
$results = $result.requests
$results# | foreach {"RequestID:" + $_.id + " ",  "Subject" + $_.subject, "Requester " + $_.Requester.name}
}
Search-Request -subject mainte