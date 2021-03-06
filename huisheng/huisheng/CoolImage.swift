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
    static var flag: Int = 0 //识别人脸标记
    static func coolFace(value:Float){
        let context = CIContext(options: nil)
        guard  let cgimg = fatherViewController.TempImage.cgImage else {
            print("imageView doesn't have an image!")
            return
        }
        var  cImage = CIImage(cgImage: cgimg)
        let coolfilter = CIFilter(name:"CIBumpDistortion")  //CIBumpDistortion
        let param = [CIDetectorAccuracy: CIDetectorAccuracyHigh]  // 参数设置(精度设置)
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: param)  //创建识别类
        guard let faceArr = faceDetector?.features(in: cImage) else {
            return }  //找到识别其中的人脸对象
        for faceFeature in faceArr {
            guard let feature = faceFeature as? CIFaceFeature else { return }
            if feature.hasLeftEyePosition {//左眼
                if(Int(value)%2 == 0){
                let point = CIVector(x:feature.leftEyePosition.x,y:feature.leftEyePosition.y)
                coolfilter?.setValue(cImage, forKey: "inputImage")
                coolfilter?.setValue(value+83, forKey: "inputRadius")
                coolfilter?.setValue(point, forKey: "inputCenter")
                cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
                flag = 1
                }
            }
            if feature.hasRightEyePosition {//右眼
                if(Int(value)%2 == 0){
                let point = CIVector(x:feature.rightEyePosition.x,y:feature.rightEyePosition.y)
                coolfilter?.setValue(cImage, forKey: "inputImage")
                coolfilter?.setValue(value+86, forKey: "inputRadius")
                coolfilter?.setValue(point, forKey: "inputCenter")
                cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
                flag = 1
                }
            }
            if feature.hasMouthPosition {  //嘴巴
                if(Int(value)%2 == 0){
                let point = CIVector(x:feature.mouthPosition.x,y:feature.mouthPosition.y)
                coolfilter?.setValue(cImage, forKey: "inputImage")
                coolfilter?.setValue(value+165, forKey: "inputRadius")
                coolfilter?.setValue(point, forKey: "inputCenter")
                cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
                flag = 1
                }
            }
            if(Int(value)%2 != 0){
            let firPos = CIVector(x:(feature.rightEyePosition.x+feature.leftEyePosition.x)/2,y:(feature.rightEyePosition.y+feature.rightEyePosition.y)/2)
            let secPos = CIVector(x:(firPos.x+feature.mouthPosition.x)/2,y:(firPos.y+feature.mouthPosition.y)/2)
            let coolOne = CIFilter(name:"CIBumpDistortion")
            let coolRad = Int(pow((secPos.x-feature.rightEyePosition.x)*(secPos.x-feature.rightEyePosition.x)+(secPos.x-feature.rightEyePosition.y)*(secPos.x-feature.rightEyePosition.y),-2))
            coolOne?.setValue(cImage, forKey: "inputImage")
            coolOne?.setValue((fatherViewController.TempImage.size.width/3), forKey: "inputRadius")
            coolOne?.setValue(secPos,forKey: "inputCenter")
            cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
            flag = 1
            }
    }
        if(flag == 0){  // no face 改变色调
            let coolfilter = CIFilter(name:"CIHueAdjust")
            coolfilter?.setValue(cImage, forKey: "inputImage")
            coolfilter?.setValue(value, forKey: "inputAngle")
            cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
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
    static func coolV(value: Int){
        var choose = (Int)(value%7)
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
        if(value%3 == 2){
            let coolOne = CIFilter(name:"CIBoxBlur")  //模糊
            coolOne?.setValue(cImage, forKey: "inputImage")
            coolOne?.setValue(value+100, forKey: "inputRadius")
            cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        if(value%3 == 1){
        let coolOne = CIFilter(name:"CITwirlDistortion")  // 中心扭曲
        coolOne?.setValue(cImage, forKey: "inputImage")
        coolOne?.setValue(Int(fatherViewController.TempImage.size.width/8*3), forKey: "inputRadius")
        let point = CIVector(x: CGFloat(Float(fatherViewController.TempImage.size.width/2)),y: CGFloat(Float(fatherViewController.TempImage.size.height/2)))
        coolOne?.setValue(point, forKey: "inputCenter")
        cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        if(value%3 == 0){
            let coolOne = CIFilter(name:"CITorusLensDistortion")  //中心圆环
            coolOne?.setValue(cImage, forKey: "inputImage")
            coolOne?.setValue(Int(fatherViewController.TempImage.size.width/3), forKey: "inputRadius")
            coolOne?.setValue(fatherViewController.TempImage.size.width/3, forKey: "inputWidth")
            let point = CIVector(x: CGFloat( Float(fatherViewController.TempImage.size.width/2)),y: CGFloat( Float(fatherViewController.TempImage.size.height/2)))
            coolOne?.setValue(point, forKey: "inputCenter")
            cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        if(value%3 == 1){
            let coolOne = CIFilter(name:"CITwirlDistortion")  //中心旋转
            coolOne?.setValue(cImage, forKey: "inputImage")
            let point = CIVector(x: CGFloat( Float(fatherViewController.TempImage.size.width/2)),y: CGFloat( Float(fatherViewController.TempImage.size.height/2)))
            coolOne?.setValue(point, forKey: "inputCenter")
            coolOne?.setValue(value+200, forKey: "inputRadius")
            cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        if(value%3 == 2){
            let coolOne = CIFilter(name:"CICircleSplashDistortion")  //四处飞溅
            coolOne?.setValue(cImage, forKey: "inputImage")
            let point = CIVector(x: CGFloat( Float(fatherViewController.TempImage.size.width/2)),y: CGFloat( Float(fatherViewController.TempImage.size.height/2)))
            coolOne?.setValue(point, forKey: "inputCenter")
            coolOne?.setValue(value+250, forKey: "inputRadius")
            cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        if(value%4 == 2){
            let coolOne = CIFilter(name:"CIDroste")  //  循环
            coolOne?.setValue(cImage, forKey: "inputImage")
            cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        if(value%3 == 2){
            var choose = (Int)((value-3)%7)  //叠加位图
            if(choose < 0 || choose > 7){
                choose = 0 - choose
            }
            let coolOne = CIFilter(name:"CIMinimumComponent")
            let teImage = UIImage(named: "\(choose).jpeg")
            let ncgimg = teImage?.cgImage
            var ncImage = CIImage(cgImage: ncgimg!)
            coolOne?.setValue(ncImage, forKey: "inputImage")
            ncImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
            let coolTwo = CIFilter(name:"CIDisplacementDistortion")
            coolTwo?.setValue(cImage, forKey: "inputImage")
            coolTwo?.setValue(ncImage, forKey: "inputDisplacementImage")
            cImage = coolTwo?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        if(value%4 == 0){
            let coolOne = CIFilter(name:"CILightTunnel")  //  大型扭转
            coolOne?.setValue(cImage, forKey: "inputImage")
            let point = CIVector(x: CGFloat( Float(fatherViewController.TempImage.size.width/2)),y: CGFloat( Float(fatherViewController.TempImage.size.height/2)))
            coolOne?.setValue(point, forKey: "inputCenter")
            //coolOne?.setValue(value, forKey: "inputRadius")
            coolOne?.setValue(value, forKey: "inputRotation")
           
            cImage = coolOne?.value(forKey: kCIOutputImageKey) as! CIImage
        }
        if(true){  // no face 改变色调
            let coolfilter = CIFilter(name:"CIHueAdjust")
            coolfilter?.setValue(cImage, forKey: "inputImage")
            coolfilter?.setValue(value, forKey: "inputAngle")
            cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
        }
    
        let rect = CGRect(x: 0, y: 0, width: fatherViewController.TempImage.size.width, height: fatherViewController.TempImage.size.height)
        let imageRef = context.createCGImage(cImage as! CIImage, from: rect)
        let image = UIImage(cgImage: imageRef!)
        fatherViewController.TempImage = image
        
    }
}
//测试记录
//CITorusLensDistortion  圆环
//CITwirlDistortion  扭转。 人脸混合参数
//CIPinchDistortion  聚拢  人脸可以试试
