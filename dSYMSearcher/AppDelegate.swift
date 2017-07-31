//
//  AppDelegate.swift
//  dSYMSearcher
//
//  Created by ZhangAo on 31/07/2017.
//  Copyright © 2017 ZhangAo. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        NotificationCenter.default.addObserver(self, selector: #selector(windowWillClose), name: NSNotification.Name.NSWindowWillClose, object: nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func windowWillClose() {
        exit(0)
    }

}

