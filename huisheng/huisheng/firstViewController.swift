//
//  firstViewController.swift
//  huisheng
//
//  Created by Andrew on 2018/8/29.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import UIKit

class firstViewController: UIViewController {
    
    var timer :Timer!
    var shapeLayer:CAShapeLayer!
    @IBOutlet weak var HuiTu: UIImageView!
    @IBOutlet weak var GGCamera: UIButton!
    @IBOutlet weak var ImageFinsh: UIButton!
    @IBAction func VoiceButton(_ sender: UIButton) {
        GGCamera.isHidden = true
        CircleAnimate()
    }
    
    @IBAction func OverButton(_ sender: UIButton) {
        GGCamera.isHidden = false
        HuiTu.isHidden = false
         ImageFinsh.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }
    
    //圆形进度条动画
    func CircleAnimate(){
        shapeLayer = CAShapeLayer()
        self.view.layer.addSublayer(shapeLayer)
        //使用贝塞尔曲线画一个圆形  注意位置
        let onePath = UIBezierPath(arcCenter: CGPoint(x:187,y:739), radius: 25, startAngle: 1.5, endAngle: CGFloat(Double.pi*2.5), clockwise: true)
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
     //   super.viewWillDisappear(<#T##animated: Bool##Bool#>)
        HuiTu.isHidden = true
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
