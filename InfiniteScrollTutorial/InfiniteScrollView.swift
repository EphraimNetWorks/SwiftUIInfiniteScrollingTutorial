//
//  ContentView.swift
//  InfiniteScrollTutorial
//
//  Created by mac on 25/09/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import SwiftUI

struct InfiniteScrollView: View {
    

    // an ObservedObject object which holds the array we populate our List with.
    @ObservedObject var myList = ObservableArray<Data>(array: [Data(value: "Infinite Scroll", id: 0)])
        
    //initialize ViewModel class which we will use to requests for data
    let viewModel = InfiniteScrollViewModel()

    init() {
        // pass viewupdateprotocol to viewmodel
        self.viewModel.viewUpdate = self
    }
    
    var body: some View {
        
        List (self.myList.array.enumerated().map({ $0 }), id: \.1.self.id) { (index,listItem) in
            // set data value into a Text View
            Text(listItem.value).onAppear(perform: {
            
                let count = self.myList.array.count

                /*
                *Whenever a view appears we check if the view appearing is the last
                *view and get more items if it is the last view.
                *In real cases you might need to increase the offset (which is in this case 1)
                *to accommodate the delay while trying to reach the *server for more data
                */
                if index == count-1 {
                  // request for more data since last row has being reached
                  self.viewModel.getNewItems(currentListSize: count)
                }
                
              })
        }
    }
}

extension InfiniteScrollView: ViewUpdateProtocol{
    func appendData(list: [Data]?) {
        self.myList.array.append(contentsOf: list!)
    }

}

protocol ViewUpdateProtocol{
    func appendData(list: [Data]?)
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    InfiniteScrollView()
  }
  
}
