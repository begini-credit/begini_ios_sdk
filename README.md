Begini iOS SDK V1.0.0

Pre-requisites
Download and install xcode from https://developer.apple.com/xcode/.  Latest supporting iOS SDK version is  Xcode 13.3. 
Before starting integration you must have a valid Integration ID and API Key from the Begini dashboard, while using the SDK these data must be passed to SDK.
 To get a Git project into your build 
CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. Then in the terminal, cd to your Xcode project root directory (where your .xcodeproj file resides) and type:
                                                        
  pod init
                     
Your Podfile will get open in text mode. Initially there will be some default commands in there. To integrate begini_ios_sdk into your Xcode project using CocoaPods, specify it in your podfile:
 
  pod 'begini_ios_sdk'
 
Or you can choose the version based on your requirements
 
 pod 'begini_ios_sdk', '1.0.0'

Mandatory permissions
Internet access
 
<key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
</key>

Non mandatory permissions
 
<key>NSCalendarsUsageDescription</key>
    <string>Having access to calendar events helps us determine how busy you are. We use this as a signal for building your credit score.</string>
    <key>NSContactsUsageDescription</key>
    <string>We access your contacts details to determine a list of people you socialise with. This data helps us to then build a social graph to assist with your credit score. We will only use this data for your personal score and we will not contact any of these people in your contact list.</string>
    <key>NSLocationWhenInUseUsageDescription</key>
    <string>We study locational activity. This helps us estimate with a fair level of accuracy your most visited locations. We use this as a signal for building your credit score.</string>
    <key>NSPhotoLibraryUsageDescription</key>
    <string>We use read access to Photos to extract geo-location information from image files. This helps us estimate with a fair level of accuracy your most visited locations. We use this as a signal for building your credit score</string>
 

Non mandatory permissions can be used according to your requirements. We will explain that later.
Starting Begini SDK integration.
Begini SDK works in a BeginiAuthorize class. 
Setup SDK Request
BeginiDataSdkOptions
BeginiDataSdkOptions is the Class which will contain the request from your application to Begini SDK.
Begini SDK  reads device data in order to create the most accurate credit score.  That is,
Contacts, Calendar, Battery information, Bluetooth Information, Wifi information, Gallery, Location and Profile (includes Screen,volume,hardware and phone settings Information, ). BeginiDataSdkOptions lets you decide which of those device data can be accessed for your App.
Also the integration id,api key and uid must be passed to Begini SDK via BeginiDataSdkOptions request.
 u_id= is the id of the user which can be decided by the client app, but for each user the u_id should be different.

func BeginiDataSdkOptions(integration_id : String, api_key : String, isContactsEnabled : Bool,  isProfileEnabled : Bool, u_id : String, isBatteryEnabled : Bool,  isWifiEnabled : Bool,  isGalleryExifDataEnabled : Bool,  isCalendarEnabled : Bool,  isLocationEnabled : Bool, primaryColor : UIColor,  delegate : BeginiAuthorizeDelegate, presentingVC: UIViewController)

 
Example initialization of BeginiDataSdkOptions
                          
BeginiAuthorize.shared.BeginiDataSdkOptions(integration_id : "621751ae4b75ebb46baa61e8", api_key : "1b43fbc0-8ec8-419e-a7ec-9e31d2d05345"
, isContactsEnabled : true,  isProfileEnabled : true, u_id: email,  isBatteryEnabled : true,  isWifiEnabled : true,  isGalleryExifDataEnabled : true,  isCalendarEnabled : true,  isLocationEnabled : true,primaryColor : .red,  delegate : self, presentingVC: self)
 
The non-mandatory permissions can be added according to the request that passing through the BeginiDataSdkOptions
That is,
If isContactsEnabled= true
 
<key>NSContactsUsageDescription</key>
    <string>We access your contacts details to determine a list of people you socialise with. This data helps us build a social graph to assist with your credit score. We will only use this data for your personal score and we will not contact any of the people in your contact list.</string>


Needed to be added to your info.
Likewise
for isCalendarEnabled=true
 
<key>NSCalendarsUsageDescription</key>
    <string>Having access to your Calendar information helps us determine how much you use your calendar to organize your life. We use this as a signal for building your credit score.</string>



for isWifiEnabled=true
Enable access wifi information capability in xcode

for isLocationEnabled :=true
 
<key>NSLocationWhenInUseUsageDescription</key>
    <string>This helps us make sure that you live where you say you live and flag possible fraudulent accounts.</string>
 

 
Handling SDK Result
Once you start the BeginiAuthorize you can receive the result of the SDK from BeginiAuthorizeDelegate.
 
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

 
Results can be identified from BeginiAuthorizeDelegate.
When the authorization starts we will get the callback in func onAuthorizeStarted(). When the status changes we will get the callback on func onStatusUpdate(status: ProgressStatus) with progress status.
If the user canceled the user by pressing the back button, we will get the callback on  func onAuthorizeCancelled(status: AuthorizationStatus).
If the result is failed, we will get the callback on func onAuthorizeFailure(status: AuthorizationStatus, message : String)  with failed message.
That is if the result is success , by BeginiAuthorizeDelegate will be func onAuthorizeComplete(status: AuthorizationStatus)
