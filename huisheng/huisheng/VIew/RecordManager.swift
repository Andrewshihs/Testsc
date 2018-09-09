//
//  RecordManager.swift
//  huisheng
//
//  Created by Andrew on 2018/9/8.
//  Copyright © 2018年 Andrew. All rights reserved.
//

import Foundation
import AVFoundation

class RecordManager {
    
    var recorder: AVAudioRecorder?
   
    let file_path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/record.wav")
    
    //开始录音
    func beginRecord() {
        let session = AVAudioSession.sharedInstance()
        //设置session类型
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch let err{
            print("set Error:\(err.localizedDescription)")
        }
        //设置session动作
        do {
            try session.setActive(true)
        } catch let err {
            print("init ERROR:\(err.localizedDescription)")
        }
        
        let recordSetting: [String: Any] = [AVSampleRateKey: NSNumber(value: 16000),//采样率
            AVFormatIDKey: NSNumber(value: kAudioFormatLinearPCM),//音频格式
            AVLinearPCMBitDepthKey: NSNumber(value: 16),//采样位数
            AVNumberOfChannelsKey: NSNumber(value: 1),//通道数
            AVEncoderAudioQualityKey: NSNumber(value: AVAudioQuality.min.rawValue)//录音质量
        ];
        //开始录音
        do {
            let url = URL(fileURLWithPath: file_path!)
            recorder = try AVAudioRecorder(url: url, settings: recordSetting)
            recorder!.prepareToRecord()
            recorder!.record()
            print("record start")
        } catch let err {
            print("record ERROr:\(err.localizedDescription)")
        }
    }
    
    //结束录音
    func stopRecord() {
        if let recorder = self.recorder {
            if recorder.isRecording {
                print("recording，ToSave：\(file_path!)")
            }else {
                print("No record")
            }
            recorder.stop()
            self.recorder = nil
        }else {
            print("not init")
        }
    }
    func audioPowerChange(){
        print("测试")
        recorder?.updateMeters()
        print(" 获取后")
        var power = recorder?.averagePower(forChannel: 1)
        var VoicePower = (1.0/160.0)*(power!+160.0)
        print("声音变化值")
        print(VoicePower)
    }
    
}
