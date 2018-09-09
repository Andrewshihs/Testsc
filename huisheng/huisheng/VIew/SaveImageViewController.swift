//
//  SaveImageViewController.swift
//  huisheng
//
//  Created by Andrew on 2018/8/30.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import UIKit

class SaveImageViewController: fatherViewController {
    
    var text1 = "iPhone X-1.png"
    @IBOutlet weak var HuiShengImage: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var OverSaveButton: UIButton!
    @IBOutlet weak var ShareButton: UIButton!
    @IBOutlet weak var SaveButton: UIButton!
    var TestView: UIImageView!
    @IBAction func Share(_ sender: UIButton) {
        // 测试分享
        
        
    }
    @IBAction func SaveButton(_ sender: UIButton) {
        backButton.isHidden = true
        SaveButton.isHidden = true
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
