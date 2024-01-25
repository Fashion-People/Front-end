//
//  AppDelegate.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit
import AWSCore
import AWSS3
import AWSCognito

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // AWS S3
        let credentialsProvider = AWSStaticCredentialsProvider(accessKey: S3Configuration.ACCESS_KEY.rawValue, secretKey: S3Configuration.SECRET_KEY.rawValue)

        let configuration = AWSServiceConfiguration(region:.APNortheast2,
                                                    credentialsProvider:credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let tuConf = AWSS3TransferUtilityConfiguration()
        tuConf.isAccelerateModeEnabled = false

        AWSS3TransferUtility.register(
            with: configuration!,
            transferUtilityConfiguration: tuConf,
            forKey: S3Configuration.FILE_KEY.rawValue
        )
        print("[ SUCCESS TO CONNECT AWS S3 ]")

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

