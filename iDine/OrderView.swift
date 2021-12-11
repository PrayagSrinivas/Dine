//
//  OrderView.swift
//  iDine
//
//  Created by Srinivas Sahu on 18/11/21.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var order:Order
    var body: some View {
        NavigationView{
            //MARK: ORDER INFO
            List{
                //MARK: SECTION FOR ORDER ITEM ROWS
                Section{
                    ForEach(order.items){item in
                        HStack{
                            Text(item.name)
                            Spacer()
                            Text("$\(item.price)")
                        }
                    }
                    .onDelete(perform: deletaItems)
                }
                //MARK: SECTION FOR PLACE HOLDER
                Section{
                    NavigationLink(destination:CheckOutView()){
                        Text("Place order")
                    }
                }
                .disabled(order.items.isEmpty)
            }
            .navigationTitle("Order")
            .listStyle(InsetGroupedListStyle())
            .toolbar{
                EditButton()
            }
        }
    }
    func deletaItems(at offsets:IndexSet){
        order.items.remove(atOffsets: offsets)
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView()
            .environmentObject(Order())
    }
}
