//
//  ObservableArray.swift
//  InfiniteScrollTutorial
//
//  Created by mac on 25/09/2019.
//  Copyright © 2019 mac. All rights reserved.
//
import Foundation
import Combine

class ObservableArray<T>: ObservableObject {
    
    var cancellables = [AnyCancellable]()
    
    @Published var array:[T] = []
    
    init(array: [T])  {
        
        self.array = array
        
    }
    
    func observeChildrenChanges<K>(_ type:K.Type) throws ->ObservableArray<T> where K : ObservableObject{
        let array2 = array as! [K]
        array2.forEach({
            let c = $0.objectWillChange.sink(receiveValue: { _ in self.objectWillChange.send() })

            // Important: You have to keep the returned value allocated,
            // otherwise the sink subscription gets cancelled
            self.cancellables.append(c)
        })
        return self
    }
}