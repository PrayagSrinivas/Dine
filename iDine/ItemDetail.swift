//
//  ItemDetail.swift
//  iDine
//
//  Created by Srinivas Sahu on 16/11/21.
//

import SwiftUI
import AlertToast

struct LargeButtonStyle: ButtonStyle {
    
    let backgroundColor: Color
    let foregroundColor: Color
    let isDisabled: Bool
    
    func makeBody(configuration: Self.Configuration) -> some View {
        let currentForegroundColor = isDisabled || configuration.isPressed ? foregroundColor.opacity(0.3) : foregroundColor
        return configuration.label
            .padding()
            .foregroundColor(currentForegroundColor)
            .background(isDisabled || configuration.isPressed ? backgroundColor.opacity(0.3) : backgroundColor)
        // This is the key part, we are using both an overlay as well as cornerRadius
            .cornerRadius(6)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
            .padding([.top, .bottom], 10)
            .font(Font.system(size: 19, weight: .semibold))
    }
}
struct ItemDetail: View {
    @EnvironmentObject var order:Order
    @State private var showToast = false
    let item:MenuItem
    var body: some View {
        VStack{
            //MARK: IMAGE AND PHOTO CREDIT INFO STACKING
            ZStack(alignment:.bottomTrailing){
                Image(item.mainImage)
                    .resizable()
                    .scaledToFit()
                Text("Photo: \(item.photoCredit)")
                    .padding(4)
                    .background(Color.black)
                    .font(.caption)
                    .foregroundColor(.white)
                    .offset(x:-5,y:-5)
            }
            
            //MARK: ITEM DESCRIPTION
            Text(item.description)
                .padding()
                .font(.system(size: 20))
            Button("Add to cart"){
                showToast.toggle()
                order.add(item: item)
            }
            .buttonStyle(LargeButtonStyle(backgroundColor: Color.gray,
                                          foregroundColor: Color.white,
                                          isDisabled: false))
            .foregroundColor(Color.black)
            .toast(isPresenting: $showToast){
                AlertToast(type: .complete(Color.black), title: "Added", subTitle:"")
            }
            Spacer()
        }
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ItemDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            ItemDetail(item: MenuItem.example)
                .environmentObject(Order())
        }
    }
}
