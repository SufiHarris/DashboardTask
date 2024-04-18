//
//  Dashboard.swift
//  DashboardTask
//
//  Created by Mohammad Haris Sofi on 17/04/24.
//

import SwiftUI
import Charts
struct Dashboard: View {
    @StateObject private var vm =  DashboardViewModel()
    @State private var showRecentLinks : Bool = false
    @State private var greeting = ""

       init() {
           _greeting = State(initialValue: getGreeting())
       }
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    Text ("Dashboard")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)
                    Spacer()
                    
                    Image("Frame 7")
                        .foregroundStyle(.white)
                        .background(.bgHeader.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.bottom , 20)
                .frame(maxWidth: .infinity)
                .frame(height: 100)
                .background(Color("bgHeader"))

                ScrollView {
                    VStack {
                        //Greetings
                          greetings
                          ChartView
                            .background(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                          hScrollVieew
                        
                        viewAnalytical
                        topBarView
                        if showRecentLinks {
                            RecentlinkView
                                .onTapGesture {
                                    showRecentLinks.toggle()
                                }
                        }else {
                            linkView
                                .onTapGesture {
                                    showRecentLinks.toggle()
                                }
                        }
                        
                        viewLinks
                        whatsAppLinks
                        questionViewButton
                    }
                }
                .background(.svBg)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .offset(y: -30)
            }
        }
    }
}

#Preview {
    Dashboard()
}


extension Dashboard {
    
    private var greetings : some View {
        VStack(alignment : .leading) {
          Text(greeting)
                .font(.headline)
                .fontWeight(.medium)
                .foregroundStyle(.gray)
        
            HStack {
                Text("Ayush Manta")
                    .font(.title3)
                    .fontWeight(.medium)
                Image("Frame 7644")
            }
        }
        .padding()
        .padding(.top , 20)
        .frame(maxWidth: .infinity , alignment: .leading)
    }
    
    private var hScrollVieew : some View {
        ScrollView(.horizontal ,showsIndicators: false) {
            HStack {
                
                HScrollCard(img: "Avatar", title: "\(vm.dbData?.today_clicks ?? 0)", bodyText: "Today's clicks")
                HScrollCard(img: "Avatar1", title: "\(vm.dbData?.top_location ?? "Kashmir")", bodyText: "Top Location")
                HScrollCard(img: "Avatar2", title: "\(vm.dbData?.top_source ?? "Insta")", bodyText: "Top Source")
                HScrollCard(img: "Avatar3", title: "\(vm.dbData?.startTime ?? "11: 00")", bodyText: "Best Time")
                
            }
            .padding(.horizontal)
        }

    }
    private var viewAnalytical : some View {
        Button(action: {}, label: {
            HStack {
                Image("Arrows")
                Text("View Analytics")
                    .foregroundStyle(.black)
            }
            .bold()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth: 0.2)
            }
            .padding()
        })
    }
    
    private var topBarView : some View {
        HStack() {
            
            Text("Top Links")
                .foregroundStyle(showRecentLinks ? .gray : .white)
                .fontWeight(.light)
                .padding(8)
                .frame(width: 110)
                .background(showRecentLinks ? .clear : .bgHeader)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .onTapGesture {
                    showRecentLinks.toggle()
                }
            Spacer()
            Text("Recent Links")
                .foregroundStyle(showRecentLinks ?  .white : .gray )
                .fontWeight(.light)
                .padding(8)
                .frame(width: 120)
                .background(showRecentLinks ?  .bgHeader :.clear )
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .onTapGesture {
                    showRecentLinks.toggle()
                }
            Spacer()
            Image("Input Container")
            
        }
        .padding(.horizontal)
    }
    private var linkView: some View {
        VStack {
            if let data = vm.dbData?.data?.top_links {
                VStack { // or any other view container as per your UI design
                    ForEach(data, id: \.self) { linkData in
                        LinksCard(linkData: linkData)
                    }
                }
            } else {
                EmptyView()
            }
        }
        
    }
    
    private var RecentlinkView: some View {
        VStack {
            if let data = vm.dbData?.data?.recent_links {
                VStack(spacing : 20) { // or any other view container as per your UI design
                    ForEach(data, id: \.self) { linkData in
                        LinksCard(linkData: linkData)
                            .padding(.vertical)
                    }
                }
            } else {
                EmptyView()
            }
        }
        
    }
    
    private var viewLinks : some View {
        Button(action: {}, label: {
            HStack {
                Image("link")
                Text("View all Links")
                    .foregroundStyle(.black)
            }
            .bold()
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth: 0.2)
            }
            .padding()
        })
    }
    private var whatsAppLinks : some View {
        HStack{
            Button(action: {}, label: {
                HStack {
                    Image("Group 7566")
                        .padding(.horizontal)
                    Text("Talk with Us")
                        .foregroundStyle(.black)
                }
           
            })
            Spacer()
        }
        .bold()
        .frame(maxWidth: .infinity)
        .padding()
        .background(.green.opacity(0.2))
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20).stroke(.green, lineWidth: 0.4)
        }
        .padding()
    }
    
    private var questionViewButton : some View {
        HStack{
            Button(action: {}, label: {
                HStack {
                    Image("question-mark")
                        .padding(.horizontal)
                    Text("Frequently Asked Questions")
                        .foregroundStyle(.black)
                }
           
            })
            Spacer()
        }
        .bold()
        .frame(maxWidth: .infinity)
        .padding()
        .background(.bgHeader.opacity(0.2))
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 20).stroke(.bgHeader, lineWidth: 0.4)
        }
        .padding()
    }
    
    private var ChartView : some View {
        
        VStack {
            HStack {
                Text("Overview")
                    .foregroundStyle(.gray)
                Spacer()
                HStack {
                    Text("22 sep - 23 sep")
                    Image(systemName: "clock.arrow.circlepath")
                }
                .font(.caption)
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 5).stroke(.gray , lineWidth: 1)
                }
            }
            
            HStack {
                if let data  = vm.dbData?.data?.overall_url_chart {
                    let chartData = extractChartData(from: vm.dbData)
                    HStack{
                        Chart(chartData , id: \.self) { data in
                            
                            LineMark(x:
                                    .value("Months", data.xValue),
                                     y : .value("data", data.yValue)
                            )
                            .shadow(color: .bgHeader.opacity(0.7), radius: 18 )
                        }
                    }
                    
                }
                else {
                    ProgressView()
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
            
        }
        .padding()

    }
    func getGreeting() -> String {
        let hour = Calendar.current.component(.hour, from: Date())

        switch hour {
        case 0..<12:
            return "Good Morning!"
        case 12..<18:
            return "Good Afternoon!"
        default:
            return "Good Evening!"
        }
    }
}
