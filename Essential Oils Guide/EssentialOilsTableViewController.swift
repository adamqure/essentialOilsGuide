//
//  EssentialOilsTableViewController.swift
//  Essential Oils Guide
//
//  Created by Adam Ure on 8/27/18.
//  Copyright © 2018 App Development with Swift. All rights reserved.
//

import UIKit

class EssentialOilsTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    var singleOils: [singleOil]?
    var oilBlends: [oilBlend]?
    var personalBlends: [oilBlend]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        singleOils = singleOil.loadOriginalData()
        oilBlends = oilBlend.loadOriginalData()
        personalBlends = []
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        singleOils = singleOil.loadOriginalData()
        oilBlends = oilBlend.loadOriginalData()
        var singles: [singleOil] = []
        var blends: [oilBlend] = []
        searchBar.showsCancelButton = true;
        
        for single in singleOils! {
            if (single.name.lowercased().contains(searchText.lowercased())){
                singles.append(single)
            } else if (single.uses != nil){
                if (single.uses!.lowercased().contains(searchText.lowercased())){
                    singles.append(single)
                }
            } else if (single.application != nil){
                if (single.application!.lowercased().contains(searchText.lowercased())){
                    singles.append(single)
                }
            } else if (single.medicalProperties != nil){
                if (single.medicalProperties!.lowercased().contains(searchText.lowercased())){
                    singles.append(single)
                }
            } else if (single.fragrantInfluence != nil){
                if (single.fragrantInfluence!.lowercased().contains(searchText.lowercased())){
                    singles.append(single)
                }
            }
        }
        for blend in oilBlends! {
            if (blend.name.lowercased().contains(searchText.lowercased())){
                blends.append(blend)
            } else {
                for singleName in blend.ingredients {
                    let single = getMatchingSingleOil(name: singleName)
                    if (single != nil){
                        if (single!.name.lowercased().contains(searchText.lowercased())){
                            blends.append(blend)
                        } else if (single!.uses != nil){
                            if (single!.uses!.lowercased().contains(searchText.lowercased())){
                                blends.append(blend)
                            }
                        } else if (single!.application != nil){
                            if (single!.application!.lowercased().contains(searchText.lowercased())){
                                blends.append(blend)
                            }
                        } else if (single!.medicalProperties != nil){
                            if (single!.medicalProperties!.lowercased().contains(searchText.lowercased())){
                                blends.append(blend)
                            }
                        } else if (single!.fragrantInfluence != nil){
                            if (single!.fragrantInfluence!.lowercased().contains(searchText.lowercased())){
                                blends.append(blend)
                            }
                        }
                    }
                }
            }
        }
        
        singleOils = singles
        oilBlends = blends
        
        if (searchText == ""){
            singleOils = singleOil.loadOriginalData()
            oilBlends = oilBlend.loadOriginalData()
        }
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        singleOils = singleOil.loadOriginalData()
        oilBlends = oilBlend.loadOriginalData()
        self.view.endEditing(true)
        searchBar.showsCancelButton = false;
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        singleOils = singleOil.loadOriginalData()
        oilBlends = oilBlend.loadOriginalData()
        searchBar.showsCancelButton = false;
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            return singleOils!.count
        } else if section == 1 {
            return oilBlends!.count
        } else if section == 2 {
            return personalBlends!.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 0:
                return "Single Oils"
            case 1:
                return "Oil Blends"
            default:
                return "Client Blends"
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "oilCell", for: indexPath) as! EssentialOilsTableViewCell
        
        // Configure the cell...
        if indexPath.section == 0 {
            let oil = singleOils![indexPath.row]
            cell.update(with: oil)
            cell.showsReorderControl = false
        } else if indexPath.section == 1 {
            let oilBlend = oilBlends![indexPath.row]
            cell.update(with: oilBlend)
            cell.showsReorderControl = false
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let singleOil = singleOils![indexPath.row]
            print(singleOil.name)
        } else if indexPath.section == 1 {
            let oilBlend = oilBlends![indexPath.row]
            print(oilBlend.name)
        } else {
            print("None")
        }
    }

    @IBAction func editButtonTapped(_ sender: UIBarButtonItem) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        if fromIndexPath.section == 0 {
            let movedOil = singleOils!.remove(at: fromIndexPath.row)
            singleOils!.insert(movedOil, at: to.row)
        } else if fromIndexPath.section == 1 {
            let movedOil = oilBlends!.remove(at: fromIndexPath.row)
            oilBlends!.insert(movedOil, at: to.row)
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0 {
                singleOils!.remove(at: indexPath.row)
            } else if indexPath.section == 1 {
                oilBlends!.remove(at: indexPath.row)
            }
            tableView.deleteRows(at: [indexPath], with: . automatic)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editOil"){
            let addEditOilViewController = segue.destination as! AddEditOilViewController
            addEditOilViewController.segueIdentifier = segue.identifier
            let indexPath = tableView.indexPathForSelectedRow!
            if indexPath.section == 0 {
                addEditOilViewController.oilType = "single"
                let oil = singleOils![indexPath.row]
                addEditOilViewController.singleOilEntry = oil
            } else if indexPath.section == 1 {
                addEditOilViewController.oilType = "blend"
                let oil = oilBlends![indexPath.row]
                addEditOilViewController.oilBlendSelection = oil
            }
        }
        
    }
    
    override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = true;
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
}
