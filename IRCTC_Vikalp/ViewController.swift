
import UIKit

class ViewController: SubView {

    @IBOutlet weak var PNR: UITextField!
    @IBOutlet weak var TrainNumber: UITextField!
    @IBOutlet weak var captchaImg: UIImageView!
    @IBOutlet weak var enterCaptcha: UITextField!
    
 
    
    @IBOutlet weak var submitBtn: UIButton!
    
    
    var captchaText : String = String()
    var pnrEnqReqDTO : atasPnrEnqReqDTO = atasPnrEnqReqDTO()
    
    
    func downloadCaptcha(){
        let url = URL(string: "http://10.64.0.214:7013/ctcan/webservices/systktservices/generateCaptcha")!
        let req = NSMutableURLRequest(url: url)
        let request:URLRequest
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        //let configuration = URLSessionConfiguration.default
        request = req as URLRequest
        
        URLSession.shared.dataTask(with: request) { (data, response, err) -> Void  in
            
            
            if(err == nil){
                do{
                    let captcha = try JSONDecoder().decode(captchaQueResponseDTO.self, from: data!)
                    
                    
                    let captchaData = NSData (base64Encoded: (captcha.captchaQuestion) , options: NSData.Base64DecodingOptions(rawValue: 0))


                                    let image = UIImage(data: captchaData! as Data)
                                    self.captchaImg.image = image
                    self.captchaImg.load(data: captchaData! as Data)
                    
                    
                }catch{
                    
                    print("Error info: \(err.debugDescription)")
                }
            }else{
                 print("Error info 2 : \(err.debugDescription)")
            }
           
           
            
        }.resume()
        print("finish")

        
        
        

    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitBtn.layer.cornerRadius = submitBtn.frame.height/2
        submitBtn.clipsToBounds = true
        downloadCaptcha()
    
    
            setCaptcha()
        
       
        
        
    }
    
    @IBAction func submitPressed(_ sender: Any) {
        pnrEnqReqDTO.pnrNumber = PNR.text!
        pnrEnqReqDTO.trainNumber = TrainNumber.text!
        pnrEnqReqDTO.captchaAnswer = enterCaptcha.text!
        //pnrEnqReqDTO.tokenKey = (self.captcha?.captchaToken)!
        
        var jsonData = "".data(using: String.Encoding.utf8)!  // just to initialize - default value
        
        let jsonEncoder = JSONEncoder()
        
        do{
            jsonData = try jsonEncoder.encode(pnrEnqReqDTO)
        }
        catch{}
        
        let url = URL(string: "/ctcan/webservices/systktservices/atasPnrEnquy?splBooking=N")!
       let req = NSMutableURLRequest(url: url)
        req.setValue("application/json", forHTTPHeaderField: "Accept")
        req.setValue("N", forHTTPHeaderField: "splBooking")
        
        if(jsonData.count > 0){
            req.httpBody = jsonData
        }
       
        
        let request:URLRequest = req as URLRequest

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
           if error == nil {
            
                do{
                  let response = try JSONDecoder().decode(StatusDTO.self, from: data!)
                  print(response.errorMsg)
                
                }catch{
                   // print("Error info: \(error.debugDescription)")
                }
           }else{
              print(error!)
            }
        }.resume()
    }
    
  
    func setCaptcha() {
        let mystr = "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"
        let captchaData = NSData (base64Encoded: mystr , options: NSData.Base64DecodingOptions(rawValue: 0))
        
        let image = UIImage(data: captchaData! as Data)
        self.captchaImg.image = image
        
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


