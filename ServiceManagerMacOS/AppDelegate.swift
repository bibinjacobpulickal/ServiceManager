//
//  AppDelegate.swift
//  CocoaTest
//
//  Created by Bibin Jacob Pulickal on 21/05/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    var window: NSWindow!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        window = NSWindow(contentViewController: ServiceController())
        window?.makeKeyAndOrderFront(nil)
    }
}

