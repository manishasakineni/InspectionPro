//
//  ViewController.swift
//  InSpectionPro
//
//  Created by Mac OS on 29/11/17.
//  Copyright © 2017 Mac OS. All rights reserved.
//

import UIKit
import CoreData
import SVProgressHUD

protocol navigationBarButtonDelegate {
    func dissmisLogOutView()
}
protocol FailedDataUpdateDelegate {
    func addDeficiencyCount(_ model : AllModel)
    func failedAddCount(_ btn : Int)
    func personOperationCount(_ model0 : String)
    func commentsCount(_ model1 : String)
    func unitIdCount(_ model2 : String)
    func correctionCount(_ model3 : String)
    func deficiencyCount(_ model4 : String)

    
    
//func getDeficencyArray( )

}

class ViewController: UIViewController ,UITableViewDelegate ,UITableViewDataSource,navigationBarButtonDelegate,FailedDataUpdateDelegate {

    var categoryData = Array<String>()
    var serviceController = ServiceController()
    var linesArray = Array<LinesVO>()
    var lineNumberId      : String = ""
    var unitIdString      : String = ""
    let utillites =  Utilities()
    var name = ""
    var lastExecuted = ""
    var status = ""
    var type = ""
    var all = "0"
    var unsaved = "0"
    var failed = "0"
    var itemList = ""
    var all1 = ""
    var all2 = ""
    var all3 = ""
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var loginUserName: UILabel!
    @IBOutlet weak var inSpectionProTableView: UITableView!
    
    @IBOutlet weak var noRecordsFound: UILabel!
    var categories: [AllModel]!
    var deficiencyTypeArray : Array<String> = Array()
    var userInfo : Dictionary<String,Any> = Dictionary()
    var paymentInfo : Dictionary<String,Any> = Dictionary()
    var deficencyCorrectiveModelArray : Array<DeficencyCorrectiveModel> = Array()
    var deficencyCorrectiveModelArray1 : Array<DeficencyCorrectiveModel> = Array()
    var allModelArray : Array<AllModel> = Array()
    var unitAllModelArray : Array<AllModel> = Array()
    var unitAllModelArray1 : Array<AllModel> = Array()
    var unitAllModelArray2 : Array<AllModel> = Array()
    var operationsModelArray : Array<String> = Array()
    var unSavedTableViewDataArray : Array<AllModel> = Array()
    var failedTableViewDataArray : Array<AllModel> = Array()
    var modelArray = Array<String>()
    let emptyArray = [String]()
    var appVersion          : String = ""
    var selectedButtonTitle = "All"
    var rootNavigationController    : CCKFNavDrawer?    = nil
    var clickedRow = -1
    var userName = ""
    var selectedModel : AllModel = AllModel()
    var unSavedBool = false
    var linesDBModel = [Lines]()
    var lineValuesDBModel = [Linevalues]()
    var operatorsDBModel = [Operators]()
    var unitsDBModel = [Units]()
    var saveDataDBModel = [SaveData]()
    var localSavedDataDBModel = [LocalSavedData]()
    var unitsModelArray : Array<UnitModel> = Array()
    var syncModelArray : Array<String> = Array()
    let nameString = ""
    let lineIdString = ""
    let appIdString = ""
    let frequencyString = ""
    let windowString : Int = 0
    let lastExcutedString = ""
    let closedString : Bool = false
    let statusString : Bool = false
    var isUpdate : Bool = false
    var unitsArray : Array<UnitModel> = Array()
    var personString = ""
    var commentsString = ""
    var deficiencyString = ""
    var correctionString = ""
    var unitIdStringOfAPI = ""
    var unitID = ""
    var syncRecordsCount : String = ""
    var inspectionTitleString : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        print(paths[0])
      
        
        if let userName = UserDefaults.standard.value(forKey: "SavedUserName") as? String{
            loginUserName.text = userName
        }

        
        inSpectionProTableView.delegate = self
        inSpectionProTableView.dataSource = self

        appVersion = "V (" + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)! + ")"
        mapperUnitGetUrl()
        allLinesModel()
        registerTableViewCells()
        
            self.noRecordsFound.isHidden = true
        
    }
    
// MARk :- Get All Lines API Method.
    func allLinesModel(){
// MARK :- Check Internet Conection Available are not
        if(appDelegate.checkInternetConnectivity()){
        NetworkServiceHandler.sharedInstance.getAllModels(self, successBlock: {(paymentTermsArray,valuesArray,operations,untValues) in
       print(untValues)
            if(paymentTermsArray.count > 0){
                for paymentTerms in paymentTermsArray{
                       var modelData = paymentTerms
                       modelData.type = "0"
                
                         self.allModelArray.append(modelData)

// MARK :- Online
// MARK :- FetchRequest Data From Local DataBase (Core Data) =>  Lines Table
                    let fetchRequest:NSFetchRequest<Lines> = NSFetchRequest.init(entityName: "Lines")
                    
                    let predicate = NSPredicate(format: "lineId = '\(paymentTerms.lineId)'")
                    fetchRequest.predicate = predicate
                    do
                    {
                        let test = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                        if test.count > 0
                        {
                            let objectUpdate = test[0] as! NSManagedObject
                            objectUpdate.setValue(modelData.name, forKey: "name")
                            objectUpdate.setValue(modelData.lineId, forKey: "lineId")
                            objectUpdate.setValue(modelData.appId, forKey: "appId")
                            objectUpdate.setValue(modelData.frequency, forKey: "frequency")
                            objectUpdate.setValue(modelData.window, forKey: "window")
                            objectUpdate.setValue(modelData.lastExecuted, forKey: "lastExecuted")
                            objectUpdate.setValue(modelData.closed, forKey: "closed")
                            objectUpdate.setValue(modelData.status, forKey: "status")

                            for unitsModel in modelData.unitsArray {
                                
                                let fetchRequest:NSFetchRequest<SaveData> = NSFetchRequest.init(entityName: "SaveData")
                                
                                let predicate = NSPredicate(format: "unitId = '\(unitsModel.unitId)'")
                                
                                fetchRequest.predicate = predicate
                                do
                                {
                                    let test = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                                    if test.count > 0
                                    {
                                        let objectUpdate = test[0] as! NSManagedObject
                                        objectUpdate.setValue(unitsModel.unitId, forKey: "unitId")
                                        objectUpdate.setValue(unitsModel.name, forKey: "name")
                                        objectUpdate.setValue(unitsModel.appId, forKey: "appId")
                                        objectUpdate.setValue(modelData.lineId, forKey: "lineId")
                                        
                                        do{
// MARK :- Save Data On Local DataBase (Core Data) =>  Lines Table
                                            try PersistenceService.managedObjectContext.save()
                                        }
                                        catch
                                        {
                                            print(error)
                                        }
                                    }
                                } catch
                                {
                                    print(error)
                                }
                            }
                            do{
                                try PersistenceService.managedObjectContext.save()
                            }
                            catch
                            {
                                print(error)
                            }
                        }else{
// MARK :- FetchRequest Data From Local DataBase (Core Data)  =>  Lines Table
                            let entityLines = NSEntityDescription.entity(forEntityName: "Lines", in: PersistenceService.managedObjectContext)
                            let userLines = NSManagedObject(entity: entityLines!, insertInto: PersistenceService.managedObjectContext)
                            userLines.setValue(modelData.name, forKey: "name")
                            userLines.setValue(modelData.lineId, forKey: "lineId")
                            userLines.setValue(modelData.appId, forKey: "appId")
                            userLines.setValue(modelData.frequency, forKey: "frequency")
                            userLines.setValue(modelData.window, forKey: "window")
                            userLines.setValue(modelData.lastExecuted, forKey: "lastExecuted")
                            userLines.setValue(modelData.closed, forKey: "closed")
                            userLines.setValue(modelData.status, forKey: "status")
                            userLines.setValue(true, forKey: "isUpdatedServer")
                            userLines.setValue(false, forKey: "isFailed")
                            userLines.setValue(false, forKey: "isUnsaved")
                            
                            for unitsModel in modelData.unitsArray {
                                
                                            let fetchRequest:NSFetchRequest<SaveData> = NSFetchRequest.init(entityName: "SaveData")
                                
                                            let predicate = NSPredicate(format: "unitId = '\(unitsModel.unitId)'")
                                
                                            fetchRequest.predicate = predicate
                                            do
                                            {
                                            let test = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                                            let entityLines = NSEntityDescription.entity(forEntityName: "SaveData", in: PersistenceService.managedObjectContext)
                                            let userLines = NSManagedObject(entity: entityLines!, insertInto: PersistenceService.managedObjectContext)
                                                userLines.setValue(unitsModel.unitId, forKey: "unitId")
                                                userLines.setValue(unitsModel.name, forKey: "name")
                                                userLines.setValue(unitsModel.appId, forKey: "appId")
                                                userLines.setValue(modelData.lineId, forKey: "lineId")
                                                do{
// MARK :- Save Data on Local DataBase (Core Data) =>  Lines Table
                                                try PersistenceService.managedObjectContext.save()
                                                self.saveDataDBModel.append(userLines as! SaveData)
                                                    }
                                                    catch{
                                                        print("Could Not Save")
                                                    }
                                                
                                            } catch
                                            {
                                                print(error)
                                            }
                            }
                            
                            do{
                                try PersistenceService.managedObjectContext.save()
                                self.linesDBModel.append(userLines as! Lines)
                            }
                            catch{
                                print("Could Not Save")
                            }
                        }
                    } catch
                        {
                            print(error)
                        }
                }
            }
            
            self.allModelArray = self.allModelArray.sorted(by: { (Obj1, Obj2) -> Bool in
                let Obj1_Name = Obj1.name.replacingOccurrences(of: " ", with: "")
                let Obj2_Name = Obj2.name.replacingOccurrences(of: " ", with: "")
                return (Obj1_Name.localizedCompare(Obj2_Name) == .orderedAscending)
            })
            //lineValuesDBModel
            if (valuesArray.count > 0){
                for valuesData in valuesArray {
                    var valuesModelData = valuesData
                  
// MARK :- FetchRequest Data From Local DataBase (Core Data) => Linevalues Table
                        let fetchRequest:NSFetchRequest<Linevalues> = NSFetchRequest.init(entityName: "Linevalues")
                    
                        let predicate = NSPredicate(format: "id = '\(valuesData.id)'")
                        fetchRequest.predicate = predicate
                        do
                        {
                           
                            let test = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                            if test.count > 0
                            {
                                let objectUpdate = test[0] as! NSManagedObject
                                    objectUpdate.setValue(valuesModelData.id, forKey: "id")
                                    objectUpdate.setValue(valuesModelData.appId, forKey: "appId")
                                    objectUpdate.setValue(valuesModelData.isInspection, forKey: "isInspection")
                                    objectUpdate.setValue(valuesModelData.name, forKey: "name")
                                    objectUpdate.setValue(valuesModelData.parentId, forKey: "parentId")
                                do{
                                    try PersistenceService.managedObjectContext.save()
                                }
                                catch
                                {
                                    print(error)
                                }
                            }else{
                                let entityLines = NSEntityDescription.entity(forEntityName: "Linevalues", in: PersistenceService.managedObjectContext)
                                let userLines = NSManagedObject(entity: entityLines!, insertInto: PersistenceService.managedObjectContext)
                                
                                userLines.setValue(valuesModelData.id, forKey: "id")
                                userLines.setValue(valuesModelData.appId, forKey: "appId")
                                userLines.setValue(valuesModelData.isInspection, forKey: "isInspection")
                                userLines.setValue(valuesModelData.name, forKey: "name")
                                userLines.setValue(valuesModelData.parentId, forKey: "parentId")
                                do{
// MARK :- Save Data From Local DataBase (Core Data) => Linevalues Table
                                    try PersistenceService.managedObjectContext.save()
                                    self.lineValuesDBModel.append(userLines as! Linevalues)
                                }
                                catch{
                                    print("Could Not Save")
                                }
                            }
                        }
                        catch
                        {
                            print(error)
                        }
                    self.deficencyCorrectiveModelArray.append(valuesModelData)
                }
            }
            print("deficencyCorrectiveModelArray",self.deficencyCorrectiveModelArray.count)

            if (operations.count > 0){
                for operationsData in operations {
                    let operationsModelData = operationsData
                
                    
                    let fetchRequest:NSFetchRequest<Operators> = NSFetchRequest.init(entityName: "Operators")
                    
                    let predicate = NSPredicate(format: "name = '\(operationsModelData)'")
                    fetchRequest.predicate = predicate
                    do
                    {
                        
// MARK :- FetchRequest Data From Local DataBase (Core Data) => Operation Table
                      let test = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                        if test.count > 0
                        {
                            let objectUpdate = test[0] as! NSManagedObject
                            objectUpdate.setValue(operationsModelData, forKey: "name")
                          
                            do{
                                try PersistenceService.managedObjectContext.save()
                            }
                            catch
                            {
                                print(error)
                            }
                        }else{
                            let entityLines = NSEntityDescription.entity(forEntityName: "Operators", in: PersistenceService.managedObjectContext)
                            let userLines = NSManagedObject(entity: entityLines!, insertInto: PersistenceService.managedObjectContext)
                            
                            userLines.setValue(operationsModelData, forKey: "name")
                          
                            do{
// MARK :- Save Data on Local DataBase (Core Data) => Operation Table
                                try PersistenceService.managedObjectContext.save()
                                self.operatorsDBModel.append(userLines as! Operators)
                            }
                            catch{
                                print("Could Not Save")
                            }
                        }
                    }
                    catch
                    {
                        print(error)
                    }
                    
                    self.operationsModelArray.append(operationsModelData)
                }
            }

            for eachAllModelArray in self.allModelArray{
               // var eachStatus =eachAllModelArray.status
                print(eachAllModelArray.status)

                    if(eachAllModelArray.status == 0){
                    self.failedTableViewDataArray.append(eachAllModelArray)
                }
            }
            self.all = "\(self.allModelArray.count)"
            self.failed = "\(self.failedTableViewDataArray.count)"
            self.unsaved = "\(self.unSavedTableViewDataArray.count)"

            self.inSpectionProTableView.reloadData()

        }, failureBlock: {(fail) in
            
        })
            
        }else{
 // MARK :- Off-line
 // MARK :- FetchRequest Data From Local DataBase (Core Data) => Lines Table

             let fetchRequest:NSFetchRequest<Lines> = NSFetchRequest.init(entityName: "Lines")
            
            do {
                let results = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                let  localAllModelArrayLocal = results as [Lines]
                
                for localModelData in localAllModelArrayLocal {
                   let model = AllModel()

                    model.name = localModelData.name!
                    model.lineId = localModelData.lineId!
                    model.appId = localModelData.appId!
                    model.frequency = localModelData.frequency!
                    model.window = Int(localModelData.window)
                    model.lastExecuted = localModelData.lastExecuted!
                    model.closed = localModelData.closed
                    model.status = localModelData.status == true ? 1 : 0
                    model.isFailed = localModelData.isFailed
                    model.isUnsaved = localModelData.isUnsaved
                    model.isUpdatedServer = localModelData.isUpdatedServer
                    
// MARK :- FetchRequest Data From Local DataBase (Core Data) => SaveData Table
                    var allUnitModels = Array<UnitModel>()
                    let fetchRequest:NSFetchRequest<SaveData> = NSFetchRequest.init(entityName: "SaveData")
                    
                    let predicate = NSPredicate(format: "lineId = '\(localModelData.lineId!)'")
                    
                    fetchRequest.predicate = predicate
                    do
                    {
                        
                        let test = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                        if test.count > 0
                        {
                            
                            for eachSaveData in test{
                                let objectUpdate = eachSaveData as SaveData
                                let unitLocalModel = UnitModel()
                                
                                unitLocalModel.unitId = objectUpdate.unitId!
                                unitLocalModel.name = objectUpdate.name!
                                unitLocalModel.appId = objectUpdate.appId!
                                unitLocalModel.lineId = objectUpdate.lineId!


                                allUnitModels.append(unitLocalModel)
                            }
                            
                            do{
// MARK :- Save Data On Local DataBase (Core Data) => SaveData Table

                                try PersistenceService.managedObjectContext.save()
                            }
                            catch
                            {
                                print(error)
                            }
                        }else{
                            
                        }
                    } catch
                    {
                        print(error)
                    }
                    
                    
                    
                    
                    model.unitsArray = allUnitModels
                    
                    allModelArray.append(model)
                    self.allModelArray = self.allModelArray.sorted(by: { (Obj1, Obj2) -> Bool in
                        let Obj1_Name = Obj1.name.replacingOccurrences(of: " ", with: "")
                        let Obj2_Name = Obj2.name.replacingOccurrences(of: " ", with: "")
                        return (Obj1_Name.localizedCompare(Obj2_Name) == .orderedAscending)
                    })
                }
                
// MARK :- FetchRequest Data From Local DataBase (Core Data) => Linevalues Table
                let deficencyCorrectivefetchRequest:NSFetchRequest<Linevalues> = NSFetchRequest.init(entityName: "Linevalues")
                
                do {
                    let results = try PersistenceService.managedObjectContext.fetch(deficencyCorrectivefetchRequest)
                    let  deficencyCorrectiveModelArrayLocal = results as [Linevalues]
                    
                    for localModelData in deficencyCorrectiveModelArrayLocal {
                        let model = DeficencyCorrectiveModel()
                        model.name = localModelData.name!
                        model.id = localModelData.id!
                        model.appId = localModelData.appId!
                        model.isInspection = localModelData.isInspection == true ? 1 : 0
                        model.parentId = localModelData.parentId!
                        deficencyCorrectiveModelArray.append(model)
                    }
                } catch let error as NSError {
                    //  print("Could not fetch \(error)”)
                }

                let operatorsFetchRequest:NSFetchRequest<Operators> = NSFetchRequest.init(entityName: "Operators")
                
                do {
                    let results = try PersistenceService.managedObjectContext.fetch(operatorsFetchRequest)
                    let  operatorsModelArrayLocal = results as [Operators]
                    
                    for localModelData in operatorsModelArrayLocal {
                      
                        operationsModelArray.append(localModelData.name!)
                    }
                } catch let error as NSError {
                    //  print("Could not fetch \(error)”)
                }

                for eachAllModelArray in allModelArray{
                    if(eachAllModelArray.isUnsaved == true){
                        unSavedTableViewDataArray.append(eachAllModelArray)
                    }else if(eachAllModelArray.status == 0){
                        failedTableViewDataArray.append(eachAllModelArray)
                    }
                }
// MARk:- Count For Header Tabs (ALL,UNSAVED,FAILED)
                self.all = "\(self.allModelArray.count)"
                self.unsaved = "\(self.unSavedTableViewDataArray.count)"
                self.failed = "\(self.failedTableViewDataArray.count)"
                inSpectionProTableView.reloadData()
                
                
            } catch let error as NSError {
              //  print("Could not fetch \(error)”)
            }
     
           // self.appDelegate.window?.makeToast("Please check your internet Connection...", duration:kToastDuration, position:CSToastPositionCenter)
            
        }
    }
    
    func savedContext() {
        
        
    }
    
    func upDateContext() {
        
        
    }
    
// MARK:- GET lines API-Service Method
    func mapperUnitGetUrl(){
        if(appDelegate.checkInternetConnectivity()){

        let endpoint: String = BASE_GETLINES_URL

        serviceController.getURLRequest(strURL: endpoint, success: { (json) in
//MARK:- Success Block
            DispatchQueue.main.async()
                {
                    
                    let respVO:JsonVO = Mapper().map(JSONObject: json)!
                    
                    let lineId =  respVO.lines?[0].lineId
                    self.linesArray = respVO.lines!

                    let nameLineId =  respVO.lines?[0].units?[0].name
                    let defaults = UserDefaults.standard
                    defaults.set(lineId, forKey: klineId)
                    defaults.set(nameLineId, forKey: KnameLineId)
                    
                    let unitId =  respVO.lines?[0].units?[0].unitId
                    defaults.set(unitId, forKey: KunitId)

                    defaults.synchronize()
       
            }
        
        }) { (failureMessage) in
   
            //MARK:- Failure Block

            
        }
        
        }else{
       //     self.appDelegate.window?.makeToast("Please check your internet Connection...", duration:kToastDuration, position:CSToastPositionCenter)

        }
    }
 
//  MARK:- Register For Tableview Cells
    private func registerTableViewCells() {
        
        let nibName  = UINib(nibName: "NumberOfLinesCell" , bundle: nil)
        inSpectionProTableView.register(nibName, forCellReuseIdentifier: "NumberOfLinesCell")
        
        let nibName1  = UINib(nibName: "HeaderSectionCell" , bundle: nil)
        inSpectionProTableView.register(nibName1, forCellReuseIdentifier: "HeaderSectionCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        disablePanGestureForNavigationDrawer(false)
    
        updateNavigationHeader()
        
        
            
      calculateDataToBeUpdated()
            
        
       // syncOnLocalData()
        // navigationItem.leftBarButtonItems = []
      
    }
    
    func updateNavigationHeader(){

//        let myString:NSString = "InspectionPro"
//        var myMutableString = NSMutableAttributedString()
//        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSAttributedStringKey.font:UIFont(name: "Georgia", size: 18.0)!])
//        myMutableString.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.red, range: NSRange(location:2,length:4))
     
        Utilities.setupHomeViewControllerNavBarColorInCntrWithColor(backImage: "Icon-40.png", cntr:self, titleView: nil, withText: "", backTitle: " InspectionPro", rightImage: appVersion, syncTotalRecodCount: syncRecordsCount ,secondRightImage: "sync", thirdRightImage: "logout-1")
    }
    
    func calculateDataToBeUpdated(){
        let deficencyCorrectivefetchRequest:NSFetchRequest<LocalSavedData> = NSFetchRequest.init(entityName: "LocalSavedData")
        do {
            let results = try PersistenceService.managedObjectContext.fetch(deficencyCorrectivefetchRequest)
            let  deficencyCorrectiveModelArrayLocal = results as [LocalSavedData]
            
            if deficencyCorrectiveModelArrayLocal.count > 0 {
                syncRecordsCount = "\(deficencyCorrectiveModelArrayLocal.count)"
                 updateNavigationHeader()
                
            }else{
                syncRecordsCount = ""
                 updateNavigationHeader()
            }
        } catch let error as NSError {
            //  print("Could not fetch \(error)”)
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
       
        
        disablePanGestureForNavigationDrawer(true)
    }
    
    private func disablePanGestureForNavigationDrawer(_ enable: Bool) {
        rootNavigationController = self.navigationController as? CCKFNavDrawer
        rootNavigationController?.pan_gr.isEnabled = enable
        
    }
//MARk:- TableView Delegate Methods AND DataSource Methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if(selectedButtonTitle == "All"){
            return allModelArray.count
        }
        else if(selectedButtonTitle == "Unsaved"){
            return unSavedTableViewDataArray.count
        }else{
            return failedTableViewDataArray.count
        }
        
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let listStr:AllModel = allModelArray[indexPath.row]

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NumberOfLinesCell", for: indexPath) as! NumberOfLinesCell
        
            cell.failedButton.addTarget(self, action: #selector(ViewController.failedSummary(_:)), for: .touchUpInside)
            cell.passedButton.addTarget(self, action: #selector(ViewController.passSummary(_:)), for: .touchUpInside)
        if(selectedButtonTitle == "All"){
            if(allModelArray.count > indexPath.row){
                
                cell.lineNameLabel.text = listStr.name
                
                cell.lastExecutedDate.text = returnEventDateWithoutTim1(selectedDateString: listStr.lastExecuted)
                
                if listStr.status == 0 {
                     cell.statusLabel.text = "Failed"
                     cell.statusLabel.textColor = UIColor.red
                    
                }else{
                     cell.statusLabel.text = "Passed"
                     cell.statusLabel.textColor = UIColor.black
                    
                    
                }
                cell.passedButton.setImage(listStr.isPassSelected == true ?#imageLiteral(resourceName: "likebtn_hover") : #imageLiteral(resourceName: "likebtn"), for: .normal)
                cell.failedButton.setImage(listStr.isFailedSelected == true ? #imageLiteral(resourceName: "unlikebtn_hover") : #imageLiteral(resourceName: "unlikebtn"), for: .normal)
                cell.failedButton.tag = indexPath.row
                cell.passedButton.tag = indexPath.row
             //   cell.failedButton.isEnabled = true

            }
        }
        else if(selectedButtonTitle == "Unsaved"){
            if(unSavedTableViewDataArray.count > indexPath.row){
                
                cell.configureCellWith(unSavedTableViewDataArray[indexPath.row])
                cell.passedButton.setImage(#imageLiteral(resourceName: "likebtn") , for: .normal)
                cell.failedButton.setImage( #imageLiteral(resourceName: "unlikebtn_hover") , for: .normal)
                cell.failedButton.tag = indexPath.row
                cell.passedButton.tag = indexPath.row
             //    cell.failedButton.isEnabled = false
            }
        }else{
            if(failedTableViewDataArray.count > indexPath.row){
                
                cell.configureCellWith(failedTableViewDataArray[indexPath.row])
                cell.passedButton.setImage(#imageLiteral(resourceName: "likebtn") , for: .normal)
                cell.failedButton.setImage( #imageLiteral(resourceName: "unlikebtn_hover") , for: .normal)
                cell.failedButton.tag = indexPath.row
                cell.passedButton.tag = indexPath.row
             //   cell.failedButton.isEnabled = false

            }
        }
      

        return cell
    }
    
   
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderSectionCell") as! HeaderSectionCell
        
        headerCell.allCountLabel.text = all
        headerCell.allButton.addTarget(self, action: #selector(ViewController.allButtonTapped(_:)), for: .touchUpInside)
        headerCell.unSavedCountLabel.text = unsaved
        headerCell.unsavedButton.addTarget(self, action: #selector(ViewController.unSavedButtonTapped(_:)), for: .touchUpInside)
        headerCell.failedCountLabel.text = failed
        headerCell.failedThumbButton.addTarget(self, action: #selector(ViewController.failedButtonTapped(_:)), for: .touchUpInside)
     
        return headerCell
        
    }
 
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60.0
        
    }
    
    @IBAction func passSummary(_ sender: UIButton) {
        print("Pass Summary Button Tapped......")
        if(selectedButtonTitle == "All"){
            
            passButtonAPI(sender.tag)

            if self.unSavedTableViewDataArray.count > 0{
                let model = self.allModelArray[sender.tag]
                
                if(unSavedTableViewDataArray.contains(model)){
                    var k = 0
                    for unsavedData in unSavedTableViewDataArray{
                        if(unsavedData.lineId == model.lineId){
                            
                            let fetchRequest:NSFetchRequest<Lines> = NSFetchRequest.init(entityName: "Lines")
                            
                            let predicate = NSPredicate(format: "lineId = '\(model.lineId)'")
                            fetchRequest.predicate = predicate
                            do
                            {
                                let test = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                                if test.count > 0
                                {
                                    let objectUpdate = test[0] as! NSManagedObject
                                    objectUpdate.setValue(false, forKey: "isUnsaved")
                                    do{
                                        try PersistenceService.managedObjectContext.save()
                                    }
                                    catch
                                    {
                                        print(error)
                                    }
                                }
                            } catch
                            {
                                print(error)
                            }
                            unSavedTableViewDataArray.remove(at: k)
                        }
                        k = k + 1
                    }

                    
                    unsaved = "\(unSavedTableViewDataArray.count)"
                    
                }
            }
            if self.failedTableViewDataArray.count > 0{
                let model = self.allModelArray[sender.tag]
                model.status = 1
                self.allModelArray[sender.tag] = model
                var i = 0
                for eachModel in failedTableViewDataArray{
                    if(eachModel.lineId == model.lineId){
                         failedTableViewDataArray.remove(at: i)
                    }
                    i = i + 1
                }
            
                if(failedTableViewDataArray.count == 0){
                    failed = "0"
                }else{
                    failed = String(failedTableViewDataArray.count)
                }
            }
            
            let model = self.allModelArray[sender.tag]
            model.isPassSelected = true
              model.isFailedSelected = false
            self.allModelArray[sender.tag] = model

        }
        else if(selectedButtonTitle == "Unsaved"){
            passButtonAPI(sender.tag)
            let model = self.unSavedTableViewDataArray[sender.tag]
       
            var k = 0
            for eachModel in allModelArray{
                if model.lineId == eachModel.lineId{
                    var matchedModel = eachModel
                    matchedModel.isFailedSelected = false
                    matchedModel.isPassSelected = true
                    allModelArray[k] = matchedModel
                    
                }
                k = k + 1
            }
            
            model.isFailedSelected = false
            model.isPassSelected = true
            unSavedTableViewDataArray[sender.tag] = model
            
            if(unSavedTableViewDataArray.contains(model)){
                let fetchRequest:NSFetchRequest<Lines> = NSFetchRequest.init(entityName: "Lines")
                
                let predicate = NSPredicate(format: "lineId = '\(model.lineId)'")
                fetchRequest.predicate = predicate
                do
                {
                    let test = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                    if test.count > 0
                    {
                        let objectUpdate = test[0] as! NSManagedObject
                        objectUpdate.setValue(false, forKey: "isUnsaved")
                        do{
                            try PersistenceService.managedObjectContext.save()
                        }
                        catch
                        {
                            print(error)
                        }
                    }
                } catch
                {
                    print(error)
                }
                unSavedTableViewDataArray.remove(at: sender.tag)
                
                unsaved = "\(unSavedTableViewDataArray.count)"
                
            }
        }else{
            
            passButtonAPI(sender.tag)
            if self.failedTableViewDataArray.count > 0 {
                
                let unsavedModel = failedTableViewDataArray[sender.tag]
                
                var k = 0
                for eachModel in allModelArray{
                    if unsavedModel.lineId == eachModel.lineId{
                        var matchedModel = eachModel
                        matchedModel.isFailedSelected = false
                        matchedModel.isPassSelected = true
                        allModelArray[k] = matchedModel
                        
                    }
                    k = k + 1
                }
                
                unsavedModel.isFailedSelected = false
                unsavedModel.isPassSelected = true
                failedTableViewDataArray[sender.tag] = unsavedModel
                
                unsavedModel.status = 1
                var i = 0
                for eachModel in allModelArray{
                    if(eachModel.lineId == unsavedModel.lineId){
                        allModelArray[i] = unsavedModel
                    }
                    i = i + 1
                }
                if(failedTableViewDataArray.contains(unsavedModel)){
                    var k = 0
                    for eachModel in failedTableViewDataArray{
                        if(eachModel.lineId == unsavedModel.lineId){
                            let fetchRequest:NSFetchRequest<Lines> = NSFetchRequest.init(entityName: "Lines")
                            
                            let predicate = NSPredicate(format: "lineId = '\(unsavedModel.lineId)'")
                            fetchRequest.predicate = predicate
                            do
                            {
                                let test = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                                if test.count > 0
                                {
                                    let objectUpdate = test[0] as! NSManagedObject
                                    objectUpdate.setValue(false, forKey: "isUnsaved")
                                    objectUpdate.setValue(false, forKey: "isFailed")

                                    do{
                                        try PersistenceService.managedObjectContext.save()
                                    }
                                    catch
                                    {
                                        print(error)
                                    }
                                }
                            } catch
                            {
                                print(error)
                            }
                            failedTableViewDataArray.remove(at: k)
                        }
                        k = k + 1
                    }

                    if(failedTableViewDataArray.count == 0){
                        failed = "0"
                    }else{
                        failed = String(failedTableViewDataArray.count)
                        
                    }
                }
                }
            }

        inSpectionProTableView.reloadData()

        self.appDelegate.window?.makeToast("Please wait...", duration:kToastDuration, position:CSToastPositionCenter)

    }
    
    //MARK:- SaveLines API-Service Method
    func passButtonAPI(_ indexValue : Int){
        var lineID = ""
        if(selectedButtonTitle == "All"){
            lineID = allModelArray[indexValue].lineId
        } else if(selectedButtonTitle == "Unsaved"){
            lineID = unSavedTableViewDataArray[indexValue].lineId
            }else{
            lineID = failedTableViewDataArray[indexValue].lineId
        }
//  MARK:- Check Internet Connection Avilable are not
        if(appDelegate.checkInternetConnectivity()){

        
        let  saveLinesAPI : String = BASE_SAVELINES_URL
        let updateProfiledictParams = [
            "lineId": lineID,
            "transactionId": "null",
            //  "failedUnits": "",
            "failedUnits": []
            ] as [String : Any]
        print(updateProfiledictParams)
        
        let dictHeaders = ["":"","":""] as NSDictionary
        
            
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

 //  MARK:- Off-line
// MARK :- FetchRequest Data From Local DataBase (Core Data) => LocalSavedData Table

            let entityLines = NSEntityDescription.entity(forEntityName: "LocalSavedData", in: PersistenceService.managedObjectContext)
            let userLines = NSManagedObject(entity: entityLines!, insertInto: PersistenceService.managedObjectContext)
            
            userLines.setValue(lineID, forKey: "lineId")
            
            userLines.setValue("", forKey: "transactionId")
            userLines.setValue([], forKey: "failedUnits")
            
            do{
                try PersistenceService.managedObjectContext.save()
                self.localSavedDataDBModel.append(userLines as! LocalSavedData)
            }
            catch{
                print("Could Not Save")
            }
            
         //   inSpectionProTableView.reloadData()
        
        }
    
    }
    //MARK:- UpDateDBModels Method (Core Data)
    func updateDBModels(index: Int, newAllModel: AllModel){
        // let appDelegate = UIApplication.shared.delegate as! AppDelegate
        linesDBModel[index].name = newAllModel.name
        linesDBModel[index].status = (newAllModel.status != nil)
        PersistenceService.saveContext()
        
    }
    
    @IBAction func failedSummary(_ sender: UIButton) {

        clickedRow = sender.tag
             var lineNamesArray = Array<String>()
        var selectTabOfLineName = ""
        
        var model : AllModel!
        
//MARK:- All Tap Selected Title
        if selectedButtonTitle == "All" {
            let unitsArray = allModelArray[sender.tag].unitsArray
            
           model = allModelArray[sender.tag]
            let listStr:AllModel = allModelArray[sender.tag]

            for singleUnitData in unitsArray{
                let singleStr = singleUnitData
                
                lineNamesArray.append(singleUnitData.name)
                selectTabOfLineName = listStr.name
                
            }
                        if(!unSavedTableViewDataArray.contains(model)){
            
                            unSavedTableViewDataArray.append(model)
            }
        
            let isSelectedImgModel = allModelArray[sender.tag]
            var k = 0
            for eachModel in unSavedTableViewDataArray{
                if isSelectedImgModel.lineId == eachModel.lineId{
                    var matchedModel = eachModel
                    matchedModel.isFailedSelected = true
                    matchedModel.isPassSelected = true
                    unSavedTableViewDataArray[k] = matchedModel
                    
                }
                k = k + 1
            }
            
            isSelectedImgModel.isFailedSelected = true
            isSelectedImgModel.isPassSelected = false
            allModelArray[sender.tag] = isSelectedImgModel
            unsaved = "\(unSavedTableViewDataArray.count)"
            
        }else if selectedButtonTitle == "Unsaved"{

            let unitsArray = unSavedTableViewDataArray[sender.tag].unitsArray
            
            model = unSavedTableViewDataArray[sender.tag]
            let listStr:AllModel = unSavedTableViewDataArray[sender.tag]

            for singleUnitData in unitsArray{
                let singleStr = singleUnitData
                
                lineNamesArray.append(singleUnitData.name)
                selectTabOfLineName = listStr.name

            }
        
        }else{
            let unitsArray = failedTableViewDataArray[sender.tag].unitsArray
            model = failedTableViewDataArray[sender.tag]
            
            if(!unSavedTableViewDataArray.contains(model)){
                unSavedTableViewDataArray.append(model)
            }
               unsaved = "\(unSavedTableViewDataArray.count)"
            let listStr:AllModel = failedTableViewDataArray[sender.tag]

            for singleUnitData in unitsArray{
                let singleStr = singleUnitData
                
                lineNamesArray.append(singleUnitData.name)
                selectTabOfLineName = listStr.name
                
            }

        }
   
        print(lineNamesArray)
        var selectedlineName = ""
     inSpectionProTableView.reloadData()

//MARk:- Navigate Other ViewController
        let  failedViewController = FailedViewController(nibName: "FailedViewController", bundle: nil)
        failedViewController.deficencyCorrectiveModelArray = deficencyCorrectiveModelArray
        failedViewController.operationArray = operationsModelArray
        failedViewController.unitsArray = lineNamesArray
        failedViewController.selectedlineName = selectTabOfLineName
        failedViewController.selectedModel = model
        failedViewController.unSavedSelectedModel = [model]
        failedViewController.failedDataUpdateDelegate = self
        
        self.navigationController?.pushViewController(failedViewController, animated: true)
        print("Failed Summary Button Tapped......")
    
        self.appDelegate.window?.makeToast("Please wait...", duration:kToastDuration, position:CSToastPositionCenter)
        
    }
//MARk:-  Sync Operations
//MARk:- UpDate Local(Core Data) Changes To Server (Data Base)
    @IBAction func refreshButtonTapped(_ sender:UIButton) {
       
        syncOnLocalData()
  
        
    }
    func syncOnLocalData(){
        if(appDelegate.checkInternetConnectivity()){
            
            let deficencyCorrectivefetchRequest:NSFetchRequest<LocalSavedData> = NSFetchRequest.init(entityName: "LocalSavedData")
            do {
                let results = try PersistenceService.managedObjectContext.fetch(deficencyCorrectivefetchRequest)
                let  deficencyCorrectiveModelArrayLocal = results as [LocalSavedData]
                var k = 0
                if deficencyCorrectiveModelArrayLocal.count > 0 {
                    syncRecordsCount = "\(deficencyCorrectiveModelArrayLocal.count)"
                     updateNavigationHeader()
                    for localModelData in deficencyCorrectiveModelArrayLocal {
                        print(localModelData.failedUnits as? Array<Dictionary<String, Any>> ?? [["":""]])
                        print(localModelData.lineId ?? "")
                        
                        // MARK:- Save lines API-Service
                        let  saveLinesAPI : String = BASE_SAVELINES_URL
                        
                        print("Refresh Button Clicked............")
                        
                        
                        let saveLinesParams = [
                            "lineId": localModelData.lineId ?? "",
                            "transactionId":"null",
                            "failedUnits": localModelData.failedUnits as? Array<Dictionary<String, Any>> ?? [["":""]]
                            ] as [String : Any]
                        
                        let dictHeaders = ["":"","":""] as NSDictionary
                        
                        
                        serviceController.postRequest(_viewController :self,strURL: saveLinesAPI as NSString , postParams: saveLinesParams as NSDictionary, postHeaders: dictHeaders, successHandler: { (result) in
                            
                            print(result)
                            
                            let respVO:SyncResultVo = Mapper().map(JSONObject: result)!
                            
                            
                            let isSuccess = respVO.result
                            print("StatusCode:\(String(describing: isSuccess))")
                            
                            if isSuccess == true {
                                
                                // for church in respVO.inspectionId!{
                                
                                var syncString = respVO.inspectionId!
                                self.syncModelArray.append(syncString)
                                
                                print("churchAdminArray", self.syncModelArray)
                                
                                self.inSpectionProTableView.reloadData()
                                
                                //   self.appDelegate.window?.makeToast(successMsg!, duration:kToastDuration, position:CSToastPositionCenter)
                                
                            }
                                
                            else {
                                
                                
                                
                            }
                            
                        }) { (failureMessage) in
                            
                            
                            print(failureMessage)
                            
                        }
                        
                        if(k == deficencyCorrectiveModelArrayLocal.count - 1){
                            
                            
                            // MARK :- FetchRequest Data From Local DataBase (Core Data) => LocalSavedData Table
                            
                            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "LocalSavedData")
                            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
                            
                            do {
                                try PersistenceService.managedObjectContext.execute(deleteRequest)
                                try PersistenceService.managedObjectContext.save()
                                self.allModelArray.removeAll()
                                self.unSavedTableViewDataArray.removeAll()
                                self.failedTableViewDataArray.removeAll()
                                self.operationsModelArray.removeAll()
                                self.deficencyCorrectiveModelArray.removeAll()
                                self.allLinesModel()

                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                                    self.syncRecordsCount = ""
                                    self.updateNavigationHeader()
                                    self.appDelegate.window?.makeToast("Sync Success full...", duration:kToastDuration, position:CSToastPositionCenter)

                                })
                            } catch {
                                print ("There was an error")
                            }
                            
                            
                            
                        }
                        k = k + 1
                    }
                    
                }else{
                     self.syncRecordsCount = ""
                     updateNavigationHeader()
                    self.allModelArray.removeAll()
                    self.unSavedTableViewDataArray.removeAll()
                    self.failedTableViewDataArray.removeAll()
                    self.operationsModelArray.removeAll()
                    self.deficencyCorrectiveModelArray.removeAll()
                    self.allLinesModel()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                        self.appDelegate.window?.makeToast("Sync Success full...", duration:kToastDuration, position:CSToastPositionCenter)
                    })
                  
                    
                }
            } catch let error as NSError {
                //  print("Could not fetch \(error)”)
            }
            
        }else{
            self.appDelegate.window?.makeToast("Please check your internet Connection...", duration:kToastDuration, position:CSToastPositionCenter)
            
        }
        inSpectionProTableView.reloadData()
        let poppedVC = navigationController?.popViewController(animated: true)
        print(poppedVC as Any)
    }
    func dissmisLogOutView(){
    
        Utilities.setupHomeViewControllerNavBarColorInCntrWithColor(backImage: "AppIcon", cntr:self, titleView: nil, withText: "", backTitle: " InSpectionPro", rightImage: appVersion,syncTotalRecodCount: syncRecordsCount, secondRightImage: "sync", thirdRightImage: "logout-1")
        
    }
    @IBAction func logOutButtonTapped(_ sender:UIButton) {
        
        print("LogOut Button Clicked............")
        Utilities.setupHomeViewControllerNavBarColorInCntrWithColor(backImage: "AppIcon", cntr:self, titleView: nil, withText: "", backTitle: " InSpectionPro", rightImage: appVersion,syncTotalRecodCount: syncRecordsCount, secondRightImage: "sync", thirdRightImage: "logout-1")
     //   navigationItem.leftBarButtonItems = []
        let reOrderPopOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LogOutViewController") as! LogOutViewController
                reOrderPopOverVC.delegate = self
                self.addChildViewController(reOrderPopOverVC)
                
                reOrderPopOverVC.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
                self.view.addSubview(reOrderPopOverVC.view)
                reOrderPopOverVC.didMove(toParentViewController: self)
            }

    
    @IBAction func allButtonTapped(_ sender: UIButton) {
           selectedButtonTitle = "All"
        
       // self.allTableViewDataArray = self.allModelArray

        if !allModelArray.isEmpty {
            self.noRecordsFound.isHidden = true
        }else{
            self.noRecordsFound.isHidden = false

        }
        print("allButtonTapped......")

        inSpectionProTableView.reloadData()

    }
    

    
    @IBAction func unSavedButtonTapped(_ sender: UIButton) {
       selectedButtonTitle = "Unsaved"
        //unSavedLinesCount()
        if !unSavedTableViewDataArray.isEmpty {
            self.noRecordsFound.isHidden = true
        }else{
            self.noRecordsFound.isHidden = false
            
        }
        print("unSavedButtonTapped......")
        inSpectionProTableView.reloadData()
        inSpectionProTableView.setContentOffset(CGPoint(x:0,y:0), animated: true)

    }
    func unSavedLinesCount(){
        
        for j in allModelArray{
            if (allModelArray.count > 0){
                if(j.type == "1"){
                    unSavedTableViewDataArray.append(j)
                }
                print("Unseved Empty Data......................")
            }
            if(unSavedTableViewDataArray.count == 0){
                unsaved = "0"
            }else{
                unsaved = String(unSavedTableViewDataArray.count)
            }
            inSpectionProTableView.reloadData()
        }
    }
    
    @IBAction func failedButtonTapped(_ sender: UIButton) {
   
       selectedButtonTitle = "Failed"
        if !failedTableViewDataArray.isEmpty {
            self.noRecordsFound.isHidden = true
        }else{
            self.noRecordsFound.isHidden = false
            
        }
          inSpectionProTableView.reloadData()

        failedLinesCount()
        print("failedButtonTapped......")

    }
    func failedLinesCount(){

      
    }
    
    func addDeficiencyCount(_ model : AllModel){
        
        //syncOnLocalData()
        
        if(clickedRow >= 0){
             //allModelArray[clickedRow] = model
            if(!failedTableViewDataArray.contains(model)){
                failedTableViewDataArray.append(model)
                failed = "\(failedTableViewDataArray.count)"
            }
            
            var j = 0
            for eachModel in unSavedTableViewDataArray{
                if(eachModel.lineId == model.lineId){
                    unSavedTableViewDataArray.remove(at: j)
                    if(unSavedTableViewDataArray.count == 0){
                        unsaved = "0"
                    }else{
                        unsaved = String(unSavedTableViewDataArray.count)
                    }
                }
                j = j + 1
            }
            
            let fetchRequest:NSFetchRequest<Lines> = NSFetchRequest.init(entityName: "Lines")
            
            let predicate = NSPredicate(format: "lineId = '\(model.lineId)'")
            fetchRequest.predicate = predicate
            do
            {
                let test = try PersistenceService.managedObjectContext.fetch(fetchRequest)
                if test.count > 0
                {
                    let objectUpdate = test[0] as! NSManagedObject
                    objectUpdate.setValue(false, forKey: "isUnsaved")
                     objectUpdate.setValue(true, forKey: "isFailed")
                     objectUpdate.setValue(false, forKey: "status")
                    do{
                        try PersistenceService.managedObjectContext.save()
                    }
                    catch
                    {
                        print(error)
                    }
                }
            } catch
            {
                print(error)
            }
        }
        
        
         inSpectionProTableView.reloadData()
    }
    
    func personOperationCount(_ model0 : String){

    //    personString = model0
        
        
    }
    
    func commentsCount(_ model1 : String){
        
      //  commentsString = model1
        
        
    }
    func unitIdCount(_ model2 : String){
        
      //  unitIdStringOfAPI = model2
        
        
    }
    func correctionCount(_ model3 : String){
        
      //  correctionString = model3
        
        
    }
    func deficiencyCount(_ model4 : String){
        
      //  deficiencyString = model4
        
        
    }
  
    
    
    func  failedAddCount (_ btn : Int){
        
    }

    func showAlertViewWithTitle(_ title:String,message:String,buttonTitle:String)
    {
        let alertView:UIAlertView = UIAlertView();
        alertView.title=title
        alertView.message=message
        alertView.addButton(withTitle: buttonTitle)
        alertView.show()
    }
    // MARK :- Convert DateString Format
    func returnEventDateWithoutTim1(selectedDateString : String) -> String{
        var newDateStr = ""
        var newDateStr1 = ""
        if(selectedDateString != ""){
            let invDtArray = selectedDateString.components(separatedBy: "T")
            let dateString = invDtArray[0]
            let dateString1 = invDtArray[1]
            print(dateString1)
            let invDtArray2 = dateString1.components(separatedBy: ".")
            var dateString3 = invDtArray2[0]
            print(dateString1)
            if(dateString != "" || dateString != "."){
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = dateFormatter.date(from: dateString)
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr = newDateString
                print(newDateStr)
            }
            if(dateString3 != "" || dateString != "."){
                dateString3 = dateString3.components(separatedBy: "-")[0]
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .medium
                dateFormatter.dateFormat = "HH:mm:ss"
                let dateFromString = dateFormatter.date(from: dateString3)
                dateFormatter.dateFormat = "hh:mm aa"
                let newDateString = dateFormatter.string(from: dateFromString!)
                newDateStr1 = newDateString
                print(newDateStr1)
            }
        }
        return newDateStr + "," + newDateStr1
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//MARK: - UIViewController Extesions

extension UIViewController {
    func showHudView(_ message: String) {
        SVProgressHUD.show(withStatus: message)
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setBackgroundColor(UIColor.lightGray)
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func hideHUDView() {
        SVProgressHUD.dismiss()
        UIApplication.shared.endIgnoringInteractionEvents()
        
    }
}
