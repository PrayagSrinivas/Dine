//
//  MainView.swift
//  iDine
//
//  Created by Srinivas Sahu on 18/11/21.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            //MARK: TAB VIEW FOR MENU
            ContentView()
                .tabItem {
                    Label("Menu Item",systemImage: "list.dash")
                }
            //MARK: TAB VIEW FOR ORDER
            OrderView()
                .tabItem {
                Label("Order",systemImage: "square.and.pencil")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Order())
    }
}
