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
              ratings: [
                PottyReview(id: "0",
                            author: "justanotherjanitor99",
                            dateTimeCreated: Date.from(year: 2022, month: 01, day: 09, hour: 20, minute: 01),
                            ratingAccessibility: 2,
                            ratingCleanliness: 3,
                            ratingAtmosphere: 4,
                            comment: "Hello, lifelong custodian here. i found this place to be pretty loud between stalls but easy to navigate for my essentials. Not very clean imo I have had my share of bad accidents but let me tell you a story bout i’d never forget. \nIt was an early autumn evening and my dog was riding shotgun when we both knew what it was time for. Right off of I71N we found this rest area that wasn’t on any signs and had to pull off immediately. \nThis was the day I met my wife.",
                            upVotes: 300,
                            downVotes: 12),
                PottyReview(id: "1",
                            author: "dogguy99",
                            dateTimeCreated: Date.from(year: 2023, month: 02, day: 14, hour: 18, minute: 01),
                            ratingAccessibility: 2,
                            ratingCleanliness: 5,
                            ratingAtmosphere: 5,
                            comment: "This place is amazing. I felt like i was in heaven if heaven was on the side of the road in back country Ohio. I’d never seen anything like this before but now I can say I have.",
                            upVotes: 3,
                            downVotes: 1648),
                PottyReview(id: "2",
                            author: "Anonymous3546",
                            dateTimeCreated: Date.from(year: 2023, month: 03, day: 24, hour: 18, minute: 01),
                            ratingAccessibility: 1,
                            ratingCleanliness: 1,
                            ratingAtmosphere: 0,
                            comment: "meh",
                            upVotes: 46,
                            downVotes: 9),
                PottyReview(id: "3",
                            author: "petboy98",
                            dateTimeCreated: Date.from(year: 2023, month: 03, day: 24, hour: 18, minute: 01),
                            ratingAccessibility: 3,
                            ratingCleanliness: 5,
                            ratingAtmosphere: 3,
                            comment: "No bathroomspace for pets for this I will deduct one star.\nMy dog was unhappy with trees deduct one star.",
                            upVotes: 5,
                            downVotes: 5),
                PottyReview(id: "4",
                            author: "ancientburro",
                            dateTimeCreated: Date.from(year: 2023, month: 03, day: 24, hour: 18, minute: 01),
                            ratingAccessibility: 1,
                            ratingCleanliness: 5,
                            ratingAtmosphere: 0,
                            comment: "This bathroom is clean",
                            upVotes: 62,
                            downVotes: 0),
                PottyReview(id: "5",
                            author: "elephantmans",
                            dateTimeCreated: Date.from(year: 2023, month: 03, day: 24, hour: 18, minute: 01),
                            ratingAccessibility: 1,
                            ratingCleanliness: 5,
                            ratingAtmosphere: 0,
                            comment: "This bathroom was so clean i let my toddler lick the floor",
                            upVotes: 22,
                            downVotes: 1),
                PottyReview(id: "6",
                            author: "elephantmans",
                            dateTimeCreated: Date.from(year: 2023, month: 03, day: 24, hour: 18, minute: 01),
                            ratingAccessibility: 1,
                            ratingCleanliness: 4,
                            ratingAtmosphere: 0,
                            comment: "I reviewed again",
                            upVotes: 0,
                            downVotes: 33),
                PottyReview(id: "7",
                            author: "momsquad4",
                            dateTimeCreated: Date.from(year: 2023, month: 03, day: 24, hour: 18, minute: 01),
                            ratingAccessibility: 0,
                            ratingCleanliness: 0,
                            ratingAtmosphere: 0,
                            comment: "nasty",
                            upVotes: 5,
                            downVotes: 3),
                PottyReview(id: "8",
                            author: "al",
                            dateTimeCreated: Date.from(year: 2023, month: 03, day: 24, hour: 18, minute: 01),
                            ratingAccessibility: 1,
                            ratingCleanliness: 1,
                            ratingAtmosphere: 1,
                            comment: "",
                            upVotes: 0,
                            downVotes: 3),
                PottyReview(id: "9",
                            author: "eggman",
                            dateTimeCreated: Date.from(year: 2023, month: 03, day: 24, hour: 18, minute: 01),
                            ratingAccessibility: 2,
                            ratingCleanliness: 2,
                            ratingAtmosphere: 2,
                            comment: "A little bit of an afterthought when it comes to this place",
                            upVotes: 4,
                            downVotes: 12),
                PottyReview(id: "10",
                            author: "benedictarnold4",
                            dateTimeCreated: Date.from(year: 2023, month: 03, day: 24, hour: 18, minute: 01),
                            ratingAccessibility: 2,
                            ratingCleanliness: 4,
                            ratingAtmosphere: 4,
                            comment: "excellent",
                            upVotes: 0,
                            downVotes: 0),
                PottyReview(id: "11",
                            author: "therealfrankzappa",
                            dateTimeCreated: Date.from(year: 2023, month: 03, day: 24, hour: 18, minute: 01),
                            ratingAccessibility: 2,
                            ratingCleanliness: 4,
                            ratingAtmosphere: 4,
                            comment: "i was here",
                            upVotes: 0,
                            downVotes: 0),
              ],
              owner: "johnthejanitor",
              latitude: -30.86,
              longitude: 150.20,
              title: "Desert Paradise",
              snippit: "Australia",
              iconView: AppAssets.ImageViews.RestAreaView35),
        Potty(id: 1,
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
              ],
              latitude: -30.16,
              longitude: 151.20,
              title: "Desert Tundra",
              snippit: "Australia",
              iconView: AppAssets.ImageViews.PortaPottyView35),
    ]
}
