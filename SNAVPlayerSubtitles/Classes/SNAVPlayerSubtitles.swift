//
//  SNAVPlayerSubtitles.swift
//  Pods-SNAVPlayerSubtitles_Example
//
//  Created by SWAGAT NAYAK on 14/03/21.
//
import ObjectiveC
import MediaPlayer
import AVKit
import CoreMedia

private struct AssociatedKeys {
    static var FontKey = "FontKey"
    static var ColorKey = "FontKey"
    static var SubtitleKey = "SubtitleKey"
    static var SubtitleHeightKey = "SubtitleHeightKey"
    static var PayloadKey = "PayloadKey"
}

public enum SNAVP_SUBTITLE_TYPE {
    case SRT
    case VTT
}

public enum SNAVP_TEXT_STYLE {
    case CLEAR_BACKGROUND
    case BLACK_BACKGROUND
}
public protocol SNAVPlayerSubtitlesDelegate: class {
    
    func onError(msg: String)
}

@objc public class Subtitles1 : NSObject {

    // MARK: - Properties
    fileprivate var parsedPayload: NSDictionary?
    
    // MARK: - Public methods
    public init(file filePath: URL, encoding: String.Encoding = String.Encoding.utf8) {
        
        // Get string
        let string = try! String(contentsOf: filePath, encoding: encoding)
        
        // Parse string
        parsedPayload = Subtitles1.parseSubRip(string)
        
    }
    
 @objc public init(subtitles string: String) {
        
        // Parse string
        parsedPayload = Subtitles1.parseSubRip(string)
        
    }
    
    /// Search subtitles at time
    ///
    /// - Parameter time: Time
    /// - Returns: String if exists
 @objc public func searchSubtitles(at time: TimeInterval) -> String? {
        
        return Subtitles1.searchSubtitles(parsedPayload, time)
        
    }
    
    // MARK: - Private methods
    
    /// Subtitle parser
    ///
    /// - Parameter payload: Input string
    /// - Returns: NSDictionary
    fileprivate static func parseSubRip(_ payload: String) -> NSDictionary? {
        
        do {
            
            // Prepare payload
//            var payload = payload.replacingOccurrences(of: "\n\r\n", with: "\n\n")
//            payload = payload.replacingOccurrences(of: "\n\n\n", with: "\n\n")
//            payload = payload.replacingOccurrences(of: "\r\n", with: "\n")
            
            // Parsed dict
            let parsed = NSMutableDictionary()
        
            // Get groups
            var index: Int = 0
            let regexStr = "(?m)^(\\d{2}:\\d{2}:\\d{2}\\.\\d+) +--> +(\\d{2}:\\d{2}:\\d{2}\\.\\d+).*[\r\n]+\\s*(?s)((?:(?!\r?\n\r?\n).)*)"
            let regex = try NSRegularExpression(pattern: regexStr, options: .caseInsensitive)
            let matches = regex.matches(in: payload, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, payload.count))
            
            if matches.isEmpty {
                NSLog("\n\n\n=========> SNAVPlayerSubtitles Error: \(400) - \("Empty file or Invalid subtitle format, recheck again (srt or vtt)") <=============\n\n\n")
                return parsed
            }
            
            for m in matches {
                
                let group = (payload as NSString).substring(with: m.range)
                
                // Get index
                var regex = try NSRegularExpression(pattern: "^[0-9]+", options: .caseInsensitive)
                var match = regex.matches(in: group, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, group.count))
                guard match.first != nil else {
                    continue
                }
//                let index = (group as NSString).substring(with: i.range)
                
                // Get "from" & "to" time
                regex = try NSRegularExpression(pattern: "\\d{1,2}:\\d{1,2}:\\d{1,2}[\\..]\\d{1,3}", options: .caseInsensitive)
                match = regex.matches(in: group, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, group.count))
                guard match.count == 2 else {
                    continue
                }
                guard let from = match.first, let to = match.last else {
                    continue
                }
                
                var h: TimeInterval = 0.0, m: TimeInterval = 0.0, s: TimeInterval = 0.0, c: TimeInterval = 0.0
                

                
                var fromTime: Double
                var toTime: Double
                
                if #available(iOS 13.0, *) {
                
                    let fromStr = (group as NSString).substring(with: from.range)
                    var scanner = Scanner(string: fromStr)
                    h = scanner.scanDouble() ?? 0.0
                    let _ = scanner.scanString(":")
                    m = scanner.scanDouble() ?? 0.0
                    let _ = scanner.scanString(":")
                    s = scanner.scanDouble() ?? 0.0
                    let _ = scanner.scanString(".")
                    c = scanner.scanDouble() ?? 0.0
                    fromTime = (h * 3600.0) + (m * 60.0) + s + (c / 1000.0)
                    
                    let toStr = (group as NSString).substring(with: to.range)
                    scanner = Scanner(string: toStr)
                    h = scanner.scanDouble() ?? 0.0
                    let _ = scanner.scanString(":")
                    m = scanner.scanDouble() ?? 0.0
                    let _ = scanner.scanString(":")
                    s = scanner.scanDouble() ?? 0.0
                    let _ = scanner.scanString(".")
                    c = scanner.scanDouble() ?? 0.0
                    toTime = (h * 3600.0) + (m * 60.0) + s + (c / 1000.0)
                    
                }else{
                    
                    let fromStr = (group as NSString).substring(with: from.range)
                    var scanner = Scanner(string: fromStr)
                    scanner.scanDouble(&h)
                    scanner.scanString(":", into: nil)
                    scanner.scanDouble(&m)
                    scanner.scanString(":",into: nil)
                    scanner.scanDouble(&s)
                    scanner.scanString(".", into: nil)
                    scanner.scanDouble(&c)
                    fromTime = (h * 3600.0) + (m * 60.0) + s + (c / 1000.0)
                    
                    let toStr = (group as NSString).substring(with: to.range)
                    scanner = Scanner(string: toStr)
                    scanner.scanDouble(&h)
                    scanner.scanString(":", into: nil)
                    scanner.scanDouble(&m)
                    scanner.scanString(":",into: nil)
                    scanner.scanDouble(&s)
                    scanner.scanString(".", into: nil)
                    scanner.scanDouble(&c)
                    toTime = (h * 3600.0) + (m * 60.0) + s + (c / 1000.0)
                    
                }
                
                
                
                
                // Get text & check if empty
                let range = NSMakeRange(0, to.range.location + to.range.length + 1)
                guard (group as NSString).length - range.length > 0 else {
                    continue
                }
                let text = (group as NSString).replacingCharacters(in: range, with: "")
                
                // Create final object
                let final = NSMutableDictionary()
                final["from"] = fromTime
                final["to"] = toTime
                final["text"] = text
                parsed[index] = final
                
                index = index+1
                
            }
            
            return parsed
            
        } catch {
            
            return nil
            
        }
        
    }
    
    fileprivate static func parseSubRipForSrt(_ payload: String) -> NSDictionary? {
        
        do {
                   
           // Prepare payload
           var payload = payload.replacingOccurrences(of: "\n\r\n", with: "\n\n")
           payload = payload.replacingOccurrences(of: "\n\n\n", with: "\n\n")
           payload = payload.replacingOccurrences(of: "\r\n", with: "\n")
           
           // Parsed dict
           let parsed = NSMutableDictionary()
           
           // Get groups
           let regexStr = "(\\d+)\\n([\\d:,.]+)\\s+-{2}\\>\\s+([\\d:,.]+)\\n([\\s\\S]*?(?=\\n{2,}|$))"
           let regex = try NSRegularExpression(pattern: regexStr, options: .caseInsensitive)
           let matches = regex.matches(in: payload, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, payload.count))
           
            if matches.isEmpty {
                NSLog("\n\n\n=========> SNAVPlayerSubtitles Error: \(400) - \("Empty file or Invalid subtitle format, recheck again (srt or vtt)") <=============\n\n\n")
                return parsed
            }
            
           for m in matches {
               
               let group = (payload as NSString).substring(with: m.range)
               
               // Get index
               var regex = try NSRegularExpression(pattern: "^[0-9]+", options: .caseInsensitive)
               var match = regex.matches(in: group, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, group.count))
               guard let i = match.first else {
                   continue
               }
               let index = (group as NSString).substring(with: i.range)
               
               // Get "from" & "to" time
               regex = try NSRegularExpression(pattern: "\\d{1,2}:\\d{1,2}:\\d{1,2}[,.]\\d{1,3}", options: .caseInsensitive)
               match = regex.matches(in: group, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, group.count))
               guard match.count == 2 else {
                   continue
               }
               guard let from = match.first, let to = match.last else {
                   continue
               }
               
               var h: TimeInterval = 0.0, m: TimeInterval = 0.0, s: TimeInterval = 0.0, c: TimeInterval = 0.0
               
               let fromStr = (group as NSString).substring(with: from.range)
               var scanner = Scanner(string: fromStr)
               scanner.scanDouble(&h)
               scanner.scanString(":", into: nil)
               scanner.scanDouble(&m)
               scanner.scanString(":", into: nil)
               scanner.scanDouble(&s)
               scanner.scanString(",", into: nil)
               scanner.scanDouble(&c)
               let fromTime = (h * 3600.0) + (m * 60.0) + s + (c / 1000.0)
               
               let toStr = (group as NSString).substring(with: to.range)
               scanner = Scanner(string: toStr)
               scanner.scanDouble(&h)
               scanner.scanString(":", into: nil)
               scanner.scanDouble(&m)
               scanner.scanString(":", into: nil)
               scanner.scanDouble(&s)
               scanner.scanString(",", into: nil)
               scanner.scanDouble(&c)
               let toTime = (h * 3600.0) + (m * 60.0) + s + (c / 1000.0)
               
               // Get text & check if empty
               let range = NSMakeRange(0, to.range.location + to.range.length + 1)
               guard (group as NSString).length - range.length > 0 else {
                   continue
               }
               let text = (group as NSString).replacingCharacters(in: range, with: "")
               
               // Create final object
               let final = NSMutableDictionary()
               final["from"] = fromTime
               final["to"] = toTime
               final["text"] = text
               parsed[index] = final
               
           }
           
           return parsed
           
       } catch {
           
           return nil
           
       }

    }

    
    /// Search subtitle on time
    ///
    /// - Parameters:
    ///   - payload: Inout payload
    ///   - time: Time
    /// - Returns: String
    fileprivate static func searchSubtitles(_ payload: NSDictionary?, _ time: TimeInterval) -> String? {
        
        let predicate = NSPredicate(format: "(%f >= %K) AND (%f <= %K)", time, "from", time, "to")
        
        guard let values = payload?.allValues, let result = (values as NSArray).filtered(using: predicate).first as? NSDictionary else {
            return nil
        }
        
        guard let text = result.value(forKey: "text") as? String else {
            return nil
        }
        
        return text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
    }
    
}

public extension AVPlayerViewController {
    
    // MARK: - Public properties
    var subtitleLabel: UILabel? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.SubtitleKey) as? UILabel }
        set (value) { objc_setAssociatedObject(self, &AssociatedKeys.SubtitleKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: - Private properties
    fileprivate var subtitleLabelHeightConstraint: NSLayoutConstraint? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.SubtitleHeightKey) as? NSLayoutConstraint }
        set (value) { objc_setAssociatedObject(self, &AssociatedKeys.SubtitleHeightKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    fileprivate var parsedPayload: NSDictionary? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.PayloadKey) as? NSDictionary }
        set (value) { objc_setAssociatedObject(self, &AssociatedKeys.PayloadKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: - Public methods
    func addSubtitles(textStyle: SNAVP_TEXT_STYLE = .CLEAR_BACKGROUND) -> Self {
        
        // Create label
        addSubtitleLabel(textStyle: textStyle)
        
        return self
        
    }
    
    func open(fileFromLocal filePath: URL,type: SNAVP_SUBTITLE_TYPE, encoding: String.Encoding = String.Encoding.utf8) {
        
        let contents = try! String(contentsOf: filePath, encoding: encoding)
        show(subtitles: contents,type: type)
    }
    
    func hideSubtitle() {
        
        self.parsedPayload = nil
    }
    
    func open(fileFromRemote filePath: URL,type: SNAVP_SUBTITLE_TYPE, encoding: String.Encoding = String.Encoding.utf8) {
        
        
        subtitleLabel?.text = "..."
        URLSession.shared.dataTask(with: filePath, completionHandler: { (data, response, error) -> Void in
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                //Check status code
                if statusCode != 200 {
                    self.hideSubtitle()
                    NSLog("Subtitle Error: \(httpResponse.statusCode) - \(error?.localizedDescription ?? "")")
                    return
                }
            }
            // Update UI elements on main thread
            DispatchQueue.main.async(execute: {
                self.subtitleLabel?.text = ""
                
                if let checkData = data as Data? {
                    if let contents = String(data: checkData, encoding: encoding) {
                        self.show(subtitles: contents,type: type)
                    }
                }else{
                    self.subtitleLabel?.text = "Error loading subtitle"

                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
                        self.subtitleLabel?.text = ""
                        
                    })
                    
                }
                
            })
        }).resume()
    }
    
    
    
    func show(subtitles string: String, type: SNAVP_SUBTITLE_TYPE) {
        // Parse
        if type == .SRT {
            parsedPayload = Subtitles1.parseSubRipForSrt(string)

        }else if type == .VTT{
            parsedPayload = Subtitles1.parseSubRip(string)

        }
        addPeriodicNotification(parsedPayload: parsedPayload!)
        
    }
    
    func showByDictionary(dictionaryContent: NSMutableDictionary) {
        
        // Add Dictionary content direct to Payload
        parsedPayload = dictionaryContent
        addPeriodicNotification(parsedPayload: parsedPayload!)
        
    }
    
    func addPeriodicNotification(parsedPayload: NSDictionary) {
        // Add periodic notifications
        self.player?.addPeriodicTimeObserver(
            forInterval: CMTimeMake(value: 1, timescale: 60),
            queue: DispatchQueue.main,
            using: { [weak self] (time) -> Void in
                
                guard let strongSelf = self else { return }
                guard let label = strongSelf.subtitleLabel else { return }
                
                // Search && show subtitles
                label.text = Subtitles1.searchSubtitles(strongSelf.parsedPayload, time.seconds)
                
                // Adjust size
                let baseSize = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
                let rect = label.sizeThatFits(baseSize)
                if label.text != nil {
                    strongSelf.subtitleLabelHeightConstraint?.constant = rect.height + 5.0
                } else {
                    strongSelf.subtitleLabelHeightConstraint?.constant = rect.height
                }
                
        })
        
    }

    
    fileprivate func addSubtitleLabel(textStyle: SNAVP_TEXT_STYLE) {
        
        guard let _ = subtitleLabel else {
            
            // Label
            subtitleLabel = UILabel()
            subtitleLabel?.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel?.backgroundColor = UIColor.clear

            if textStyle == .BLACK_BACKGROUND {
                subtitleLabel?.backgroundColor = UIColor.black.withAlphaComponent(CGFloat(0.6))
            }
            
            subtitleLabel?.textAlignment = .center
            subtitleLabel?.numberOfLines = 0
            subtitleLabel?.font = UIFont.boldSystemFont(ofSize: UI_USER_INTERFACE_IDIOM() == .pad ? 40.0 : 22.0)
            subtitleLabel?.textColor = UIColor.white
            subtitleLabel?.numberOfLines = 0;
            subtitleLabel?.layer.shadowColor = UIColor.black.cgColor
            subtitleLabel?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0);
            subtitleLabel?.layer.shadowOpacity = 0.9;
            subtitleLabel?.layer.shadowRadius = 1.0;
            subtitleLabel?.layer.shouldRasterize = true;
            subtitleLabel?.layer.rasterizationScale = UIScreen.main.scale
            subtitleLabel?.lineBreakMode = .byWordWrapping
            subtitleLabel?.layer.cornerRadius = 8
            subtitleLabel?.clipsToBounds = true
            contentOverlayView?.addSubview(subtitleLabel!)
            
            // Position
            
            var constraints = [NSLayoutConstraint]()
            constraints.append((subtitleLabel?.bottomAnchor.constraint(equalTo: (contentOverlayView?.bottomAnchor)!,constant: CGFloat(-30)))!)
            constraints.append((subtitleLabel?.centerXAnchor.constraint(equalTo: (contentOverlayView?.centerXAnchor)!))!)
            NSLayoutConstraint.activate(constraints)
            
        
            
            return
            
        }
        
    }
    
}


public extension AVPlayer {
    
    // MARK: - Public properties
    var subtitleLabel: UILabel? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.SubtitleKey) as? UILabel }
        set (value) { objc_setAssociatedObject(self, &AssociatedKeys.SubtitleKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: - Private properties
    fileprivate var subtitleLabelHeightConstraint: NSLayoutConstraint? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.SubtitleHeightKey) as? NSLayoutConstraint }
        set (value) { objc_setAssociatedObject(self, &AssociatedKeys.SubtitleHeightKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    fileprivate var parsedPayload: NSDictionary? {
        get { return objc_getAssociatedObject(self, &AssociatedKeys.PayloadKey) as? NSDictionary }
        set (value) { objc_setAssociatedObject(self, &AssociatedKeys.PayloadKey, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    // MARK: - Public methods
    func addSubtitles(view: UIView,textStyle: SNAVP_TEXT_STYLE = .CLEAR_BACKGROUND) -> Self {
        
        // Create label
        addSubtitleLabel(view: view,textStyle: textStyle)
        
        return self
        
    }
    
    func open(fileFromLocal filePath: URL,type: SNAVP_SUBTITLE_TYPE, encoding: String.Encoding = String.Encoding.utf8) {
        
        self.subtitleLabel?.isHidden = false
        let contents = try! String(contentsOf: filePath, encoding: encoding)
        show(subtitles: contents,type: type)
    }
    
    func open(fileFromRemote filePath: URL,type: SNAVP_SUBTITLE_TYPE, encoding: String.Encoding = String.Encoding.utf8) {
        
        
        subtitleLabel?.text = "..."
        URLSession.shared.dataTask(with: filePath, completionHandler: { (data, response, error) -> Void in
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = httpResponse.statusCode
                
                //Check status code
                if statusCode != 200 {
                    self.hideSubtitle()
                    NSLog("Subtitle Error: \(httpResponse.statusCode) - \(error?.localizedDescription ?? "")")
                    return
                }
            }
            // Update UI elements on main thread
            DispatchQueue.main.async(execute: {
                self.subtitleLabel?.text = ""
                
                if let checkData = data as Data? {
                    if let contents = String(data: checkData, encoding: encoding) {
                        self.show(subtitles: contents,type: type)
                    }
                }else{
                    self.subtitleLabel?.text = "Error loading subtitle"

                    Timer.scheduledTimer(withTimeInterval: 3, repeats: false, block: { _ in
                        self.subtitleLabel?.text = ""
                        
                    })
                    
                }
                
            })
        }).resume()
    }
    
    
    
    func show(subtitles string: String,type: SNAVP_SUBTITLE_TYPE) {
        // Parse
        if type == .SRT {
            parsedPayload = Subtitles1.parseSubRipForSrt(string)

        }else if type == .VTT {
            parsedPayload = Subtitles1.parseSubRip(string)
        }
        addPeriodicNotification(parsedPayload: parsedPayload!)
        
    }
    
    func hideSubtitle() {
        
        self.parsedPayload = nil
    }
    
    func showByDictionary(dictionaryContent: NSMutableDictionary) {
        
        // Add Dictionary content direct to Payload
        parsedPayload = dictionaryContent
        addPeriodicNotification(parsedPayload: parsedPayload!)
        
    }
    
    func addPeriodicNotification(parsedPayload: NSDictionary) {
        // Add periodic notifications
        self.addPeriodicTimeObserver(
            forInterval: CMTimeMake(value: 1, timescale: 60),
            queue: DispatchQueue.main,
            using: { [weak self] (time) -> Void in
                
                guard let strongSelf = self else { return }
                guard let label = strongSelf.subtitleLabel else { return }
                
                // Search && show subtitles
                label.text = Subtitles1.searchSubtitles(strongSelf.parsedPayload, time.seconds)
                
                // Adjust size
                let baseSize = CGSize(width: label.bounds.width, height: CGFloat.greatestFiniteMagnitude)
                let rect = label.sizeThatFits(baseSize)
                if label.text != nil {
                    strongSelf.subtitleLabelHeightConstraint?.constant = rect.height + 5.0
                } else {
                    strongSelf.subtitleLabelHeightConstraint?.constant = rect.height
                }
                
        })
        
    }

    
    fileprivate func addSubtitleLabel(view: UIView,textStyle: SNAVP_TEXT_STYLE) {
        
        guard let _ = subtitleLabel else {
            
            // Label
            subtitleLabel = UILabel()
            subtitleLabel?.translatesAutoresizingMaskIntoConstraints = false
            subtitleLabel?.backgroundColor = UIColor.clear

            if textStyle == .BLACK_BACKGROUND {
                subtitleLabel?.backgroundColor = UIColor.black.withAlphaComponent(CGFloat(0.6))
            }
            
            subtitleLabel?.textAlignment = .center
            subtitleLabel?.numberOfLines = 0
            subtitleLabel?.font = UIFont.boldSystemFont(ofSize: UI_USER_INTERFACE_IDIOM() == .pad ? 40.0 : 22.0)
            subtitleLabel?.textColor = UIColor.white
            subtitleLabel?.numberOfLines = 0;
            subtitleLabel?.layer.shadowColor = UIColor.black.cgColor
            subtitleLabel?.layer.shadowOffset = CGSize(width: 1.0, height: 1.0);
            subtitleLabel?.layer.shadowOpacity = 0.9;
            subtitleLabel?.layer.shadowRadius = 1.0;
            subtitleLabel?.layer.shouldRasterize = true;
            subtitleLabel?.layer.cornerRadius = 8
            subtitleLabel?.clipsToBounds = true
            subtitleLabel?.layer.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
            subtitleLabel?.layer.rasterizationScale = UIScreen.main.scale
            subtitleLabel?.lineBreakMode = .byWordWrapping
            subtitleLabel?.isHidden = false
            view.insertSubview(subtitleLabel!, at: 1)
            
            
            var constraints = [NSLayoutConstraint]()
            constraints.append((subtitleLabel?.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: CGFloat(-30)))!)
            constraints.append((subtitleLabel?.centerXAnchor.constraint(equalTo: view.centerXAnchor))!)
            NSLayoutConstraint.activate(constraints)

            return
            
        }
        
    }
    
}

