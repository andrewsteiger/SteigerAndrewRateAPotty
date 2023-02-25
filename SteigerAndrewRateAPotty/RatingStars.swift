//
//  RatingStars.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/24/23.
//

import UIKit

class RatingStars: UIView {
    let star1 = UIButton(type: .system)
    var star1On: Bool = false
    let star2 = UIButton(type: .system)
    var star2On: Bool = false
    let star3 = UIButton(type: .system)
    var star3On: Bool = false
    let star4 = UIButton(type: .system)
    var star4On: Bool = false
    let star5 = UIButton(type: .system)
    var star5On: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        star1.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        star1.setImage(AppIcons.StarEmpty, for: .normal)
        star1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star1.titleLabel?.text = "star1"
        star1.tintColor = AppColors.starGray
        self.addSubview(star1)
        star2.frame = CGRect(x: 20, y: 0, width: 25, height: 25)
        star2.setImage(AppIcons.StarEmpty, for: .normal)
        star2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star2.titleLabel?.text = "star2"
        star2.tintColor = AppColors.starGray
        self.addSubview(star2)
        star3.frame = CGRect(x: 40, y: 0, width: 25, height: 25)
        star3.setImage(AppIcons.StarEmpty, for: .normal)
        star3.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star3.titleLabel?.text = "star3"
        star3.tintColor = AppColors.starGray
        self.addSubview(star3)
        star4.frame = CGRect(x: 60, y: 0, width: 25, height: 25)
        star4.setImage(AppIcons.StarEmpty, for: .normal)
        star4.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star4.titleLabel?.text = "star4"
        star4.tintColor = AppColors.starGray
        self.addSubview(star4)
        star5.frame = CGRect(x: 80, y: 0, width: 25, height: 25)
        star5.setImage(AppIcons.StarEmpty, for: .normal)
        star5.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star5.titleLabel?.text = "star5"
        star5.tintColor = AppColors.starGray
        self.addSubview(star5)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        if sender.tintColor == AppColors.starGray {
            switch sender.titleLabel?.text {
            case "star1":
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: false)
                checkStar(sender: star3, isChecked: false)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case "star2":
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: false)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case "star3":
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: true)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case "star4":
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: true)
                checkStar(sender: star4, isChecked: true)
                checkStar(sender: star5, isChecked: false)
            case "star5":
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: true)
                checkStar(sender: star4, isChecked: true)
                checkStar(sender: star5, isChecked: true)
            default:
                return
            }
        }
        else {
            switch sender.titleLabel?.text {
            case "star1":
                checkStar(sender: star1, isChecked: false)
                checkStar(sender: star2, isChecked: false)
                checkStar(sender: star3, isChecked: false)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case "star2":
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: false)
                checkStar(sender: star3, isChecked: false)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case "star3":
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: false)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case "star4":
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: true)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case "star5":
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: true)
                checkStar(sender: star4, isChecked: true)
                checkStar(sender: star5, isChecked: false)
            default:
                return
            }
        }
    }
    
    func checkStar(sender: UIButton!, isChecked: Bool) {
        if isChecked {
            sender.setImage(AppIcons.StarFull, for: .normal)
            sender.tintColor = AppColors.starYellow
        }
        else {
            sender.setImage(AppIcons.StarEmpty, for: .normal)
            sender.tintColor = AppColors.starGray
        }
    }
}
