//
//  ShopViewController.swift
//  Love letter
//
//  Created by KJW on 2022/07/06.
//

import UIKit
import Foundation

class ShopViewController: UIViewController {

    @IBOutlet weak var shopView: UIView!
    @IBOutlet weak var TapMenuView: UIView!
    @IBOutlet weak var tapView: UICollectionView!
    @IBOutlet weak var ivBack: UIImageView!
    @IBOutlet weak var shoplistView: UITableView!
    
    let indicaterView = UIView()       // 탭 메뉴 인디케이터
    let menu = ["벽지", "바닥", "창문"]
    
    let wallManu = ["indigowall", "pattenWall", "wallDeco"]
    let plowerMenu = ["woodplower", "whiteplower"]
    let windowMenu = ["window", "redwindow"]
    
    let wallPrice = [5, 10, 13]
    let plowerPrice = [10, 13]
    let windowPrice = [15, 20]
    
    var wallBuyManu: [String] = []
    var plowerBuyMenu: [String] = []
    var windowBuyMenu: [String] = []
    
    var menuType = "wall"
    var selectedIndex = 0
    var heartCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heartCount = SaveSetting.getHeartCount()
        
        wallBuyManu = SaveSetting.getWallList()
        plowerBuyMenu = SaveSetting.getPlowerList()
        windowBuyMenu = SaveSetting.getWindowList()
        
        
        shopView.layer.cornerRadius = 20
        shoplistView.backgroundColor = UIColor.white
        
        indicaterView.backgroundColor = UIColor.init(named: "coralpink")
        let width = TapMenuView.frame.width / 3 - 1
        let yposition = tapView.frame.height
        indicaterView.frame = CGRect(x: 0, y: yposition, width: width, height: 2)
        TapMenuView.addSubview(indicaterView)
        
        
        tapView.delegate = self
        tapView.dataSource = self
        
        shoplistView.delegate = self
        shoplistView.dataSource = self
        
        
        let tapClose = UITapGestureRecognizer.init(target: self, action: #selector(clickBack(_:)))
        ivBack.addGestureRecognizer(tapClose)
    }
    
    
    @objc func clickBack(_ tap: UITapGestureRecognizer) {
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name("dismissShop"), object: nil)
        }
    }
    
    
    func BuyProduct(index: Int) {
        if selectedIndex == 0 {
            wallBuyManu.append(wallManu[index])
            heartCount = heartCount - wallPrice[index]
            
            SaveSetting.setWallList(value: wallBuyManu)
            SaveSetting.setHeartCount(value: heartCount)
        }
        else if selectedIndex == 1 {
            plowerBuyMenu.append(plowerMenu[index])
            heartCount = heartCount - plowerPrice[index]
            
            SaveSetting.setWallList(value: plowerBuyMenu)
            SaveSetting.setHeartCount(value: heartCount)
        }
        else {
            windowBuyMenu.append(windowMenu[index])
            heartCount = heartCount - windowPrice[index]
            
            SaveSetting.setWallList(value: windowBuyMenu)
            SaveSetting.setHeartCount(value: heartCount)
        }
        
        shoplistView.reloadData()
    }
    
    
}



// MARK: - Extension
extension ShopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.backgroundColor = UIColor.white
        let cell = tapView.dequeueReusableCell(withReuseIdentifier: "tapCell", for: indexPath) as! tapMenuCell
        
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
        
        tapView.reloadData()
        shoplistView.reloadData()
    }
    
    // indicater 이동 함수
    func moveIndicater(index: Int) {
        let width = TapMenuView.frame.width / 3 - 1
        
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



extension ShopViewController: UICollectionViewDelegateFlowLayout {
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


extension ShopViewController: UITableViewDelegate, UITableViewDataSource {
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
        let cell = shoplistView.dequeueReusableCell(withIdentifier: "shopCell", for: indexPath) as! ShopCell
        
        cell.btnBuy.layer.cornerRadius = 10
        cell.btnBuy.setTitle("구매", for: .normal)
        cell.btnBuy.backgroundColor = UIColor.init(named: "hiddenmagenta")
        cell.btnBuy.isEnabled = false
        
        cell.buyAction = { [unowned self] in
            BuyProduct(index: indexPath.row)
        }
        
        
        if selectedIndex == 0 {
            cell.ivProduct.image = UIImage.init(named: "\(wallManu[indexPath.row])")
            cell.lbProduct.text = "\(wallPrice[indexPath.row])개"
            
            if heartCount >= wallPrice[indexPath.row] {
                cell.btnBuy.backgroundColor = UIColor.init(named: "magenta")
                cell.btnBuy.isEnabled = true
            }
            if wallBuyManu.contains("\(wallManu[indexPath.row])") {
                cell.btnBuy.backgroundColor = UIColor.init(named: "hiddenmagenta")
                cell.btnBuy.isEnabled = false
                cell.btnBuy.setTitle("구매완료", for: .normal)
                cell.btnBuy.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            }
        }
        
        else if selectedIndex == 1 {
            cell.ivProduct.image = UIImage.init(named: "\(plowerMenu[indexPath.row])")
            cell.lbProduct.text = "\(plowerPrice[indexPath.row])개"
            
            if heartCount >= plowerPrice[indexPath.row] {
                cell.btnBuy.backgroundColor = UIColor.init(named: "magenta")
                cell.btnBuy.isEnabled = true
            }
            if plowerBuyMenu.contains("\(plowerMenu[indexPath.row])") {
                cell.btnBuy.backgroundColor = UIColor.init(named: "hiddenmagenta")
                cell.btnBuy.isEnabled = false
                cell.btnBuy.setTitle("구매완료", for: .normal)
                cell.btnBuy.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            }
        }
        else {
            cell.ivProduct.image = UIImage.init(named: "\(windowMenu[indexPath.row])")
            cell.lbProduct.text = "\(windowPrice[indexPath.row])개"
            
            if heartCount >= windowPrice[indexPath.row] {
                cell.btnBuy.backgroundColor = UIColor.init(named: "magenta")
                cell.btnBuy.isEnabled = true
            }
            if windowBuyMenu.contains("\(windowMenu[indexPath.row])") {
                cell.btnBuy.backgroundColor = UIColor.init(named: "hiddenmagenta")
                cell.btnBuy.isEnabled = false
                cell.btnBuy.setTitle("구매완료", for: .normal)
                cell.btnBuy.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            }
        }
        
        return cell
    }
    
}
