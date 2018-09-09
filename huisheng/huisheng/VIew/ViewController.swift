//
//  ViewController.swift
//  huisheng
//
//  Created by Andrew on 2018/8/29.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import UIKit

class ViewController: fatherViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var flag = 0;
    var timer :Timer!
    let recoder_manager = RecordManager()
    
    @IBOutlet weak var CameraImage: UIImageView!  //搞怪相机
    @IBOutlet weak var takePictureButton: UIButton! //从相机处获取
    var imagePicker: UIImagePickerController!
    @IBAction func Voicefinsh(_ sender: UIButton) { //绘图完成Button
        recoder_manager.stopRecord()
        print("结束录音")
        fatherViewController.TempImage = CameraImage.image!
    }
    
    @IBAction func Album(_ sender: UIButton) {
        if self.imagePicker == nil {
            self.imagePicker = UIImagePickerController()
        }
        self.imagePicker.delegate = self
        self.imagePicker.allowsEditing = true
        self.imagePicker.sourceType = .photoLibrary
        self.present(self.imagePicker,animated: true,completion:nil)
        flag=1
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
            flag = 1
        }else{
            let controller = UIAlertController(title:"系统错误",message:"\n相机无法启动",preferredStyle: .alert)
            let OKAction = UIAlertAction(title:"我知道了", style: .default,handler: nil)
            controller.addAction(OKAction)
            self.present(controller,animated: true,completion: nil)//警告视窗
        }
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        flag = 0
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(flag == 1){
            recoder_manager.beginRecord()
            let queue = DispatchQueue.global(qos: .default)
            queue.async {
                self.timer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:Selector("recoder_manager.audioPowerChange()"), userInfo: nil, repeats: true)
                print("监听开始")
               // self.recoder_manager.audioPowerChange()
            }
          //  self.timer = Timer.scheduledTimer(timeInterval: 0.1, target:self, selector:Selector("recoder_manager.audioPowerChange()"), userInfo: nil, repeats: true)
        
        }
           // timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(recoder_manager.audioPowerChange), userInfo: nil, repeats: true)
        
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
        flag = 0
    }

    

}

