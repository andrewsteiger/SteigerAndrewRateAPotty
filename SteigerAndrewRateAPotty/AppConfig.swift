//
//  AppConfig.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import Foundation
import UIKit

class AppConfig {
    struct RatingTypes {
        static let accessibility: String = "Accessibility"
        static let cleanliness: String = "Cleanliness"
        static let atmosphere: String = "Atmosphere"
    }
    
    struct InitialStates {
        static let pottyInitialState: Potty = Potty(id: -1, latitude: 0.0, longitude: 0.0, ratings: [])
    }
    
}

struct Potty {
    var id: Int
    var latitude: Double
    var longitude: Double
    var ratings: [PottyReview]
    var owner: String?
    
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
}

struct AppColors {
    // dont forget to divide standard rgb by 255 smh
    static let blueFocus = UIColor(red: 0.0, green: 0.506, blue: 0.541, alpha: 1.0)
    static let blueDark = UIColor(red: 0.059, green: 0.298, blue: 0.459, alpha: 1.0);
    static let blueLight = UIColor(red: 0.859, green: 0.929, blue: 0.953, alpha: 1.0);
    static let bluePurple = UIColor(red: 0.157, green: 0.192, blue: 0.286, alpha: 1.0);
    static let starYellow = UIColor(red: 0.961, green: 0.725, blue: 0.259, alpha: 1.0)
    static let starGray = UIColor(red: 0.294, green: 0.294, blue: 0.294, alpha: 1.0)
    
    static let cgGray = CGColor(red: 0, green: 0, blue: 0, alpha: 0.5)
}

struct AppIcons {
    static let StarEmpty = UIImage(named:"StarEmpty")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
    static let StarFull = UIImage(named:"StarFull")?.withRenderingMode(UIImage.RenderingMode.alwaysTemplate).withTintColor(UIColor.yellow)
}

func DrawBorderLayer(_ originView: UIView, inset: CGFloat) -> CAShapeLayer {
    let grayRoundBorderLayer: CAShapeLayer = CAShapeLayer()
    
    let bezierPath = UIBezierPath(roundedRect: CGRect(x: originView.frame.origin.x + inset, y: originView.frame.origin.y + inset, width: originView.frame.size.width - inset*2, height: originView.frame.size.height - inset*2), cornerRadius: 8)
    originView.backgroundColor = UIColor.clear
    
    grayRoundBorderLayer.path = bezierPath.cgPath
    grayRoundBorderLayer.frame = originView.bounds
    grayRoundBorderLayer.strokeColor = AppColors.cgGray
    grayRoundBorderLayer.fillColor = UIColor.clear.cgColor
    grayRoundBorderLayer.lineWidth = 1
    return grayRoundBorderLayer
}
