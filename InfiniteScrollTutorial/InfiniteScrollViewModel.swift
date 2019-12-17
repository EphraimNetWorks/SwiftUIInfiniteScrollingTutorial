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

  let infiniteScrollRepo : InfiniteScrollRepoProtocol
  var viewUpdate: ViewUpdateProtocol? = nil
  let disposeBag = DisposeBag()

  init (infiniteScrollRepo : InfiniteScrollRepoProtocol = InfiniteScrollRepository()){

    self.infiniteScrollRepo = infiniteScrollRepo

    // subscribe and start listening for changes in our data
    self.infiniteScrollRepo.getDataArray().subscribe({ [weak self] newList in

      // update list in our View class whenever list changes
      self?.updateListItems(newList: newList.element)
                                                      
    }).disposed(by: disposeBag)

  }
    

  func getNewItems(currentListSize: Int){

    // fetch new list items
    infiniteScrollRepo.fetchListItems(currentListSize: currentListSize)

  }
  
  func updateListItems(newList: [Data]?){
    if newList != nil && !newList!.isEmpty{
      // append new lists to the bottom of the list we already have
        self.viewUpdate?.appendData(list: newList)
    }
  }
  
}
