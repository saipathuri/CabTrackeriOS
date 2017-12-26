//
//  OptionsViewController.swift
//  CabTracker
//
//  Created by Sai Pathuri on 12/23/17.
//  Copyright © 2017 Sai Pathuri. All rights reserved.
//

import UIKit

class OptionsCell: UITableViewCell{
    @IBOutlet weak var cabName: UILabel!
    @IBOutlet weak var cabSelected: UISwitch!
    
    // when switch is toggled, update the manager of tracking status
    // and store the information to UserDefults
    @IBAction func switchToggled(_ sender: Any) {
        CabManager.shared.updateCabTrackingEnabled(cabName: cabName.text!, isTracked: cabSelected.isOn)
        if(!cabName.text!.isEmpty){
            UserDefaults.standard.set(cabSelected.isOn, forKey: cabName.text!)
        }
    }
    
}
class OptionsViewController: UITableViewController {
    @IBOutlet var cabsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cabsTableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CabManager.shared.getCabs().count
    }
    
    // create an OptionsCell and fill the cab name and tracking status
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionsCell", for: indexPath) as! OptionsCell
        let row = indexPath.row
        let cabs = CabManager.shared.getCabs()
        let cabsArray = Array(cabs.values)
        var text = ""
        var currentCab: CabModel? = nil
        if(cabsArray.count > row){
            currentCab = cabsArray[row]
            text = currentCab!.name
            cell.cabSelected.isOn = CabManager.shared.getTrackingStatusFromDefaults(cab: currentCab!)
        }
        cell.cabName.text = text
        
        
        return cell
    }

    // title for section
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cabs to Track"
    }
}

