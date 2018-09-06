//
//  SaveImageViewController.swift
//  huisheng
//
//  Created by Andrew on 2018/8/30.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import UIKit

class SaveImageViewController: UIViewController {
    
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
        HuiShengImage.image = UIImage(named: "\(text1)")
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
