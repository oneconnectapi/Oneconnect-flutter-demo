# Integrate oneconnect SDK in Flutter
<p style="text-align: center;">We Accept the Payment Via <a href="https://coincardx.com/register/devoneconnect" target="_blank">Coincardx.com</a>&nbsp;and Debit &amp; Credit Card For Buy Paid Plans</p>
OneConnect VPN is a private virtual network that has unique features and has high security. Any Developers can Create their Dream VPN App Using Our SDK and Resource, it support android and iOS 
<br>
<br>
<p><a href="https://oneconnect-1.gitbook.io/oneconnect-sdk-for-android-doc/integrate-oneconnect-sdk-in-flutter"><strong><span style="color: rgb(97, 189, 109); font-size: 96px;">Click Here to Get Full Documentation</span></a></p> 
	
## Prerequisites
*Install OneConnect library by putting this code in Pubsec.yaml*
``` 
oneconnect_flutter: ^1.0.1
```

*Import OneConnect library in you Dart file*
```
import 'package:oneconnect_flutter/openvpn_flutter.dart';
```
<br>

## Fetch Servers
* **Create instance of OpenVPN**
```
OpenVPN openVPN = OpenVPN();
```
* **Initialize OneConnect**
```
var oneConnectKey = "YOUR_ONECONNECT_API_KEY";
openVPN.initializeOneConnect(context, oneConnectKey); //Put BuildContext and API key
```

* **Save servers to list**<br>
*VpnServer class contains the server id, name, flag, ovpn configuration, username, password and server type (free or pro)*
```
List<VpnServer> vpnServerList = [];

vpnServerList.addAll(await AppConstants.openVPN.fetchOneConnect(OneConnect.free)); //Free
vpnServerList.addAll(await AppConstants.openVPN.fetchOneConnect(OneConnect.pro)); //Pro

//Logging first server from vpnServerList for visualization
debugPrint("${vpnServerList[0].id}"); //Server id
debugPrint("${vpnServerList[0].serverName}"); //Server name as show in OneConnect account
debugPrint("${vpnServerList[0].flagUrl}"); //Country flag image url of server
debugPrint("${vpnServerList[0].ovpnConfiguration}"); //Configuration exclusive to OpenVPN
debugPrint("${vpnServerList[0].vpnUserName}"); //Vhandle by SDK itself
debugPrint("${vpnServerList[0].vpnPassword}"); //handle by SDK itself
debugPrint("${vpnServerList[0].isFree}"); //Equals to 1 of server is free
```
<br>

## Connecting to VPN
* **Declare variables**<br>
*Select a server from the server list you have fetched earlier then save that to 'vpnConfig'*

```
VPNStage? vpnStage;
VpnStatus? vpnStatus;
VpnServer? vpnConfig; //Initialize variable later using a server from vpnServerList

//OpenVPN engine
late OpenVPN engine;

//Check if VPN is connected
bool get isConnected => vpnStage == VPNStage.connected;
```

* **Initialize VPN engine**
```
    engine = OpenVPN(
        onVpnStageChanged: onVpnStageChanged,
        onVpnStatusChanged: onVpnStatusChanged)
      ..initialize(
        lastStatus: onVpnStatusChanged,
        lastStage: (stage) => onVpnStageChanged(stage, stage.name),
        groupIdentifier: groupIdentifier,
        localizedDescription: localizationDescription,
        providerBundleIdentifier: providerBundleIdentifier,
      );
  
```

* **Required methods**
```
//VPN status changed
void onVpnStatusChanged(VpnStatus? status) {
	vpnStatus = status;
}

//VPN stage changed
void onVpnStageChanged(VPNStage stage, String rawStage) {
	vpnStage = stage;
	if (stage == VPNStage.error) {
	  Future.delayed(const Duration(seconds: 3)).then((value) {
	    vpnStage = VPNStage.disconnected;
	  });
	}	
}
```

* **Connect to VPN using OneConnect**<br>
*For the sake of demonstration, we will use the first server (position 0) in vpnServerList and save that to 'vpnConfig'. Modify the code based on how to select servers in your project*
```
void connect() async {

    vpnConfig = vpnServerList[0];

	const bool certificateVerify = true; //Turn it on if you use certificate
	String? config;
	
	try {
	  config = await OpenVPN.filteredConfig(vpnConfig?.ovpnConfiguration);
	} catch (e) {
	  config = vpnConfig?.ovpnConfiguration;
	}
	
	if (config == null) return;
	
	engine.connect(
	  config,
	  vpnConfig!.serverName,
	  certIsRequired: certificateVerify,
	  username: vpnConfig!.vpnUserName,
	  password: vpnConfig!.vpnPassword,
	);
}
```

* **Disconnect VPN**
```
engine.disconnect();
```

  
# Note :- Any Developer, those who want to Use or Sell for end Client
  they need to make the sufficient Changes in the Original Demo Project.
  

* **Use of demo project**

  Required flutter version 3.16.5

  run the project > Go to lib/core/resources/environment.dart
  
<img src="https://oneconnect.top/enviorements.png" style="width: 727px;">

  and put your oneconnect api key for fatch servers in app

  * **How do i  get oneconnect key follow this**

  <p><a href="https://oneconnect-1.gitbook.io/oneconnect-sdk-for-android-doc"><strong><span style="color: rgb(97, 189, 109); font-size: 96px;">Click here to create oneconney api key</span></a></p> 

  # Just Smile after get the Project..... <strong>(^_^)</strong></pre>
