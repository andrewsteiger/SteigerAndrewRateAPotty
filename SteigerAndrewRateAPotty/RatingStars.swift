//
//  RatingStars.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/24/23.
//

import UIKit

class RatingStars: UIView {
    let star1 = UIButton()
    var star1On: Bool = false
    let star2 = UIButton()
    var star2On: Bool = false
    let star3 = UIButton()
    var star3On: Bool = false
    let star4 = UIButton()
    var star4On: Bool = false
    let star5 = UIButton()
    var star5On: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    /// Setup the `RatingStars` view
    ///
    /// - Parameters:
    ///   - originView: The parent view to receive the border.
    ///   - inset: The amount to inset for each side, from the parent view frame
    /// - Returns: A `CAShapeLayer` which represents a gray border and can be added as a SubView
    private func setupView() {
        // create the ratings stars
        star1.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        star1.setImage(AppIcons.StarEmpty, for: .normal)
        star1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star1.tintColor = UIColor.starGray
        self.addSubview(star1)
        star2.frame = CGRect(x: 20, y: 0, width: 25, height: 25)
        star2.setImage(AppIcons.StarEmpty, for: .normal)
        star2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star2.tintColor = UIColor.starGray
        self.addSubview(star2)
        star3.frame = CGRect(x: 40, y: 0, width: 25, height: 25)
        star3.setImage(AppIcons.StarEmpty, for: .normal)
        star3.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star3.tintColor = UIColor.starGray
        self.addSubview(star3)
        star4.frame = CGRect(x: 60, y: 0, width: 25, height: 25)
        star4.setImage(AppIcons.StarEmpty, for: .normal)
        star4.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star4.tintColor = UIColor.starGray
        self.addSubview(star4)
        star5.frame = CGRect(x: 80, y: 0, width: 25, height: 25)
        star5.setImage(AppIcons.StarEmpty, for: .normal)
        star5.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star5.tintColor = UIColor.starGray
        self.addSubview(star5)
        
        // set this so that background blends with parent view background i.e. tableview selection color
        self.backgroundColor = UIColor.opaqueBackground
    }
    
    /// Define the actions when stars inside of `RatingStars` are clicked.
    /// Checking one star will automatically check the others below it to retain a sequential selection.
    /// Unchecking one star will automatically uncheck the others above it to retain a sequential selection.
    ///
    /// - Parameters:
    ///   - sender: The star button that was selected
    @objc func buttonAction(sender: UIButton!) {
        if sender.tintColor == UIColor.starGray {
            switch sender {
            case star1:
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: false)
                checkStar(sender: star3, isChecked: false)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case star2:
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: false)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case star3:
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: true)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case star4:
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: true)
                checkStar(sender: star4, isChecked: true)
                checkStar(sender: star5, isChecked: false)
            case star5:
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
            switch sender {
            case star1:
                checkStar(sender: star1, isChecked: false)
                checkStar(sender: star2, isChecked: false)
                checkStar(sender: star3, isChecked: false)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case star2:
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: false)
                checkStar(sender: star3, isChecked: false)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case star3:
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: false)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case star4:
                checkStar(sender: star1, isChecked: true)
                checkStar(sender: star2, isChecked: true)
                checkStar(sender: star3, isChecked: true)
                checkStar(sender: star4, isChecked: false)
                checkStar(sender: star5, isChecked: false)
            case star5:
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
    
    /// Used to display the visual rating as defined by the parent.
    ///
    /// - Parameters:
    ///   - rating: An `Int` between 0 and 5 to denote the number of stars that should be presented as selected
    func setRating(_ rating: Int) {
        switch rating {
        case 0:
            checkStar(sender: star1, isChecked: false)
            checkStar(sender: star2, isChecked: false)
            checkStar(sender: star3, isChecked: false)
            checkStar(sender: star4, isChecked: false)
            checkStar(sender: star5, isChecked: false)
        case 1:
            checkStar(sender: star1, isChecked: true)
            checkStar(sender: star2, isChecked: false)
            checkStar(sender: star3, isChecked: false)
            checkStar(sender: star4, isChecked: false)
            checkStar(sender: star5, isChecked: false)
        case 2:
            checkStar(sender: star1, isChecked: true)
            checkStar(sender: star2, isChecked: true)
            checkStar(sender: star3, isChecked: false)
            checkStar(sender: star4, isChecked: false)
            checkStar(sender: star5, isChecked: false)
        case 3:
            checkStar(sender: star1, isChecked: true)
            checkStar(sender: star2, isChecked: true)
            checkStar(sender: star3, isChecked: true)
            checkStar(sender: star4, isChecked: false)
            checkStar(sender: star5, isChecked: false)
        case 4:
            checkStar(sender: star1, isChecked: true)
            checkStar(sender: star2, isChecked: true)
            checkStar(sender: star3, isChecked: true)
            checkStar(sender: star4, isChecked: true)
            checkStar(sender: star5, isChecked: false)
        case 5:
            checkStar(sender: star1, isChecked: true)
            checkStar(sender: star2, isChecked: true)
            checkStar(sender: star3, isChecked: true)
            checkStar(sender: star4, isChecked: true)
            checkStar(sender: star5, isChecked: true)
        default:
            checkStar(sender: star1, isChecked: false)
            checkStar(sender: star2, isChecked: false)
            checkStar(sender: star3, isChecked: false)
            checkStar(sender: star4, isChecked: false)
            checkStar(sender: star5, isChecked: false)
            
        }
    }
    
    func disable(_ shouldDisable: Bool) {
        star1.isEnabled = !shouldDisable
        star2.isEnabled = !shouldDisable
        star3.isEnabled = !shouldDisable
        star4.isEnabled = !shouldDisable
        star5.isEnabled = !shouldDisable
    }
    
    /// Checks stars, reflected by a yellow star or an empty star in the UI
    ///
    /// - Parameters:
    ///   - sender: The star button to change
    ///   - isChecked: A `Bool` to determine if the star should be checked or un-checked
    func checkStar(sender: UIButton!, isChecked: Bool) {
        if isChecked {
            sender.setImage(AppIcons.StarFull, for: .normal)
            sender.tintColor = UIColor.starYellow
        }
        else {
            sender.setImage(AppIcons.StarEmpty, for: .normal)
            sender.tintColor = UIColor.starGray
        }
    }
}
