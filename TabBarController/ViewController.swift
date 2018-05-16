//
//  ViewController.swift
//  TabBarController
//
//  Created by apple on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fisrtnvc = FirstViewController()
        let secondvc = SecondViewController()
        
        self.viewControllers = [creatTabBar(viewController: fisrtnvc, title: "首页", imageName: "zm_tabbar_t10@3x", slectImageName: "zm_tabbar_t11@3x", ishidenNvc: true),creatTabBar(viewController: secondvc, title: "财富", imageName: "zm_tabbar_t20@3x", slectImageName: "zm_tabbar_t21@3x", ishidenNvc: true)]
        
    }
    
    func creatTabBar (viewController:UIViewController ,title:String, imageName:String,slectImageName:String,ishidenNvc:Bool)->UIViewController{
        
        let vc = viewController
        let nvc = UINavigationController.init(rootViewController: vc)
        var image = UIImage.init(named: imageName )
        image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        var selectImage = UIImage.init(named: slectImageName )
        selectImage = selectImage?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        vc.tabBarItem = UITabBarItem.init(title: "", image: image, selectedImage: selectImage)
        vc.tabBarItem.imageInsets = UIEdgeInsets.init(top: 5, left: 0, bottom: -5, right: 0)
        vc.navigationItem.title = title
        
        if(ishidenNvc){
            return nvc
        }
        return vc
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

