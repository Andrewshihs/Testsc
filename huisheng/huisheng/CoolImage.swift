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
}
