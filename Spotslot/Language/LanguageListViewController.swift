//
//  LanguageListViewController.swift
//  SplotslotVendor
//
//  Created by jaipee on 30/01/21.
//  Copyright © 2021 Infograins. All rights reserved.
//

import UIKit

class LanguageListViewController: UIViewController {

    @IBOutlet private weak var searchTextField: UITextField!
    @IBOutlet private weak var languageTableView: UITableView! {
        didSet {
            let nib = UINib(nibName: "LanguageTableViewCell", bundle: nil)
            languageTableView.register(nib, forCellReuseIdentifier: "LanguageTableViewCell")
            languageTableView.delegate = self
            languageTableView.dataSource = self
        }
    }
    @IBOutlet private weak var searchBackgroundView: UIView!
    @IBOutlet private weak var saveChangesBackgroundView: UIView!
    @IBOutlet private weak var container: UIView!
    private var languageList = [LanguageModel]()
    private var allLanguageList = [LanguageModel]()
    var languageAddCompletion: (()-> Void)?
    var profileSelectedLanguages: [LanguageModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
        // Do any additional setup after loading the view.
    }
    
    private func setupInitialUI() {
        DispatchQueue.main.async {
            self.container.roundedTop(width: 16, height: 16)
            self.searchBackgroundView.addTopBottomShadow(offset: CGSize(width: 0, height: 4), color: .lightGray, opacity: 0.2, shadowRadius: 2.0, cornerRadius: 0)
            self.saveChangesBackgroundView.addTopBottomShadow(offset: CGSize(width: 0, height: -4), color: .lightGray, opacity: 0.2, shadowRadius: 2.0, cornerRadius: 0)
        }
        searchTextField.addTarget(self, action: #selector(serarchLanguage(_:)), for: .editingChanged)
        webserviceTogetAllLanguages()
    }
    
    @objc func serarchLanguage(_ textField: UITextField) {
        if let languageText = textField.text, !languageText.isEmpty {
            let languages = allLanguageList.filter { (language) -> Bool in
                let languageMatch = language.languageName?.lowercased().range(of: languageText.lowercased())
                return languageMatch != nil ? true : false
            }
            languageList = languages
        }else {
            languageList = allLanguageList
        }
        
        DispatchQueue.main.async {
            self.languageTableView.reloadData()
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchAction(_ sender: Any) {
        self.searchTextField.becomeFirstResponder()
    }
    
    @IBAction func saveChangesAction(_ sender: Any) {
        let selectedLanguageIDs = allLanguageList.reduce([String]()) { (result, model) -> [String] in
            var _result = result
            if model.selected {
                _result.append(model.id ?? "")
            }
            
            return _result
        }.joined(separator: ",")
        
        guard !selectedLanguageIDs.isEmpty else {return}
        self.webServiceToAddLanguageWith(languageIds: selectedLanguageIDs)
    }
    
    private func setLanguageListData(_ list: [LanguageModel]) {
        
        allLanguageList = list
        
        //Profile base languages update in all Language list
        profileSelectedLanguages?.forEach({ (model) in
            var _model = model
            _model.selected = true
            updateSelectedLanguagesInStorage(_model)
        })
        
        languageList = allLanguageList
        
        DispatchQueue.main.async {
            self.languageTableView.reloadData()
        }
    }
    
    private func updateSelectedLanguagesInStorage(_ model: LanguageModel) {
        if allLanguageList.contains(model), let index = allLanguageList.firstIndex(of: model) {
            allLanguageList[index] = model
        }
    }
}

extension LanguageListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageTableViewCell") as! LanguageTableViewCell
        cell.cellConfiguration(languageList[indexPath.row])
        return cell
    }
}

extension LanguageListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        languageList[indexPath.row].selected = !languageList[indexPath.row].selected
        self.languageTableView.reloadRows(at: [indexPath], with: .automatic)
        updateSelectedLanguagesInStorage(languageList[indexPath.row])
    }
}


//MARK:- API Call

extension LanguageListViewController {
    func webserviceTogetAllLanguages(){
        //https://impetrosys.com/spot_slot/api/common/getLanguage
        UserDataModel.webserviceTogetAllLanguages(params: [:]) { [weak self] (response) in
            guard let self = self else {return}
            if response != nil{
                if response?.status == 200{
                    self.setLanguageListData(response?.data?.languageList ?? [])
                }else{
                    GlobalObj.showAlertVC(title: appName, message: response?.message ?? "", controller: self)
                }
            }
        }
    }
    
    //to add language to the profile
    func webServiceToAddLanguageWith(languageIds: String){
        var para = [String:Any]()
        para["language_id"] = languageIds
        UserDataModel.webServicesToAddlanguage(params:para) { [weak self] (response) in
            guard let self = self else {return}
            if response != nil{
                if response?.status == 200{
                    self.languageAddCompletion?()
                }else{
                    GlobalObj.showAlertVC(title: "Failler", message: response?.message ?? "", controller: self)
                }
            }
        }
    }
}
