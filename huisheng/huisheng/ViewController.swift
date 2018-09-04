//
//  ViewController.swift
//  huisheng
//
//  Created by Andrew on 2018/8/29.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import UIKit



class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var CameraImage: UIImageView!
    var imagePicker: UIImagePickerController!
    @IBOutlet weak var takePictureButton: UIButton!
    
    @IBAction func Album(_ sender: UIButton) {
        if self.imagePicker == nil {
            self.imagePicker = UIImagePickerController()
        }
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker,animated: true,completion:nil)
        

    }
    
    @IBAction func Camera(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            if self.imagePicker == nil{
                self.imagePicker = UIImagePickerController()
            }
            
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = true
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker,animated: true,completion: nil)
        }else{
            let controller = UIAlertController(title:"系统错误",message:"\n相机无法启动",preferredStyle: .alert)
            let OKAction = UIAlertAction(title:"我知道了", style: .default,handler: nil)
            controller.addAction(OKAction)
            self.present(controller,animated: true,completion: nil)
            //警告视窗
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
    }
   
    override func viewWillAppear(_ animated: Bool) {
    //    self.navigationController?.isNavigationBarHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
       
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        self.CameraImage.image = originalImage
        self.CameraImage.contentMode = .scaleAspectFill
        self.imagePicker.delegate = nil
        self.dismiss(animated: true,completion: nil)
        CameraImage.isHidden = false
    }

    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.imagePicker.delegate=nil
        self.dismiss(animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

