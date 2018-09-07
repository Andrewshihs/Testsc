//
//  firstViewController.swift
//  huisheng
//
//  Created by Andrew on 2018/8/29.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import UIKit

class firstViewController: fatherViewController{
    
    var text = "logo.png"
    var timer :Timer!
    var shapeLayer:CAShapeLayer!
    let screenh = UIScreen.main.bounds.size.height
    let screenw = UIScreen.main.bounds.size.width
    @IBOutlet weak var HuiTu: UIImageView!
    @IBOutlet weak var GGCamera: UIButton!
    @IBOutlet weak var ImageFinsh: UIButton!
    
    @IBAction func VoiceButton(_ sender: UIButton) {
        GGCamera.isHidden = true
        CircleAnimate()
        HuiTu.image = fatherViewController.TempImage
        HuiTu.isHidden = false
        CoolImage.cool(value: 30)
        
    }
    @IBAction func ImageFinsh(_ sender: UIButton) {
         fatherViewController.TempImage = HuiTu.image!
    }
    
 
    
    @IBAction func OverButton(_ sender: UIButton) {
        HuiTu.image=UIImage(named: "\(text)")
        HuiTu.isHidden = false
        ImageFinsh.isHidden = false
        HuiTu.image = fatherViewController.TempImage
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //圆形进度条动画
    func CircleAnimate(){
        shapeLayer = CAShapeLayer()
        self.view.layer.addSublayer(shapeLayer)
        //使用贝塞尔曲线画一个圆形  注意位置
        let onePath = UIBezierPath(arcCenter: CGPoint(x:screenw/2,y:(screenh-57.5)), radius: 25, startAngle: 1.5, endAngle: CGFloat(Double.pi*2.5), clockwise: true)
        //CAShapeLayer 的路径
        shapeLayer.path = onePath.cgPath
        //描线的线宽
        shapeLayer.lineWidth = 3
        //描线起始点
        shapeLayer.strokeStart = 0
        //描线终点
        shapeLayer.strokeEnd = 0
        //填充色
        shapeLayer.fillColor = UIColor.clear.cgColor
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(animate), userInfo: nil, repeats: true)
    }
    //定时器
    @objc func animate(){
        shapeLayer.strokeColor = UIColor.blue.cgColor
        if  shapeLayer.strokeEnd < 1{
            self.shapeLayer.strokeEnd += 0.02
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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
    
}
