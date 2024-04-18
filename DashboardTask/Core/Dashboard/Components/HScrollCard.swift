//
//  HScrollCard.swift
//  DashboardTask
//
//  Created by Mohammad Haris Sofi on 17/04/24.
//

import SwiftUI

struct HScrollCard: View {
    
    let img : String
    let title : String
    let bodyText : String
    
    var body: some View {

        VStack(alignment: .leading) {
            Image(img)
                .padding(.leading , 0)
                .padding(.bottom , 10)
            Text(title)
                .font(.callout)
                .fontWeight(.bold)
                .padding(.leading , 5)

            Text(bodyText)
                .font(.callout)
                .foregroundStyle(.gray)
                .fontWeight(.medium)
                .padding(.leading , 5)

            
        }
       .padding(.horizontal)
        .frame(width: 150 , height: 140)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    HScrollCard(img: "Avatar", title: "123", bodyText: "Today's Click")
}
