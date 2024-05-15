# MDE Portal Dashboard

The MDE Portal Dashboard is meant to extract information from 3 different data sources to aggregate them and check for things like overall device health, alerts, and the status of various aspects of MDE for a given set of devices.

### Features

This Power BI report contains multiple different tabs for various purposes:

- **Machines** - This page gives an overall breakdown of machines onboarded to the service, including health state, alert stats, and Operating System breakdown
- **Azure Onboarding Status** - This page gives an overall view of Azure Virtual Machines that have been onboarded through Microsoft Defender for Cloud (MDC). It is meant to track devices that have been synchronized from MDC to MDE, and optionally track those that were synced to Entra ID for Policy management through Intune.
- **Alerts** - This page gives a breakdown on Alerts generated in your environment, including statistics on Severity, Status, and individual detailed information.
- **Investigation Results** - This page shows the disposition of alerts within the environment, their category, and the means of resolution.
- **Action Center** - This page shows actions taken on machines within MDE, including counts for machines that are currently under restricted execution, isolation, and files that are blocked.
- **Defender AV** - This is a status page showing information about the Antivirus engine, including items such as engine and signature versions.
- **Network Protection** - This page shows the URLs that have been blocked within the environment.
- **SmartScreen** - This page shows the URLs and files blocked by SmartScreen within the environment.
- **AV Compliance** - This page shows a list of recommended configurations within the environment that can be used to ensure MDE is operating properly and at maximum capacity.

### Configuration

All connectivity to the backend APIs that populate this dashboard is done via a Service Principal that needs to be permissioned in different services to operate properly. One Service Principal is used for this dashboard to work properly.

#### Permissions

- **Microsoft Defender for Endpoint** - To extract data from MDE, the Service Principal needs **Alert.Read.All** and **Machine.Read.All**
- **Microsoft Graph** - To extract data from Microsoft Graph, which includes most detailed information in this report, the Service Principal needs **ThreatHunting.Read.All**
- **Microsoft Azure** - To extract data from Azure, for Azure VMs onboarded through MDC, the Service Principal needs the following permissions at the scope to be monitored:
  - Microsoft.Compute/virtualMachines/read
  - Microsoft.Compute/virtualMachines/\*/read
  - Microsoft.Resources/tags/read

#### Parameters

The following parameters are available in this report, some of which are required while some are optional:

- **Required Parameters**
  - Entra ID Tenant ID - The Tenant ID of the Service Principal used to authenticate
  - Entra Application Client ID - The Client ID (**NOT** the Object ID) of the Service Principal used to authenticate
  - Entra Application Client Secret - The Secret of the Service Principal used to authenticate
- **Optional Parameters**
  - Azure Filter Tag - The Azure Tag Key to filter VMs on in the report. Only VMs with this Tag Key will be returned by the service, and its value can be used in some slicers.
  - Azure Bypass Tag - For devices synchronizing between Azure and MDE, any device with this Tag will have its health monitoring bypassed in the MDE dashboard.
  - Azure VM MDE Device Tag - If writing MDE Device ID back to devices in Azure for correlation, this is the Tag Key being used to house that value.
  - Azure VM Entra Device Tag - If writing Entra Device ID back to devices in Azure for correlation, this is the Tag Key being used to house that value.
