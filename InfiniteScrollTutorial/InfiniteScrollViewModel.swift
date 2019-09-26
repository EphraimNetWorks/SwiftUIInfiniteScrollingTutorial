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
        
        self.infiniteScrollRepo.listObservable.subscribe({ newList in
            self.updateListItems(list: newList.element)
            }).disposed(by: disposeBag)
    }
    
    func setView(view: InfiniteScrollView) -> InfiniteScrollViewModel{
        self.infiniteScrollView = view
        return self
    }
    
    func getNewItems(currentListSize: Int){
        infiniteScrollRepo.fetchListItems(currentListSize: currentListSize)
    }
    
    func updateListItems(list: [Data]?){
        if list != nil && !list!.isEmpty{
            infiniteScrollView?.myList.array.append(contentsOf: list!)
        }
    }
    
}
