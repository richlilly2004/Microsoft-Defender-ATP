# Tag-DecomissionedMachines-Initial
author: Rich Lilly

This playbook will tag all machines that haven't checked in, in the last 30 days, with the tag Decommissioned. This playbook is a one-time only run, please use the additional playbook in this repo for a recurring job.
Note that the account you setup for MDE must have at least the Alerts investigation role.

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Frichlilly2004%2FMicrosoft-Defender-ATP%2Fmaster%2FLogicApps%2FTag-DecomissionedMachines-Initial%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton""/>
</a>
<a href="https://portal.azure.us/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Frichlilly2004%2FMicrosoft-Defender-ATP%2Fmaster%2FPlaybooks%2FTag-DecomissionedMachines-Initial%2Fazuredeploy.json" target="_blank">
<img src="https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/1-CONTRIBUTION-GUIDE/images/deploytoazuregov.png"/>
</a>