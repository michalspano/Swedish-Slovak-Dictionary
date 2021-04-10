import UIKit

class GradientViewLesson4: UIView {
    var TopColor: UIColor = #colorLiteral(red: 0.1671483174, green: 0.437896219, blue: 0.8611094157, alpha: 1)
    var BotColor: UIColor = #colorLiteral(red: 0.05498923135, green: 0.1335868716, blue: 0.5876514945, alpha: 1)
    
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

