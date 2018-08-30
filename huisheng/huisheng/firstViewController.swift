//
//  firstViewController.swift
//  huisheng
//
//  Created by Andrew on 2018/8/29.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import UIKit

class firstViewController: UIViewController {

    @IBOutlet weak var HuiTu: UIImageView!
    @IBOutlet weak var GGCamera: UIButton!
    @IBAction func VoiceButton(_ sender: UIButton) {
        GGCamera.isHidden = true
    }
    @IBAction func OverButton(_ sender: UIButton) {
        GGCamera.isHidden = false
        HuiTu.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        HuiTu.isHidden = true
                // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
