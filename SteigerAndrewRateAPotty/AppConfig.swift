//
//  AppConfig.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import Foundation

class AppConfig {
    
    
    struct RatingTypes {
        static let accessibility: String = "Accessibility"
        static let cleanliness: String = "Cleanliness"
        static let atmosphere: String = "Atmosphere"
    }
    
    
}

struct Potty {
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
