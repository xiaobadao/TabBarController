//
//  FirstDetailViewConroller.swift
//  TabBarController
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

protocol backValueDelegate{
    func changeValue(value:String)
}

class FirstDetailViewConroller: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var btn: UIButton!
   
    typealias textBlock = (String)->()
    var block :textBlock?
    var vcdelegate:backValueDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray;
        
    }
    
    @IBAction func click(_ sender: UIButton) {
        
        if self.block != nil {
            self.block!(self.textField.text!)
        }
        
        self.vcdelegate?.changeValue(value: self.textField.text!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue:"changevalue"), object: self.textField.text)
        self.navigationController?.popViewController(animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

