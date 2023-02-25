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
                            author: "justanotherjanitor99",
                            dateTimeCreated: Date.from(year: 2022, month: 01, day: 09, hour: 12, minute: 01),
                            ratingAccessibility: 2,
                            ratingCleanliness: 3,
                            ratingAtmosphere: 0,
                            comment: "Hello, lifelong custodian here. i found this place to be pretty loud between stalls but easy to navigate for my essentials. Not very clean imo I have had my share of bad accidents but let me tell you a story bout i’d never forget. \nIt was an early autumn evening and my dog was riding shotgun when we both knew what it was time for. Right off of I71N we found this rest area that wasn’t on any signs and had to pull off immediately. \nThis was the day I met my wife.",
                            upVotes: 300,
                            downVotes: 12),
                PottyReview(id: "1",
                            author: "dogguy99",
                            dateTimeCreated: Date.from(year: 2023, month: 02, day: 14, hour: 18, minute: 01),
                            ratingAccessibility: 4,
                            ratingCleanliness: 5,
                            ratingAtmosphere: 2,
                            comment: "This place is amazing. I felt like i was in heaven if heaven was on the side of the road in back country Ohio. I’d never seen anything like this before but now I can say I have.",
                            upVotes: 3,
                            downVotes: 1648),
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
