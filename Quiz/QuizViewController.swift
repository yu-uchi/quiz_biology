//
//  QuizViewController.swift
//  Quiz
//
//  Created by ゆん on 2016/05/13.
//  Copyright © 2016年 yunya. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController {

    //問題文を格納する配列
    var quizArray = [AnyObject]()
    
    //正解数
    var correctAnswer: Int = 0
    
    //クイズを表示するTextView
    @IBOutlet var quizTextView: UITextView!
    
    //選択肢のボタン
    @IBOutlet var choiceButton1: UIButton!
    @IBOutlet var choiceButton2: UIButton!
    @IBOutlet var choiceButton3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //一時的にクイズを格納しておく配列
        var tmpArray = [AnyObject]()
        
        //tmpArrayに問題文と３つの選択肢と答えの番号の入った配列を追加していく
        tmpArray.append(["生物圏の範囲はどのくらい？","約１０km","約２０km","約３０km",1])
        tmpArray.append(["生物の持つDNAの役割とは？","個体維持","種族維持","形質の決定",3])
        tmpArray.append(["ウイルスが感染した細胞の名前は？","感染細胞","宿主細胞","親細胞",2])
        tmpArray.append(["顕微鏡の発明者は誰？","ヤンセン父子","ロバート・フック","ブラウン",1])
        tmpArray.append(["生きた細胞を発見したのは誰？","ブラウン","レーゲンフック","レーウェンフック",3])
        tmpArray.append(["ブラウンが核を発見したのはいつ？","１５９０年","１８３１年","１８５８年",2])
        
        
        //問題をシャッフルしてquizArrayに格納する
        srand(UInt32(time(nil)))
        while (tmpArray.count > 0) {
            let index = Int(rand()) % tmpArray.count
            quizArray.append(tmpArray[index])
            tmpArray.removeAtIndex(index)
        }
        choiceQuiz()
        }
    
    func choiceQuiz() {
        
        //問題文のテキストを表示
        quizTextView.text = quizArray[0][0] as! String
        
        //選択肢のボタンにそれぞれの選択肢のテキストをセット
        choiceButton1.setTitle(quizArray[0][1] as? String, forState: .Normal)
        choiceButton2.setTitle(quizArray[0][2] as? String, forState: .Normal)
        choiceButton3.setTitle(quizArray[0][3] as? String, forState: .Normal)
    }
    
    @IBAction func choiceAnswer(sender: UIButton) {
        if quizArray[0][4] as! Int == sender.tag {
        
        //正解数を増やす
        correctAnswer = correctAnswer + 1
        }
        
        //解いた問題をquizArrayから取り除く
        quizArray.removeAtIndex(0)
        
        //解いた問題数の合計が予め設定していた問題数に達したら結果画面へ
        if quizArray.count == 0 {
         performSegueToResult()
        } else {
            choiceQuiz()
        }
    }
    
    func performSegueToResult() {
        performSegueWithIdentifier("toResultView", sender: nil)
    }
    
    //Segueを準備(prepare)するときに呼ばれるメソッド
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toResultView" {
            let resultViewController = segue.destinationViewController as! ResultViewController
            resultViewController.correctAnswer = self.correctAnswer
        }
    }


        // Do any additional setup after loading the view.
    }

    func didReceiveMemoryWarning() {
        didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


