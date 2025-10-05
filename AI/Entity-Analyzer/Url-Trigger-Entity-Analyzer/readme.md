# URL Entity Analyzer - Microsoft Sentinel Playbook

Activating the 'Deploy' button initiates the deployment of an Azure Logic App integrated with Security Copilot Actions, utilizing a Microsoft Sentinel entity trigger.
The Logic App is configured to run when a URL entity is selected in a Sentinel incident. This Logic App analyzes suspicious URLs and provides detailed security insights including classification, analysis results, and recommendations.

The playbook automatically triggers when:
- A URL entity is identified in a Microsoft Sentinel incident
- Security analysts need detailed analysis of suspicious URLs
- Automated threat intelligence is required for URL-based investigations

After the analysis is complete, Security Copilot conducts a comprehensive investigation of the URL entity and automatically adds a detailed comment to the incident with:
- **Classification**: Security classification of the URL
- **Entity Type**: Confirmation of the URL entity type
- **Analysis Result**: Detailed security analysis findings
- **Recommendation**: Security recommendations based on the analysis
- **Disclaimer**: AI-generated analysis disclaimer
- **Data Sources**: List of data sources used in the analysis

### Prerequisites

Prior to beginning the installation process, it's crucial to confirm that you have met the following prerequisites:
- The user deploying this Logic App needs to have a **Contributor Role**
- You have enabled the **Security Copilot license** on your tenant
- The user has permissions to access **Microsoft Sentinel** workspace
- You have the **Workspace ID** for your Sentinel environment
- The **SentinelMCP connector** is available in your environment

### Parameters

During deployment, you'll need to provide:
- **PlaybookName**: Name for the Logic App (default: "Entity-analyzer-Url-Trigger")
- **lookBackDays**: Number of days to look back for entity analysis (default: 10 days)
- **workspaceId**: Your Microsoft Sentinel workspace ID (required)

### Deployment 

To deploy the URL Entity Analyzer Logic App:
1. Press on the Deploy button below
2. Select your subscription and resource group (use the same tenant where Security Copilot is enabled)
3. Provide the required Workspace ID parameter
4. Configure the lookBackDays parameter if needed (default is 10 days)

<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2FYaniv-Shasha%2FSentinel%2Fmain%2FAI%2FEntity-Analyzer%2FEntity-Trigger%2Fazuredeploy.json" target="_blank">
    <img src="https://aka.ms/deploytoazurebutton"/>
</a>

### Post Deployment

After successful deployment:
- The Logic App will be automatically enabled and ready to use
- **Authenticate the connections**: Go to the Logic App → API connections and authenticate:
  - **Microsoft Sentinel connection**: Authenticate with a user that has Sentinel permissions
  - **SentinelMCP connection**: Authenticate with Security Copilot permissions
- The playbook will automatically trigger when URL entities are processed in incidents
- Results will be automatically added as comments to the relevant incidents

### How It Works

1. **Trigger**: The Logic App triggers when a URL entity is identified in a Sentinel incident
2. **Analysis**: The URL is sent to Security Copilot for comprehensive analysis using the SentinelMCP connector
3. **Processing**: The analysis results are formatted into a readable table format with emojis and proper formatting
4. **Output**: A detailed comment is automatically added to the incident containing:
   - Security classification of the URL
   - Detailed analysis results
   - Security recommendations
   - Data sources used
   - AI-generated disclaimer

### Sample Output

The playbook generates a formatted table comment in the incident with sections like:

| 🔍 **Section** | Details |
|---|---|
| 🏷️ **Classification** | Malicious/Suspicious/Benign |
| 🕵️ **Entity Type** | Url |
| 🔎 **Analysis Result** | Detailed security findings |
| ✅ **Recommendation** | Security recommendations |
| ⚠️ **Disclaimer** | 🤖 AI-generated analysis notice |
| 📂 **Data Sources** | List of threat intelligence sources |

### Troubleshooting

- Ensure both API connections are properly authenticated
- Verify the Workspace ID is correct for your Sentinel environment
- Check that Security Copilot is enabled and accessible
- Confirm the SentinelMCP connector is available in your region