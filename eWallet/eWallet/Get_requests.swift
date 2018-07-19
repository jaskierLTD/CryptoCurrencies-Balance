//
//  Get_request.swift
//  BitWallet
//
//  Created by Alessandro Marconi on 16/07/2018.
//  Copyright © 2018 JaskierLTD. All rights reserved.
//

import Darwin
import Foundation

//-------------------------------ETH------------------------------------
func GET_ETH(addressETH : String)
{
    if addressETH != ""
    {
        // Send HTTP GET Request
        let address: String = addressETH
        let headers = ["content-type": "application/x-www-form-urlencoded"]
        let request = NSMutableURLRequest(url: NSURL(string: "https://api.etherscan.io/api?module=account&action=balance&address=0\(address)&tag=latest&apikey=YourApiKeyToken")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode
                //print(httpResponse as Any)
                
                //successfully connected
                if(statusCode == 200)
                {
                    if (String(data: data!, encoding: .utf8)! != "Checksum does not validate") && (String(data: data!, encoding: .utf8)! != "Illegal character 0 at position 0"){
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                        print("ETH parsed value")
                        //print(jsonResponse as! NSDictionary)

                        //Dictionary inside
                        let dataDictionary:NSDictionary = jsonResponse as! NSDictionary
                        for (key,_) in dataDictionary
                        {
                            if key as! String == "result"
                            {
                                //Assigning as a correct money value
                                let money = ((dataDictionary[key] as! NSString)as String)
                                var stringChars = (money).count

                                    stringChars = stringChars - (stringChars - 18)
                                    let landslide = (pow(Double(10),Double(stringChars)))
                                    let correctDouble:Double = Double(money)! / Double(landslide)
                                    let cutThePrice2Symbols = NSString(format: "%0.02f", correctDouble as CVarArg)
                                    let cutNoZeros = cutThePrice2Symbols.doubleValue
                                    UserDefaults.standard.set(cutNoZeros, forKey: "ETHvalue")

                            }
                        }
                        
                    }
                    catch let error
                    {
                        print(error)
                    }
                    }
                }
            }
        })
        dataTask.resume()
    }
}

//-------------------------------BTC------------------------------------
func GET_BTC(addressBTC : String)
{
    if addressBTC != ""
    {
        
        let address: String = addressBTC
        let confirmations: Int = 0
        let url = URL(string: "https://blockchain.info/q/addressbalance/\(address)?confirmations=\(confirmations)")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = response, let data = data
            {
                if (String(data: data, encoding: .utf8)! != "Checksum does not validate") && (String(data: data, encoding: .utf8)! != "Illegal character 0 at position 0"){
                    print("BTC parsed values")
                    //print(response)
                    let money = String(data: data, encoding: .utf8)!
                    //print(money as NSString)
                    let landslide = (pow(Double(10),Double(8)))
                    let correctDouble:Double = Double(money)! / Double(landslide)
                    let cutThePrice2Symbols = NSString(format: "%0.02f", correctDouble as CVarArg)
                    let cutNoZeros = cutThePrice2Symbols.doubleValue
                    UserDefaults.standard.set(cutNoZeros, forKey: "BTCvalue")
                    //print(CryptoCoins.BTC)
                }

            } else {
                print(error as Any)
            }
        }
        
            task.resume()
        
    }
}

//-------------------------------LTC------------------------------------
func GET_LTC(addressLTC : String)
{
    if addressLTC != ""
    {
        let headers = [ "content-type": "application/x-www-form-urlencoded" ]
        let adress: String = addressLTC
        let confirmations: Int = 0
        
        let request = NSMutableURLRequest(url: NSURL(string: "https://chain.so/api/v2/get_address_balance/LTC/\(adress)/\(confirmations))")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        //request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error as Any)
            } else {
                
                if (String(data: data!, encoding: .utf8)! != "Checksum does not validate") && (String(data: data!, encoding: .utf8)! != "Illegal character 0 at position 0"){
                let httpResponse = response as? HTTPURLResponse
                let statusCode = httpResponse?.statusCode
                //print("LTC parsed value")
                //print(httpResponse as Any)
                
                //if successfully connected code: 200-300
                if(statusCode == 200)
                {
                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String:Any]
                        //Dictionary inside
                        let dataDictionary:NSDictionary = jsonResponse! as NSDictionary
                        for (key,_) in dataDictionary
                        {
                        if key as! String == "data"{
                                
                                let nextDictionary:NSDictionary = dataDictionary[key] as! NSDictionary
                                for (key,value) in nextDictionary
                                {
                                    if key as! String == "confirmed_balance"
                                    {
                                            //print("LTC parsed values")
                                            //print(response)
                                            let money = String(value as! NSString)
                                            //print(money as NSString)
                                            let correctDouble:Double = Double(money)!
                                            let cutThePrice2Symbols = NSString(format: "%0.02f", correctDouble as CVarArg)
                                            let cutNoZeros = cutThePrice2Symbols.doubleValue
                                            UserDefaults.standard.set(cutNoZeros, forKey: "LTCvalue")
                                            //print(CryptoCoins.LTC)
                                    }
                                }
                        }
                        }
                    }
                    catch let error
                    {
                        print(error)
                    }
                }
                }
            }
        })
     dataTask.resume()
    }
}
