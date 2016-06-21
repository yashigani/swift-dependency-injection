//
//  AppDelegate.swift
//  Movie
//
//  Created by taiki on 2016/06/08.
//  Copyright © 2016年 yashigani. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var repository: PlistRepository!

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.registerDefaults([
            "allmovies": [
                ["title": "STAR WARS Episode 1", "director": "George Lucas"],
                ["title": "STAR WARS Episode 2", "director": "George Lucas"],
                ["title": "STAR WARS Episode 3", "director": "George Lucas"],
                ["title": "STAR WARS Episode 4", "director": "George Lucas"],
                ["title": "STAR WARS Episode 5", "director": "George Lucas"],
                ["title": "STAR WARS Episode 6", "director": "George Lucas"],
            ]
        ])

        repository = PlistRepository(userDefaults: defaults)
        if let vc = window?.rootViewController?.childViewControllers.first as? MoviesViewController {
            vc.repository = repository
        }
        return true
    }

}
