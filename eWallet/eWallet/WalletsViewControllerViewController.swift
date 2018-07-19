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
    
    var timer: DispatchSourceTimer?
    
    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    deinit {
        self.stopTimer()
    }
    
    func startTimer()
    {
        let queue = DispatchQueue(label: "com.domain.app.timer")  // you can also use `DispatchQueue.main`, if you want
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer!.schedule(deadline: .now(), repeating: .seconds(1))
        timer!.setEventHandler { [weak self] in
            if Wallet.displayBTC {
                print(CryptoCoins.BTC)
            }
            
            if Wallet.displayBTC {
                print(CryptoCoins.LTC)
                
            }
            if Wallet.displayBTC {
                print(CryptoCoins.ETH)
                
            }
        }
        timer!.resume()
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //self.btcAddress.stringValue = UserDefaults.standard.string(forKey: "BTCaddress")!
        //self.ltcAddress.stringValue = UserDefaults.standard.string(forKey: "LTCaddress")!
        //self.ethAddress.stringValue = UserDefaults.standard.string(forKey: "ETHaddress")!

        stopTimer()
        startTimer()
    }
}

// MARK: Actions
extension WalletsViewController
{
    @IBAction func saveBTC(_ sender: NSButton) {
        GET_BTC(addressBTC: self.btcAddress.stringValue)
        
        //save the value of crypto address
        UserDefaults.standard.set(CryptoCoins.BTC, forKey: "BTCvalue")
        UserDefaults.standard.set(true, forKey: "BTCdisplay")
        UserDefaults.standard.set(self.btcAddress.stringValue, forKey: "BTCaddress")
        
        GET_BTC(addressBTC: self.btcAddress.stringValue)
        //save the value of crypto address
        UserDefaults.standard.set(CryptoCoins.BTC, forKey: "BTCvalue")
        UserDefaults.standard.set(true, forKey: "BTCdisplay")
        UserDefaults.standard.set(self.btcAddress.stringValue, forKey: "BTCaddress")

    }
    
    @IBAction func saveLTC(_ sender: NSButton) {
        GET_LTC(addressLTC: self.ltcAddress.stringValue)
        
        //save the value of crypto address
        UserDefaults.standard.set(CryptoCoins.LTC, forKey: "LTCvalue")
        UserDefaults.standard.set(true, forKey: "LTCdisplay")
        UserDefaults.standard.set(self.ltcAddress.stringValue, forKey: "LTCaddress")
        
        GET_LTC(addressLTC: self.ltcAddress.stringValue)
        
        //save the value of crypto address
        UserDefaults.standard.set(CryptoCoins.LTC, forKey: "LTCvalue")
        UserDefaults.standard.set(true, forKey: "LTCdisplay")
        UserDefaults.standard.set(self.ltcAddress.stringValue, forKey: "LTCaddress")
    }
    
    @IBAction func saveETH(_ sender: NSButton) {
        GET_ETH(addressETH: self.ethAddress.stringValue)
        
        //save the value of crypto address
        UserDefaults.standard.set(CryptoCoins.ETH, forKey: "ETHvalue")
        UserDefaults.standard.set(true, forKey: "ETHdisplay")
        UserDefaults.standard.set(self.ethAddress.stringValue, forKey: "ETHaddress")
        
        GET_ETH(addressETH: self.ethAddress.stringValue)
        
        //save the value of crypto address
        UserDefaults.standard.set(CryptoCoins.ETH, forKey: "ETHvalue")
        UserDefaults.standard.set(true, forKey: "ETHdisplay")
        UserDefaults.standard.set(self.ethAddress.stringValue, forKey: "ETHaddress")
    }
    
    @IBAction func moreCurrencies(_ sender: NSButton) {
        print("PopUp - buy PRO")
    }
    
    @IBAction func quit(_ sender: NSButton) {
        if self.btcAddress.stringValue == "" {
            //reset the value of crypto BTC
            UserDefaults.standard.set(0.0, forKey: "BTCvalue")
            UserDefaults.standard.set(false, forKey: "BTCdisplay")
            
        }
        if self.ltcAddress.stringValue == "" {
            //reset the value of crypto LTC
            UserDefaults.standard.set(0.0, forKey: "LTCvalue")
            UserDefaults.standard.set(false, forKey: "LTCdisplay")
            
        }
        if self.ethAddress.stringValue == "" {
            //reset the value of crypto ETH
            UserDefaults.standard.set(0.0, forKey: "ETHvalue")
            UserDefaults.standard.set(false, forKey: "ETHdisplay")
        
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
