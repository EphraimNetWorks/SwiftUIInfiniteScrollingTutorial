//
//  InfiniteScrollRepository.swift
//  InfiniteScrollTutorial
//
//  Created by mac on 25/09/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import RxSwift

protocol InfiniteScrollRepoProtocol{
    
    func getDataArray() -> BehaviorSubject<[Data]>
    func fetchListItems(currentListSize: Int)
    
}

class InfiniteScrollRepository : InfiniteScrollRepoProtocol{
  
    // this is an observable which holds our data
    private let listObservable = BehaviorSubject<[Data]>(value: [])
    
    func getDataArray() -> BehaviorSubject<[Data]>{
        return listObservable
    }

        
    func fetchListItems(currentListSize: Int){
        var dummyList : [Data] = []
        let limit = 20
        
        // we calculate the next page's number with the size of the list we currently have
        let page = currentListSize/limit + 1
        
        // create an array of dummy data
        for index in 1...limit {
        dummyList.append(Data(value: "Page \(page) -> Item \(index)", id: index+currentListSize))
        }
        // update observable with new data
        listObservable.onNext(dummyList)
    }
  
}
