import UIKit

open class AvatarView: UIImageView {

    // MARK: - Properties
    
    open var initials: String? {
        didSet {
            setImageFrom(initials: initials)
        }
    }

    open var placeholderFont: UIFont = UIFont.preferredFont(forTextStyle: .caption1) {
        didSet {
            setImageFrom(initials: initials)
        }
    }

    open var placeholderTextColor: UIColor = .white {
        didSet {
            setImageFrom(initials: initials)
        }
    }

    open var fontMinimumScaleFactor: CGFloat = 0.5

    open var adjustsFontSizeToFitWidth = true

    private var minimumFontSize: CGFloat {
        return placeholderFont.pointSize * fontMinimumScaleFactor
    }

    private var radius: CGFloat?

    // MARK: - Overridden Properties
    open override var frame: CGRect {
        didSet {
            setCorner(radius: self.radius)
        }
    }

    open override var bounds: CGRect {
        didSet {
            setCorner(radius: self.radius)
        }
    }

    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        prepareView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }

    convenience public init() {
        self.init(frame: .zero)
        prepareView()
    }
    
    private func setImageFrom(initials: String?) {
        guard let initials = initials else { return }
        image = getImageFrom(initials: initials)
    }

    private func getImageFrom(initials: String) -> UIImage {
        let width = frame.width
        let height = frame.height
        if width == 0 || height == 0 {return UIImage()}
        var font = placeholderFont

        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, UIScreen.main.scale)
        defer { UIGraphicsEndImageContext() }
        let context = UIGraphicsGetCurrentContext()!

        //// Text Drawing
        let textRect = calculateTextRect(outerViewWidth: width, outerViewHeight: height)
        let initialsText = NSAttributedString(string: initials, attributes: [.font: font])
        if adjustsFontSizeToFitWidth,
            initialsText.width(considering: textRect.height) > textRect.width {
            let newFontSize = calculateFontSize(text: initials, font: font, width: textRect.width, height: textRect.height)
            font = placeholderFont.withSize(newFontSize)
        }

      print(textRect)
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: placeholderTextColor, NSAttributedString.Key.paragraphStyle: textStyle]

        let textTextHeight: CGFloat = initials.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        initials.draw(in: CGRect(textRect.minX, textRect.minY + (textRect.height - textTextHeight) / 2, textRect.width, textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()
        guard let renderedImage = UIGraphicsGetImageFromCurrentImageContext() else { assertionFailure("Could not create image from context"); return UIImage()}
        return renderedImage
    }

    /**
     Recursively find the biggest size to fit the text with a given width and height
     */
    private func calculateFontSize(text: String, font: UIFont, width: CGFloat, height: CGFloat) -> CGFloat {
        let attributedText = NSAttributedString(string: text, attributes: [.font: font])
        if attributedText.width(considering: height) > width {
            let newFont = font.withSize(font.pointSize - 1)
            if newFont.pointSize > minimumFontSize {
                return font.pointSize
            } else {
                return calculateFontSize(text: text, font: newFont, width: width, height: height)
            }
        }
        return font.pointSize
    }

    /**
     Calculates the inner circle's width.
     - Note: Assumes corner radius cannot be more than width/2 (this creates circle).
     */
    private func calculateTextRect(outerViewWidth: CGFloat, outerViewHeight: CGFloat) -> CGRect {
        guard outerViewWidth > 0 else {
            return CGRect.zero
        }
        let shortEdge = min(outerViewHeight, outerViewWidth)
        // Converts degree to radian degree and calculate the
        // Assumes, it is a perfect circle based on the shorter part of ellipsoid
        // calculate a rectangle
        let w = shortEdge * sin(CGFloat(45).degreesToRadians) * 2
        let h = shortEdge * cos(CGFloat(45).degreesToRadians) * 2
        let startX = (outerViewWidth - w)/2
        let startY = (outerViewHeight - h)/2
        // In case the font exactly fits to the region, put 2 pixel both left and right
        return CGRect(startX+2, startY, w-4, h)
    }

    // MARK: - Internal methods

    internal func prepareView() {
        backgroundColor = .red
        contentMode = .scaleAspectFill
        layer.masksToBounds = true
        clipsToBounds = true
        setCorner(radius: nil)
    }

    // MARK: - Open setters
    
    open func set(avatar: Avatar) {
        if let image = avatar.image {
            self.image = image
        } else {
            initials = avatar.initials
        }
    }

    open func setCorner(radius: CGFloat?) {
        guard let radius = radius else {
            //if corner radius not set default to Circle
            let cornerRadius = min(frame.width, frame.height)
            layer.cornerRadius = cornerRadius/2
            return
        }
        self.radius = radius
        layer.cornerRadius = radius
    }

}

fileprivate extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

public struct Avatar {
    
    // MARK: - Properties
    
    /// The image to be used for an `AvatarView`.
    public let image: UIImage?
    
    /// The placeholder initials to be used in the case where no image is provided.
    ///
    /// The default value of this property is "?".
    public var initials: String = "?"
    
    // MARK: - Initializer
    
    public init(image: UIImage? = nil, initials: String = "?") {
        self.image = image
        self.initials = initials
    }
    
}

public extension NSAttributedString {

    func width(considering height: CGFloat) -> CGFloat {

        let size = self.size(consideringHeight: height)
        return size.width
        
    }
    
    func height(considering width: CGFloat) -> CGFloat {

        let size = self.size(consideringWidth: width)
        return size.height
        
    }
    
    func size(consideringHeight height: CGFloat) -> CGSize {
        
        let constraintBox = CGSize(width: .greatestFiniteMagnitude, height: height)
        return self.size(considering: constraintBox)
        
    }
    
    func size(consideringWidth width: CGFloat) -> CGSize {
        
        let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)
        return self.size(considering: constraintBox)
        
    }
    
    func size(considering size: CGSize) -> CGSize {
        
        let rect = self.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return rect.size
        
    }
}

internal extension CGRect {
    init(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        self.init(x: x, y: y, width: w, height: h)
    }
}
