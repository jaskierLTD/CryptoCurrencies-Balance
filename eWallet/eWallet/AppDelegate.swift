//
//  AppDelegate.swift
//  BitWallet
//
//  Created by Alessandro Marconi on 16/07/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import Cocoa
struct CryptoCoins
{
    static var ETH:Double = 0.00
    static var BTC:Double = 0.00
    static var LTC:Double = 0.00
}

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate
{
    let statusItem = NSStatusBar.system.statusItem(withLength: 170)
    let popover = NSPopover()
    var eventMonitor: EventMonitor?
    
    func applicationDidFinishLaunching(_ aNotification: Notification)
    {
        
        if let button = statusItem.button
        {
            //Output the values
            var walletsAmount: Int = 0
            var totalStringMenu: String = ""

            if UserDefaults.standard.bool(forKey: "BTCdisplay") == true {
                walletsAmount = walletsAmount + 1
                totalStringMenu = totalStringMenu+"\(UserDefaults.standard.double(forKey: "BTCvalue").makeShort1f()) BTC, "
            }
            if UserDefaults.standard.bool(forKey: "LTCdisplay") == true {
                walletsAmount = walletsAmount + 1
                totalStringMenu = totalStringMenu+"\(UserDefaults.standard.double(forKey: "LTCvalue").makeShort1f()) LTC, "
            }
            if UserDefaults.standard.bool(forKey: "ETHdisplay") == true {
                walletsAmount = walletsAmount + 1
                totalStringMenu = totalStringMenu+"\(UserDefaults.standard.double(forKey: "ETHvalue").makeShort1f()) ETH, "
            }
            
            if (walletsAmount == 0)
            {
                //No addresses given
                button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
                
            }
                
                //in case only 1 value =0.02f
                if walletsAmount == 1
                {
                    if Wallet.displayBTC == true { totalStringMenu = "\(UserDefaults.standard.double(forKey: "BTCvalue").makeShort2f()) BTC, " }
                    if Wallet.displayLTC == true { totalStringMenu = "\(UserDefaults.standard.double(forKey: "LTCvalue").makeShort2f()) LTC, " }
                    if Wallet.displayETH == true { totalStringMenu = "\(UserDefaults.standard.double(forKey: "ETHvalue").makeShort2f()) ETH, " }
                }
                button.title.append(contentsOf: totalStringMenu.dropLast().dropLast())
                button.action = #selector(togglePopover(_:))
        }
        popover.contentViewController = WalletsViewController.freshController()
        
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown])
        { [weak self] event in
            if let strongSelf = self, strongSelf.popover.isShown
            {
                strongSelf.closePopover(sender: event)
            }
        }
        
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore
        {
            print("Not first launch.")
        } else {
            print("First launch, setting UserDefault.")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            popover.show(relativeTo: (statusItem.button?.bounds)!, of: statusItem.button!, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
        
        //--------------------------------- UNCOMMENT TO RESET THE FIRST LAUNCH ---------------------------------
        //UserDefaults.standard.set(false, forKey: "launchedBefore")
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc func printQuote(_ sender: Any?) {
        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
        let quoteAuthor = "Mark Twain"
        
        print("\(quoteText) — \(quoteAuthor)")
    }
    
    @objc func togglePopover(_ sender: Any?)
    {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
    
    func showPopover(sender: Any?)
    {
        if let button = statusItem.button
        {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            eventMonitor?.start()
        }
    }
    
    func closePopover(sender: Any?)
    {
        popover.performClose(sender)
        eventMonitor?.stop()
    }
    
    func constructMenu()
    {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Save address", action: #selector(AppDelegate.printQuote(_:)), keyEquivalent: "S"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "Q"))
        
        statusItem.menu = menu
    }
}

