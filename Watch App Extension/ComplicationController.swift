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
        
        // Create the template and timeline entry.
        //Graphic Bezel
        if complication.family == .graphicBezel {
            let textTemplate = CLKComplicationTemplateGraphicBezelCircularText()
            let textOne = myDelegate.lab + " " + myDelegate.status
            textTemplate.textProvider = CLKSimpleTextProvider(text: textOne)
            let openGSimple = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText()
            let textTwo = myDelegate.status!
            openGSimple.bottomTextProvider = CLKSimpleTextProvider(text: "lab")
            if textTwo == "closed" {
                openGSimple.centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
                openGSimple.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 0)
            }
            else if textTwo == "coffee" {
                openGSimple.centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
                openGSimple.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 0.33)
            }
            else if textTwo == "fire" {
                openGSimple.centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
                openGSimple.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 0.66)
            }
            else if textTwo == "open" {
                openGSimple.centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
                openGSimple.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 1)
            }
            else if textTwo == "nil" {
                openGSimple.centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
                openGSimple.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColor: UIColor.red, fillFraction: 0.5)
            }
            textTemplate.circularTemplate = openGSimple
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Graphic Corner
        if complication.family == .graphicCorner {
            let textTemplate = CLKComplicationTemplateGraphicCornerStackText()
            let textOne = myDelegate.lab!
            let textTwo = myDelegate.status!
            textTemplate.outerTextProvider = CLKSimpleTextProvider(text: textTwo)
            textTemplate.outerTextProvider.tintColor = UIColor(red: 200/255, green: 30/255, blue: 60/255, alpha: 1)
            textTemplate.innerTextProvider = CLKSimpleTextProvider(text: textOne)
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Graphic Circular
        if complication.family == .graphicCircular {
            let textTemplate = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText()
            let textOne = myDelegate.lab!
            let textTwo = myDelegate.status!
            textTemplate.bottomTextProvider = CLKSimpleTextProvider(text: textOne)
            if textTwo == "closed" {
                textTemplate.centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
                textTemplate.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 0)
            }
            else if textTwo == "coffee" {
                textTemplate.centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
                textTemplate.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 0.33)
            }
            else if textTwo == "fire" {
                textTemplate.centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
                textTemplate.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 0.66)
            }
            else if textTwo == "open" {
                textTemplate.centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
                textTemplate.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColors: [UIColor.red,UIColor.brown,UIColor.orange,UIColor.green], gaugeColorLocations: [0,0.33,0.66,1], fillFraction: 1)
            }
            else if textTwo == "nil" {
                textTemplate.centerTextProvider = CLKSimpleTextProvider(text: myDelegate.emoji)
                textTemplate.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColor: UIColor.red, fillFraction: 0.5)
            }
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Mod Small
        if complication.family == .modularSmall {
            let textTemplate = CLKComplicationTemplateModularSmallSimpleText()
            let textTwo = myDelegate.emoji!
            textTemplate.textProvider = CLKSimpleTextProvider(text: textTwo)
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Util Large
        if complication.family == .utilitarianLarge {
            let textTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            let textOne = myDelegate.lab + " " + myDelegate.status
            textTemplate.textProvider = CLKSimpleTextProvider(text: textOne)
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Util Small
        if complication.family == .utilitarianSmall {
            let textTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
            let textOne = myDelegate.lab + " " + myDelegate.status
            textTemplate.textProvider = CLKSimpleTextProvider(text: textOne)
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Util Small Flat
        if complication.family == .utilitarianSmallFlat {
            let textTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
            let textOne = myDelegate.lab + " " + myDelegate.status
            textTemplate.textProvider = CLKSimpleTextProvider(text: textOne)
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //XL
        if complication.family == .extraLarge {
            let textTemplate = CLKComplicationTemplateExtraLargeStackText()
            let textOne = myDelegate.lab!
            let textTwo = myDelegate.status!
            textTemplate.line1TextProvider = CLKSimpleTextProvider(text: textOne)
            textTemplate.line2TextProvider = CLKSimpleTextProvider(text: textTwo)
            entry = CLKComplicationTimelineEntry(date: now as Date, complicationTemplate: textTemplate)
        }
        
        //Circular Small
        if complication.family == .circularSmall {
            let textTemplate = CLKComplicationTemplateCircularSmallSimpleText()
            let textTwo = myDelegate.emoji!
            textTemplate.textProvider = CLKSimpleTextProvider(text: textTwo)
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
            let textTemplate = CLKComplicationTemplateGraphicBezelCircularText()
            let textOne = lab + " " + status
            textTemplate.textProvider = CLKSimpleTextProvider(text: textOne)
            let openGSimple = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText()
            openGSimple.bottomTextProvider = CLKSimpleTextProvider(text: lab)
            openGSimple.centerTextProvider = CLKSimpleTextProvider(text: emoji)
            openGSimple.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColor: UIColor.purple, fillFraction: 0.5)
            textTemplate.circularTemplate = openGSimple
            handler(textTemplate)
        }
        
        //Graphic Corner
        if complication.family == .graphicCorner {
            let textTemplate = CLKComplicationTemplateGraphicCornerStackText()
            let textOne = lab
            let textTwo = status
            textTemplate.outerTextProvider = CLKSimpleTextProvider(text: textTwo)
            textTemplate.outerTextProvider.tintColor = UIColor(red: 200/255, green: 30/255, blue: 60/255, alpha: 1)
            textTemplate.innerTextProvider = CLKSimpleTextProvider(text: textOne)
            handler(textTemplate)
        }
        
        //Graphic Circular
        if complication.family == .graphicCircular {
            let textTemplate = CLKComplicationTemplateGraphicCircularOpenGaugeSimpleText()
            textTemplate.bottomTextProvider = CLKSimpleTextProvider(text: lab)
            textTemplate.centerTextProvider = CLKSimpleTextProvider(text: emoji)
            textTemplate.gaugeProvider = CLKSimpleGaugeProvider(style: CLKGaugeProviderStyle.ring, gaugeColor: UIColor.purple, fillFraction: 0.5)
            handler(textTemplate)
        }
        
        //Mod Small
        if complication.family == .modularSmall {
            let textTemplate = CLKComplicationTemplateModularSmallSimpleText()
            let textTwo = emoji
            textTemplate.textProvider = CLKSimpleTextProvider(text: textTwo)
            handler(textTemplate)
        }
        
        //Util Large
        if complication.family == .utilitarianLarge {
            let textTemplate = CLKComplicationTemplateUtilitarianLargeFlat()
            let textOne = lab + " " + status
            textTemplate.textProvider = CLKSimpleTextProvider(text: textOne)
            handler(textTemplate)
        }
        
        //Util Small
        if complication.family == .utilitarianSmall {
            let textTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
            let textOne = lab + " " + status
            textTemplate.textProvider = CLKSimpleTextProvider(text: textOne)
            handler(textTemplate)
        }
        
        //Util Small Flat
        if complication.family == .utilitarianSmallFlat {
            let textTemplate = CLKComplicationTemplateUtilitarianSmallFlat()
            let textOne = lab + " " + status
            textTemplate.textProvider = CLKSimpleTextProvider(text: textOne)
            handler(textTemplate)
        }
        
        //XL
        if complication.family == .extraLarge {
            let textTemplate = CLKComplicationTemplateExtraLargeStackText()
            let textOne = lab
            let textTwo = status
            textTemplate.line1TextProvider = CLKSimpleTextProvider(text: textOne)
            textTemplate.line2TextProvider = CLKSimpleTextProvider(text: textTwo)
            handler(textTemplate)
        }
        
        //Circular Small
        if complication.family == .circularSmall {
            let textTemplate = CLKComplicationTemplateCircularSmallSimpleText()
            let textTwo = emoji
            textTemplate.textProvider = CLKSimpleTextProvider(text: textTwo)
            handler(textTemplate)
        }
    }
}

