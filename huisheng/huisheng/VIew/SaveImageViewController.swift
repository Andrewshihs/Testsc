//
//  SaveImageViewController.swift
//  huisheng
//
//  Created by Andrew on 2018/8/30.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import UIKit

class SaveImageViewController: fatherViewController {
    
    @IBOutlet weak var saveT: UIImageView!
    @IBOutlet weak var saveW: UILabel!
    @IBOutlet weak var HuiShengImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var OverSaveButton: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    var TestView: UIImageView!
    @IBAction func Share(_ sender: UIButton) {
        // 测试分享
     //   let activityItems = ["绘声",HuiShengImage.image!] as [Any]
        let textShare = "绘声"
        let imageShare = HuiShengImage.image
        let activityItems = [textShare,imageShare] as [Any]
       // UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        let toVC = UIActivityViewController(activityItems: activityItems, applicationActivities:[CustomUIActicity()])
        present(toVC, animated: true, completion: nil)
        toVC.completionWithItemsHandler = {(_ activityType: UIActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ activityError: Error?) -> Void in
            print(completed ? "成功" : "失败")
        }
        
    }
    @IBAction func SaveButton(_ sender: UIButton) {
        backButton.isHidden = true
        SaveButton.isHidden = true
        UIImageWriteToSavedPhotosAlbum(HuiShengImage.image!, nil, nil, nil)
        OverSaveButton.isHidden = false
        ShareButton.isHidden = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        HuiShengImage.image = fatherViewController.TempImage
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        backButton.isHidden = false
        SaveButton.isHidden = false
        OverSaveButton.isHidden = true
        ShareButton.isHidden = true
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
class CustomUIActicity: UIActivity {
    override var activityTitle: String? {
        return "绘声"
    }
    override var activityImage: UIImage? {
        return UIImage.init(named: "logo.png")
    }
    override class var activityCategory: UIActivityCategory {
        return .share
    }
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return false
    }
    
}
