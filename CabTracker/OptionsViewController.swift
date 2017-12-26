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
    @IBAction func switchToggled(_ sender: Any) {
        CabManager.shared.updateCabTrackingEnabled(cabName: cabName.text!, isTracked: cabSelected.isOn)
    }
    
}
class OptionsViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CabCell", for: indexPath) as! OptionsCell
        let row = indexPath.row
        let cabs = CabManager.shared.getCabs()
        let cabsArray = Array(cabs.values)
        var text = ""
        var currentCab: CabModel? = nil
        if(cabsArray.count > row){
            currentCab = cabsArray[row]
            text = currentCab!.name
            cell.cabSelected.isOn = currentCab!.trackingEnabled
        }
        cell.cabName.text = text
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cabs to Track"
    }
}

