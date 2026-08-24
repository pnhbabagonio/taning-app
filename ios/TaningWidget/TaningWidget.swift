//
//  TaningWidget.swift
//  TaningWidget
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> TaningEntry {
        TaningEntry(
            date: Date(),
            title: "Vacation",
            days: 14,
            hours: 6,
            minutes: 42,
            color: Color(.indigo),
            icon: "✈️",
            progress: 0.67,
            isComplete: false
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (TaningEntry) -> ()) {
        let entry = loadWidgetData()
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TaningEntry>) -> ()) {
        let entry = loadWidgetData()
        let timeline = Timeline(
            entries: [entry],
            policy: .after(Date().addingTimeInterval(3600)) // Update every hour
        )
        completion(timeline)
    }
    
    private func loadWidgetData() -> TaningEntry {
        // Load from shared UserDefaults
        let sharedDefaults = UserDefaults(suiteName: "group.com.taning.app")
        let data = sharedDefaults?.dictionary(forKey: "widget_data") ?? [:]
        
        return TaningEntry(
            date: Date(),
            title: data["title"] as? String ?? "Taning",
            days: data["days"] as? Int ?? 0,
            hours: data["hours"] as? Int ?? 0,
            minutes: data["minutes"] as? Int ?? 0,
            color: Color(
                red: Double(data["red"] as? Float ?? 0.31),
                green: Double(data["green"] as? Float ?? 0.27),
                blue: Double(data["blue"] as? Float ?? 0.9)
            ),
            icon: data["icon"] as? String ?? "⏳",
            progress: data["progress"] as? Double ?? 0.0,
            isComplete: data["isComplete"] as? Bool ?? false
        )
    }
}

struct TaningEntry: TimelineEntry {
    let date: Date
    let title: String
    let days: Int
    let hours: Int
    let minutes: Int
    let color: Color
    let icon: String
    let progress: Double
    let isComplete: Bool
}

struct TaningWidgetEntryView: View {
    var entry: Provider.Entry

    @Environment(\.widgetFamily) var family
    
    var body: some View {
        ZStack {
            // Background
            entry.color
            
            VStack(alignment: .leading, spacing: 4) {
                // Header
                HStack {
                    Text(entry.icon)
                        .font(.system(size: 16))
                    Text(entry.title)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.white.opacity(0.9))
                        .lineLimit(1)
                }
                
                Spacer(minLength: 4)
                
                // Countdown
                if entry.isComplete {
                    Text("✅ Done!")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                } else if entry.days > 0 {
                    VStack(alignment: .leading, spacing: 0) {
                        Text("\(entry.days)d")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Text("\(entry.hours)h \(entry.minutes)m")
                            .font(.system(size: 12))
                            .foregroundColor(.white.opacity(0.7))
                    }
                } else if entry.hours > 0 {
                    Text("\(entry.hours)h \(entry.minutes)m")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                } else {
                    Text("\(entry.minutes)m")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                }
                
                Spacer(minLength: 4)
                
                // Progress bar
                if entry.progress > 0 && entry.progress < 1 {
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: geometry.size.width, height: 4)
                                .cornerRadius(2)
                            
                            Rectangle()
                                .fill(Color.white)
                                .frame(width: geometry.size.width * entry.progress, height: 4)
                                .cornerRadius(2)
                        }
                    }
                    .frame(height: 4)
                }
            }
            .padding(12)
        }
    }
}

@main
struct TaningWidget: Widget {
    let kind: String = "TaningWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            TaningWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Taning")
        .description("See your Taning countdown at a glance.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Widget Preview

struct TaningWidget_Previews: PreviewProvider {
    static var previews: some View {
        TaningWidgetEntryView(
            entry: TaningEntry(
                date: Date(),
                title: "Vacation",
                days: 14,
                hours: 6,
                minutes: 42,
                color: Color(.indigo),
                icon: "✈️",
                progress: 0.67,
                isComplete: false
            )
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}