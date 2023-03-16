//
//  AppConfig.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import Foundation
import UIKit

// MARK: - AppConfig
/// Used to configure app specific constants, states
class AppConfig {
    struct RatingTypes {
        static let accessibility: String = "Accessibility"
        static let cleanliness: String = "Cleanliness"
        static let atmosphere: String = "Atmosphere"
    }
    
    struct InitialStates {
        static let pottyInitialState: Potty = Potty(id: "", details: [0, 0, 0, 0, 0, 0, 0], ratings: [], latitude: 0.0, longitude: 0.0, title: "", snippet: "", iconView: AppAssets.ImageViews.RestAreaView35)
    }
    
}

// MARK: - UIButton CheckBox
class CheckBox: UIButton {
    private var isCBDisabled: Bool = false
    
    var isChecked: Bool = false {
        didSet {
            //this can be set to some color to make it visible in IB
            self.backgroundColor = UIColor.clear
            if isChecked == true {
                self.setImage(AppAssets.Icons.CheckBoxChecked, for: .normal)
            } else {
                self.setImage(AppAssets.Icons.CheckBoxUnchecked, for: .normal)
            }
            self.contentVerticalAlignment = .fill
            self.contentHorizontalAlignment = .fill
        }
    }
        
    override func awakeFromNib() {
        self.addTarget(self, action:#selector(buttonClicked(sender:)), for: .touchUpInside)
        self.isChecked = false
    }
    
    func isDisabled(_ disable: Bool) {
        if disable {
            isCBDisabled = true
        }
        else {
            isCBDisabled = false
        }
    }
        
    @objc func buttonClicked(sender: UIButton) {
        if isCBDisabled { return }
        if sender == self {
            isChecked = !isChecked
        }
    }
}

// MARK: - struct Potty
struct Potty {
    var id: String
    var details: [Int]
    var ratings: [PottyReview]
    var owner: String?
    
    //GoogleMaps Marker properties
    var latitude: Double
    var longitude: Double
    var title: String
    var snippet: String
    var iconView: UIImageView
    
    /// Gets the average rating on a potty, using the local `ratings` object of type `[PottyReview]`
    ///
    /// - Parameters:
    ///   - ratingType: A string to represent the `RatingTypes`, default value will return average of all `RatingTypes`
    /// - Returns: A `Double` of the average `RatingTypes` specified
    func getAverageRating(_ ratingType: String) -> Double {
        var totalValue: Double = 0.0
        var totalCount: Int = 0
        for i in 0..<ratings.count {
            switch (ratingType) {
            case AppConfig.RatingTypes.accessibility:
                totalValue += Double(ratings[i].ratingAccessibility)
                totalCount += 1
            case AppConfig.RatingTypes.cleanliness:
                totalValue += Double(ratings[i].ratingCleanliness)
                totalCount += 1
            case AppConfig.RatingTypes.atmosphere:
                totalValue += Double(ratings[i].ratingAtmosphere)
                totalCount += 1
            default:
                //get average overall rating
                totalValue += Double(ratings[i].ratingAccessibility + ratings[i].ratingCleanliness + ratings[i].ratingAtmosphere) / 3.0
            }
        }
        return (totalValue / Double(ratings.count))
    }
    
    func getTopRated() -> PottyReview? {
        var highestRatedReviewId: String = ""
        var highestRatedLikes: Int = 0
        for i in 0..<ratings.count {
            if highestRatedLikes <= ratings[i].upVotes {
                highestRatedReviewId = ratings[i].id
                highestRatedLikes = ratings[i].upVotes
            }
        }
        return getReview(highestRatedReviewId)
    }
    
    func getReview(_ id: String) -> PottyReview? {
        for i in 0..<ratings.count {
            if ratings[i].id == id {
                return ratings[i]
            }
        }
        return nil
    }
}

// MARK: - struct PottyReview
struct PottyReview {
    var id: String
    var author: String
    var dateTimeCreated: Date?
    var ratingAccessibility: Double
    var ratingCleanliness: Double
    var ratingAtmosphere: Double
    var comment: String
    var upVotes: Int
    var downVotes: Int
    // represents whether a user:
    // nil: did not cast a vote
    // false: voted down
    // true: voted up
    var userCastVote: Bool?
    
    /// Gets the average rating on a review, using the local `ratings` object of type `[PottyReview]`
    ///
    /// - Returns: An `Int` of all the `RatingTypes`
    func getAverageRating() -> Double {
        return Double((ratingAccessibility + ratingCleanliness + ratingAtmosphere) / 3.0)
    }
}

struct AppAssets {
    
    // MARK: - AppAssets.Icons
    ///UIImages
    struct Icons {
        static let StarEmpty = UIImage(named:"StarEmpty")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        static let StarFull = UIImage(named:"StarFull")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.starYellow)
        static let ThumbUp = UIImage(named:"ThumbUp")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(.systemGray)
        static let ThumbDown = UIImage(named:"ThumbDown")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(.systemGray)
        static let ThumbUpSelected = UIImage(named:"ThumbUp")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(.systemBlue)
        static let ThumbDownSelected = UIImage(named:"ThumbDown")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(.systemBlue)
        static let RestArea = UIImage(named:"RestArea")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        static let PortaPotty = UIImage(named:"PortaPotty")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        static let ZoomIn = UIImage(named:"ZoomIn")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.systemBlue)
        static let ZoomOut = UIImage(named:"ZoomOut")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.systemBlue)
        static let NewMarker = UIImage(named:"NewMarker")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.systemBlue)
        static let CheckBoxChecked = UIImage(named:"Checkbox")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.systemBlue)
        static let CheckBoxUnchecked = UIImage(named:"Checkbox")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.lightGray)
    }
    
    // MARK: - AppAssets.ImageViews
    ///UIImageViews
    struct ImageViews {
        static var RestAreaView35: UIImageView {
            get {
                let ivFrame = CGRect(x: 0, y: 0, width: 35, height: 35)
                let ivReturn = UIImageView(image: Icons.RestArea)
                ivReturn.frame = ivFrame
                return ivReturn
            }
        }
        static var PortaPottyView35: UIImageView {
            get {
                let ivFrame = CGRect(x: 0, y: 0, width: 35, height: 35)
                let ivReturn = UIImageView(image: Icons.PortaPotty)
                ivReturn.frame = ivFrame
                return ivReturn
            }
        }
        static var ZoomIn40: UIImageView {
            get {
                let ivFrame = CGRect(x: 0, y: 0, width: 40, height: 40)
                let ivReturn = UIImageView(image: Icons.ZoomIn)
                ivReturn.frame = ivFrame
                ivReturn.contentMode = .scaleAspectFit
                return ivReturn
            }
        }
        static var ZoomOut40: UIImageView {
            get {
                let ivFrame = CGRect(x: 0, y: 0, width: 40, height: 40)
                let ivReturn = UIImageView(image: Icons.ZoomOut)
                ivReturn.frame = ivFrame
                return ivReturn
            }
        }
        static var NewMarker35: UIImageView {
            get {
                let ivFrame = CGRect(x: 0, y: 0, width: 35, height: 35)
                let ivReturn = UIImageView(image: Icons.NewMarker)
                ivReturn.frame = ivFrame
                return ivReturn
            }
        }
    }
}

// MARK: - DrawBorderLayer
/// Create a rounded border for a given view.
///
/// Example usage:
///
/// uiview.layoutIfNeeded() // use before call if view frame is dynamic
///
/// uiview.layer.addSublayer(DrawBorderLayer(view, 12))
///
/// - Parameters:
///   - originView: The parent view to receive the border.
///   - inset: The amount to inset for each side, from the parent view frame
/// - Returns: A `CAShapeLayer` which represents a gray border and can be added as a SubView
func DrawBorderLayer(_ originView: UIView, inset: CGFloat) -> CAShapeLayer {
    let grayRoundBorderLayer: CAShapeLayer = CAShapeLayer()
    
    let bezierPath = UIBezierPath(roundedRect: CGRect(x: originView.bounds.origin.x + inset, y: originView.bounds.origin.y + inset, width: originView.bounds.size.width - inset*2, height: originView.bounds.size.height - inset*2), cornerRadius: 8)
    grayRoundBorderLayer.path = bezierPath.cgPath
    grayRoundBorderLayer.strokeColor = UIColor.cgGray
    grayRoundBorderLayer.fillColor = UIColor.clear.cgColor
    grayRoundBorderLayer.lineWidth = 1
    grayRoundBorderLayer.needsDisplayOnBoundsChange = true
    return grayRoundBorderLayer
}

// MARK: - struct AlertActions
struct AlertActions {
    //define actions available
    static let cancelAction =
    UIAlertAction(title: "Cancel",
                  style: .cancel,
                  handler: nil)
    static let okAction =
    UIAlertAction(title: "Ok",
                  style: .default)
}
