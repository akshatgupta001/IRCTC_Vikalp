//
//  otpVC.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 10/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import UIKit

class otpVC: SubView {

    @IBOutlet weak var otpBtn: UIButton!
    var pnrNumber  : String = "";
    var trainEnqResp : AtasTrainEnqRespDTO?
    @IBOutlet weak var otpTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.navigationItem.titl = "OTP SCREEN"
        otpBtn.layer.cornerRadius = otpBtn.frame.height/2
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(true)
        setTitle(title: "OTP SCREEN")
        
        
        
    }
    
    func otpWebServiceCall(){
        //let otp : String = (otpTextField.text)!
            let url = URL(string: "http://10.64.0.214:7011/ctcan/webservices/systktservices/atasTrainEnq/\(pnrNumber)/\(otpTextField.text!)")!
        
       
        let req = NSMutableURLRequest(url: url)
        let request:URLRequest
        req.httpMethod = "GET"
        req.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        //let configuration = URLSessionConfiguration.default
        request = req as URLRequest
        
        URLSession.shared.dataTask(with: request) { (data, response, err) -> Void  in
            print(data ?? "data otp not found")
            print(response ?? "response not found")
            
            if(err == nil){
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
                    let errorMsg = json["errorMsg"] as? String
                    print(errorMsg!)
                    
                    let trainResponse = try JSONDecoder().decode(AtasTrainEnqRespDTO.self, from: data!)
                    self.trainEnqResp = trainResponse
                    if let pnrBuffer : AtasPNRBufferDTO = trainResponse.atasPnrBuffer {
                        print(pnrBuffer.fromStaion)
                        print(pnrBuffer.toStation)
                    }
                    if errorMsg != "OTP Mismatch /Session Expired"{
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "showTrain", sender: self)
                        }
                    }else {
                        DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Alert", message: errorMsg, preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            switch action.style{
                            case .default:
                                print("default")
                                
                            case .cancel:
                                print("cancel")
                                
                            case .destructive:
                                print("destructive")
                                
                                
                            }}))
                        self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    
                    
                   
                    
//
                }catch{
                    print("otp error: \(err.debugDescription)")
                }
            }else{
                print("data not found error : \(err.debugDescription)")
            }
            
            }.resume()
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showTrain" {
            if  let trainVC = segue.destination as? TrainsVC{
                trainVC.testString = "hello"
                trainVC.atasTrainEnqResp = self.trainEnqResp
                trainVC.pnrBuffer = self.trainEnqResp?.atasPnrBuffer
            }

        }
    }
   
    @IBAction func otpBtnPressed(_ sender: Any) {
        print(otpTextField)
        if otpTextField != nil {
          otpWebServiceCall()
            
        }
        
        
        
//            if  let trainVC = self.storyboard?.instantiateViewController(withIdentifier: "showTrain") as? TrainsVC{
//                trainVC.testString = "hello"
//                trainVC.atasTrainEnqResp = self.trainEnqResp
//                trainVC.pnrBuffer = self.trainEnqResp?.atasPnrBuffer
//            }
        
        
        
        
        
    }
    
    
    
}
