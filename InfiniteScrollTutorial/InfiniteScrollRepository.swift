//
//  InfiniteScrollRepository.swift
//  InfiniteScrollTutorial
//
//  Created by mac on 25/09/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import RxSwift

class InfiniteScrollRepository {
    
    let listObservable = BehaviorSubject<[Data]>(value: [])
    
    func fetchListItems(currentListSize: Int){
        
        var dummyList : [Data] = []
        let limit = 20
        let page = currentListSize/limit + 1
        
        for index in 1...limit {
            dummyList.append(Data(value: "Page \(page) -> Item \(index)", id: index+currentListSize))
        }
        
        listObservable.onNext(dummyList)
    }
    
}
