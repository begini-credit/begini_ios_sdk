Begini iOS SDK V1.1.0

<b>Pre-requisites</b>

Download and install xcode from https://developer.apple.com/xcode/.  Latest supporting iOS SDK version is  Xcode 13.3. 

Before starting integration you must have a valid Integration ID and API Key from the Begini dashboard, while using the SDK these data must be passed to SDK.

<b>To get a Git project into your build</b>
 
 CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. Then in the terminal, cd to your Xcode project root directory (where your .xcodeproj file resides) and type:
   
```ruby
  pod init
```
      
Your Podfile will get open in text mode. Initially there will be some default commands in there. To integrate begini_ios_sdk into your Xcode project using CocoaPods, specify it in your podfile:

```ruby
  pod 'begini_ios_sdk'
 ```
 
Or you can choose the version based on your requirements
 
```ruby
 pod 'begini_ios_sdk', '1.1.0'
 ```
 
<b>Mandatory permissions</b>

Internet access
 
```swift
<key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
</key>

 ```

Non mandatory permissions
 
 ```swift
<key>NSCalendarsUsageDescription</key>
    <string>Having access to calendar events helps us determine how busy you are. We use this as a signal for building your credit score.</string>
<key>NSContactsUsageDescription</key>
    <string>We access your contacts details to determine a list of people you socialise with. This data helps us to then build a social graph to assist with your credit score. We will only use this data for your personal score and we will not contact any of these people in your contact list.</string>
<key>NSLocationWhenInUseUsageDescription</key>
    <string>We study locational activity. This helps us estimate with a fair level of accuracy your most visited locations. We use this as a signal for building your credit score.</string>
<key>NSPhotoLibraryUsageDescription</key>
    <string>We use read access to Photos to extract geo-location information from image files. This helps us estimate with a fair level of accuracy your most visited locations. We use this as a signal for building your credit score</string>
 ```
 
Non mandatory permissions can be used according to your requirements. We will explain that later.

<b>Starting Begini SDK integration.</b>

Begini SDK works in a BeginiAuthorize class. 

<b>Setup SDK Request</b>

<b>BeginiDataSdkOptions</b>

BeginiDataSdkOptions is the Class which will contain the request from your application to Begini SDK.

Begini SDK  reads device data in order to create the most accurate credit score.  That is,

Contacts, Calendar, Battery information, Bluetooth Information, Wifi information, Gallery, Location and Profile (includes Screen,volume,hardware and phone settings Information). BeginiDataSdkOptions lets you decide which of those device data can be accessed for your App.

Also the integration id,api key and uid must be passed to Begini SDK via BeginiDataSdkOptions request.

u_id= is the id of the user which can be decided by the client app, but for each user the u_id should be different.

 ```swift
func BeginiDataSdkOptions(integration_id : String, api_key : String, isContactsEnabled : Bool,  isProfileEnabled : Bool, u_id : String, isBatteryEnabled : Bool,  isWifiEnabled : Bool,  isGalleryExifDataEnabled : Bool,  isCalendarEnabled : Bool,  isLocationEnabled : Bool, primaryColor : UIColor,  delegate : BeginiAuthorizeDelegate, presentingVC: UIViewController)
 ```
 
Example initialization of BeginiDataSdkOptions
          
```swift
BeginiAuthorize.shared.BeginiDataSdkOptions(integration_id : "621751ae4b75ebb46baa61e8", api_key : "1b43fbc0-8ec8-419e-a7ec-9e31d2d05345"
, isContactsEnabled : true,  isProfileEnabled : true, u_id: email,  isBatteryEnabled : true,  isWifiEnabled : true,  isGalleryExifDataEnabled : true,  isCalendarEnabled : true,  isLocationEnabled : true,primaryColor : .red,  delegate : self, presentingVC: self)
```
  
The non-mandatory permissions can be added according to the request that passing through the BeginiDataSdkOptions

That is, If isContactsEnabled= true
 
```swift
<key>NSContactsUsageDescription</key>
    <string>We access your contacts details to determine a list of people you socialise with. This data helps us to then build a social graph to assist with your credit score. We will only use this data for your personal score and we will not contact any of these people in your contact list.</string>
```

Needed to be added to your info.
Likewise
for isCalendarEnabled=true
 
```swift
<key>NSCalendarsUsageDescription</key>
    <string>Having access to calendar events helps us determine how busy you are. We use this as a signal for building your credit score.</string>
```

for isWifiEnabled=true
Enable access wifi information capability in xcode

for isLocationEnabled :=true
 
```swift
<key>NSLocationWhenInUseUsageDescription</key>
    <string>We study locational activity. This helps us estimate with a fair level of accuracy your most visited locations. We use this as a signal for building your credit score.</string>
```
 
<b>Handling SDK Result</b>

Once you start the BeginiAuthorize you can receive the result of the SDK from BeginiAuthorizeDelegate.
 
```swift
public protocol BeginiAuthorizeDelegate : AnyObject{
    func onAuthorizeStarted()
    func onAuthorizeComplete(status: AuthorizationStatus)
    func onAuthorizeFailure(status: AuthorizationStatus, message : String)
    func onAuthorizeCancelled(status: AuthorizationStatus)
    func onStatusUpdate(status: ProgressStatus)
}

public enum AuthorizationStatus {
    case success
    case failed
    case cancelled
}

public enum ProgressStatus {
    case permission_requesting
    case data_colletion
    case data_sending
    case scroe_generating
    case completed
}
```
 
Results can be identified from BeginiAuthorizeDelegate.

When the authorization starts we will get the callback in func onAuthorizeStarted(). When the status changes we will get the callback on 

```swift
func onStatusUpdate(status: ProgressStatus) with progress status.
```

If the user canceled the user by pressing the back button, we will get the callback on  

```swift
func onAuthorizeCancelled(status: AuthorizationStatus).
```

If the result is failed, we will get the callback on 

```swift
func onAuthorizeFailure(status: AuthorizationStatus, message : String)  with failed message.
```

That is if the result is success , by BeginiAuthorizeDelegate will be 

```swift
func onAuthorizeComplete(status: AuthorizationStatus)
```
