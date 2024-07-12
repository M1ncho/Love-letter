//
//  SaveSetting.swift
//  Love letter
//
//  Created by KJW on 2022/06/27.
//

import Foundation


class SaveSetting {
    
    // 레벨 저장
    class func setLavel(lavel: Int) {
        UserDefaults.standard.set(lavel, forKey: "lavel")
    }
    
    class func getLavel() -> Int {
        return UserDefaults.standard.integer(forKey: "lavel")
    }
    
    
    // 현재 클릭 수 저장
    class func setClickValue(value: Int) {
        UserDefaults.standard.set(value, forKey: "clickvalue")
    }
    
    class func getClickValue() -> Int {
        return UserDefaults.standard.integer(forKey: "clickvalue")
    }
    
    
    // 현재 하트개수 저장
    class func setHeartCount(value: Int) {
        UserDefaults.standard.set(value, forKey: "heartcount")
    }
    
    class func getHeartCount() -> Int {
        return UserDefaults.standard.integer(forKey: "heartcount")
    }
    
    
    // 현재 벽 유형
    class func setWallValue(value: String) {
        UserDefaults.standard.set(value, forKey: "wallvalue")
    }
    
    class func getWallValue() -> String {
        return UserDefaults.standard.string(forKey: "wallvalue") ?? "wall"
    }
    
    
    // 현재 바닥 유형
    class func setPlowerValue(value: String) {
        UserDefaults.standard.set(value, forKey: "plowervalue")
    }
    
    class func getPlowerValue() -> String {
        return UserDefaults.standard.string(forKey: "plowervalue") ?? "plower"
    }
    
    
    // 현재 창문 유형
    class func setWindowValue(value: String) {
        UserDefaults.standard.set(value, forKey: "windowvalue")
    }
    
    class func getWindowValue() -> String {
        return UserDefaults.standard.string(forKey: "windowvalue") ?? "not"
    }
    
    
    // 구매한 벽지 리스트
    class func setWallList(value: [String]) {
        UserDefaults.standard.set(value, forKey: "walllist")
    }
    
    class func getWallList() -> [String] {
        let value = UserDefaults.standard.object(forKey: "walllist") as? [String] ?? ["wall"]
        return value
    }
    
    
    // 구매한 바닥 리스트
    class func setPlowerList(value: [String]) {
        UserDefaults.standard.set(value, forKey: "plowerlist")
    }
    
    class func getPlowerList() -> [String] {
        let value = UserDefaults.standard.object(forKey: "plowerlist") as? [String] ?? ["plower"]
        return value
    }
    
    
    // 구매한 창문 리스트
    class func setWindowList(value: [String]) {
        UserDefaults.standard.set(value, forKey: "windowlist")
    }
    
    class func getWindowList() -> [String] {
        let value = UserDefaults.standard.object(forKey: "windowlist") as? [String] ?? []
        return value
    }
    
    
    
    
    
    
    
}
