Function ConvertTo-UnixTime {
	<#
.SYNOPSIS
Returns UnixTime of a given date.

.DESCRIPTION
Returns UnixTime as a whole number.

.PARAMETER Date
A DateTime object to return the UnixTime of.

.EXAMPLE
Get-Date | ConvertTo-UnixTime

#>
	[CmdletBinding()]
	[OutputType('System.Integer')]
	Param(
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[DateTime]$Date,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[switch]$Milliseconds
	)
	begin {
		$currentCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
	}
	process {
		[System.Threading.Thread]::CurrentThread.CurrentCulture = "en-US"

		$UnixTime = [math]::Round($(Get-Date $Date.ToUniversalTime() -UFormat %s))

		If ($Milliseconds) {
			$UnixTime = $UnixTime * 1000
		}

		$UnixTime
	}
	end {
		[System.Threading.Thread]::CurrentThread.CurrentCulture = $currentCulture
	}
}