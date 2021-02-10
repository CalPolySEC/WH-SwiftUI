//
//  WhiteHatWidget.swift
//  WhiteHatWidget
//
//  Created by Stephen Parkinson on 6/24/20.
//  Copyright © 2020 Stephen Parkinson. All rights reserved.
//

import WidgetKit
import SwiftUI

var status: String = "nil"
var done: Bool = false

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry

    public func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        getJsonFromUrl()
        var i = 0;
        while (!done && i <= 10) {
            sleep(1)
            i += 1
        }
        done = false
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let entry = SimpleEntry(date: entryDate, status: status)
        completion(entry)
    }

    public func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        getJsonFromUrl()
        var i = 0;
        while (!done && i <= 10) {
            sleep(1)
            i += 1
        }
        done = false
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let entryDate = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate)!
        let entry = SimpleEntry(date: entryDate, status: status)
        entries.append(entry)

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        let entry = SimpleEntry(date: Date(), status: "nil")
        return entry
    }
    
    func getJsonFromUrl() {
        let config = URLSessionConfiguration.default
        config.requestCachePolicy = .reloadIgnoringLocalCacheData
        config.urlCache = nil
        
        let session = URLSession.init(configuration: config)
        
        let url = URL(string: "https://thewhitehat.club/api/v1/status")
        session.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let jStatus = json["data"] as? Dictionary<String, Any>
                let jStatus2 = jStatus?["status"] as? String ?? "nil"
                print(jStatus2)
                status = jStatus2
                done = true
            } catch let error as NSError {
                print(error)
            }
        }).resume()
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public var status: String
}

struct WhiteHatWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        WidgetView(status: entry.status)
    }
}

@main
struct WhiteHatWidget: Widget {
    private let kind: String = "WhiteHatWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            WhiteHatWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("White Hat")
        .description("White Hat lab status widget.")
    }
}
