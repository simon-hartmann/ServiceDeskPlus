
$ApiKey = "D89B534B-A2CA-4E31-A992-0D23C472EA9E" # Technician API Key
$SdpUri = "https://demo.servicedeskplus.com" # SDP URL
$header = @{TECHNICIAN_KEY=$ApiKey}
$filter = "Open_System"
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
$Manager, # Manager field
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
[String]
$RequestFor, # Person Request is For
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
[String]
$subject,
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
[String]
$priority,
[Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
[String]
$status
)
$filter_by = @{
        name = $filter
    }
$filterby
$subject = $null
$priority = "high"
$input = @{
    list_info = @{
        "row_count"= "20"
        "start_index"= "1"
        "sort_field"= "subject"
        "sort_order"= "asc"
        "get_total_count"= $true
        search_fields =@{
            "subject" = $subject
            "priority.name" = $priority
        }
        filter_by = $filter_by

    }
}


$inputJson = $input| ConvertTo-Json -Depth 10
$inputJson
$params = @{input_data=$inputJson;format='json'}
$params
$Uri = $SdpUri + "/api/v3/requests"
$result = Invoke-RestMethod -Method Get -Uri $Uri -Headers $header -Body $params #-OutFile "C:\Users\pablo\source\Power1\Ticket.json"
$results = $result.requests
$results | foreach { $_.subject}
}
Search-Request -subject mails