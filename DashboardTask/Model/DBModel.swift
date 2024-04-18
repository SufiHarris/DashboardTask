//
//  DBModel.swift
//  DashboardTask
//
//  Created by Mohammad Haris Sofi on 17/04/24.
//

import UIKit
import Foundation

import Foundation

// MARK: - Welcome
struct DBModel : Codable {
    let status: Bool?
    let statusCode: Int?
    let message, support_whatsapp_number: String?
    let extra_income: Double?
    let total_links, total_clicks, today_clicks: Int?
    let top_source, top_location, startTime: String?
    let links_created_today, applied_campaign: Int?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass : Codable {
    let recent_links, top_links: [Link]?
    let favourite_links: [Link]?
    let overall_url_chart: [String: Int]?
}

// MARK: - Link
struct Link : Codable, Hashable{
    let url_id: Int?
    let web_link: String?
    let smart_link, title: String?
    let total_clicks: Int?
    let original_image: String?
    let thumbnail: String?
    let times_ago: String?
    let created_at: String?
    let domain_id: String?
    let url_prefix: String?
    let url_suffix, app: String?
    let is_favourite: Bool?
}

enum DomainID: String , Codable {
    case inopenappCOM
}

enum TimesAgo: String , Codable {
    case the1YrAgo
    case the2YrAgo
}

func extractChartData(from dbModel: DBModel?) -> [chartData] {
    guard let chartDataDict = dbModel?.data?.overall_url_chart else {
        return []
    }
    
    // Extract key-value pairs and create chartData objects
    let chartDataArray = chartDataDict.map { key, value in
        return chartData(xValue: key, yValue: value ?? 0)
    }
    
    return chartDataArray
}



struct chartData : Hashable {
    
   let xValue : String
   let yValue : Int
}
