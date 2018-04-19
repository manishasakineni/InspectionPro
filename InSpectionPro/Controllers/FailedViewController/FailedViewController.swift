 //
//  FailedViewController.swift
//  InSpectionPro
//
//  Created by Mac OS on 30/11/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit
import CoreData

protocol CopyDataDelegate {
    func dataToBeCopied(descriptionArray : String ,_ button : Int)
}
 protocol AddDeficienciDelegate {
    func addDeficienciCount(_ button : Int)
    func failedCount(_ button : Int)
    func noButtonCount(_ button : Int)

 }

class FailedViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource,UITextFieldDelegate,UIPickerViewDelegate, UIPickerViewDataSource, UITextViewDelegate,CopyDataDelegate,AddDeficienciDelegate {
    
    @IBOutlet weak var loginUserName: UILabel!
    @IBOutlet weak var failedTableView: UITableView!
    @IBOutlet weak var resetButtonOutLet: UIButton!
    @IBOutlet weak var saveButtonOutLet: UIButton!
    
    
    var serviceController = ServiceController()
    var failedDataUpdateDelegate : FailedDataUpdateDelegate?
    var operation = ""
    var unitID = ""
    var selectedIndexValue : NSInteger! = -1
    var checkBoxArrray = Array<String>()
    var tagValue       : Int  = 0
    var selectedData = ""
    var idProofParmsDict = [String:Any]()
    let utillites =  Utilities()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var deficencyCorrectiveModelArray : Array<DeficencyCorrectiveModel> = Array()
    var operationsModelArray : Array<AllModel> = Array()
    var allModelArray : Array<AllModel> = Array()
    var allModelArray1 : Array<AllModel> = Array()
    var deficencyArray : Array<String> = Array()
    var correctiveArray : Array<String> = Array()
    var operationArray : Array<String> = Array()
    var unitsArray : Array<String> = Array()
    var operationStringArray  : Array<String> = Array()
    var pickerData = Array<String>()
    let pickerView = UIPickerView()
    var titleType        : String = ""
    var titleType2        : String = ""
    var titleType3        : String = ""
    var titleType4        : String = ""
    var titleType5        : String = ""
    var titleType6        : String = ""
    var emptyString        : String = "Choose One"
    var emptyString1        : String = "Choose One"
    var emptyString2        : String = "Choose One"
    var emptyString3        : String = "Choose One"
    var emptyTextView        : String = ""
    var comments        : String = ""
    var one  = ""
    var two  = ""
    var three  = ""
    var four  = ""
    var five  = ""
    var six  = ""
    var selectedString = ""
    var oneIdAry = Array<String>()
    var twoIdAry = Array<String>()
    var threeIdAry = Array<String>()
    var fourIdAry = Array<String>()
    var fiveIdAry = Array<String>()
    var sixIdAry = Array<String>()
    var oneTypeID    : Int    = 0
    var twoTypeID    : Int    = 0
    var threeTypeID    : Int    = 0
    var fourTypeID    : Int    = 0
    var fiveTypeID    : Int    = 0
    var sixTypeID    : Int    = 0
    var selectedModel : AllModel = AllModel()
    var unSavedSelectedModel : Array<AllModel> = Array()
    var appVersion          : String = ""
    var isDataChanged = false
    var activeTextField = UITextField()
    var referenceTextView = UITextView()
    var deficiencyArrayData = ["Re-inspect","Other","Dispose","Re-sanitize","Re-rines","Sweep","Scrub"]
    var correctiveActtionArrayData = ["Broken Glass","Packaging","Other","Grease","Cheese","Build-up","Foof Particles","pallets"]
    var pickerTitle  = ["Unit","Deficiency Type","Operator","Corrective Action"]
    var labelAry  = ["A","B","C","D","E","F"]
    var labelAry1  = ["A1","B1","C1","D1","E1","F1"]
    var labelAry2  = ["A2","B2","C2","D2","E2","F2"]
    var labelAry3 = ["A3","B3","C3","D3","E3","F3"]
    var labelAry4  = ["A4","B4","C4","D4","E4","F4"]
    var labelAry5  = ["A5","B5","C5","D5","E5","F5"]
    var testArray : Array<String> = Array()
    var lineNumberId      : String = ""
    var lineNameNumberId      : String = ""
    var unitIdString      : String = ""
    var selectedlineName = ""
    var deficencyCountString  = "1"
    var unitsDBModel = [Units]()
    var localSavedDataDBModel = [LocalSavedData]()
    var localAllModelArray : Array<String> = Array()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginUserName.text = "FACILITY: Some Amazing Food / USER: " + "\(UserDefaults.standard.value(forKey: "SavedUserName") as! String)"

        self.lineNumberId = UserDefaults.standard.value(forKey: klineId) as! String
        print(lineNumberId)
        
        self.lineNameNumberId = UserDefaults.standard.value(forKey: KnameLineId) as! String
        print(self.lineNameNumberId)
        print(selectedModel.unitId)
        failedTableView.delegate = self
        failedTableView.dataSource = self
        pickerView.delegate = self
        pickerView.dataSource = self
        referenceTextView.delegate = self
        //saveButtonOutLet.isEnabled = false
        registerTableViewCells()
        // Do any additional setup after loading the view.

      borderColor()
        
     deficencyCorrectiveArray()
        
    }

    
    func deficencyCorrectiveArray(){
        for i in 0 ..< allModelArray1.count {
            let viewModel = allModelArray1[i]
        }
        for k in 0 ..< deficencyCorrectiveModelArray.count {
            let viewModel = deficencyCorrectiveModelArray[k]
            if(viewModel.isInspection == 1){
                deficencyArray.append(viewModel.name)
            }else{
                correctiveArray.append(viewModel.name)
            }
        }
        failedTableView.reloadData()
        
        
    }
    
    
    func borderColor(){
        
        saveButtonOutLet.layer.borderWidth = 1
        saveButtonOutLet.layer.cornerRadius = 3
        saveButtonOutLet.layer.borderColor = UIColor.lightGray.cgColor
        
        resetButtonOutLet.layer.borderWidth = 1
        resetButtonOutLet.layer.cornerRadius = 3
        resetButtonOutLet.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
// Set NavigationTitle On NavigatioBar
        Utilities.setupFailedViewControllerNavBarColorInCntrWithColor(backImage: "Back", cntr:self, titleView: nil, withText: "", backTitle: "  InspectionPro", rightImage: appVersion, secondRightImage: "Up", thirdRightImage: "Up")

         //navigationItem.leftBarButtonItems = []
        
    }
// MARK:- Register TableViewCells
    private func registerTableViewCells() {
        
        let nibName  = UINib(nibName: "FailedTableViewCell" , bundle: nil)
        failedTableView.register(nibName, forCellReuseIdentifier: "FailedTableViewCell")
        
        let nibName1  = UINib(nibName: "NoteTableViewCell" , bundle: nil)
        failedTableView.register(nibName1, forCellReuseIdentifier: "NoteTableViewCell")
        
        let nibName2  = UINib(nibName: "DeficiencySectionCell" , bundle: nil)
        failedTableView.register(nibName2, forCellReuseIdentifier: "DeficiencySectionCell")
        
    }
// MARK:- UITableViewDelegate And UITableViewDataSource Methods

    public func numberOfSections(in tableView: UITableView) -> Int {
        
        
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableViewAutomaticDimension
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if(indexPath.row != 4){

        let cell = tableView.dequeueReusableCell(withIdentifier: "FailedTableViewCell", for: indexPath) as! FailedTableViewCell
        cell.pickerTitleLabel.text = pickerTitle[indexPath.row]
        cell.differentTypesPickerTF.delegate = self
        cell.differentTypesPickerTF.tag = indexPath.row
        if indexPath.row == 0 {
            cell.differentTypesPickerTF.text = one
           cell.differentTypesPickerTF.text = emptyString
        }
        else if indexPath.row == 1 {
            if emptyString1 != "" {
                cell.differentTypesPickerTF.text = emptyString1
            }else{
                two = emptyString1
            }
        }else if indexPath.row == 2 {
            cell.differentTypesPickerTF.text = three
            cell.differentTypesPickerTF.text = emptyString2
        }else if indexPath.row == 3 {
            
            if emptyString3 != "" {
                cell.differentTypesPickerTF.text = emptyString3
            }else{
                two = emptyString3
            }
        } else {
            
        }

        return cell
        } else{
            
            let noteCell = tableView.dequeueReusableCell(withIdentifier: "NoteTableViewCell", for: indexPath) as! NoteTableViewCell
                noteCell.noteTitle.text = "Note"
            noteCell.noteTextView.delegate = self
            noteCell.noteTextView.tag = indexPath.row
            noteCell.noteTextView.text = emptyTextView
            
            return noteCell
        }
     
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "DeficiencySectionCell") as! DeficiencySectionCell
        
        headerCell.lineNumberLabel.text = "- " + self.selectedlineName
        headerCell.numberOfDeficiencyCount.text = self.deficencyCountString

        
        return headerCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 30.0
        
    }
    
    // MARK:- UITextFieldDelegate Methods

  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {

  //  enableSaveButton()

    if textField.tag == 1{

        focusContactNameTextField(textField.tag)
        self.popUpView(textField)


    }
    if textField.tag == 3 {

        focusContactNameTextField(textField.tag)
        self.popUpView(textField)
    }
    return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
      //  enableSaveButton()

        
      //  datePicker.endEditing(true)
        activeTextField = textField
        
        if textField.tag == 0{
            textField.clearButtonMode = .never
            textField.inputView = pickerView
           pickerData = unitsArray
            self.pickUp(activeTextField)
            pickerView.reloadAllComponents()
            pickerView.selectRow(0, inComponent: 0, animated: false)
            
        }
        if textField.tag == 1{
            textField.text = emptyString1
            focusContactNameTextField(textField.tag)
        }
        if textField.tag == 2{
            textField.clearButtonMode = .never
            textField.inputView = pickerView
            
            
           // pickerData = operationArray
            
                   pickerData = operationArray
            
            self.pickUp(activeTextField)
            pickerView.reloadAllComponents()
            pickerView.selectRow(0, inComponent: 0, animated: false)
            
        }
        if textField.tag == 3{
            focusContactNameTextField(textField.tag)

        }
     
    }

    
    func textFieldDidEndEditing(_ textField: UITextField) {
  
        if let pickerTextCell : FailedTableViewCell = textField.superview?.superview as? FailedTableViewCell {
            
            if textField.tag == 0{
                    activeTextField.text = one
            }

            else if textField.tag == 1 {
                activeTextField.text = emptyString1
            }
            else if textField.tag == 2 {
                activeTextField.text = three
            }
            else if textField.tag == 3 {
                activeTextField.text = emptyString3
            }
            pickerView.endEditing(true)
        }
    }
     func textViewDidEndEditing(_ textView: UITextView) {

      textView.resignFirstResponder()
        textView.endEditing(true)
    }
   
    func dataToBeCopied(descriptionArray :String ,_ button : Int ){
        if button == 0 {
            emptyString3 = descriptionArray
        }else{
            emptyString1 = descriptionArray
        }
        failedTableView.reloadData()
    }
    func addDeficienciCount(_ button : Int ){
     //   let indexPath : IndexPath = IndexPath(row: 0, section: 0)
      //  if let deficiencySectionCell : DeficiencySectionCell = self.failedTableView.cellForRow(at: indexPath) as? DeficiencySectionCell {
            deficencyCountString = "\(button)"
     //   }
         emptyString     = "Choose One"
         emptyString1    = "Choose One"
         emptyString2    = "Choose One"
         emptyString3    = "Choose One"
        failedTableView.reloadData()
        
    }
    func failedCount(_ button : Int ){
        deficencyCountString = "\(button)"
        emptyString     = "Choose One"
        emptyString1    = "Choose One"
        emptyString2    = "Choose One"
        emptyString3    = "Choose One"
        isDataChanged = true
        selectedModel.status = 0
        
       // unSavedSelectedModel.remove(at: button)
        failedTableView.reloadData()
    }
    
    func noButtonCount(_ button : Int ){
        deficencyCountString = "\(button)"
        isDataChanged = true
        selectedModel.status = 0
        if(isDataChanged == true){
        if let delegate = self.failedDataUpdateDelegate{
            delegate.addDeficiencyCount(selectedModel)
        }
        }
        failedTableView.reloadData()
    }
    
  
//MARK:- UIPickerViewDelegate AND UIPickerViewDataSource Methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
        
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if activeTextField.tag == 0{
            
            if pickerData.count > row {
                
                one = pickerData[row]
                activeTextField.text = one
                if(row < oneIdAry.count){
                    if let value = Int(oneIdAry[row]){
                        oneTypeID = value
                    }
                }
                unitID = selectedModel.unitsArray[row].unitId
                emptyString = pickerData[row]
                pickerView.reloadAllComponents()
            }
        }
        
        if activeTextField.tag == 1{

        if pickerData.count > row {

            }
        }
        
        if activeTextField.tag == 2{
            
            if pickerData.count > row {
                
                three = pickerData[row]
                activeTextField.text = three
                if(row < threeIdAry.count){
                    if let value = Int(threeIdAry[row]){
                        threeTypeID = value
                    }
                }
                emptyString2 = pickerData[row]
                pickerView.reloadAllComponents()
            }
        }
        
        if activeTextField.tag == 3{

            if pickerData.count > row {

            }
        }
        self.view.endEditing(true)

    }
 
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let string = pickerData[row]
        
        let pickerLabel = UILabel()
        pickerLabel.text = string
        pickerLabel.font = UIFont(name: "HelveticaNeue", size: 16) // In this use your custom font
        pickerLabel.textAlignment = .center
        if(string == "Select Reason"){
            pickerLabel.textColor = UIColor.init(red: 91.0/255.0, green: 158.0/255.0, blue: 7.0/255.0, alpha: 1.0)
            
        }else
        {
            pickerLabel.textColor = UIColor.black
        }
        
        return pickerLabel
        
    }
    

    
    func pickUp(_ textField : UITextField){
        
        textField.inputView = self.pickerView
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.blue
        toolBar.sizeToFit()
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(FailedViewController.doneClick))
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(FailedViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        if textField.inputView == pickerView{
            textField.inputAccessoryView = toolBar
        }
      
    }
//MARK:- Done Button
    @objc func doneClick() {
        activeTextField.resignFirstResponder()
        failedTableView.reloadData()
        
        }
//MARK:- Cancel Button
    @objc func cancelClick() {
        activeTextField.resignFirstResponder()
        failedTableView.reloadData()
            
            
        }
    
  
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        emptyString = "Choose One"
        emptyString1 = "Choose One"
        emptyString2 = "Choose One"
        emptyString3 = "Choose One"
        emptyTextView = ""
       // saveButtonOutLet.isEnabled = true
      //  saveButtonOutLet.backgroundColor = UIColor(red: 122.0/255.0, green: 208.0/255.0, blue: 52.0/255.0, alpha: 1.0)
        failedTableView.reloadData()
        
        
        
    }
// MARK:- Validations For Required Fields
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if (emptyString.isEmpty == true || emptyString == "Choose One") {
            self.appDelegate.window?.makeToast("Please select Unit", duration:kToastDuration, position:CSToastPositionCenter)

        }else if (emptyString1.isEmpty == true || emptyString1 == "Choose One"){
            
            self.appDelegate.window?.makeToast("Please select Deficiency type", duration:kToastDuration, position:CSToastPositionCenter)

            
        }else if (emptyString2.isEmpty == true || emptyString2 == "Choose One") {
            
            self.appDelegate.window?.makeToast("Please select Operator", duration:kToastDuration, position:CSToastPositionCenter)

        }else if (emptyString3.isEmpty == true || emptyString3 == "Choose One") {
            
            self.appDelegate.window?.makeToast("Please select Corrective Action", duration:kToastDuration, position:CSToastPositionCenter)

        }else{
            
             saveLinesAPICall()
        }
        
    }
    
    func validateAllFields() -> Bool
    {
        return true
    }
// MARK:- POST Save All Lines API-Service Method

    func saveLinesAPICall(){
        
        var saveLinesDictionary = Dictionary<String, Any>()
        let selectedDefArray = emptyString1.components(separatedBy: ",")
        var defiencyArray = Array<String>()
        for defString in selectedDefArray{
            defiencyArray.append(defString)
        }
        
        let selectedCorrArray = emptyString3.components(separatedBy: ",")
        var correctionArray = Array<String>()
        for corrString in selectedDefArray{
            correctionArray.append(corrString)
        }
        
        saveLinesDictionary.updateValue(defiencyArray,forKey:"deficiency")
        saveLinesDictionary.updateValue(correctionArray ,forKey:"correction" )
        saveLinesDictionary.updateValue(unitID ,forKey:"unitId")
        saveLinesDictionary.updateValue(emptyString2 ,forKey:"person" )
        saveLinesDictionary.updateValue(comments ,forKey:"comments" )
        
        var saveLinesArray:Array = Array<Dictionary<String, Any>>()
        saveLinesArray.append(saveLinesDictionary)
        print(saveLinesArray)
     //   delegate.personOperationCount(saveLinesArray)
        
            let  saveLinesAPI : String = BASE_SAVELINES_URL
                        let updateProfiledictParams = [
                            "lineId": self.selectedModel.lineId,
                            "transactionId": "null",
                          //  "failedUnits": "",
                             "failedUnits": saveLinesArray
                            ] as [String : Any]
            print(updateProfiledictParams)
            
            let dictHeaders = ["":"","":""] as NSDictionary
            if(appDelegate.checkInternetConnectivity()){

            
            serviceController.postURLRequest(_ViewController: self, strURL: saveLinesAPI as NSString, postParams: updateProfiledictParams as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                
                DispatchQueue.main.async()
                    {
                        
                        print("result:\(result)")
                        
                        let respVO:SaveLineResultVO = Mapper().map(JSONObject: result)!
                        
                        
                        print("responseString = \(respVO)")
                        
                        
                        let statusCode = respVO.result
                        
                        print("StatusCode:\(String(describing: statusCode))")
                        
                        
                        
                        if statusCode == true
                        {
                            
                            
                            let successMsg = respVO.inspectionId
                            
                       


                            let reOrderPopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddMoreDeficienciesViewController") as! AddMoreDeficienciesViewController
                            reOrderPopOverVC.delegate = self
                       
                            reOrderPopOverVC.deficencyCount = Int(self.deficencyCountString)!
                                    self.addChildViewController(reOrderPopOverVC)
                                    
                                    reOrderPopOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                                    self.view.addSubview(reOrderPopOverVC.view)
                                    reOrderPopOverVC.didMove(toParentViewController: self)
                                    print("AddMoreDeficienciesViewController Button Tapped......")
                        }
                        else {
                            
                            let failMsg = respVO.inspectionId
                            //self.showAlertViewWithTitle("Alert", message: failMsg!, buttonTitle: "Ok")
                            return
                        }
                }
                
            }, failureHandler: {(error) in
       
            })
            }else{
         
                    let entityLines = NSEntityDescription.entity(forEntityName: "LocalSavedData", in: PersistenceService.managedObjectContext)
                    let userLines = NSManagedObject(entity: entityLines!, insertInto: PersistenceService.managedObjectContext)

                    userLines.setValue(self.selectedModel.lineId, forKey: "lineId")

                    userLines.setValue("", forKey: "transactionId")
                    userLines.setValue(saveLinesArray, forKey: "failedUnits")
                
                               do{
                                   try PersistenceService.managedObjectContext.save()
                                    self.localSavedDataDBModel.append(userLines as! LocalSavedData)
                                    }
                                    catch{
                                            print("Could Not Save")
                                        }
                
 
                let reOrderPopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddMoreDeficienciesViewController") as! AddMoreDeficienciesViewController
                reOrderPopOverVC.delegate = self
                
                reOrderPopOverVC.deficencyCount = Int(self.deficencyCountString)!
                self.addChildViewController(reOrderPopOverVC)
                
                reOrderPopOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(reOrderPopOverVC.view)
                reOrderPopOverVC.didMove(toParentViewController: self)
                print("AddMoreDeficienciesViewController Button Tapped......")
                
                
          //  self.appDelegate.window?.makeToast("Please check your internet Connection...", duration:kToastDuration, position:CSToastPositionCenter)
                
            }
        
        
        }
    
    @IBAction func backLeftButtonTapped(_ sender:UIButton) {
        
     //   navigationItem.leftBarButtonItems = []

        failedTableView.resignFirstResponder()
        failedTableView.endEditing(true)
        if(isDataChanged == true){
            if let delegate = self.failedDataUpdateDelegate{
                delegate.addDeficiencyCount(selectedModel)
            //  delegate.personOperationCount(emptyString3)
            }
            
        }
     
        let poppedVC = navigationController?.popViewController(animated: true)
        print(poppedVC as Any)
        self.appDelegate.window?.makeToast("Please wait...", duration:kToastDuration, position:CSToastPositionCenter)

        print("Back Button Tapped......")
    
    }

    private func focusContactNameTextField(_ textFieldTag : Int) {
       // keyBoardHide()
        let indexPath = IndexPath.init(row: textFieldTag, section: 0)

       
            if let addressTableViewCell = failedTableView.cellForRow(at: indexPath) as? FailedTableViewCell {
                
                addressTableViewCell.differentTypesPickerTF.resignFirstResponder()
                addressTableViewCell.differentTypesPickerTF.endEditing(true)
                keyBoardHide()

            }

    }
// MARK:- keyBoard Hide Method
    private func keyBoardHide() {

        let indexPath = IndexPath.init(row: 4, section: 0)

        if let keyBoardTableViewCell = failedTableView.cellForRow(at: indexPath) as? NoteTableViewCell {

           keyBoardTableViewCell.noteTextView.resignFirstResponder()
           keyBoardTableViewCell.noteTextView.endEditing(true)

        }
    }
    
// MARK:- Get PopUpView Button Tapped

    @IBAction func  popUpView(_ sendre:UITextField) {
      
    
        for textField in self.failedTableView.subviews where textField is UITextField {
            textField.resignFirstResponder()

        }
        for textView in self.failedTableView.subviews where textView is UITextView {
            textView.resignFirstResponder()

        }
        failedTableView.endEditing(true)
        
        
        focusContactNameTextField(sendre.tag)
        let reOrderPopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DeficiencyTypeViewController") as! DeficiencyTypeViewController
        reOrderPopOverVC.delegate = self
        if sendre.tag == 1 {
            
            
            if pickerTitle.count > 0{
        reOrderPopOverVC.tag = 1
                reOrderPopOverVC.deficiencyTypeArray = deficencyArray
                self.addChildViewController(reOrderPopOverVC)
                
                reOrderPopOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(reOrderPopOverVC.view)
                reOrderPopOverVC.didMove(toParentViewController: self)
                print("DeficiencyTypeViewController Button Tapped......")
            }
          
                
            
        } else {
            
            reOrderPopOverVC.tag = 0
            reOrderPopOverVC.deficiencyTypeArray = correctiveArray
            self.addChildViewController(reOrderPopOverVC)
            reOrderPopOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.addSubview(reOrderPopOverVC.view)
            reOrderPopOverVC.didMove(toParentViewController: self)
            print("DeficiencyTypeViewController Button Tapped......")
        }
        

    }
    
    // MARK:- Show Alert Message Method

    func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
