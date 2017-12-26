//
//  ViewController.swift
//  iOS8.0之前的UIPopoverController
//
//  Created by huangbiyong on 2017/12/26.
//  Copyright © 2017年 com.chase. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    var currentPopover: UIPopoverController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func openOrClose(_ sender: UISwitch) {
        
        if sender.isOn {
            
            // 1. 创建 UIViewController, 添加imageview
            let contentVC = UIViewController()
            let imageView = UIImageView(image: UIImage(named: "colorWheel"))
            imageView.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(pixColor(gester:)))
            imageView.addGestureRecognizer(tap)
            
            contentVC.view.addSubview(imageView)
            
            // 2. 创建pop
            let popover = UIPopoverController(contentViewController: contentVC)
            
            // 2.1 调整内容显示大小
            popover.contentSize = imageView.frame.size
            // 2.2 设置过滤试图 （代表哪些试图依然可以与用户交互）
            popover.passthroughViews = [sender, self.view]
            // 2.3 设置背景色 （可以消除点击状态箭头默认的颜色）
            popover.backgroundColor = UIColor.white
            
            currentPopover = popover
            
            // 3. 弹出
            // 参数1: 位置
            // 参数2: 相对于谁的位置
            popover.present(from: sender.frame, in: self.view, permittedArrowDirections: .any, animated: true)
            
        } else {
            currentPopover?.dismiss(animated: true)
        }
        
    }
    

    
    @objc func pixColor(gester: UITapGestureRecognizer) {
        let point = gester.location(in: gester.view)
        
        let imageView = gester.view as? UIImageView
        
        guard let image = imageView?.image else {
            return
        }
        
        let color = image.pixelColor(atLocation: point)
        
        view.backgroundColor = color
        
    }
    
}




























