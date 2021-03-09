//
//  ViewController.swift
//  Salary Estimator
//
//  Created by SOMA SEKHAR ANAPARTHI on 08/03/21.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    //function to set number of components in Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //function to set number of rows in Picker View
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return qualification.count
    }
    
    //function to set element in Picker View
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return qualification[row]
    }
    
    //function to do something when an element is selected in Picker View
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if qualification[row] == "Choose Education Qualification"{
            basicPay = 0.0 //if no qualification selected taking basic Salary as 0
        }else if qualification[row] == "Bachelor"{
            basicPay = 55000.0
        }else if qualification[row] == "Diploma"{
            basicPay = 47000.0
        }else if qualification[row] == "High School"{
            basicPay = 40000.0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //declaring some variables for Salary Estimation
    var qualification = ["Choose Education Qualification","Bachelor","Diploma","High School"]
    var basicPay:Double = 0.0
    var kidsAllowance:Double = 0.0
    var experienceBonus:Double = 0.0
    var skillBonus1:Double = 0.0
    var skillBonus2:Double = 0.0
    
    //Connecting Views as Outlets from main Storyboard
    @IBOutlet weak var qualificationPicker: UIPickerView!
    @IBOutlet weak var single: UIButton!
    @IBOutlet weak var notSingle: UIButton!
    @IBOutlet weak var kids: UIButton!
    @IBOutlet weak var noKids: UIButton!
    @IBOutlet weak var kidsValue: UILabel!
    @IBOutlet weak var kidsStepper: UIStepper!
    @IBOutlet weak var java: UIButton!
    @IBOutlet weak var cSharp: UIButton!
    @IBOutlet weak var swift: UIButton!
    @IBOutlet weak var php: UIButton!
    @IBOutlet weak var python: UIButton!
    @IBOutlet weak var rlanguage: UIButton!
    @IBOutlet weak var javascript: UIButton!
    @IBOutlet weak var none: UIButton!
    @IBOutlet weak var experienceValue: UILabel!
    @IBOutlet weak var estimatedSalary: UILabel!
    @IBOutlet weak var message: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.qualificationPicker.delegate = self
        self.qualificationPicker.dataSource = self
        
        //Initially setting the no of kids, salary estimeted and experience as 0
        kidsValue.text = "0"
        estimatedSalary.text = "0"
        
        message.text = "Please above Button to get Estimated Salary"
        
        experienceValue.text = "0"
        marital() //calling marital function to check marital status and change remaining views
    }

    //if single selected the action will takes place
    @IBAction func singleSelected(_ sender: Any) {
        single.isSelected = true
        notSingle.isSelected = false
        kidsValue.text = "0"
        
        kids.isEnabled = false
        noKids.isEnabled = false
        kidsStepper.value = 0
        kidsStepper.isEnabled = false
    }
    
    //if married action
    @IBAction func notSingleSelected(_ sender: Any) {
        notSingle.isSelected = true
        single.isSelected = false
        
        kids.isEnabled = true
        noKids.isEnabled = true
        kid()
    }
    
    //if kids present
    @IBAction func hasKids(_ sender: Any) {
        kids.isSelected = true
        noKids.isSelected = false
        
        kidsStepper.isEnabled = true
        kidsStepper.value = 1
        kidsValue.text = "1"
    }
    
    //if kids not present
    @IBAction func hasNoKids(_ sender: Any) {
        kids.isSelected = false
        noKids.isSelected = true
        kidsValue.text = "0"
        kidsStepper.value = 0
        kidsStepper.isEnabled = false
    }
    
    //assigning the stepper value to kidsValue
    @IBAction func kidsStepper(_ sender: UIStepper) {
        kidsValue.text = String(Int(sender.value))
    }
    
    //if java check box ticked
    @IBAction func java(_ sender: Any) {
        if java.isSelected{    //if java already ticked then it it unticks it
            java.isSelected = false
        }else {
            java.isSelected = true
            none.isSelected = false
        }
        checkNone() // Checking None and changing the remaining views
    }
    //if cSharp check box ticked
    @IBAction func cSharp(_ sender: Any) {
        if cSharp.isSelected{
            cSharp.isSelected = false
        }else {
           cSharp.isSelected = true
            none.isSelected = false
        }
        checkNone()
    }
    //if swift check box ticked
    @IBAction func swift(_ sender: Any) {
        if swift.isSelected{
            swift.isSelected = false
        }else {
            swift.isSelected = true
            none.isSelected = false
        }
        checkNone()
    }
    //if php check box ticked
    @IBAction func php(_ sender: Any) {
        if php.isSelected{
            php.isSelected = false
        }else {
            php.isSelected = true
            none.isSelected = false
        }
        checkNone()
    }
    //if python check box ticked
    @IBAction func python(_ sender: Any) {
        if python.isSelected{
            python.isSelected = false
        }else {
            python.isSelected = true
            none.isSelected = false
        }
        checkNone()
    }
    //if rlang check box ticked
    @IBAction func rlang(_ sender: Any) {
        if rlanguage.isSelected{
            rlanguage.isSelected = false
        }else {
            rlanguage.isSelected = true
            none.isSelected = false
        }
        checkNone()
    }
    //if javascript check box ticked
    @IBAction func javascript(_ sender: Any) {
        if javascript.isSelected{
            javascript.isSelected = false
        }else {
            javascript.isSelected = true
            none.isSelected = false
        }
        checkNone()
    }
    //if none check box ticked
    @IBAction func none(_ sender: Any) {
        if none.isSelected{
            none.isSelected = false
        }else {
            none.isSelected = true
            javascript.isSelected = false
            rlanguage.isSelected = false
            python.isSelected = false
            php.isSelected = false
            cSharp.isSelected = false
            java.isSelected = false
            swift.isSelected = false
        }
        checkNone()
    }
    
    //assigning the slider value to experienceValue
    @IBAction func expSlided(_ sender: UISlider) {
        experienceValue.text = String(Int(sender.value))
    }
    
    
    //action when get Estimated salary Pressed
    @IBAction func getEstimatedSalary(_ sender: Any) {
        
        if basicPay != 0 { //checking the basic pay if it is not zero
            
            let kids = Int(kidsValue.text!)!  //taking no of kids
            kidsAllowance = Double(kids) * 7000.0 //adding 7000 per each kid
            
            //checking for swift or python or rlanguage
            if swift.isSelected || python.isSelected || rlanguage.isSelected {
                //if any selected adding 5000
                skillBonus1 = 5000.0
            }else{
                skillBonus1 = 0.0
            }
            if java.isSelected || javascript.isSelected || cSharp.isSelected {
                skillBonus2 = 3000.0
            }else{
                skillBonus2 = 0.0
            }
    
            let exp:Int = Int(experienceValue.text!)!//taking experience
            if exp > 3{
                experienceBonus = 10000.0 //adding 10000 if experience > 3
            }else {
                experienceBonus = 0.0
            }
            
            //calculation final Salary Estimated
            let estimatedSal = basicPay + kidsAllowance + experienceBonus + skillBonus1 + skillBonus2
            
            //keeping in Estimated Salary Label
            estimatedSalary.text = String(format: "%.2f", estimatedSal) //upto 2 decimal places
            message.text = "Thank you for using our service"
            message.isHighlighted = false
            message.textColor = #colorLiteral(red: 0, green: 0.5921568627, blue: 0.6549019608, alpha: 1)
            
        }else {
            //if no qualification is selected shows user  the following
            message.text = "Please Choose Qualification"
            message.textColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            message.isHighlighted = true
            estimatedSalary.text = ""
        }
       
    }
    
    //function to check none in programming languages and return true if no one selected
    func checkNone(){
        if java.isSelected || cSharp.isSelected || swift.isSelected || php.isSelected || python.isSelected || rlanguage.isSelected || javascript.isSelected {
            none.isSelected = false
        }else{
            none.isSelected = true
        }
    }
    
    //function to check marital status and change remaining buttons
    func marital(){
            if single.isSelected {
                kid()
            }else if notSingle.isSelected{
                kid()
            }
        }
        
    //function to check kids status and change remaining buttons
    func kid(){
        if kids.isSelected {
            kidsStepper.isEnabled = true
        }else if noKids.isSelected {
            kidsStepper.isEnabled = false
        }else{
            kidsStepper.isEnabled = false
        }
    }
    
}

