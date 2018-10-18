//
//  IllnessesTableViewController.swift
//  Essential Oils Guide
//
//  Created by Adam Ure on 9/29/18.
//  Copyright © 2018 App Development with Swift. All rights reserved.
//

import UIKit

class IllnessesTableViewController: UITableViewController, UISearchBarDelegate {

    var oilBlends: [oilBlend]?
    var singleOils: [singleOil]?
    var illnesses: [illness]?
    var searchedIllnesses: [illness] = []
    @IBOutlet weak var searchBar: UISearchBar!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        oilBlends = oilBlend.loadOriginalData()
        singleOils = singleOil.loadOriginalData()
        illnesses = illness.loadOriginalData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        illnesses = illness.loadOriginalData()
        searchBar.showsCancelButton = true;
        searchedIllnesses = []
        for illness in illnesses! {
            if (illness.name.lowercased().contains(searchText.lowercased())){
                tryToAddIllness(illness: illness)
            } else if (illness.description != nil) {
                if (illness.description!.lowercased().contains(searchText.lowercased())) {
                    tryToAddIllness(illness: illness)
                }
            } else if (illness.suggestedSingleOils != nil){
                for singleName in illness.suggestedSingleOils! {
                    let singleOil = getMatchingSingleOil(name: singleName)
                    if (singleOil != nil){
                        if (singleOil!.name.lowercased().contains(searchText.lowercased())){
                            tryToAddIllness(illness: illness)
                        } else if (singleOil!.uses != nil){
                            if (singleOil!.uses!.lowercased().contains(searchText.lowercased())){
                                tryToAddIllness(illness: illness)
                            }
                        } else if (singleOil!.medicalProperties != nil){
                            if (singleOil!.medicalProperties!.lowercased().contains(searchText.lowercased())){
                                tryToAddIllness(illness: illness)
                            }
                        } else if (singleOil!.fragrantInfluence != nil){
                            if (singleOil!.fragrantInfluence!.lowercased().contains(searchText.lowercased())){
                                tryToAddIllness(illness: illness)
                            }
                        }
                    }
                }
            } else if (illness.suggestedOilBlends != nil){
                for blendName in illness.suggestedOilBlends! {
                    let oilBlend = getMatchingOilBlend(name: blendName)
                    if (oilBlend!.name.lowercased().contains(searchText.lowercased())){
                        tryToAddIllness(illness: illness)
                    } else if (oilBlend!.use.lowercased().contains(searchText.lowercased())){
                        tryToAddIllness(illness: illness)
                    } else {
                        for singleName in oilBlend!.ingredients {
                            let singleOil = getMatchingSingleOil(name: singleName)
                            if (singleOil != nil){
                                if (singleOil!.name.lowercased().contains(searchText.lowercased())){
                                    tryToAddIllness(illness: illness)
                                } else if (singleOil!.uses != nil){
                                    if (singleOil!.uses!.lowercased().contains(searchText.lowercased())){
                                        tryToAddIllness(illness: illness)
                                    }
                                } else if (singleOil!.medicalProperties != nil){
                                    if (singleOil!.medicalProperties!.lowercased().contains(searchText.lowercased())){
                                        tryToAddIllness(illness: illness)
                                    }
                                } else if (singleOil!.fragrantInfluence != nil){
                                    if (singleOil!.fragrantInfluence!.lowercased().contains(searchText.lowercased())){
                                        tryToAddIllness(illness: illness)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        illnesses = searchedIllnesses
        
        if (searchText == ""){
            illnesses = illness.loadOriginalData()
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = true;
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = true;
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return illnesses!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "illnessCell", for: indexPath) as! IllnessTableViewCell
        cell.updateIllness(illness: illnesses![indexPath.row])
        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    
    func getMatchingSingleOil(name: String) -> singleOil? {
        var newSingleOil: singleOil?
        for single in singleOils! {
            if single.name == name {
                newSingleOil = single
            }
        }
        return newSingleOil
    }
    
    func getMatchingOilBlend(name: String) -> oilBlend? {
        var newOilBlend: oilBlend?
        for blend in oilBlends! {
            if blend.name == name {
                newOilBlend = blend
            }
        }
        return newOilBlend
    }

    func tryToAddIllness(illness: illness){
        var canAdd = true
        for searchedIllness in searchedIllnesses {
            if (searchedIllness.name.lowercased() != illness.name.lowercased()){
                canAdd = true
            } else {
                canAdd = false
            }
        }
        if canAdd {
            searchedIllnesses.append(illness)
        }
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.showsCancelButton = true;
        self.view.endEditing(true)
    }
    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
