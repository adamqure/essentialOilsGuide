//
//  AddEditOilViewController.swift
//  Essential Oils Guide
//
//  Created by Adam Ure on 8/30/18.
//  Copyright © 2018 App Development with Swift. All rights reserved.
//

import UIKit

class AddEditOilViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var singleOilEntry: singleOil? = nil
    var oilBlendSelection: oilBlend? = nil
    var segueIdentifier: String? = nil
    var oilType: String? = nil
    var singleOils: [singleOil]? = nil
    
    @IBOutlet weak var oilImage: UIImageView!
    @IBOutlet weak var usesStackView: UIStackView!
    @IBOutlet weak var warningStackView: UIStackView!
    @IBOutlet weak var medicalPropertiesStackView: UIStackView!
    @IBOutlet weak var fragrantInfluenceStackView: UIStackView!
    @IBOutlet weak var applicationStackView: UIStackView!
    @IBOutlet weak var historicalDataStackView: UIStackView!
    @IBOutlet weak var ingredientsStackView: UIStackView!
    @IBOutlet weak var usesLabel: UILabel!
    @IBOutlet weak var warningsLabel: UILabel!
    @IBOutlet weak var medicalPropertiesLabel: UILabel!
    @IBOutlet weak var fragrantInfluenceLabel: UILabel!
    @IBOutlet weak var applicationLabel: UILabel!
    @IBOutlet weak var historicalDataLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        singleOils = singleOil.loadOriginalData()
        oilImage.layer.borderWidth = 1
        oilImage.layer.cornerRadius = 60.0
        oilImage.layer.masksToBounds = true
        tableView.delegate = self
        tableView.dataSource = self
        
        //Setup Title
        //Create Table View
        if oilType! == "single" {
            self.title = singleOilEntry!.name
            if (UIImage(named: singleOilEntry!.name) != nil){
                oilImage.image = UIImage(named: singleOilEntry!.name)
            } else {
                oilImage.image = UIImage(named: "addImage")
            }
            setupSinglePage()
        } else {
            self.title = oilBlendSelection!.name
            if (UIImage(named: oilBlendSelection!.name) != nil){
                oilImage.image = UIImage(named: oilBlendSelection!.name)
            } else {
                oilImage.image = UIImage(named: "addImage")
            }
            setupBlendPage()
            
        }
        oilBlendSelection = oilBlend(name: "",use: "",ingredients: [""],warnings: "")
    }

    func setupSinglePage(){
        ingredientsStackView.isHidden = true
        
        if (singleOilEntry!.uses != nil){
            usesLabel.text = singleOilEntry!.uses
        } else {
            usesStackView.isHidden = true
        }
        
        if (singleOilEntry!.warning != nil){
           warningsLabel.text = singleOilEntry!.warning
        } else {
            warningStackView.isHidden = true
        }
        
        if (singleOilEntry!.medicalProperties != nil){
            medicalPropertiesLabel.text = singleOilEntry!.medicalProperties
        } else {
            medicalPropertiesStackView.isHidden = true
        }
        
        if (singleOilEntry!.fragrantInfluence != nil){
            fragrantInfluenceLabel.text = singleOilEntry!.fragrantInfluence
        } else {
            fragrantInfluenceStackView.isHidden = true
        }
        
        if (singleOilEntry!.application != nil){
            applicationLabel.text = singleOilEntry!.application
        } else {
            applicationStackView.isHidden = true
        }
        
        if (singleOilEntry!.historicalData != nil){
            historicalDataLabel.text = singleOilEntry!.historicalData
        } else {
            historicalDataStackView.isHidden = true
        }
    }
    
    func setupBlendPage(){
        medicalPropertiesStackView.isHidden = true
        fragrantInfluenceStackView.isHidden = true
        applicationStackView.isHidden = true
        historicalDataStackView.isHidden = true
        
        usesLabel.text = oilBlendSelection!.use
        if (oilBlendSelection!.warnings != nil){
            warningsLabel.text = oilBlendSelection!.warnings
        } else {
            warningStackView.isHidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oilBlendSelection!.ingredients.count // your number of cell here
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // your cell coding
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath as IndexPath) as! EssentialOilsTableViewCell
        
        // Configure the cell...
        let oilName = oilBlendSelection!.ingredients[indexPath.row]
        if let oil: singleOil = getMatchingOil(name: oilName) {
            cell.update(with: oil)
            cell.showsReorderControl = false
        }
        return cell
    }
    
    func getMatchingOil(name: String) -> singleOil? {
        var newSingleOil: singleOil?
        for single in singleOils! {
            if single.name == name {
                newSingleOil = single
            }
        }
        return newSingleOil
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // cell selected code here
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
