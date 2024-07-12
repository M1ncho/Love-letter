//
//  SettingViewController.swift
//  Love letter
//
//  Created by KJW on 2022/07/18.
//

import UIKit
import Foundation

class SettingViewController: UIViewController {
    
    @IBOutlet weak var ivClose: UIImageView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var tapmenuView: UICollectionView!
    @IBOutlet weak var roomsetView: UITableView!
    @IBOutlet weak var SetView: UIView!
    
    let indicaterView = UIView()       // 탭 메뉴 인디케이터
    var selectedIndex = 0
    
    let menu = ["벽지", "바닥", "창문"]
    let wallManu = ["wall", "indigowall", "pattenWall", "wallDeco"]
    let plowerMenu = ["plower", "woodplower", "whiteplower"]
    let windowMenu = ["window", "redwindow"]
    
    let wallName = ["분홍벽지", "남색벽지", "꽃무늬 벽지", "몰딩 꽃무늬 벽지"]
    let plowerName = ["일반 타일", "나무 타일", "흰색 나무 타일"]
    let windowName = ["아침 창문", "노을 창문"]
    
    var wallBuyManu: [String] = []
    var plowerBuyMenu: [String] = []
    var windowBuyMenu: [String] = []
    var nowWall: String = ""
    var nowPlower: String = ""
    var nowWindow: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SetView.layer.cornerRadius = 20
        tapmenuView.backgroundColor = UIColor.white
        roomsetView.backgroundColor = UIColor.white
        
        wallBuyManu = SaveSetting.getWallList()
        plowerBuyMenu = SaveSetting.getPlowerList()
        windowBuyMenu = SaveSetting.getWindowList()
        
        nowWall = SaveSetting.getWallValue()
        nowPlower = SaveSetting.getPlowerValue()
        nowWindow = SaveSetting.getWindowValue()
        
        
        tapmenuView.delegate = self
        tapmenuView.dataSource = self
        
        roomsetView.delegate = self
        roomsetView.dataSource = self
        
        
        indicaterView.backgroundColor = UIColor.init(named: "coralpink")
        let width = menuView.frame.width / 3 - 1
        let yposition = tapmenuView.frame.height
        indicaterView.frame = CGRect(x: 0, y: yposition, width: width, height: 2)
        menuView.addSubview(indicaterView)
        
        
        let tapClose = UITapGestureRecognizer.init(target: self, action: #selector(clickClose(_:)))
        ivClose.addGestureRecognizer(tapClose)
    }
    
    
    // MARK: - Objc function
    @objc func clickClose(_ tap: UITapGestureRecognizer) {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("dismissSet"), object: nil)
        }
    }
    
    
    // MARK: - Function
    func UseProduct(index: Int) {
        if selectedIndex == 0 {
            SaveSetting.setWallValue(value: wallBuyManu[index])
        }
        else if selectedIndex == 1 {
            SaveSetting.setPlowerValue(value: plowerBuyMenu[index])
        }
        else {
            SaveSetting.setWindowValue(value: windowBuyMenu[index])
        }
        
        nowWall = SaveSetting.getWallValue()
        nowPlower = SaveSetting.getPlowerValue()
        nowWindow = SaveSetting.getWindowValue()
        
        roomsetView.reloadData()
    }
    
}





// MARK: - Extension
extension SettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = tapmenuView.dequeueReusableCell(withReuseIdentifier: "tapcell", for: indexPath) as! tapMenuCell
        
        cell.lbMenu.text = menu[indexPath.row]
        
        if selectedIndex == indexPath.row {
            cell.lbMenu.textColor = UIColor.black
        } else {
            cell.lbMenu.textColor = UIColor.lightGray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        moveIndicater(index: indexPath.row)
        
        tapmenuView.reloadData()
        roomsetView.reloadData()
    }
    
    // indicater 이동 함수
    func moveIndicater(index: Int) {
        let width = tapmenuView.frame.width / 3 - 1
        
        if index == 0 {
            UIView.animate(withDuration: 0.3, animations: { self.indicaterView.transform = CGAffineTransform(translationX: 0, y: 0)})
        }
        else if index == 1 {
            UIView.animate(withDuration: 0.3, animations: { self.indicaterView.transform = CGAffineTransform(translationX: width, y: 0)})
        }
        else {
            UIView.animate(withDuration: 0.3, animations: { self.indicaterView.transform = CGAffineTransform(translationX: width * 2, y: 0)})
        }
    }
}

extension SettingViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 3 - 1
        let size = CGSize(width: width, height: collectionView.frame.height)
        
        return size
    }
}


extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedIndex == 0 {
            return wallManu.count
        }
        else if selectedIndex == 1 {
            return plowerMenu.count
        }
        else {
            return windowMenu.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = roomsetView.dequeueReusableCell(withIdentifier: "setcell", for: indexPath) as! SettingCell
        
        cell.btnUse.layer.cornerRadius = 10
        cell.btnUse.setTitle("사용하기", for: .normal)
        cell.btnUse.backgroundColor = UIColor.init(named: "hiddenmagenta")    // hiddenmagenta
        cell.btnUse.isEnabled = false
        
        cell.useAction = { [unowned self] in
            UseProduct(index: indexPath.row)
        }
        
        
        if selectedIndex == 0 {
            cell.ivProduct.image = UIImage.init(named: "\(wallManu[indexPath.row])")
            cell.lbProduct.text = wallName[indexPath.row]
            
            if wallBuyManu.contains("\(wallManu[indexPath.row])") {
                if wallManu[indexPath.row] == nowWall {
                    cell.btnUse.setTitle("사용중", for: .normal)
                    cell.btnUse.backgroundColor = UIColor.init(named: "magenta")
                    cell.btnUse.isEnabled = false
                }
                else {
                    cell.btnUse.backgroundColor = UIColor.init(named: "magenta")
                    cell.btnUse.isEnabled = true
                }
            }
        }
        
        else if selectedIndex == 1 {
            cell.ivProduct.image = UIImage.init(named: "\(plowerMenu[indexPath.row])")
            cell.lbProduct.text = plowerName[indexPath.row]
            
            if plowerBuyMenu.contains("\(plowerMenu[indexPath.row])") {
                if plowerMenu[indexPath.row] == nowPlower {
                    cell.btnUse.setTitle("사용중", for: .normal)
                    cell.btnUse.backgroundColor = UIColor.init(named: "magenta")
                    cell.btnUse.isEnabled = false
                }
                else {
                    cell.btnUse.backgroundColor = UIColor.init(named: "magenta")
                    cell.btnUse.isEnabled = true
                }
            }
        }
        
        else {
            cell.ivProduct.image = UIImage.init(named: "\(windowMenu[indexPath.row])")
            cell.lbProduct.text = windowName[indexPath.row]
            
            if windowBuyMenu.contains("\(windowMenu[indexPath.row])") {
                if windowMenu[indexPath.row] == nowWindow {
                    cell.btnUse.setTitle("사용중", for: .normal)
                    cell.btnUse.backgroundColor = UIColor.init(named: "magenta")
                    cell.btnUse.isEnabled = false
                }
                else {
                    cell.btnUse.backgroundColor = UIColor.init(named: "magenta")
                    cell.btnUse.isEnabled = true
                }
            }
        }
        
        return cell
    }
    
}
