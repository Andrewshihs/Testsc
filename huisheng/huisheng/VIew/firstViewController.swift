//
//  firstViewController.swift
//  huisheng
//
//  Created by Andrew on 2018/8/29.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import UIKit
import AVFoundation

class firstViewController: fatherViewController{
    
    var text = "logo.png"  //初始化默认图像
    var timer :Timer!   //进度条动画定时器
    var shapeLayer:CAShapeLayer!
    let screenh = UIScreen.main.bounds.size.height
    let screenw = UIScreen.main.bounds.size.width
    @IBOutlet weak var HuiTu: UIImageView!  //绘图
    @IBOutlet weak var GGCamera: UIButton!  
    @IBOutlet weak var ImageFinsh: UIButton!
    @IBOutlet weak var vButton :UIButton!
    var averageV: Float = 0.0
    
    var recorder:AVAudioRecorder? //录音器
    var player:AVAudioPlayer? //播放器
    var recorderSeetingsDic:[String : Any]? //录音器设置参数数组
    var volumeTimer:Timer! //定时器线程，循环监测录音的音量大小
    var aacPath:String? //录音存储路径
    @IBAction func CGCame(){
        recorder?.stop()    //停止录音
        recorder = nil  //录音器释放
        volumeTimer.invalidate()  //暂停定时器
        volumeTimer = nil
    }
    @IBAction func VoiceButton(_ sender: UIButton) {
        GGCamera.isHidden = true
        HuiTu.image = fatherViewController.TempImage
        vButton.isEnabled = false
        
        self.CircleAnimate()
    }
    @IBAction func ImageFinsh(_ sender: UIButton) {
        fatherViewController.TempImage = HuiTu.image!
        recorder?.stop()    //停止录音
        recorder = nil  //录音器释放
        volumeTimer.invalidate()  //暂停定时器
        volumeTimer = nil
        print("结束录音")
    }
    
 
    
    @IBAction func OverButton(_ sender: UIButton) {
       let queue = DispatchQueue.global(qos: .default)  //开子线程处理图像
        queue.async {
            print("do work")
            CoolImage.coolVoi(value: Int(self.averageV+50))
            self.HuiTu.image = fatherViewController.TempImage
            self.HuiTu.isHidden = false
            print("finsh")
           DispatchQueue.main.async(execute: {
                self.HuiTu.image = fatherViewController.TempImage
                self.HuiTu.isHidden = false
                self.HuiTu.reloadInputViews()
           })
        }
        ImageFinsh.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        recorder = try! AVAudioRecorder(url: URL(string: aacPath!)!,
                                        settings: recorderSeetingsDic!)
        if recorder != nil {
            recorder!.isMeteringEnabled = true  //开启仪表计数功能
            recorder!.prepareToRecord()    // 准备录音
            recorder!.record()  //开始录音
            volumeTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self,
                                               selector: #selector(audioPowerChange),
                                               userInfo: nil, repeats: true)
            //启动定时器，定时更新录音音量
            print("监听开始")
        }
    }
    
    //圆形进度条动画
    func CircleAnimate(){
        shapeLayer = CAShapeLayer()
        self.view.layer.addSublayer(shapeLayer)
        let onePath = UIBezierPath(arcCenter: CGPoint(x:screenw/2,y:(screenh-57.5)), radius: 25, startAngle: 1.5, endAngle: CGFloat(Double.pi*2.5), clockwise: true)//使用贝塞尔曲线画一个圆形  注意位置
        shapeLayer.path = onePath.cgPath//CAShapeLayer 的路径
        shapeLayer.lineWidth = 3//描线的线宽
        shapeLayer.strokeStart = 0//描线起始点
        shapeLayer.strokeEnd = 0//描线终点
        shapeLayer.fillColor = UIColor.clear.cgColor//填充色
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
    }
    //定时器
    @objc func animate(){
        shapeLayer.strokeColor = UIColor.blue.cgColor
        if  shapeLayer.strokeEnd < 1{
            self.shapeLayer.strokeEnd += 0.01
        }else{
            timer.invalidate()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        ImageFinsh.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        HuiTu.isHidden = true
        vButton.isEnabled = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func audioPowerChange(){
        recorder!.updateMeters() // 刷新音量数据
        averageV = recorder!.averagePower(forChannel: 0) //获取音量的平均值
        print(averageV)
    }
    
}
