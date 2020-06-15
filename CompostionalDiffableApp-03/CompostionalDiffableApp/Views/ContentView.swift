//
//  ContentView.swift
//  CompostionalDiffableApp
//
//  Created by yongzhan on 2020/6/14.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameStoreController()
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .onAppear {
                GameStore.shared.fetchGame(with: .games) { (result) in
                    switch result {
                    case .success(let games):
                        print(games.count)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
        }
    }
}
