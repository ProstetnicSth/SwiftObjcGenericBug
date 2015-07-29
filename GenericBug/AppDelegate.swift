//
//  AppDelegate.swift
//  GenericBug
//
//  Created by Seyithan Teymur on 29/07/15.
//  Copyright © 2015 Brokoli. All rights reserved.
//

import UIKit
import TestFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        var myobject = MyClass(name: "")
        var myGenericClass = MyGenericClass<MyClass>()
        
        return true
    }

}

