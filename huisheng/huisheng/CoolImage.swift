//
//  CoolImage.swift
//  huisheng
//
//  Created by Andrew on 2018/9/6.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import Foundation
import UIKit
import CoreImage


class CoolImage {
    static func cool(value: Int){
        let context = CIContext(options: nil)
        guard  let cgimg = fatherViewController.TempImage.cgImage else {
            print("imageView doesn't have an image!")
            return
        }
        let cImage = CIImage(cgImage: cgimg)
        let guassinBlur = CIFilter(name:"CIGaussianBlur")
        guassinBlur?.setValue(cImage, forKey: "inputImage")
        guassinBlur?.setValue(value, forKey: "inputRadius")
        let result = guassinBlur?.value(forKey: kCIOutputImageKey)
        let rect = CGRect(x: 0, y: 0, width: fatherViewController.TempImage.size.width, height: fatherViewController.TempImage.size.height)
        let imageRef = context.createCGImage(result as! CIImage, from: rect)
        let image = UIImage(cgImage: imageRef!)
        fatherViewController.TempImage = image
        
    }
    static func coolV(value: Int){
        let context = CIContext(options: nil)
        guard  let cgimg = fatherViewController.TempImage.cgImage else {
            print("imageView doesn't have an image!")
            return
        }
        let cImage = CIImage(cgImage: cgimg)
        let coolfilter = CIFilter(name:"CIBumpDistortion")
        coolfilter?.setValue(cImage, forKey: "inputImage")
        coolfilter?.setValue(400, forKey: "inputRadius")
      // coolfilter?.setValue(0.6, forKey: "inputScale")
        var point = CIVector(x:fatherViewController.TempImage.size.width/2.0,y:fatherViewController.TempImage.size.height/2.0)
        coolfilter?.setValue(point, forKey: "inputCenter")  //fliter Postion
        
        let result = coolfilter?.value(forKey: kCIOutputImageKey)
        let rect = CGRect(x: 0, y: 0, width: fatherViewController.TempImage.size.width, height: fatherViewController.TempImage.size.height)
        let imageRef = context.createCGImage(result as! CIImage, from: rect)
        let image = UIImage(cgImage: imageRef as! CGImage)
        fatherViewController.TempImage = image
    }
    static func coolFace(value:Float){
        let context = CIContext(options: nil)
        guard  let cgimg = fatherViewController.TempImage.cgImage else {
            print("imageView doesn't have an image!")
            return
        }
        var  cImage = CIImage(cgImage: cgimg)
        let coolfilter = CIFilter(name:"CITwirlDistortion")  //CIBumpDistortion
        let param = [CIDetectorAccuracy: CIDetectorAccuracyHigh]  // 参数设置(精度设置)
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: param)  //创建识别类
        guard let faceArr = faceDetector?.features(in: cImage) else { return }  //找到识别其中的人脸对象
        for faceFeature in faceArr {
            guard let feature = faceFeature as? CIFaceFeature else { return }
            //左眼
            if feature.hasLeftEyePosition {
                let point = CIVector(x:feature.leftEyePosition.x,y:feature.leftEyePosition.y)
                print("左眼1")
                coolfilter?.setValue(cImage, forKey: "inputImage")
                coolfilter?.setValue(value+83, forKey: "inputRadius")
                coolfilter?.setValue(point, forKey: "inputCenter")
                cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
                print("左眼2")
                
            }
            //右眼
            if feature.hasRightEyePosition {
                let point = CIVector(x:feature.rightEyePosition.x,y:feature.rightEyePosition.y)
                coolfilter?.setValue(cImage, forKey: "inputImage")
                coolfilter?.setValue(value+86, forKey: "inputRadius")
                coolfilter?.setValue(point, forKey: "inputCenter")
                cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
                
            }
            if feature.hasMouthPosition {
                let point = CIVector(x:feature.mouthPosition.x,y:feature.mouthPosition.y)
                coolfilter?.setValue(cImage, forKey: "inputImage")
                coolfilter?.setValue(value+165, forKey: "inputRadius")
                coolfilter?.setValue(point, forKey: "inputCenter")
                cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
            }
        
        
    }
        let rect = CGRect(x: 0, y: 0, width: fatherViewController.TempImage.size.width, height: fatherViewController.TempImage.size.height)
        let imageRef = context.createCGImage(cImage as! CIImage, from: rect)
        let image = UIImage(cgImage: imageRef as! CGImage)
        fatherViewController.TempImage = image
        print("刷新一次")
    }
    static func coolVo(value: Int){
        var choose = (Int)(value%7)
        if(choose < 0 ){
            choose = 7 - choose
        }
        fatherViewController.TempImage = UIImage(named: "\(choose).jpeg")!
        let context = CIContext(options: nil)
        guard  let cgimg = fatherViewController.TempImage.cgImage else {
            print("imageView doesn't have an image!")
            return
        }
        let cImage = CIImage(cgImage: cgimg)
        let coolOne = CIFilter(name:"CICircleSplashDistortion")
        coolOne?.setValue(cImage, forKey: "inputImage")
        coolOne?.setValue(value, forKey: "inputRadius")
        let tempV = Float(value%10)
        let point = CIVector(x: CGFloat(tempV*Float(fatherViewController.TempImage.size.width)),y: CGFloat(tempV*Float(fatherViewController.TempImage.size.height)))
        coolOne?.setValue(point, forKey: "inputCenter")
        var result = coolOne?.value(forKey: kCIOutputImageKey)
        let rect = CGRect(x: 0, y: 0, width: fatherViewController.TempImage.size.width, height: fatherViewController.TempImage.size.height)
        let imageRef = context.createCGImage(result as! CIImage, from: rect)
        let image = UIImage(cgImage: imageRef as! CGImage)
        fatherViewController.TempImage = image
        
    }
    static func coolVoi(value: Int){
        var choose = (Int)(value/7)
        if(choose < 0 || choose > 7){
            choose = 0 - choose
        } //选择基调
        print(choose)
        fatherViewController.TempImage = UIImage(named: "\(choose).jpeg")!  //半初始化
        let context = CIContext(options: nil)
        guard  let cgimg = fatherViewController.TempImage.cgImage else {
            print("imageView doesn't have an image!")
            return
        }
        var cImage = CIImage(cgImage: cgimg)
        if(true){
        let coolOne = CIFilter(name:"CITwirlDistortion")
        coolOne?.setValue(cImage, forKey: "inputImage")
        coolOne?.setValue(Int(fatherViewController.TempImage.size.width/3), forKey: "inputRadius")
        //let tempV = Float(value/5)
        let point = CIVector(x: CGFloat( Float(fatherViewController.TempImage.size.width/2)),y: CGFloat( Float(fatherViewController.TempImage.size.height/2)))
        coolOne?.setValue(point, forKey: "inputCenter")
        cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        if(true){
            let coolOne = CIFilter(name:"CIPinchDistortion")
            coolOne?.setValue(cImage, forKey: "inputImage")
            //coolOne?.setValue(Int(fatherViewController.TempImage.size.width/3), forKey: "inputRadius")
            //let tempV = Float(value/5)
            let point = CIVector(x: CGFloat( Float(fatherViewController.TempImage.size.width/2)),y: CGFloat( Float(fatherViewController.TempImage.size.height/2)))
            //coolOne?.setValue(point, forKey: "inputCenter")
            cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        if(true){
            let coolOne = CIFilter(name:"CITorusLensDistortion")
            coolOne?.setValue(cImage, forKey: "inputImage")
            cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        
        //let result = coolOne?.value(forKey: kCIOutputImageKey)
        let rect = CGRect(x: 0, y: 0, width: fatherViewController.TempImage.size.width, height: fatherViewController.TempImage.size.height)
        let imageRef = context.createCGImage(cImage as! CIImage, from: rect)
        let image = UIImage(cgImage: imageRef!)
        fatherViewController.TempImage = image
        
    }
}
//测试成果记录
//CITorusLensDistortion  圆环
//CITwirlDistortion  扭转。 人脸混合参数
//CIPinchDistortion  聚拢
