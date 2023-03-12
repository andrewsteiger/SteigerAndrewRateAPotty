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
    func getAllPottys() -> [Potty] {
        return AppData.sharedData.PottyDataSet
    }
    
    func getPottyByID(_ id: Int) -> Potty {
        for i in 0...AppData.sharedData.AppPotties.count - 1 {
            if AppData.sharedData.AppPotties[i].id == id {
                return AppData.sharedData.AppPotties[i]
            }
        }
        return AppConfig.InitialStates.pottyInitialState
    }
    
    // sorry about the nesting, again this would be server side logic and probably have more data tables to handle it
    func postVote(_ reviewId: String, increment: Bool, upVote: Bool, userCastVote: Bool?) {
        for i in 0..<AppData.sharedData.PottyDataSet.count {
            for j in 0..<AppData.sharedData.PottyDataSet[i].ratings.count {
                if AppData.sharedData.PottyDataSet[i].ratings[j].id == reviewId {
                    if increment == true {
                        // user is casting a vote
                        if upVote == true {
                            // request to increment upVote
                            if AppData.sharedData.PottyDataSet[i].ratings[j].userCastVote == false {
                                // first remove previous downVote
                                AppData.sharedData.PottyDataSet[i].ratings[j].downVotes -= 1
                            }
                        }
                        else {
                            // request to increment downVote
                            if AppData.sharedData.PottyDataSet[i].ratings[j].userCastVote == true {
                                // first remove previous upVote
                                AppData.sharedData.PottyDataSet[i].ratings[j].upVotes -= 1
                            }
                        }
                    }
                    else {
                        // user is undoing vote
                        if upVote == true {
                            // request to decrement upVote
                            if AppData.sharedData.PottyDataSet[i].ratings[j].userCastVote == true {
                                // remove previous upVote
                                AppData.sharedData.PottyDataSet[i].ratings[j].upVotes -= 1
                            }
                        }
                        else {
                            // request to decrement downVote
                            if AppData.sharedData.PottyDataSet[i].ratings[j].userCastVote == false {
                                // remove previous downVote
                                AppData.sharedData.PottyDataSet[i].ratings[j].downVotes -= 1
                            }
                        }
                    }
                    // set the new cast status
                    if let test = AppData.sharedData.PottyDataSet[i].ratings[j].userCastVote {
                        print("before: ", String(AppData.sharedData.PottyDataSet[i].ratings[j].userCastVote!))
                    }
                    else {
                        print("before: NO VOTE")
                    }
                    AppData.sharedData.PottyDataSet[i].ratings[j].userCastVote = userCastVote
                    if let test = AppData.sharedData.PottyDataSet[i].ratings[j].userCastVote {
                        print("after: ", String(AppData.sharedData.PottyDataSet[i].ratings[j].userCastVote!))
                    }
                    else {
                        print("after: NO VOTE")
                    }
                }
            }
        }
    }
    
    //get users cast vote
    func getUserCastedVote(_ reviewId: String) -> Bool? {
        for i in 0..<AppData.sharedData.PottyDataSet.count {
            for j in 0..<AppData.sharedData.PottyDataSet[i].ratings.count {
                if AppData.sharedData.PottyDataSet[i].ratings[j].id == reviewId {
                    return AppData.sharedData.PottyDataSet[i].ratings[j].userCastVote
                }
            }
        }
        return nil
    }
}
