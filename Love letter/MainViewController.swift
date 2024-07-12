//
//  MainViewController.swift
//  Love letter
//
//  Created by KJW on 2022/06/27.
//

import UIKit
import Foundation


class MainViewController: UIViewController {

    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var roomsetView: UIView!
    @IBOutlet weak var letterView: UIView!
    
    @IBOutlet weak var ivWindow: UIImageView!
    @IBOutlet weak var ivWall: UIImageView!
    @IBOutlet weak var ivPlower: UIImageView!
    @IBOutlet weak var ivChar: UIImageView!
    @IBOutlet weak var ivClickHeart: UIImageView!
    
    @IBOutlet weak var lbHeartCount: UILabel!
    @IBOutlet weak var lavelView: UIView!
    @IBOutlet weak var lbLavel: UILabel!
    @IBOutlet weak var lbCount: UILabel!
    
    var HeartCount = 0
    var SumCount = 0
    var lavel = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRoom()
        
        SumCount = SaveSetting.getClickValue()
        HeartCount = SaveSetting.getHeartCount()
        lbHeartCount.text = "\(HeartCount)"
        
        if SaveSetting.getLavel() == 0 {
            lavel = 1
        } else {
            lavel = SaveSetting.getLavel()
        }

        lbLavel.text = "\(lavel)"
        
        setClickCount()
        
        
        // 그릴 원의 크기 설정
        let diameter = lavelView.bounds.size.height
        let circle = UIBezierPath(ovalIn: CGRect(x: 0, y: 0,width: diameter, height: diameter))
        let shape = CAShapeLayer()
        shape.path = circle.cgPath

        shape.lineWidth = 2.0
        shape.strokeColor = UIColor.init(named: "coralpink")?.cgColor
        shape.fillColor = UIColor.clear.cgColor
        lavelView.layer.addSublayer(shape)
        
        
        //magenta, coralpink
        shopView.layer.cornerRadius = 8
        shopView.layer.borderWidth = 2
        shopView.layer.borderColor = UIColor.init(named: "magenta")?.cgColor
        
        roomsetView.layer.cornerRadius = 8
        roomsetView.layer.borderWidth = 2
        roomsetView.layer.borderColor = UIColor.init(named: "magenta")?.cgColor
        
        letterView.layer.cornerRadius = 8
        letterView.layer.borderWidth = 2
        letterView.layer.borderColor = UIColor.init(named: "magenta")?.cgColor
        
        
        let tapChar = UITapGestureRecognizer.init(target: self, action: #selector(clickChar(_:)))
        ivChar.addGestureRecognizer(tapChar)
        
        let tapHeart = UITapGestureRecognizer.init(target: self, action: #selector(clickHeart(_:)))
        ivClickHeart.addGestureRecognizer(tapHeart)
        
        let tapShop = UITapGestureRecognizer.init(target: self, action: #selector(clickShop(_:)))
        shopView.addGestureRecognizer(tapShop)
        
        let tapSet = UITapGestureRecognizer.init(target: self, action: #selector(clickRoomset(_:)))
        roomsetView.addGestureRecognizer(tapSet)
        
        let tapLetter = UITapGestureRecognizer.init(target: self, action: #selector(clickLetter(_:)))
        letterView.addGestureRecognizer(tapLetter)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(dismissShop(_:)), name: NSNotification.Name("dismissShop"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(dismissSet(_:)), name: NSNotification.Name("dismissSet"), object: nil)
    }
    
    
    
    // MARK: - objc function
    @objc func clickChar(_ tap: UITapGestureRecognizer) {
        SumCount += 1
        
        heartVisiblite()
        setLavelUp()
        setClickCount()
    }
    
    @objc func clickHeart(_ tap: UITapGestureRecognizer) {
        HeartCount += 1
        SaveSetting.setHeartCount(value: HeartCount)
        
        lbHeartCount.text = "\(HeartCount)"
        ivClickHeart.isHidden = true
    }
    
    @objc func clickShop(_ tap: UITapGestureRecognizer) {
        let shopController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "shopView")
        shopController.modalPresentationStyle = .overCurrentContext
        
        self.present(shopController, animated: true)
    }
    
    @objc func clickRoomset(_ tap: UITapGestureRecognizer) {
        let setController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "setView")
        setController.modalPresentationStyle = .overCurrentContext
        
        self.present(setController, animated: true)
    }
    
    @objc func clickLetter(_ tap: UITapGestureRecognizer) {
        let letterController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "letterView")
        letterController.modalPresentationStyle = .overCurrentContext
        
        self.present(letterController, animated: true)
    }
    
    
    
    @objc func dismissShop(_ noti: Notification) {
        HeartCount = SaveSetting.getHeartCount()
        lbHeartCount.text = "\(HeartCount)"
    }
    
    @objc func dismissSet(_ noti: Notification) {
        setRoom()
    }
    
    
    // MARK: - Function
    func setRoom() {
        let wall = SaveSetting.getWallValue()
        let plower = SaveSetting.getPlowerValue()
        let window = SaveSetting.getWindowValue()
        
        ivWall.image = UIImage.init(named: "\(wall)")
        ivPlower.image = UIImage.init(named: "\(plower)")
        
        if window != "not" {
            ivWindow.isHidden = false
            ivWindow.image = UIImage.init(named: "\(window)")
        }
        
        print("\(wall)   \(plower)")
    }
    
    
    func setClickCount() {
        if lavel == 1 {
            lbCount.text = "\(SumCount) / \(LavelType.LAVELONE.rawValue)"
        }
        else if lavel == 2 {
            lbCount.text = "\(SumCount) / \(LavelType.LAVELTWO.rawValue)"
        }
        else if lavel == 3 {
            lbCount.text = "\(SumCount) / \(LavelType.LAVELTHREE.rawValue)"
        }
        else if lavel == 4 {
            lbCount.text = "\(SumCount) / \(LavelType.LAVELFOURE.rawValue)"
        }
        else if lavel == 5 {
            lbCount.text = "\(SumCount) / \(LavelType.LAVELFIVE.rawValue)"
        }
        else if lavel == 6 {
            lbCount.text = "\(SumCount) / \(LavelType.LAVELSIX.rawValue)"
        }
        else if lavel == 7 {
            lbCount.text = "\(SumCount) / \(LavelType.LAVELSEVEN.rawValue)"
        }
        else if lavel == 8 {
            lbCount.text = "\(SumCount) / \(LavelType.LAVELEAIT.rawValue)"
        }
    }
    
    // 클릭수 확인
    func setLavelUp() {
        if SumCount == LavelType.LAVELONE.rawValue && lavel == 1 {
            SumCount = 0
            lavel += 1
            SaveSetting.setLavel(lavel: lavel)
            showPopup()
        }
        else if SumCount == LavelType.LAVELTWO.rawValue && lavel == 2 {
            SumCount = 0
            lavel += 1
            SaveSetting.setLavel(lavel: lavel)
            showPopup()
        }
        else if SumCount == LavelType.LAVELTHREE.rawValue && lavel == 3 {
            SumCount = 0
            lavel += 1
            SaveSetting.setLavel(lavel: lavel)
            showPopup()
        }
        else if SumCount == LavelType.LAVELFOURE.rawValue && lavel == 4 {
            SumCount = 0
            lavel += 1
            SaveSetting.setLavel(lavel: lavel)
            showPopup()
        }
        else if SumCount == LavelType.LAVELFIVE.rawValue && lavel == 5 {
            SumCount = 0
            lavel += 1
            SaveSetting.setLavel(lavel: lavel)
            showPopup()
        }
        else if SumCount == LavelType.LAVELSIX.rawValue && lavel == 6 {
            SumCount = 0
            lavel += 1
            SaveSetting.setLavel(lavel: lavel)
            showPopup()
        }
        else if SumCount == LavelType.LAVELSEVEN.rawValue && lavel == 7 {
            SumCount = 0
            lavel += 1
            SaveSetting.setLavel(lavel: lavel)
            showPopup()
        }
        else if SumCount == LavelType.LAVELEAIT.rawValue && lavel == 8 {
            SumCount = 0
            lavel += 1
            SaveSetting.setLavel(lavel: lavel)
            showPopup()
        }
        
        SaveSetting.setClickValue(value: SumCount)
        lbLavel.text = "\(lavel)"
    }
    
    
    // 확률적 heart 등장
    func heartVisiblite() {
        if SumCount % 30 == 0 {
            let ranNum = Int.random(in: 0...10)
            print(ranNum)
            
            if ranNum % 2 == 0 {
                ivClickHeart.isHidden = false
            }
        }
    }
    
    func showPopup() {
        let newController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "letterpop")
        newController.modalPresentationStyle = .overCurrentContext
        
        self.present(newController, animated: true)
    }
    
}
