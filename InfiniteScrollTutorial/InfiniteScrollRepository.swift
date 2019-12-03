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
  
  // this is an observable which holds our data
  let listObservable = BehaviorSubject<[Data]>(value: [])
  

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
