iOS External Documentation
Begini.co


Document Control
Document Title: iOS External Documentation
Document Description:  This document offers clear and accessible explanations of the app's features, functionalities, and user interface, ensuring that external users can make the most of the Begini iOS app to meet their specific needs.
Release Date: 16 Jan 2025


Begini iOS SDK V1.2.2

Pre-requisites
Download and install xcode from https://developer.apple.com/xcode/.  Latest supporting iOS SDK version is  Xcode 13.3. 
Before starting integration you must have a valid Integration ID and API Key from the Begini dashboard, while using the SDK these data must be passed to SDK.
To get a Git project into your build 
CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. Then in the terminal, cd to your Xcode project root directory (where your .xcodeproj file resides) and type:
                                                        
  pod init
                     
Your Podfile will get open in text mode. Initially there will be some default commands in there. To integrate begini_ios_sdk into your Xcode project using CocoaPods, specify it in your podfile:
 
  pod 'begini_ios_sdk'


Or you can choose the version based on your requirements
 
 pod 'begini_ios_sdk', '1.2.2'

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
    <string>We access your contact details to determine a list of people you socialize with. This data helps us to then build a social graph to assist with your credit score. We will only use this data for your personal score and we will not contact any of these people in your contact list.</string>
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

func BeginiDataSdkOptions(
integration_id : String, 
api_key : String, 
isContactsEnabled : Bool, 
 isProfileEnabled : Bool, 
u_id : String, 
isBatteryEnabled : Bool, 
 isWifiEnabled : Bool, 
 isGalleryExifDataEnabled : Bool,  
isCalendarEnabled : Bool,  
isLocationEnabled : Bool, 
isPiiHashingEnabled : Bool, 
primaryColor : UIColor, 
language: String, 
delegate : BeginiAuthorizeDelegate, 
presentingVC: UIViewController
)



 
Example initialization of BeginiDataSdkOptions
                
          
BeginiAuthorize.shared.BeginiDataSdkOptions(
    integration_id: "621751ae4b75ebb46baa61e8",
    api_key: "1b43fbc0-8ec8-419e-a7ec-9e31d2d05345",
    isContactsEnabled: true,
    isProfileEnabled: true,
    u_id: email,
    isBatteryEnabled: true,
    isWifiEnabled: true,
    isGalleryExifDataEnabled: true,
    isCalendarEnabled: true,
    isLocationEnabled: true,
    isPiiHashingEnabled: true,
    primaryColor: ..red,
    language: preferredLanguage,
    delegate: self,
    presentingVC: self
)





The non-mandatory permissions can be added according to the request that passing through the BeginiDataSdkOptions
That is,
If isContactsEnabled= true


<key>NSContactsUsageDescription</key>
    <string>We access your contacts details to determine a list of people you socialise with. This data helps us to then build a social graph to assist with your credit score. We will only use this data for your personal score and we will not contact any of these people in your contact list.</string>



Needed to be added to your info.
Likewise
for isCalendarEnabled=true


<key>NSCalendarsUsageDescription</key>
    <string>Having access to calendar events helps us determine how busy you are. We use this as a signal for building your credit score.</string>



for isWifiEnabled=true
Enable access wifi information capability in xcode

 For  isLocationEnabled :=true


<key>NSLocationWhenInUseUsageDescription</key>
    <string>We study locational activity. This helps us estimate with a fair level of accuracy your most visited locations. We use this as a signal for building your credit score.</string>
 


Using Custom UI with BeginiDataSdkCore
To enable custom UI, use BeginiDataSdkCore. This provides flexibility to design custom UI components while integrating with the SDK.
Function Definition:



public func BeginiDataSdkCore(
    integration_id: String,
    api_key: String,
    isContactsEnabled: Bool,
    isProfileEnabled: Bool,
    u_id: String,
    isBatteryEnabled: Bool,
    isWifiEnabled: Bool,
    isGalleryExifDataEnabled: Bool,
    isCalendarEnabled: Bool,
    isLocationEnabled: Bool,
    isPiiHashingEnabled: Bool,
    primaryColor: UIColor,
    language: String,
    delegate: BeginiAuthorizeDelegate,
    presentingVC: UIViewController,
    useCustomUI: Bool = false
)



Sample Usage:
BeginiAuthorize.shared.customUIViewControllerProvider = {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: "ClientCustomUI")
}


let deviceLanguage = Locale.preferredLanguages.first ?? "en"
let preferredLanguage = deviceLanguage.hasPrefix("th") ? "th" : "en"




let integration_id = "621751ae4b75ebb46baa61e8"
let api_key = "1b43fbc0-8ec8-419e-a7ec-9e31d2d05345"


BeginiAuthorize.shared.BeginiDataSdkCore(
    integration_id: integration_id,
    api_key: api_key,
    isContactsEnabled: true,
    isProfileEnabled: true,
    u_id: email,
    isBatteryEnabled: true,
    isWifiEnabled: true,
    isGalleryExifDataEnabled: true,
    isCalendarEnabled: true,
    isLocationEnabled: true,
    isPiiHashingEnabled: true,
    primaryColor: Utils.shared.theameColor,
    language: preferredLanguage,
    delegate: self,
    presentingVC: self,
    useCustomUI: true
)


Sample code for CustomUI

import UIKit
import begini_ios_sdk
class CustomUIViewController: UIViewController {
    @IBOutlet weak var progressView1: UIProgressView!
    @IBOutlet weak var lblStatus: UILabel!
    weak var progressUpdateDelegate: (any ProgressUpdateDelegate)?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFacadeDelegates()
        startDataCollection()
    }
    /// Configures the facade delegates
       func setupFacadeDelegates() {
           let facade = DataCollectionFacade.shared
           facade.progressUpdateDelegate = self
           facade.dataCollectionDelegate = self
       }
       /// Starts the data collection process
       func startDataCollection() {
           let facade = DataCollectionFacade.shared
           facade.startCollectingData()
       }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


extension CustomUIViewController : ProgressUpdateDelegate{
    func progressUpdated(status: ProgressStatus) {
        let progress: Float
        switch status {
        case .permission_requesting: progress = 0.2
        case .data_colletion: progress = 0.4
        case .data_sending: progress = 0.6
        case .scroe_generating: progress = 0.8
        case .completed: progress = 1.0
        }
        DispatchQueue.main.async {
            self.progressView1.setProgress(progress, animated: true)
            self.lblStatus.text = self.description(for: status)
        }
    }
    func description(for status: ProgressStatus) -> String {
        switch status {
        case .permission_requesting:
            return "Requesting Permissions..."
        case .data_colletion:
            return "Fetching Data..."
        case .data_sending:
            return "Sending Data..."
        case .scroe_generating:
            return "Generating Score..."
        case .completed:
            return "Process Completed"
        }
    }
}
extension CustomUIViewController: DataCollectionDelegate {
    func dataSubmissionCompleted() {
        DispatchQueue.main.async {
            self.progressView1.setProgress(1.0, animated: true)
            self.lblStatus.text = "Data Fetch Completed"
            // Show alert for submission success
            let alert = UIAlertController(
                title: "Success",
                message: "Submission Completed",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                // Dismiss the view controller after success
                self.dismiss(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
    
    func dataSubmissionFailed(message: String, code: String?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Submission Failed",
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                // Optionally, dismiss the view controller after failure
                self.dismiss(animated: true)
            }))
            self.present(alert, animated: true)
        }
    }
    
    func dataSubmissionCancelled(message: String) {
        print("Submission Cancelled: \(message)")
    }
}
extension CustomUIViewController : DataFetchCompletedDelegate{
    // MARK: - DataFetchCompletedDelegate
    func dataFetchCompleted() {
        DispatchQueue.main.async {
            self.lblStatus.text = "Data Fetch Completed"
        }
    }
}
extension CustomUIViewController: ProgressUpdatable {}
extension CustomUIViewController : BeginiAuthorizeDelegate{
    
    func onAuthorizeStarted() {
        print("status: onAuthorizeStarted")
    }
    
    func onAuthorizeComplete(status: AuthorizationStatus) {
        print("status: \(status)")
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showScoreScreen", sender: nil)
        }
    }
    
    func onAuthorizeFailure(status: begini_ios_sdk.AuthorizationStatus, message: String, code: String?) {
        print("status: \(status) message: \(message) code: \(code ?? "empty")")
        DispatchQueue.main.async {
            //MessageMethods.showError(message: message)
            self.performSegue(withIdentifier: "showScoreScreen", sender: message)
        }
    }
    
    func onAuthorizeCancelled(status: begini_ios_sdk.AuthorizationStatus, message: String) {
        print("status: \(status)")
        
        DispatchQueue.main.async {
            // Show an alert dialog with the status message
            let alert = UIAlertController(
                title: "Authorization Cancelled",
                message: "Status: \(status)\nMessage: \(message)",
                preferredStyle: .alert
            )
            
            // Add an OK action
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                // Perform segue after dismissing the alert
                self.performSegue(withIdentifier: "showScoreScreen", sender: message)
            }))
            
            // Present the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func onStatusUpdate(status: begini_ios_sdk.ProgressStatus) {
        let statusMessage: String
        let progress: Float
        switch status {
        case .permission_requesting:
            statusMessage = "Requesting Permissions..."
            progress = 0.2
        case .data_colletion:
            statusMessage = "Fetching Data..."
            progress = 0.4
        case .data_sending:
            statusMessage = "Sending Data..."
            progress = 0.6
        case .scroe_generating:
            statusMessage = "Generating Score..."
            progress = 0.8
        case .completed:
            statusMessage = "Authorization Process Completed"
            progress = 1.0
        }
    }
}







Applying Theme
primaryColor is the theme color of the SDK. All the button colors and progress loaders will show in primaryColor. 

For example :


BeginiAuthorize.shared.BeginiDataSdkOptions(integration_id : "621751ae4b75ebb46baa61e8", api_key : "1b43fbc0-8ec8-419e-a7ec-9e31d2d05345"
, isContactsEnabled : true,  isProfileEnabled : true, u_id: email,  isBatteryEnabled : true,  isWifiEnabled : true,  isGalleryExifDataEnabled : true,  isCalendarEnabled : true,  isLocationEnabled : true,primaryColor : .red,  delegate : self, presentingVC: self)



PII Hashing in Begini iOS SDK
What is PII Hashing?
Personally Identifiable Information (PII) includes any data that could potentially identify a specific individual. In the Begini SDK, sensitive data such as contact details and calendar event information can be hashed before being sent to our servers. This ensures that any identifiable information is obfuscated, providing an additional layer of privacy and security for your users.
Hashing converts PII into a fixed-length string, which is irreversible. This means even if the data is intercepted, it cannot be converted back into its original form.
When isPiiHashingEnabled is true, the SDK will automatically hash sensitive PII data before it is processed.
Contact Information Hashing
When fetching contact details, PII Hashing can be applied to contact names, phone numbers, and email addresses. 
Calendar Event Organizer Hashing
Similarly, the organizer's name in calendar events can also be hashed if isPiiHashingEnabled is set to true


Language Translation Support
Overview
The Begini SDK can adapt its language to match the device’s preferred language setting, ensuring a seamless user experience for international audiences. The SDK currently supports English and Thai, switching between these based on the device's locale.
Implementing Language Translation
The SDK language is set using the language parameter in BeginiDataSdkOptions. By default, it uses the device's primary language. If the device’s language setting starts with "th" (for Thai), the SDK language will be set to Thai. Otherwise, it defaults to English.
Example Implementation
To integrate this feature, you can use the following code:
let deviceLanguage = Locale.preferredLanguages.first ?? "en"
let preferredLanguage = deviceLanguage.hasPrefix("th") ? "th" : "en"

BeginiAuthorize.shared.BeginiDataSdkOptions(
    integration_id: integration_id,
    api_key: api_key,
    isContactsEnabled: true,
    isProfileEnabled: true,
    u_id: email,
    isBatteryEnabled: true,
    isWifiEnabled: true,
    isGalleryExifDataEnabled: true,
    isCalendarEnabled: true,
    isLocationEnabled: true,
    isPiiHashingEnabled: true,
    primaryColor: Utils.shared.themeColor,
    language: preferredLanguage, // Set language based on device preference
    delegate: self,
    presentingVC: self
)

How it Works
Device Language Detection: The device’s preferred language is fetched using Locale.preferredLanguages.
Conditional Language Selection: The app checks if the language code starts with "th" for Thai; if so, the preferredLanguage is set to "th", otherwise to "en".
Passing Language to SDK: The preferredLanguage variable is then passed to the SDK through the languageparameter in BeginiDataSdkOptions, allowing the SDK to localize its interface and messages accordingly.
Handling SDK Result
Once you start the BeginiAuthorize you can receive the result of the SDK from BeginiAuthorizeDelegate.


public protocol BeginiAuthorizeDelegate : AnyObject{
    func onAuthorizeStarted()
    func onAuthorizeComplete(status: AuthorizationStatus)
func onAuthorizeFailure(status: AuthorizationStatus, message: String, code: String?)
    func onAuthorizeCancelled(status: AuthorizationStatus, message: String)
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
If the user canceled the user by pressing the back button, we will get the callback on  func onAuthorizeCancelled(status: AuthorizationStatus, message: String).
That is if the result is success , by BeginiAuthorizeDelegate will be func onAuthorizeComplete(status: AuthorizationStatus)

If the result is failed, we will get the callback on func onAuthorizeFailure(status: AuthorizationStatus, message : String, code: String) with failed message and error code.
Error codes:


IOS0001 - Unexpected error
IOS0002 - Session canceled
IOS0003 - Session expired
IOS0004 - Session incomplete
IOS0005 - Session already submitted



