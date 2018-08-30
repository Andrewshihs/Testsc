//
//  cireview.swift
//  huisheng
//
//  Created by Andrew on 2018/8/30.
//  Copyright © 2018年 Andrew. All rights reserved.
//
import UIKit
import Foundation

class cireview: UIView{
    
    var value: CGFloat = 0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    var maximumValue: CGFloat = 0 {
        didSet { self.setNeedsDisplay() }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.opaque = false
    }
    
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        
        //线宽度
        let lineWidth: CGFloat = 10.0
        //半径
        let radius = CGRectGetWidth(rect) / 2.0 - lineWidth
        //中心点x
        let centerX = CGRectGetMidX(rect)
        //中心点y
        let centerY = CGRectGetMidY(rect)
        //弧度起点
        let startAngle = CGFloat(-90 * M_PI / 180)
        //弧度终点
        let endAngle = CGFloat(((self.value / self.maximumValue) * 360 - 90) ) * CGFloat(M_PI) / 180
        
        //创建一个画布
        let context = UIGraphicsGetCurrentContext()
        
        //画笔颜色
        CGContextSetStrokeColorWithColor(context, UIColor.blueColor().CGColor)
        
        //画笔宽度
        CGContextSetLineWidth(context, lineWidth)
        
        //（1）画布 （2）中心点x（3）中心点y（4）圆弧起点（5）圆弧结束点（6） 0顺时针 1逆时针
        CGContextAddArc(context, centerX, centerY, radius, startAngle, endAngle, 0)
        
        //绘制路径
        CGContextStrokePath(context)
        
        //画笔颜色
        CGContextSetStrokeColorWithColor(context, UIColor.darkGrayColor().CGColor)
        
        //（1）画布 （2）中心点x（3）中心点y（4）圆弧起点（5）圆弧结束点（6） 0顺时针 1逆时针
        CGContextAddArc(context, centerX, centerY, radius, startAngle, endAngle, 1)
        
        //绘制路径
        CGContextStrokePath(context)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
