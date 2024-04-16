import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var kennyImage: UIImageView!
    
    var timer = Timer()
    var counter = 10
    var score = 0
    var timerStarted = false
    var highscore = UserDefaults.standard.integer(forKey: "highscore")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        highscoreLabel.text = "Highscore: \(highscore)"
        
        counter = 10
        timerLabel.text = "Time: \(counter)"
        
        kennyImage.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        kennyImage.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func imageTapped() {
        if !timerStarted {
            timerStarted = true
            startTimer()
        }
        
        score += 1
        scoreLabel.text = "Score: \(score)"
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerFunction), userInfo: nil, repeats: true)
    }
    
    @objc func timerFunction() {
        counter -= 1
        timerLabel.text = "Time: \(counter)"
        
        if counter == 0 {
            timer.invalidate()
            timerLabel.text = "Time's over."
            makeAlert()
            updateHighscore()
        }
    }
    
    @IBAction func resetButton(_ sender: Any) {
        resetAlert()
    }
    
    func resetAlert() {
        let alert = UIAlertController(title: "Are you sure?", message: "Your highest score will not come back.", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "RESET", style: UIAlertAction.Style.destructive) { _ in
            self.resetGame()
            self.resetHighscore()
        }
        let quitButton = UIAlertAction(title: "Quit", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        alert.addAction(quitButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func makeAlert() {
        let alert = UIAlertController(title: "Time's up", message: "You can try again!", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            self.resetGame()
        }
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func resetGame() {
        score = 0
        scoreLabel.text = "Score: \(score)"
        counter = 10
        timerLabel.text = "Time: \(counter)"
        timerStarted = false
    }
    
    func updateHighscore() {
        if score > highscore {
            highscore = score
            highscoreLabel.text = "Highscore: \(highscore)"
            UserDefaults.standard.set(highscore, forKey: "highscore")
        }
    }
    
    func resetHighscore() {
        highscore = 0
        highscoreLabel.text = "Highscore: \(highscore)"
        UserDefaults.standard.set(highscore, forKey: "highscore")
    }
}
