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
  
  var body: some View {
  
    self.viewModel.infiniteScrollView = self
    
    return List(myList.array, id: \.id) { listItem in
    
    // set data value into a Text View
    Text(listItem.value).onAppear(perform: {
    
        /*
        *Whenever a view appears we check if the view appearing is the last
        *view and get more items if it is the last view
        */
        let index = self.myList.array.firstIndex(where: { $0.id == listItem.id })!
        let count = self.myList.array.count

        /*
        *Check if row being added is the last row and get more items.
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    InfiniteScrollView()
  }
  
}
