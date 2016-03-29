//
//  Copyright (c) 2016 Google Inc.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

//
// For more information on setting up and running this sample code, see
// https://developers.google.com/firebase/docs/auth/ios/user-auth
//

import UIKit

// [START usermanagement_import]
import Firebase.Core
import FirebaseApp
import FirebaseAuth
import FirebaseAuthUI
import Firebase.SignIn
// [END usermanagement_import]

import Fabric
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let kFacebookAppID = "Placeholder"

  func application(application: UIApplication, didFinishLaunchingWithOptions
      launchOptions: [NSObject: AnyObject]?) -> Bool {
    // [START firebase_configure]
    // Use Firebase library to configure APIs
    do {
      try FIRContext.sharedInstance().configure()
    } catch let configureError as NSError {
      print ("Error configuring Firebase services: \(configureError)")
    }
    FIRApp.configure()
    // [END firebase_configure]

    FBSDKApplicationDelegate.sharedInstance().application(application,
        didFinishLaunchingWithOptions:launchOptions)
    Fabric.with([Twitter.self])
    return true
  }

  func application(app: UIApplication, openURL url: NSURL, options: [String : AnyObject]) -> Bool {
    if #available(iOS 9.0, *) {
      if (FIRFirebaseApp.handleOpenURL(url,
          sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as! String)) {
        return true
      }
    } else {
      // Fallback on earlier versions
    }
    return false
  }

  func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    if GIDSignIn.sharedInstance().handleURL(url, sourceApplication: sourceApplication, annotation: annotation) {
      return true
    }
    return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
  }
}
