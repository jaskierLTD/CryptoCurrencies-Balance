//
//  PurchaseViewController.swift
//  eWallet
//
//  Created by Alessandro Marconi on 18/07/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import Cocoa

class PurchaseViewController: NSViewController {

    @IBAction func backButton(_ sender: Any) {
        NSApplication.shared.terminate(sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
}

extension PurchaseViewController
{
    // MARK: Storyboard instantiation
    static func freshController() -> WalletsViewController
    {
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        let identifier = NSStoryboardSegue.Identifier("PurchaseViewController")
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? WalletsViewController else {
            fatalError("Why cant i find PurchaseViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
