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
        var result = guassinBlur?.value(forKey: kCIOutputImageKey)
        let rect = CGRect(x: 0, y: 0, width: fatherViewController.TempImage.size.width, height: fatherViewController.TempImage.size.height)
        let imageRef = context.createCGImage(result as! CIImage, from: rect)
        let image = UIImage(cgImage: imageRef as! CGImage)
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
      //  coolfilter?.setValue(0.6, forKey: "inputScale")
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
        let coolfilter = CIFilter(name:"CIBumpDistortion")
        let param = [CIDetectorAccuracy: CIDetectorAccuracyHigh]  // 参数设置(精度设置)
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: context, options: param)  //创建识别类
        guard let faceArr = faceDetector?.features(in: cImage) else { return }  //找到识别其中的人连对象
        for faceFeature in faceArr {
            guard let feature = faceFeature as? CIFaceFeature else { return }
            //左眼
            if feature.hasLeftEyePosition {
                let point = CIVector(x:feature.leftEyePosition.x,y:feature.leftEyePosition.y)
                coolfilter?.setValue(cImage, forKey: "inputImage")
                coolfilter?.setValue(value+160, forKey: "inputRadius")
                coolfilter?.setValue(point, forKey: "inputCenter")
                cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
                
            }
            //右眼
            if feature.hasRightEyePosition {
                let point = CIVector(x:feature.rightEyePosition.x,y:feature.rightEyePosition.y)
                coolfilter?.setValue(cImage, forKey: "inputImage")
                coolfilter?.setValue(value+160, forKey: "inputRadius")
                coolfilter?.setValue(point, forKey: "inputCenter")
                cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
                
            }
            if feature.hasMouthPosition {
                var point = CIVector(x:feature.mouthPosition.x,y:feature.mouthPosition.y)
                coolfilter?.setValue(cImage, forKey: "inputImage")
                coolfilter?.setValue(350, forKey: "inputRadius")
                coolfilter?.setValue(point, forKey: "inputCenter")
                cImage = coolfilter?.value(forKey: kCIOutputImageKey) as! CIImage
            }
        
        
    }
        let rect = CGRect(x: 0, y: 0, width: fatherViewController.TempImage.size.width, height: fatherViewController.TempImage.size.height)
        let imageRef = context.createCGImage(cImage as! CIImage, from: rect)
        let image = UIImage(cgImage: imageRef as! CGImage)
        fatherViewController.TempImage = image
    }
}
