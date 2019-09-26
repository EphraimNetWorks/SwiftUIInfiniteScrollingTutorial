//
//  InfiniteScrollViewModel.swift
//  InfiniteScrollTutorial
//
//  Created by mac on 25/09/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import Foundation
import RxSwift

class InfiniteScrollViewModel {

  let infiniteScrollRepo : InfiniteScrollRepository
  var infiniteScrollView: InfiniteScrollView? = nil
  let disposeBag = DisposeBag()

  init (infiniteScrollRepo : InfiniteScrollRepository){

    self.infiniteScrollRepo = infiniteScrollRepo

    // subscribe and start listening for changes in our data
    self.infiniteScrollRepo.listObservable.subscribe({ newList in

      // update list in our View class whenever list changes
      self.updateListItems(list: newList.element)
                                                      
    }).disposed(by: disposeBag)

  }

  func getNewItems(currentListSize: Int){

    // fetch new list items
    infiniteScrollRepo.fetchListItems(currentListSize: currentListSize)

  }
  
  func updateListItems(list: [Data]?){
    if list != nil && !list!.isEmpty{
      // append new lists to the bottom of the list we already have
      infiniteScrollView?.myList.array.append(contentsOf: list!)
    }
  }
  
}
