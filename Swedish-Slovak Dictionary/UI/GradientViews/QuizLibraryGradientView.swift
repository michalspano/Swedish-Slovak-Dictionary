import UIKit

class QuizLibraryGradientView: UIView {
    var TopColor: UIColor = #colorLiteral(red: 0.2141568405, green: 0.5169032432, blue: 0.8685660314, alpha: 1)
    var BotColor: UIColor = #colorLiteral(red: 0.04957042189, green: 0.1831928065, blue: 0.5410735014, alpha: 1)
    
    var StartPointX: CGFloat = 0
    var StartPointY: CGFloat = 0
    var EndPointX: CGFloat = 1
    var EndPointY: CGFloat = 1
    
    override func layoutSubviews() {
        let gradientView = CAGradientLayer()
        gradientView.colors = [TopColor.cgColor, BotColor.cgColor]
        gradientView.startPoint = CGPoint(x: StartPointX, y: StartPointY)
        gradientView.endPoint = CGPoint(x: EndPointX, y: EndPointY)
        gradientView.frame = self.bounds
        self.layer.insertSublayer(gradientView, at: 0)
    }


}
