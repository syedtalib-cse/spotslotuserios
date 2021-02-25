//
//  PartnerWithSpotslotVC.swift
//  Spotslot
//
//  Created by mac on 20/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class PartnerWithSpotslotVC: UIViewController {

    @IBOutlet weak var tlvContentList: UITableView!
    
    @IBOutlet weak var viewBG: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        intialConfig()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

//MARK:- Custom function here
extension PartnerWithSpotslotVC{
    func intialConfig() {
        tlvContentList.register(UINib(nibName: "PartnerWithSpotslotCell", bundle: nil), forCellReuseIdentifier: "PartnerWithSpotslotCell")
        DispatchQueue.main.async {
            self.viewBG.roundedTop(width: 16, height: 16)
        }
        
    }
    func getTextOFArray() -> [String] {
        var arrStr = [String]()
        arrStr = ["Potentially earn more than you would in a salon/shop","No more chair rent!","Be completely flexible - set your own working hours and availability","Choose areas you want to work in","Benefit from cancellation fees","Build your credability and get shortlisted for international, celebrity and Film/TV work","Get help and advice on how to be completely competent with working and providing a mobile service"]
        return arrStr
    }
}

//MARK:- TableView Delegate and dataSource
extension PartnerWithSpotslotVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getTextOFArray().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tlvContentList.dequeueReusableCell(withIdentifier: "PartnerWithSpotslotCell", for: indexPath) as! PartnerWithSpotslotCell
        let arrStr = self.getTextOFArray()
        cell.content = arrStr[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
}
