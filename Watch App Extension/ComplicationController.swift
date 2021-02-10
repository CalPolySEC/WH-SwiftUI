//
//  ComplicationController.swift
//  Watch App Extension
//
//  Created by Stephen Parkinson on 6/3/19.
//  Copyright © 2019 Stephen Parkinson. All rights reserved.
//

import ClockKit
import WatchKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        // Get the complication data from the extension delegate.
        let myDelegate = WKExtension.shared().delegate as! ExtensionDelegate
        myDelegate.lab = "lab"
        var entry : CLKComplicationTimelineEntry?
        let now = NSDate()
        myDelegate.getJsonFromUrl()
        if myDelegate.status == "coffee" {
            myDelegate.emoji = "☕️"
        }
        else if myDelegate.status == "closed" {
            myDelegate.emoji = "🔒"
        }
        else if myDelegate.status == "open" {
            myDelegate.emoji = "🔓"
        }
        else if myDelegate.status == "fire" {
            myDelegate.emoji = "🔥"
        }
        else {
            myDelegate.status = "nil"
            myDelegate.emoji = "🚫"
        }
        
        // text and gague setup
        var centerTextProvider: CLKSimpleTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
        var gaugeProvider: CLKSimpleGaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColor: UIColor.red, fillFraction: 0.5)
        let textOne = myDelegate.lab + " " + myDelegate.status
        let textTwo = myDelegate.status!
        if textTwo == "closed" {
            centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
            gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 0)
        }
        else if textTwo == "coffee" {
            centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
            gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 0.33)
        }
        else if textTwo == "fire" {
            centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
            gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 0.66)
        }
        else if textTwo == "open" {
            centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
            gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 1)
        }
        else if textTwo == "nil" {
            centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
            gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColor: UIColor.red, fillFraction: 0.5)
        }
        
        // Create the template and timeline entry.
        // Graphic Bezel
        if complication.family == .graphicBezel {
            let openGSimple = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText(gaugeProvider: gaugeProvider, bottomTextProvider: CLKSimpleTextProvider(text: "lab"), centerTextProvider: centerTextProvider)
            let textTemplate = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate: openGSimple, textProvider: CLKSimpleTextProvider(text: textOne))
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Graphic Corner
        if complication.family == .graphicCorner {
            let textOne = myDelegate.lab!
            let textTwo = myDelegate.status!
            let textTemplate = CLKComplicationTemplateGraphicCornerStackText(innerTextProvider: CLKSimpleTextProvider(text: textOne), outerTextProvider: CLKSimpleTextProvider(text: textTwo))
            textTemplate.outerTextProvider.tintColor = UIColor(red: 200/255, green: 30/255, blue: 60/255, alpha: 1)
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Graphic Circular
        if complication.family == .graphicCircular {
            let textTemplate = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText(gaugeProvider: gaugeProvider, bottomTextProvider: CLKSimpleTextProvider(text: "lab"), centerTextProvider: centerTextProvider)
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Mod Small
        if complication.family == .modularSmall {
            let textTemplate = CLKComplicationTemplateModularSmallSimpleText(textProvider: centerTextProvider)
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Util Large
        if complication.family == .utilitarianLarge {
            let textTemplate = CLKComplicationTemplateUtilitarianLargeFlat(textProvider: CLKSimpleTextProvider(text: textOne))
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Util Small
        if complication.family == .utilitarianSmall {
            let textTemplate = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: CLKSimpleTextProvider(text: textOne))
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Util Small Flat
        if complication.family == .utilitarianSmallFlat {
            let textTemplate = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: CLKSimpleTextProvider(text: textOne))
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //XL
        if complication.family == .extraLarge {
            let textOne = myDelegate.lab!
            let textTwo = myDelegate.status!
            let textTemplate = CLKComplicationTemplateExtraLargeStackText(line1TextProvider: CLKSimpleTextProvider(text: textOne), line2TextProvider: CLKSimpleTextProvider(text: textTwo))
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Circular Small
        if complication.family == .circularSmall {
            let textTemplate = CLKComplicationTemplateCircularSmallSimpleText(textProvider: centerTextProvider)
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        else {
            // ...configure entries for other complication families.
        }
        
        // Pass the timeline entry back to ClockKit.
        handler(entry)
    }
    
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    // MARK: - Placeholder Templates
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let lab = "lab"
        let status = "N/A"
        let emoji = "🐧"
        
        //Graphic Bezel
        if complication.family == .graphicBezel {
            let textOne = lab + " " + status
            let openGSimple = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText(gaugeProvider: CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColor: UIColor.purple, fillFraction: 0.5), bottomTextProvider: CLKSimpleTextProvider(text: lab), centerTextProvider: CLKSimpleTextProvider(text: emoji))
            let textTemplate = CLKComplicationTemplateGraphicBezelCircularText(circularTemplate: openGSimple, textProvider: CLKSimpleTextProvider(text: textOne))
            textTemplate.circularTemplate = openGSimple
            handler(textTemplate)
        }
        
        //Graphic Corner
        if complication.family == .graphicCorner {
            let textOne = lab
            let textTwo = status
            let textTemplate = CLKComplicationTemplateGraphicCornerStackText(innerTextProvider: CLKSimpleTextProvider(text: textOne), outerTextProvider: CLKSimpleTextProvider(text: textTwo))
            textTemplate.outerTextProvider.tintColor = UIColor(red: 200/255, green: 30/255, blue: 60/255, alpha: 1)
            handler(textTemplate)
        }
        
        //Graphic Circular
        if complication.family == .graphicCircular {
            let textTemplate = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText(gaugeProvider: CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColor: UIColor.purple, fillFraction: 0.5), bottomTextProvider: CLKSimpleTextProvider(text: lab), centerTextProvider: CLKSimpleTextProvider(text: emoji))
            handler(textTemplate)
        }
        
        //Mod Small
        if complication.family == .modularSmall {
            let textTwo = emoji
            let textTemplate = CLKComplicationTemplateModularSmallSimpleText(textProvider: CLKSimpleTextProvider(text: textTwo))
            handler(textTemplate)
        }
        
        //Util Large
        if complication.family == .utilitarianLarge {
            let textOne = lab + " " + status
            let textTemplate = CLKComplicationTemplateUtilitarianLargeFlat(textProvider: CLKSimpleTextProvider(text: textOne))
            handler(textTemplate)
        }
        
        //Util Small
        if complication.family == .utilitarianSmall {
            let textOne = lab + " " + status
            let textTemplate = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: CLKSimpleTextProvider(text: textOne))
            handler(textTemplate)
        }
        
        //Util Small Flat
        if complication.family == .utilitarianSmallFlat {
            let textOne = lab + " " + status
            let textTemplate = CLKComplicationTemplateUtilitarianSmallFlat(textProvider: CLKSimpleTextProvider(text: textOne))
            handler(textTemplate)
        }
        
        //XL
        if complication.family == .extraLarge {
            let textOne = lab
            let textTwo = status
            let textTemplate = CLKComplicationTemplateExtraLargeStackText(line1TextProvider: CLKSimpleTextProvider(text: textOne), line2TextProvider: CLKSimpleTextProvider(text: textTwo))
            handler(textTemplate)
        }
        
        //Circular Small
        if complication.family == .circularSmall {
            let textTwo = emoji
            let textTemplate = CLKComplicationTemplateCircularSmallSimpleText(textProvider: CLKSimpleTextProvider(text: textTwo))
            handler(textTemplate)
        }
    }
}

