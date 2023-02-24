//
//  AppData.swift
//  SteigerAndrewRateAPotty
//
//  Created by asteiger on 2/23/23.
//

import Foundation

class AppData {
    private var _AppPotties: [Potty]
    var AppPotties: [Potty] {
        return _AppPotties
    }
    
    init() {
        self._AppPotties = PottyDataSet
    }
    
    func getAllPottys() -> [Potty] {
        return PottyDataSet
    }
    
    func getPottyByID(_ id: Int) -> Potty {
        for i in 0...AppPotties.count - 1 {
            if AppPotties[i].id == id {
                return AppPotties[i]
            }
        }
        return AppConfig.InitialStates.pottyInitialState
    }
    
    // mock data sets
    let PottyDataSet: [Potty] = [
        Potty(id: 0,
              latitude: 1.1,
              longitude: 1.2,
              ratings: [
                PottyReview(id: "0",
                            author: "justanotherjanitor",
                            dateTimeCreated: Date.from(year: 2022, month: 01, day: 09, hour: 12, minute: 01),
                            ratingAccessibility: 2,
                            ratingCleanliness: 3,
                            ratingAtmosphere: 0,
                            comment: "some comment",
                            upVotes: 30,
                            downVotes: 12),
                PottyReview(id: "1",
                            author: "dogguy99",
                            dateTimeCreated: Date.from(year: 2023, month: 02, day: 14, hour: 18, minute: 01),
                            ratingAccessibility: 4,
                            ratingCleanliness: 5,
                            ratingAtmosphere: 2,
                            comment: "some comment",
                            upVotes: 3,
                            downVotes: 1),
              ]),
        Potty(id: 1,
              latitude: 2.1,
              longitude: 3.2,
              ratings: [
                PottyReview(id: "0",
                            author: "justanotherjanitor",
                            dateTimeCreated: Date.from(year: 2022, month: 09, day: 14, hour: 12, minute: 12),
                            ratingAccessibility: 5,
                            ratingCleanliness: 5,
                            ratingAtmosphere: 5,
                            comment: "some comment",
                            upVotes: 3,
                            downVotes: 1)
              ]),
    ]
}
