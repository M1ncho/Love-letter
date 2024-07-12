//
//  LetterViewController.swift
//  Love letter
//
//  Created by KJW on 2022/07/21.
//

import UIKit

class LetterViewController: UIViewController {

    @IBOutlet weak var letterView: UIView!
    @IBOutlet weak var ivClose: UIImageView!
    @IBOutlet weak var letterlistView: UITableView!
    @IBOutlet weak var contentView: UITextView!
    @IBOutlet weak var btnClose: UIButton!
    
    let lavel = SaveSetting.getLavel()
    let letterName = ["첫번째", "두번째", "세번째", "네번째", "다섯번쨰", "여섯번째", "일곱번째"]
    let letterNum = [LetterType.letter1.rawValue, LetterType.letter2.rawValue, LetterType.letter3.rawValue, LetterType.letter4.rawValue, LetterType.letter5.rawValue, LetterType.letter6.rawValue, LetterType.letter7.rawValue]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        letterView.layer.cornerRadius = 20
        letterlistView.backgroundColor = UIColor.white
        
        contentView.backgroundColor = UIColor.white
        contentView.textContainerInset = UIEdgeInsets(top: 8, left: 15, bottom: 5, right: 15)
        
        
        letterlistView.delegate = self
        letterlistView.dataSource = self
        
        
        let tapClose = UITapGestureRecognizer.init(target: self, action: #selector(clickClose(_:)))
        ivClose.addGestureRecognizer(tapClose)
    }
    
    
    @objc func clickClose(_ tap: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func clickBackBtn(_ sender: Any) {
        letterlistView.isHidden = false
        btnClose.isHidden = true
    }
    
}



extension LetterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lavel - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = letterlistView.dequeueReusableCell(withIdentifier: "lettercell", for: indexPath) as! LetterCell
        
        cell.lbletter.text = "\(letterName[indexPath.row]) 편지"
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        letterlistView.isHidden = true
        btnClose.isHidden = false
        contentView.text = letterNum[indexPath.row]
    }
    
}
