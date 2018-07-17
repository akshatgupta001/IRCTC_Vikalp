//
//  TrainsVC.swift
//  IRCTC_Vikalp
//
//  Created by Akshat Gupta on 09/07/18.
//  Copyright © 2018 Akshat Gupta. All rights reserved.
//

import UIKit

class TrainsVC: SubView, UITableViewDelegate, UITableViewDataSource {
    var testString : String = "hi"
    
    var atasTrainEnqResp : AtasTrainEnqRespDTO?
    var pnrBuffer : AtasPNRBufferDTO?
    var datePicker : UIDatePicker?

    @IBOutlet weak var pnrNumber: UILabel!
    @IBOutlet weak var trainName: UILabel!
    @IBOutlet weak var fromStn: UILabel!
    @IBOutlet weak var trainNumber: UILabel!
    
    
    @IBOutlet weak var toStn: UILabel!
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var SubmitBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    //var trainData : NSDictionary
    //var trainBtwnStnList : [TrainBtwnStnsDTO]
    
    @IBOutlet weak var TrainDateInputField: UITextField!
    
    
    func setDate(){
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        let currentDate = Date()
        self.TrainDateInputField.text = dateFormatter.string(from: currentDate)
        
        TrainDateInputField.inputView = datePicker
        // tool bar picker from extension
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(dismissPicker))
        self.TrainDateInputField.inputAccessoryView = toolBar
        
        datePicker?.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        
        //to set max date
        //        let gregorian: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        //        let currentDate: NSDate = NSDate()
        //        let components: NSDateComponents = NSDateComponents()
        //
        //
        //
        //        components.year = 4
        //        let maxDate: NSDate = gregorian.date(byAdding: components as DateComponents, to: currentDate as Date, options: NSCalendar.Options(rawValue: 0))! as NSDate
        //
        //
        //        self.datePicker?.maximumDate = maxDate as Date
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setDate()
       
        tableView.delegate = self
        tableView.dataSource = self
        let nibName = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "TableViewCell")
        SubmitBtn.layer.cornerRadius = SubmitBtn.frame.height/2
        
        if let trainResp = atasTrainEnqResp{
            pnrBuffer = trainResp.atasPnrBuffer
            self.trainName.text = pnrBuffer?.trainName
            self.trainNumber.text = pnrBuffer?.trainNumber
            self.pnrNumber.text = pnrBuffer?.pnrNumber
            self.fromStn.text = pnrBuffer?.fromStaion
            self.toStn.text = pnrBuffer?.toStation

        }
        print(testString)
        print(atasTrainEnqResp?.atasPnrBuffer?.trainName ?? "lol")
        self.trainName.text = atasTrainEnqResp?.atasPnrBuffer?.trainName
        self.pnrNumber.text = atasTrainEnqResp?.atasPnrBuffer?.pnrNumber
    }
//    override func viewDidAppear(_ animated: Bool) {
//        
//        super.viewDidAppear(true)
//        setTitle(title: "TRAIN LIST")
//        
//    }

    
    @objc func dateChanged(datePicker : UIDatePicker){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        self.TrainDateInputField.text = dateFormatter.string(from: datePicker.date)
        
    }

    @objc func dismissPicker() {
        
      TrainDateInputField.resignFirstResponder()
        //self.view.endEditing(true)
      print("exit")
        
    }
    @IBAction func toggleCheckBox(_ sender: Any) {
        if checkBox.image(for: .normal) == #imageLiteral(resourceName: "if_check-box-outline-blank_326558.png") {
            checkBox.setImage(#imageLiteral(resourceName: "if_check-box_326563.png"), for: .normal)
        }else {
            checkBox.setImage(#imageLiteral(resourceName: "if_check-box-outline-blank_326558.png"), for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let cell = tableView.cellForRow(at: indexPath) as! TableViewCell
        if cell.checkBox.image == #imageLiteral(resourceName: "if_check-box-outline-blank_326558"){
            cell.checkBox.image = #imageLiteral(resourceName: "if_check-box_326563")
        }else {
            cell.checkBox.image = #imageLiteral(resourceName: "if_check-box-outline-blank_326558")
        }
        
        
    }
    
    //assign values for table view
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 112
    }
    
    func extractTrainList(){
       // let path = Bundle.main.path(forResource: "TrainBtwnStnsDTO", ofType: "json")
        
       // let url = URL(fileURLWithPath: path!)
       // let data = try? Data(contentsOf:url)
        
       // trainData = try! JSONDecoder().decode([TrainBtwnStnsDTO].self, from: data!)
        
    }
 
 
}
extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}
