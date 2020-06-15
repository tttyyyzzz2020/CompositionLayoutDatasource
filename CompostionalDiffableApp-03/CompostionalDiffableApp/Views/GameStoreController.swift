//
//  GameStoreController2.swift
//  CompostionalDiffableApp
//
//  Created by yongzhan on 2020/6/15.
//  Copyright © 2020 yongzhan. All rights reserved.
//

import SwiftUI


struct GameStoreController: UIViewControllerRepresentable {
    
    func makeUIViewController(context: Context) ->  UIViewController {
        let controller = UINavigationController(rootViewController:  MainViewController())
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

struct GameStoreController_Previews: PreviewProvider {
    static var previews: some View {
        GameStoreController()
        
    }
}
