//
//  ViewController.swift
//  dSYMSearcher
//
//  Created by ZhangAo on 31/07/2017.
//  Copyright © 2017 ZhangAo. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var inputBar: NSTextField!
    @IBOutlet var searchButton: NSButton!
    @IBOutlet var resultView: NSTextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func search(sender: NSView) {
        let originalUUID = self.inputBar.stringValue
        
        guard originalUUID.characters.count > 0 else {
            return
        }
        
        let finalUUID = self.generateLegalUUID(originalUUID: originalUUID)
        self.inputBar.stringValue = finalUUID
        
        if let result = self.search(UUID: finalUUID) {
            if result.characters.count > 0 {
                self.resultView.string = result
            } else {
                self.resultView.string = "Not found."
            }
        }
    }
    
    func generateLegalUUID(originalUUID: String) -> String {
        if originalUUID.characters.count == 32 {
            var newUUID = originalUUID.uppercased()
            newUUID.insert("-", at: newUUID.index(newUUID.startIndex, offsetBy: 8))
            newUUID.insert("-", at: newUUID.index(newUUID.startIndex, offsetBy: 13))
            newUUID.insert("-", at: newUUID.index(newUUID.startIndex, offsetBy: 18))
            newUUID.insert("-", at: newUUID.index(newUUID.startIndex, offsetBy: 23))
            return newUUID
        } else {
            return originalUUID
        }
    }
    
    func search(UUID: String) -> String? {
        let pipe = Pipe()
        let process = Process()
        
        process.launchPath = "/usr/bin/mdfind"
        process.arguments = ["com_apple_xcode_dsym_uuids == " + UUID]
        process.standardOutput = pipe
        
        let fileHandle = pipe.fileHandleForReading
        process.launch()

        return String(data: fileHandle.readDataToEndOfFile(), encoding: .utf8)
    }

}

