
import UIKit

class ViewController: SubView {

    @IBOutlet weak var PNR: UITextField!
    @IBOutlet weak var TrainNumber: UITextField!
    @IBOutlet weak var captchaImg: UIImageView!
    @IBOutlet weak var enterCaptcha: UITextField!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    var captchaText : String = String()
    var pnrEnqReqDTO : atasPnrEnqReqDTO = atasPnrEnqReqDTO()
    
    @IBAction func reloadCaptcha(_ sender: Any) {
        downloadCaptcha()
    }
    
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
                    
                    
                    //calling extension of UI Image view
                      self.captchaImg.load(data: captchaData! as Data)
//                                    let image = UIImage(data: captchaData! as Data)
//                                    self.captchaImg.image = image
//                    self.captchaImg.load(data: captchaData! as Data)
                    
                    
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


