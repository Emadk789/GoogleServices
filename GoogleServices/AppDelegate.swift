//
//  AppDelegate.swift
//  GoogleServices
//
//  Created by Emad Albarnawi on 23/07/2020.
//  Copyright © 2020 Emad Albarnawi. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps;
import GooglePlaces;
import GoogleSignIn;
//import GTMSessionFetcher;
//import GoogleAPIClientForREST;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate, GIDSignInUIDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
        print("\(error.localizedDescription)")
        // [START_EXCLUDE silent]
        NotificationCenter.default.post(
          name: Notification.Name(rawValue: "ToggleAuthUINotification"), object: nil, userInfo: nil)
            } else {
              // Perform any operations on signed in user here.
              let userId = user.userID                  // For client-side use only!
              let idToken = user.authentication.idToken // Safe to send to the server
              let fullName = user.profile.name
              let givenName = user.profile.givenName
              let familyName = user.profile.familyName
              let email = user.profile.email
              // [START_EXCLUDE]
              NotificationCenter.default.post(
                name: Notification.Name(rawValue: "ToggleAuthUINotification"),
                object: nil,
                userInfo: ["statusText": "Signed in user:\n\(fullName)"])
              // [END_EXCLUDE]
//              print("\(error.localizedDescription)")
            }
    }
    
    private func setupGoogleSignIn() {
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().scopes = [kGTLRAuthScopeDrive]
        GIDSignIn.sharedInstance()?.signInSilently()
    }
    


//    AIzaSyDztdHzApqyn5K1cmLJTnLW0BNvN6w39fY
//    Client 29001001549-ts2a9b1qcl1utab9ge8lcmod9o4p78va.apps.googleusercontent.com
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance().clientID = "29001001549-ts2a9b1qcl1utab9ge8lcmod9o4p78va.apps.googleusercontent.com";
        GIDSignIn.sharedInstance().delegate = self;
        
        
        GMSServices.provideAPIKey("AIzaSyDztdHzApqyn5K1cmLJTnLW0BNvN6w39fY");
        GMSPlacesClient.provideAPIKey("AIzaSyDztdHzApqyn5K1cmLJTnLW0BNvN6w39fY");
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 9.0, *)
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
                                                 sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return GIDSignIn.sharedInstance().handle(url,
        sourceApplication: sourceApplication,
        annotation: annotation)
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoogleServices")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

