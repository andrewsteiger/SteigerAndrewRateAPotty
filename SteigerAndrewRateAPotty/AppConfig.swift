//
//  AppConfig.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import Foundation
import UIKit

/// Used to configure app specific constants, states
class AppConfig {
    struct RatingTypes {
        static let accessibility: String = "Accessibility"
        static let cleanliness: String = "Cleanliness"
        static let atmosphere: String = "Atmosphere"
    }
    
    struct InitialStates {
        static let pottyInitialState: Potty = Potty(id: -1, ratings: [], owner: nil, latitude: 0.0, longitude: 0.0, title: "", snippit: "", iconView: AppAssets.ImageViews.RestAreaView35)
    }
    
}

struct Potty {
    var id: Int
    var ratings: [PottyReview]
    var owner: String?
    
    //GoogleMaps Marker properties
    var latitude: Double
    var longitude: Double
    var title: String
    var snippit: String
    var iconView: UIImageView
    
    /// Gets the average rating on a potty, using the local `ratings` object of type `[PottyReview]`
    ///
    /// - Parameters:
    ///   - ratingType: A string to represent the `RatingTypes`, default value will return average of all `RatingTypes`
    /// - Returns: A `Double` of the average `RatingTypes` specified
    func getAverageRating(_ ratingType: String) -> Double {
        var totalValue: Double = 0.0
        var totalCount: Int = 0
        for i in 0...ratings.count - 1 {
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
                // get average overall rating
                totalValue += Double(ratings[i].ratingAccessibility + ratings[i].ratingCleanliness + ratings[i].ratingAtmosphere) / 3.0
            }
        }
        return (totalValue / Double(ratings.count))
    }
    
    func getTopRated() -> PottyReview? {
        var highestRatedReviewId: String = ""
        var highestRatedLikes: Int = 0
        for i in 0...ratings.count - 1 {
            if highestRatedLikes <= ratings[i].upVotes {
                highestRatedReviewId = ratings[i].id
                highestRatedLikes = ratings[i].upVotes
            }
        }
        return getReview(highestRatedReviewId)
    }
    
    func getReview(_ id: String) -> PottyReview? {
        for i in 0...ratings.count - 1 {
            if ratings[i].id == id {
                return ratings[i]
            }
        }
        return nil
    }
}

struct PottyReview {
    var id: String
    var author: String
    var dateTimeCreated: Date?
    var ratingAccessibility: Int
    var ratingCleanliness: Int
    var ratingAtmosphere: Int
    var comment: String
    var upVotes: Int
    var downVotes: Int
    
    /// Gets the average rating on a review, using the local `ratings` object of type `[PottyReview]`
    ///
    /// - Returns: An `Int` of all the `RatingTypes`
    func getAverageRating() -> Int {
        return Int(Double(ratingAccessibility + ratingCleanliness + ratingAtmosphere) / 3.0)
    }
}

struct AppAssets {
    //UIImages
    struct Icons {
        static let StarEmpty = UIImage(named:"StarEmpty")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        static let StarFull = UIImage(named:"StarFull")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.yellow)
        static let ThumbUp = UIImage(named:"ThumbUp")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.blueFocus)
        static let ThumbDown = UIImage(named:"ThumbDown")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.blueFocus)
        static let RestArea = UIImage(named:"RestArea")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        static let PortaPotty = UIImage(named:"PortaPotty")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        static let ZoomIn = UIImage(named:"ZoomIn")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.blueFocus)
        static let ZoomOut = UIImage(named:"ZoomOut")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal).withTintColor(UIColor.blueFocus)
    }
    
    //UIImageViews
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
    }
}

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
    
    let bezierPath = UIBezierPath(roundedRect: CGRect(x: originView.bounds.origin.x + inset, y: originView.bounds.origin.y + inset, width: originView.frame.size.width - inset*2, height: originView.frame.size.height - inset*2), cornerRadius: 8)
    originView.backgroundColor = UIColor.clear
    
    grayRoundBorderLayer.path = bezierPath.cgPath
    grayRoundBorderLayer.strokeColor = UIColor.cgGray
    grayRoundBorderLayer.fillColor = UIColor.white.cgColor
    grayRoundBorderLayer.lineWidth = 1
    grayRoundBorderLayer.needsDisplayOnBoundsChange = true
    return grayRoundBorderLayer
}
