//
//  ContentView.swift
//  InfiniteScrollTutorial
//
//  Created by mac on 25/09/2019.
//  Copyright © 2019 mac. All rights reserved.
//

import SwiftUI

struct InfiniteScrollView: View {
    
    @ObservedObject var myList = ObservableArray<Data>(array: [Data(value: "Infinite Scroll", id: 0)])
    
    let viewModel = InfiniteScrollViewModel(infiniteScrollRepo: InfiniteScrollRepository())
    
    var body: some View {
        self.viewModel.infiniteScrollView = self
        self.viewModel.getNewItems(currentListSize: 0)
        return List(myList.array, id: \.id) { listItem in
            Text(listItem.value).onAppear(perform: {
                let index = self.myList.array.firstIndex(where: { $0.id == listItem.id })!
                let count = self.myList.array.count
                if index == count-1 {
                    
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
