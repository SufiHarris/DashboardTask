//
//  LinksCard.swift
//  DashboardTask
//
//  Created by Mohammad Haris Sofi on 17/04/24.
//

import SwiftUI
struct LinksCard: View {
    @Environment(\.openURL) private var openURL
    @State private var showToast: Bool = false

    let linkData : Link?
    
    var body: some View {

        VStack {
            
            HStack {
                HStack{
                    AsyncImage(url: URL(string: linkData?.original_image ??  "")) { image in
                        image.image?.resizable()
                            .scaledToFit()
                            .frame(width : 40 ,height: 40)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 10).stroke(.gray , lineWidth: 0.3)
                            })
                    }
                    .padding(.trailing ,10)
                    VStack (alignment: .leading){
                        Text("https://\(linkData?.smart_link  ?? "google.com")")
                            .frame(width: 220)
                            .truncationMode(/*@START_MENU_TOKEN@*/.tail/*@END_MENU_TOKEN@*/)
                            .font(.callout)
                            .lineLimit(1)
                        Text(linkData?.created_at?.formatDate() ?? "")
                            .font(.caption)
                            .foregroundStyle(.gray)
                        
                    }
                }
                .padding(.vertical)
                Spacer()
                VStack {
                    Text("\(linkData?.total_clicks ?? 0)")
                        .font(.headline)
                    
                    Text("Clicks")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .fontWeight(.thin)
                }
            }
            .padding(.horizontal)
       
            HStack {
                Text("https://\(linkData?.smart_link  ?? "google.com")")
                    .frame(width: 200)
                    .truncationMode(.tail)
                    .lineLimit(1)
                    .onTapGesture {
                        if let url = URL(string: "https://\(linkData?.smart_link  ?? "google.com")") {
                            UIApplication.shared.openURL(url
                            )
                        }else {
                            print("cant open the li k")
                        }
                        
                    }
                Spacer()
                Image("copy")
                    .onTapGesture {
                        if let urlString = linkData?.smart_link {
                            UIPasteboard.general.string = urlString
                            showToast = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                showToast = false
                            }
                            print("Link copied: \(urlString)")
                        } else {
                            print("Can't copy the link")
                        }
                    }
                    .overlay(
                           Text("Link Copied!")
                               .font(.system(size: 20, weight: .bold))
                               .foregroundColor(.white)
                               .padding(.vertical, 12)
                               .padding(.horizontal, 16)
                               .background(Color.black.opacity(0.7))
                               .cornerRadius(16)
                               .opacity(showToast ? 1 : 0)
                               .animation(.easeInOut(duration: 0.5))
                               .offset(
                                x: -UIScreen.main.bounds.width / 2.5 , y: -60 ) // Adjust offset to move the toast message up or down
                            .frame(width : UIScreen.main.bounds.width / 1, alignment: .center)
                       , alignment: .bottom)
                       .edgesIgnoringSafeArea(.bottom)
                
            }
            .foregroundStyle(.bgHeader)
            .frame(maxWidth: .infinity)
            .padding()
            .background(.bgHeader.opacity(0.2))
            .overlay {
                UnevenRoundedRectangle(cornerRadii: .init(
                    topLeading: 0,
                    bottomLeading: 10 ,
                    bottomTrailing: 10,
                    topTrailing: 0
                ))
                .stroke(.bgHeader , style: StrokeStyle(lineWidth: 1.4 , dash: [4]) )
            }
        }
       // .padding(.top , 20)
       // .padding(.vertical)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
    }
}

//#Preview {
//    LinksCard()
//}
