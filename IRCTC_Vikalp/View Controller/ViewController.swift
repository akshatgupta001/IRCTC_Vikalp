
import UIKit

class ViewController: SubView {

    @IBOutlet weak var PNR: UITextField!
    @IBOutlet weak var TrainNumber: UITextField!
    @IBOutlet weak var captchaImg: UIImageView!
    @IBOutlet weak var enterCaptcha: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    var captchaText : String = ""
    var pnrEnqReqDTO : AtasPnrEnqReqDTO = AtasPnrEnqReqDTO()
    
    @IBAction func reloadCaptcha(_ sender: Any) {
        downloadCaptcha()
    }
    
    func downloadCaptcha(){
        let url = URL(string: "http://10.64.0.214:7011/ctcan/webservices/systktservices/generateCaptcha")!
        let req = NSMutableURLRequest(url: url)
        let request:URLRequest
        req.httpMethod = "GET"
        req.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        //let configuration = URLSessionConfiguration.default
        request = req as URLRequest
        
        URLSession.shared.dataTask(with: request) { (data, response, err) -> Void  in
            
            
            if(err == nil){
                do{
                    let captcha = try JSONDecoder().decode(captchaQueResponseDTO.self, from: data!)
                    let captchaData = NSData (base64Encoded: (captcha.captchaQuestion) , options: NSData.Base64DecodingOptions(rawValue: 0))
                    print(captcha.captchaToken)
                    self.pnrEnqReqDTO.tokenKey = captcha.captchaToken
                    
                    //calling extension of UI Image view
                      self.captchaImg.load(data: captchaData! as Data)
//                                    let image = UIImage(data: captchaData! as Data)
//                                    self.captchaImg.image = image
//                    self.captchaImg.load(data: captchaData! as Data)
                    
                    
                }catch{
                    print("captcha error: \(err.debugDescription)")
                }
            }else{
                 print("data not found error : \(err.debugDescription)")
            }
        }.resume()
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.layer.cornerRadius = submitBtn.frame.height/2
        submitBtn.clipsToBounds = true
        downloadCaptcha()

        
       
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "otpScreen"{
            if let otpVC = segue.destination as? otpVC{
                otpVC.pnrNumber = self.PNR.text!
            }
            
        }
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        pnrEnqReqDTO.pnrNumber = PNR.text!
        pnrEnqReqDTO.trainNumber = TrainNumber.text!
        pnrEnqReqDTO.captchaAnswer = enterCaptcha.text!
        //pnrEnqReqDTO.tokenKey = (self.captcha?.captchaToken)! --already set in get web service call
        
       var jsonData = "".data(using: String.Encoding.utf8)!  // just to initialize - default value
       
        let jsonEncoder = JSONEncoder()
       // jsonEncoder.outputFormatting = .prettyPrinted
        do{
            jsonData = try jsonEncoder.encode(pnrEnqReqDTO)
            print(String(data: jsonData, encoding: .utf8)!)
        }
        catch{
            print("json encoding failed")
        }
        //test code
       
        
        let url = URL(string: "http://10.64.0.214:7011/ctcan/webservices/systktservices/atasPnrEnquy?splBooking=N")!
       let req = NSMutableURLRequest(url: url)
        req.httpMethod = "POST"
        req.addValue("Keep-Alive", forHTTPHeaderField: "Connection")
        req.setValue("application/json", forHTTPHeaderField: "Accept")
         req.addValue("Content-Type", forHTTPHeaderField: "application/x-www-form-urlencoded")
        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
       // req.setValue("N", forHTTPHeaderField: "splBooking")
        
        if(jsonData.count > 0){
            req.httpBody = jsonData
        }
        

        
        let request:URLRequest = req as URLRequest

        URLSession.shared.dataTask(with: request) { (data, response, error) in
           
           // print(String(data: (data), encoding: .utf8) ?? "data  not found 1")
            print(data ?? "data not found")
            
            print(response ?? "response not found")
            
            print(error ?? "error not found 101")
           if error == nil {
           
                do{
//                    let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: []) as! [String:Any]
//                    if let msg = jsonResponse["errorMsg"] as? String{
//                        print(msg)
//                    }
//                    if let name = jsonResponse["journeyDate"] as? String{
//                        print(name)
//                    }
//
                     let response = try JSONDecoder().decode(StatusDTO.self, from: data!)
                     print("statusDTO")
                     print(response.errorMsg)
                     print(response.journeyDate)
                
                }catch{
                    print("Error info 2:")
                }
           }else{
              print("3\(error!)")
            }
        }.resume()
    }
    
}

extension UIImageView {
    func load(data : Data) {
        DispatchQueue.global().async { [weak self] in
            
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }


