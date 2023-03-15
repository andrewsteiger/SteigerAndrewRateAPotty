//
//  ApiClient.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 3/10/23.
//
//  Represents mock data and shared request/response models they would share
//  Assumed logic:
//  -data is sorted by highest rating
//  -potty id is unique, review id is wholly unique

import Foundation

class ApiClient {
    // MARK: - getAllPotties()
    /// Calls API to return all `Potty` objects
    func getAllPottys() -> [Potty] {
        return AppData.sharedData.AppPotties
    }
    
    // MARK: - getPottyById()
    /// Calls API to return a specific `Potty` by id
    ///
    /// - Parameters:
    ///   - id: The guid of the `Potty` to return
    func getPottyByID(_ id: String) -> Potty {
        for i in 0...AppData.sharedData.AppPotties.count - 1 {
            if AppData.sharedData.AppPotties[i].id == id {
                return AppData.sharedData.AppPotties[i]
            }
        }
        return AppConfig.InitialStates.pottyInitialState
    }
    
    // MARK: - postNewReview()
    /// Calls POST to API to create new `PottyReview`
    ///
    /// - Parameters:
    ///   - somePottyStuff: Various `PottyReview` details
    func postNewReview(_ pottyId: String, author: String, ratingAccessibility: Int, ratingCleanlines: Int, ratingAtmosphere: Int, comment: String) {
        let newPottyReview = PottyReview(
            id: "",
            author: author,
            ratingAccessibility: Double(ratingAccessibility),
            ratingCleanliness: Double(ratingCleanlines),
            ratingAtmosphere: Double(ratingAtmosphere),
            comment: comment,
            upVotes: 0,
            downVotes: 0)
        AppData.sharedData.addReview(pottyId, newReview: newPottyReview)
    }
    
    // MARK: - postNewPotty()
    /// Calls POST to API to create new `Potty`
    ///
    /// - Parameters:
    ///   - somePottyStuff: Various `Potty` details
    func postNewPotty(latitude: Double, longitude: Double, title: String, snippet: String) {
        let newPotty = Potty(
            id: "",
            ratings: [],
            latitude: latitude,
            longitude: longitude,
            title: title,
            snippet: snippet,
            iconView: AppAssets.ImageViews.RestAreaView35)
        AppData.sharedData.addPotty(newPotty)
    }
    
    // MARK: - postVote()
    /// Calls POST to API to cast a vote for a review by ID
    /// sorry about the nesting, again this would be server side logic and probably have more data tables to handle it
    ///
    /// - Parameters:
    ///   - reviewId: The guid of the review to be created
    ///   - increment: Set to `true` if increment is needed, otherwise decrement
    ///   - upVote: Set to `true` if the action is to be performed on the up vote
    ///   - userCastVote: Set to `nil` if the user is resetting to no cast vote, `true` if new vote is up vote, `false` if new vote is down vote
    func postVote(_ reviewId: String, increment: Bool, upVote: Bool, userCastVote: Bool?) {
        for i in 0..<AppData.sharedData.AppPotties.count {
            for j in 0..<AppData.sharedData.AppPotties[i].ratings.count {
                if AppData.sharedData.AppPotties[i].ratings[j].id == reviewId {
                    if increment == true {
                        //user is casting a vote
                        if upVote == true {
                            //request to increment upVote
                            if AppData.sharedData.AppPotties[i].ratings[j].userCastVote == false {
                                //first remove previous downVote
                                AppData.sharedData.incrementVote(AppData.sharedData.AppPotties[i].ratings[j].id, upVote: false, increment: false)
                            }
                        }
                        else {
                            //request to increment downVote
                            if AppData.sharedData.AppPotties[i].ratings[j].userCastVote == true {
                                //first remove previous upVote
                                AppData.sharedData.incrementVote(AppData.sharedData.AppPotties[i].ratings[j].id, upVote: true, increment: false)
                            }
                        }
                    }
                    else {
                        //user is undoing vote
                        if upVote == true {
                            //request to decrement upVote
                            if AppData.sharedData.AppPotties[i].ratings[j].userCastVote == true {
                                //remove previous upVote
                                AppData.sharedData.incrementVote(AppData.sharedData.AppPotties[i].ratings[j].id, upVote: true, increment: false)
                            }
                        }
                        else {
                            //request to decrement downVote
                            if AppData.sharedData.AppPotties[i].ratings[j].userCastVote == false {
                                //remove previous downVote
                                AppData.sharedData.incrementVote(AppData.sharedData.AppPotties[i].ratings[j].id, upVote: false, increment: true)
                            }
                        }
                    }
                    //set the new cast status
                    AppData.sharedData.setUserCastVote(reviewId, userCastVote: userCastVote)
                    return
                }
            }
        }
    }
    
    // MARK: - getUserCastedVote()
    /// Calls API to receive the userCastVote property
    ///
    /// - Parameters:
    ///   - reviewId: The guid of the review to query
    func getUserCastedVote(_ reviewId: String) -> Bool? {
        for i in 0..<AppData.sharedData.AppPotties.count {
            for j in 0..<AppData.sharedData.AppPotties[i].ratings.count {
                if AppData.sharedData.AppPotties[i].ratings[j].id == reviewId {
                    return AppData.sharedData.AppPotties[i].ratings[j].userCastVote
                }
            }
        }
        return nil
    }
}
