//
//  WalletsViewControllerViewController.swift
//  BitWallet
//
//  Created by Alessandro Marconi on 16/07/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import Cocoa

class WalletsViewController: NSViewController
{
    @IBOutlet weak var btcAddress: NSTextField!
    @IBOutlet weak var ltcAddress: NSTextField!
    @IBOutlet weak var ethAddress: NSTextField!
    
    func dialogOKCancel(coin: String) -> Bool
    {
        let alert = NSAlert()
        alert.messageText = coin
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        return alert.runModal() == .alertFirstButtonReturn
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.btcAddress.stringValue = Wallet.btcAddress//UserDefaults.standard.string(forKey: "BTCaddress")!
        self.ltcAddress.stringValue = Wallet.ltcAddress//UserDefaults.standard.string(forKey: "LTCaddress")!
        self.ethAddress.stringValue = Wallet.ethAddress//UserDefaults.standard.string(forKey: "ETHaddress")!
    }
}

// MARK: Actions
extension WalletsViewController
{
    @IBAction func saveBTC(_ sender: NSButton) {
        //Should NOT contain additional symbols
        let alphaNumericCharacterSet = NSCharacterSet.alphanumerics
        let filteredCharacters = btcAddress.stringValue.filter {
            return  String($0).rangeOfCharacter(from: alphaNumericCharacterSet) != nil
        }
        btcAddress.stringValue = String(filteredCharacters)
        for _ in 0...btcAddress.stringValue.count
        {
            if btcAddress.stringValue.first == "0"
            {   btcAddress.stringValue = String(btcAddress.stringValue.dropFirst()) }
        }
        
        //Reset
        if btcAddress.stringValue == ""{
            _ = dialogOKCancel(coin: "The value was successfully reseted")
            UserDefaults.standard.set(false, forKey: "BTCdisplay")
        } else {
        
            if btcAddress.stringValue.count == 34{
                GET_BTC(addressBTC: self.btcAddress.stringValue)
                //save the value of crypto address
                UserDefaults.standard.set(CryptoCoins.BTC, forKey: "BTCvalue")
                UserDefaults.standard.set(true, forKey: "BTCdisplay")
                UserDefaults.standard.set(self.btcAddress.stringValue, forKey: "BTCaddress")
                
                /*if let path = Bundle.main.resourceURL?.deletingLastPathComponent().deletingLastPathComponent().absoluteString {
                    NSLog("restart \(path)")
                    _ = Process.launchedProcess(launchPath: "/usr/bin/open", arguments: [path])
                    NSApp.terminate(self)
                }*/
            } else { _ = dialogOKCancel(coin: "Incorrect length of BTC address or contains incorrect symbols!") }
            
        }
    }
    
    @IBAction func saveLTC(_ sender: NSButton) {
        //Should NOT contain additional symbols
        let alphaNumericCharacterSet = NSCharacterSet.alphanumerics
        let filteredCharacters = ltcAddress.stringValue.filter {
            return  String($0).rangeOfCharacter(from: alphaNumericCharacterSet) != nil
        }
        ltcAddress.stringValue = String(filteredCharacters)
        for _ in 0...ltcAddress.stringValue.count
        {
            if ltcAddress.stringValue.first == "0"
            {   ltcAddress.stringValue = String(ltcAddress.stringValue.dropFirst()) }
        }
        
        //Reset
        if ltcAddress.stringValue == ""{
            _ = dialogOKCancel(coin: "The value was successfully reseted")
        } else {
            
            if ltcAddress.stringValue.count == 34{
                GET_LTC(addressLTC: self.ltcAddress.stringValue)
                
                //save the value of crypto address
                UserDefaults.standard.set(CryptoCoins.LTC, forKey: "LTCvalue")
                UserDefaults.standard.set(true, forKey: "LTCdisplay")
                UserDefaults.standard.set(self.ltcAddress.stringValue, forKey: "LTCaddress")
                
                /*if let path = Bundle.main.resourceURL?.deletingLastPathComponent().deletingLastPathComponent().absoluteString {
                    NSLog("restart \(path)")
                    _ = Process.launchedProcess(launchPath: "/usr/bin/open", arguments: [path])
                    NSApp.terminate(self)
                }*/
            } else { _ = dialogOKCancel(coin: "Incorrect length of LTC address or contains incorrect symbols!") }
            
        }
    }
    
    @IBAction func saveETH(_ sender: NSButton) {
        //Should NOT contain additional symbols
        let alphaNumericCharacterSet = NSCharacterSet.alphanumerics
        let filteredCharacters = ethAddress.stringValue.filter {
            return  String($0).rangeOfCharacter(from: alphaNumericCharacterSet) != nil
        }
        ethAddress.stringValue = String(filteredCharacters)
        for _ in 0...ethAddress.stringValue.count
        {
            if ethAddress.stringValue.first == "0"
            {   ethAddress.stringValue = String(ethAddress.stringValue.dropFirst()) }
        }
        
        //Reset
        if ethAddress.stringValue == ""{
            _ = dialogOKCancel(coin: "The value was successfully reseted")
        } else {
            
            if ethAddress.stringValue.count == 41{
                GET_ETH(addressETH: self.ethAddress.stringValue)
                
                //save the value of crypto address
                UserDefaults.standard.set(CryptoCoins.ETH, forKey: "ETHvalue")
                UserDefaults.standard.set(true, forKey: "ETHdisplay")
                UserDefaults.standard.set(self.ethAddress.stringValue, forKey: "ETHaddress")
                
                /*if let path = Bundle.main.resourceURL?.deletingLastPathComponent().deletingLastPathComponent().absoluteString {
                    NSLog("restart \(path)")
                    _ = Process.launchedProcess(launchPath: "/usr/bin/open", arguments: [path])
                    NSApp.terminate(self)
                }*/
            } else { _ = dialogOKCancel(coin: "Incorrect length of ETH address or contains incorrect symbols!") }
            
        }
    }
    
    @IBAction func moreCurrencies(_ sender: NSButton) {
        print("PopUp - buy PRO")
    }
    
    @IBAction func quit(_ sender: NSButton) {
        if self.btcAddress.stringValue == "" {
            //reset the value of crypto BTC
            UserDefaults.standard.set(false, forKey: "BTCdisplay")
            UserDefaults.standard.set(self.ltcAddress.stringValue, forKey: "BTCaddress")
            
        }
        if self.ltcAddress.stringValue == "" {
            //reset the value of crypto LTC
            UserDefaults.standard.set(false, forKey: "LTCdisplay")
            UserDefaults.standard.set(self.ltcAddress.stringValue, forKey: "LTCaddress")
            
        }
        if self.ethAddress.stringValue == "" {
            //reset the value of crypto ETH
            UserDefaults.standard.set(false, forKey: "ETHdisplay")
            UserDefaults.standard.set(self.ltcAddress.stringValue, forKey: "ETHaddress")
        
        }
        NSApplication.shared.terminate(sender)
    }
}

extension WalletsViewController
{
    // MARK: Storyboard instantiation
    static func freshController() -> WalletsViewController {
        //1.
        let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
        //2.
        let identifier = NSStoryboardSegue.Identifier("WalletsViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? WalletsViewController else {
            fatalError("Why cant i find WalletsViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
