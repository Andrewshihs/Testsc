//
//  ViewController.swift
//  huisheng
//
//  Created by Andrew on 2018/8/29.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: fatherViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
    var flag = 0;  //选取器标志
    var recorder:AVAudioRecorder? //录音器
    var player:AVAudioPlayer? //播放器
    var recorderSeetingsDic:[String : Any]? //录音器设置参数数组
    var volumeTimer:Timer! //定时器线程，循环监测录音的音量大小
    var aacPath:String? //录音存储路径
    var averageV: Float!
    
    @IBOutlet weak var VoiceFinsh: UIButton!   //到分享页
    @IBOutlet weak var CameraImage: UIImageView!  //搞怪相机图
    @IBOutlet weak var takePictureButton: UIButton! //从相机处获取
    var imagePicker: UIImagePickerController!
    @IBAction func Voicefinsh(_ sender: UIButton) { //绘图完成Button
        recorder?.stop()    //停止录音
        recorder = nil  //录音器释放
        volumeTimer.invalidate()  //暂停定时器
        volumeTimer = nil
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
        VoiceFinsh.isHidden = true
        let session:AVAudioSession = AVAudioSession.sharedInstance()    //初始化录音器
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)   //设置录音类型
        try! session.setActive(true)   //设置支持后台
        let docDir = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                         .userDomainMask, true)[0]//获取Document目录
        aacPath = docDir + "/play.aac"  //组合录音文件路径
        recorderSeetingsDic =     
            [
                AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC),
                AVNumberOfChannelsKey: 2, //录音的声道数，立体声为双声道
                AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                AVEncoderBitRateKey : 320000,
                AVSampleRateKey : 44100.0 //录音器每秒采集的录音样本数
        ]//初始化字典并添加设置参数
    }
   
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if(flag == 1){
            VoiceFinsh.isHidden = false
            fatherViewController.TempImage = CameraImage.image!
            recorder = try! AVAudioRecorder(url: URL(string: aacPath!)!,
                                            settings: recorderSeetingsDic!)
            if recorder != nil {
                recorder!.isMeteringEnabled = true  //开启仪表计数功能
                recorder!.prepareToRecord()    // 准备录音
                recorder!.record()  //开始录音
               volumeTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self,selector: #selector(audioPowerChange),userInfo: nil, repeats: true)
                audioPowerChange()
                //启动定时器，定时更新录音音量
                print("监听开始")
            }
            let queue = DispatchQueue.global(qos: .default)  //开子线程处理图像
            queue.async {
                print("do work")
                CoolImage.coolV(value: 50)
                self.CameraImage.image = fatherViewController.TempImage
                //self.CameraImage.isHidden = false
                print("finsh")
                DispatchQueue.main.async(execute: {
                    self.CameraImage.isHidden = false
                    self.CameraImage.reloadInputViews()
                })
            }
        }
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
    @objc func audioPowerChange(){
        recorder!.updateMeters() // 刷新音量数据
        averageV = recorder!.averagePower(forChannel: 0) //获取音量的平均值
        print(averageV)
    }

}

