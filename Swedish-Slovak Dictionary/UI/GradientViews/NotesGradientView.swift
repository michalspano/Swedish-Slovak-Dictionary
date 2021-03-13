import UIKit

class NotesGradientView: UIView {
    
    var TopColor = UIColor()
    var BotColor = UIColor()
    
    var StartPointX: CGFloat = 0
    var StartPointY: CGFloat = 0
    var EndPointX: CGFloat = 1
    var EndPointY: CGFloat = 1
    
    override func layoutSubviews() {
        if self.traitCollection.userInterfaceStyle == .dark {
            TopColor = #colorLiteral(red: 0.03474496031, green: 0.09181994107, blue: 0.1845918906, alpha: 1)
            BotColor = #colorLiteral(red: 0.02330116216, green: 0.1273211346, blue: 0.3706473919, alpha: 1)
        }
        else {
            TopColor = #colorLiteral(red: 0.1477379563, green: 0.3904246923, blue: 0.78489739, alpha: 1)
            BotColor = #colorLiteral(red: 0.05556120951, green: 0.3446611744, blue: 1, alpha: 1)
        }
        let gradientView = CAGradientLayer()
        gradientView.colors = [TopColor.cgColor, BotColor.cgColor]
        gradientView.startPoint = CGPoint(x: StartPointX, y: StartPointY)
        gradientView.endPoint = CGPoint(x: EndPointX, y: EndPointY)
        gradientView.frame = self.bounds
        self.layer.insertSublayer(gradientView, at: 0)
    }


}
