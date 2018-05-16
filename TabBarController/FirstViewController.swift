//
//  FirstViewController.swift
//  TabBarController
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit
import Alamofire

extension String{
    func hyLength() -> Int {
        return self.count
    }
}
class FirstViewController: UIViewController,backValueDelegate,UITableViewDelegate,UITableViewDataSource {
    var dataSource:Array<Dictionary<String, Any>>?
    
    var btn:UIButton?
    var labl1:UILabel?
    var labl2:UILabel?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        let dic = dataSource![indexPath.row]
        for (key,value) in dic {
            if key == "name"{
               cell.textLabel?.text = value as? String
            }
        }
        
        return cell
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray;
        
//        nativeNetRequestData();
        thirdNetRequestData()
        
    }
    func creatTableView() {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
    }
    func thirdNetRequestData(){
        
        Alamofire.request("http://mulanapi.caihang.com/s1/house_fund/get_all_citys").response { (response) in
//            let utf8Text = String(data: response.data!, encoding: .utf8)
            
            let data = try? JSONSerialization.jsonObject(with: (response.data)!, options: JSONSerialization.ReadingOptions.allowFragments)
            let datas = data as? Dictionary<String, Any>
            
            self.dataSource = data as? Array<Dictionary<String, Any>>
            for (key,value)in datas! {
                if key == "data"{
                    for (_,value2)in (value as? Dictionary<String, Any>)! {
                        self.dataSource =  value2 as? Array
                    }
                }
            }
            self.creatTableView()
        }
    }
    func nativeNetRequestData() {
        
        //http://mulanapi.caihang.com/s1/
        //http://leavesmulantest.caihang.com/zima_web_app/s1
        var request = URLRequest.init(url: URL.init(string: "http://mulanapi.caihang.com/s1/house_fund/get_all_citys")!, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60)
        request.httpMethod = "POST"
        
//        let dic = ["":""]
//        request.httpBody = "".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        //NSKeyedArchiver.archivedData(withRootObject: dic)

        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if data != nil{
                let responsobject = try?JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                print(responsobject)
            }
            
        }
        session.resume()

    }
    func creatUI() {
        NotificationCenter.default.addObserver(self, selector: #selector(backchangevalue(noti:)), name: NSNotification.Name(rawValue: "changevalue"), object: nil)
        
        
        btn = UIButton.init(type: UIButtonType.custom)
        btn?.frame = CGRect.init(origin: CGPoint.init(x: 10.0, y: 100.0), size: CGSize.init(width: 100, height: 30))
        btn?.setTitle("btn", for: .normal)
        self.view.addSubview(btn!)
        btn?.addTarget(self, action:#selector(click), for: UIControlEvents.touchUpInside)
        
        labl1 = UILabel.init(frame: .init(x: 40, y: 150, width: 150, height: 20))
        self.view.addSubview(labl1!)
        
        labl2 = UILabel.init(frame: .init(x: 40, y: 190, width: 150, height: 20))
        self.view.addSubview(labl2!)
    }
    
    @objc func backchangevalue(noti:NSNotification){
        self.labl2?.text = noti.object as? String
        print(noti.object as? String ?? "")
    }
    
    @objc func click() {
        let detailvc = FirstDetailViewConroller()
        detailvc.block = {
            print($0)
            self.btn?.setTitle($0, for: .normal)
        }
        detailvc.vcdelegate = self;
            self.navigationController?.pushViewController(detailvc, animated: true)
    }
    
    func changeValue(value: String) {
        self.labl1?.text = value
    }
}
