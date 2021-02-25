//
//  ChooseLanguageVC.swift
//  Spotslot
//
//  Created by mac on 18/08/20.
//  Copyright © 2020 Infograins. All rights reserved.
//

import UIKit

class ChooseLanguageVC: UIViewController {

    //View
    @IBOutlet weak var viewContinue: UIView!
    @IBOutlet weak var viewUK: UIView!
    @IBOutlet weak var viewUS: UIView!
    @IBOutlet weak var viewSpanish: UIView!
    @IBOutlet weak var viewFrench: UIView!
   
    //Button
    @IBOutlet weak var btnEngUK: UIButton!
    @IBOutlet weak var btnEngUS: UIButton!
    @IBOutlet weak var btnFrench: UIButton!
    @IBOutlet weak var btnSpanish: UIButton!
    
    @IBOutlet weak var lblUK: UILabel!
    @IBOutlet weak var lblUS: UILabel!
    @IBOutlet weak var lblSpanish: UILabel!
    @IBOutlet weak var lblFrench: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialConfig()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnContinue(_ sender: Any) {
          pushToLogin()
    }
    
    @IBAction func gotoLogin(_ sender: Any) {
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
//        self.present(vc, animated: true, completion: nil)
    }
    
}


//MARK:- IBAction

extension ChooseLanguageVC{
    
    @IBAction func btnEngUK(_ sender: Any) {
        viewUK.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        viewUS.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        viewFrench.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        viewSpanish.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        lblUK.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        lblUS.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblSpanish.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblFrench.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    @IBAction func btnEngUS(_ sender: Any) {
        viewUK.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        viewUS.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        viewFrench.backgroundColor =  #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        viewSpanish.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        lblUK.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblUS.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        lblSpanish.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblFrench.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    @IBAction func btnFrench(_ sender: Any){
        viewUK.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        viewUS.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        viewFrench.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        viewSpanish.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        lblUK.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblUS.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblSpanish.textColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblFrench.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
    }
    @IBAction func btnSpanish(_ sender: Any) {
        viewUS.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        viewUK.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        viewFrench.backgroundColor = #colorLiteral(red: 0.1333333333, green: 0.1568627451, blue: 0.1647058824, alpha: 1)
        viewSpanish.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        lblUK.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblUS.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lblSpanish.textColor = #colorLiteral(red: 0.137254902, green: 0.137254902, blue: 0.137254902, alpha: 1)
        lblFrench.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }
    
    
}
//MARK:- Custom function here
extension ChooseLanguageVC{
    func initialConfig(){
        viewUK.layer.cornerRadius = 10
        viewUS.layer.cornerRadius = 10
        viewSpanish.layer.cornerRadius = 10
        viewFrench.layer.cornerRadius = 10
        viewContinue.layer.cornerRadius = 10
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        viewContinue.addGradientBG()
    }
    
    func pushToLogin()  {
        let vc = UIStoryboard(name: "Intro", bundle: nil).instantiateViewController(withIdentifier: "IntroVC") as! IntroVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
