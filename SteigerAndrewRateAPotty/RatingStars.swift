//
//  RatingStars.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/24/23.
//
//  Custom UIView which represents a "star rating" for a given review
//  Buttons will populate from the right
//  Width of view should be at least 100

import UIKit

class RatingStars: UIView {
    let star1 = UIButton()
    let star2 = UIButton()
    let star3 = UIButton()
    let star4 = UIButton()
    let star5 = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    /// Setup the `RatingStars` view
    func setupView() {
        let buttonDimensions: CGFloat = self.frame.height
        let buttonWidthBaseline: CGFloat = self.frame.width - buttonDimensions
        let buttonWidthActual: CGFloat = 0.875 * buttonDimensions
        let buttonHeightBaseline: CGFloat = 0
        
        // create the ratings stars
        star1.frame = CGRect(x: buttonWidthBaseline - 4 * buttonWidthActual, y: buttonHeightBaseline, width: buttonDimensions, height: buttonDimensions)
        star1.setImage(AppAssets.Icons.StarEmpty, for: .normal)
        star1.contentVerticalAlignment = .fill
        star1.contentHorizontalAlignment = .fill
        star1.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star1.tintColor = UIColor.starGray
        self.addSubview(star1)
        star2.frame = CGRect(x: buttonWidthBaseline - 3 * buttonWidthActual, y: buttonHeightBaseline, width: buttonDimensions, height: buttonDimensions)
        star2.setImage(AppAssets.Icons.StarEmpty, for: .normal)
        star2.contentVerticalAlignment = .fill
        star2.contentHorizontalAlignment = .fill
        star2.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star2.tintColor = UIColor.starGray
        self.addSubview(star2)
        star3.frame = CGRect(x: buttonWidthBaseline - 2 * buttonWidthActual, y: buttonHeightBaseline, width: buttonDimensions, height: buttonDimensions)
        star3.setImage(AppAssets.Icons.StarEmpty, for: .normal)
        star3.contentVerticalAlignment = .fill
        star3.contentHorizontalAlignment = .fill
        star3.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star3.tintColor = UIColor.starGray
        self.addSubview(star3)
        star4.frame = CGRect(x: buttonWidthBaseline - buttonWidthActual, y: buttonHeightBaseline, width: buttonDimensions, height: buttonDimensions)
        star4.setImage(AppAssets.Icons.StarEmpty, for: .normal)
        star4.contentVerticalAlignment = .fill
        star4.contentHorizontalAlignment = .fill
        star4.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star4.tintColor = UIColor.starGray
        self.addSubview(star4)
        star5.frame = CGRect(x: buttonWidthBaseline, y: buttonHeightBaseline, width: buttonDimensions, height: buttonDimensions)
        star5.setImage(AppAssets.Icons.StarEmpty, for: .normal)
        star5.contentVerticalAlignment = .fill
        star5.contentHorizontalAlignment = .fill
        star5.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        star5.tintColor = UIColor.starGray
        self.addSubview(star5)
        
        // set this so that background blends with parent view background i.e. tableview selection color
        self.backgroundColor = UIColor.opaqueBackground
    }
    
    /// Define the actions when stars inside of `RatingStars` are clicked.
    ///
    /// Checking one star will automatically check the others below it to retain a sequential selection.
    ///
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
            sender.setImage(AppAssets.Icons.StarFull, for: .normal)
            sender.tintColor = UIColor.starYellow
        }
        else {
            sender.setImage(AppAssets.Icons.StarEmpty, for: .normal)
            sender.tintColor = UIColor.starGray
        }
    }
}
