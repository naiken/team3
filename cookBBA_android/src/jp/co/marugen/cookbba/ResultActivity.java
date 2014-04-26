package jp.co.marugen.cookbba;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;


public class ResultActivity extends Activity {
    private ImageButton backbtn;
    private ImageButton twitterbtn;

    //SharedPreferencesのキー
    private static final String PREF_KEY = "score_key";

    //スコアのテキストのキー
    private static final String SC_KEY = "score_";

    //直近ゲームのスコアのテキストキー
    private static final String RECENT_SCORE_KEY = "recent_score";
    public static SharedPreferences pref;
    public static SharedPreferences.Editor editor;
    public static List<Integer> arrayScore = new ArrayList<Integer>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_result);
        pref = getSharedPreferences(PREF_KEY,MODE_PRIVATE);
        //        initBringScore();
        editor = pref.edit();
        backbtn = (ImageButton) findViewById(R.id.imageButton1);
        twitterbtn = (ImageButton) findViewById(R.id.imageButton2);

        //直近ゲームのスコア
        int takeOffPoint = recentScore();
        final String rPoint = Integer.toString(takeOffPoint);

        backbtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        });
        twitterbtn.setOnClickListener(new View.OnClickListener() {


            @Override
            public void onClick(View v) {
                if(appInstalledOrNot("com.twitter.android")){
                    String url = "twitter://post?message=ハンバーグ料理ゲーム【cookBBA（くっくばばあ）】の今回のスコアは” " + rPoint + " ”やで！もっと美味しく作れる人おるんちゃう？"
                            + "みんなもやってみぃや！%23cookBBA";
                    Intent intent = new Intent(Intent.ACTION_VIEW);
                    intent.setData(Uri.parse(url));
                    startActivity(intent);
                }else{
                    Toast.makeText(ResultActivity.this, "Twitterアプリがインストールされていません", Toast.LENGTH_LONG).show();
                }
            }
        });


        sortScore1(takeOffPoint);


        TextView nowScore = (TextView) findViewById(R.id.textView1);
        TextView rankScore1 = (TextView) findViewById(R.id.textView2);
        TextView rankScore2 = (TextView) findViewById(R.id.textView3);
        TextView rankScore3 = (TextView) findViewById(R.id.textView4);
        TextView rankScore4 = (TextView) findViewById(R.id.textView5);
        TextView rankScore5 = (TextView) findViewById(R.id.textView6);

        nowScore.setTextColor(Color.parseColor("red"));
        rankScore1.setTextColor(Color.parseColor("#932020"));
        rankScore2.setTextColor(Color.parseColor("#932020"));
        rankScore3.setTextColor(Color.parseColor("#932020"));
        rankScore4.setTextColor(Color.parseColor("#932020"));
        rankScore5.setTextColor(Color.parseColor("#932020"));

        nowScore.setTextSize(26.0f);
        rankScore1.setTextSize(22.0f);
        rankScore2.setTextSize(22.0f);
        rankScore3.setTextSize(22.0f);
        rankScore4.setTextSize(22.0f);
        rankScore5.setTextSize(22.0f);


        // テキストビューのテキストを設定します
        nowScore.setText("今回のスコア:　" + rPoint);
        rankScore1.setText("第一位　" + arrayScore.get(0));
        rankScore2.setText("第二位　" + arrayScore.get(1));
        rankScore3.setText("第三位　" + arrayScore.get(2));
        rankScore4.setText("第四位　" + arrayScore.get(3));
        rankScore5.setText("第五位　" + arrayScore.get(4));

    }


    //リザルト画面:スコアを取得してソートを掛けて再保存。
    public static void sortScore1(int recentScore) {

        arrayScore.clear();
        if (pref.getBoolean("score_BOOL",false) == false) {
            arrayScore.add(0);
            arrayScore.add(0);
            arrayScore.add(0);
            arrayScore.add(0);
            arrayScore.add(0);

            editor.putBoolean("score_BOOL",true);
            editor.commit();
        } else{
            arrayScore.add(pref.getInt(SC_KEY+1,0));
            arrayScore.add(pref.getInt(SC_KEY+2,0));
            arrayScore.add(pref.getInt(SC_KEY+3,0));
            arrayScore.add(pref.getInt(SC_KEY+4,0));
            arrayScore.add(pref.getInt(SC_KEY+5,0));
        }

        arrayScore.add(recentScore);

        Collections.sort(arrayScore);

        Collections.reverse(arrayScore);

        editor.putInt(SC_KEY+1,arrayScore.get(0));
        editor.putInt(SC_KEY+2,arrayScore.get(1));
        editor.putInt(SC_KEY+3,arrayScore.get(2));
        editor.putInt(SC_KEY+4,arrayScore.get(3));
        editor.putInt(SC_KEY+5,arrayScore.get(4));
        editor.commit();
    }


    public static int recentScore () {
        int rScore = pref.getInt(RECENT_SCORE_KEY, 0);
        return rScore;
    }
    //スコア画面のスコアを取得してString型の配列に格納
    public static String[] getScore(){

        int[] scoreArray = new int[5];
        String[] scoreStr = new String[5];
        List<Integer> scoreList = new ArrayList<Integer>();

        //スコアを取得してString型にキャスト
        for (int i = 4; i >= 0; i--) {
            int rank = i+1;

            int sc = pref.getInt(SC_KEY+rank,0);

            scoreArray[i] = sc;
            scoreList.add(scoreArray[i]);
        }

        Collections.sort(scoreList);
        for(int j = 0; j <= 4 ; j++){
            for (int i = 4;i >= 0 ; i--) {
                int sc = scoreList.get(i);
                String str1 = Integer.toString(sc);
                scoreStr[j] = str1;
            }
        }

        return scoreStr;
    }



    //スコアを取得してソートを掛けて再保存。
    public static void sortScore(int recentScore) {

        //スコアを取得する配列
        int[] sortScoreArray = new int[5];

        //ソート対象となるリスト
        List<Integer> scoreList = new ArrayList<Integer>();

        //スコアを取得してscoreListに格納。
        for (int i = 4; i >= 0; i--) {
            int rank = i+1;

            int sc = pref.getInt(SC_KEY+rank,0);
            scoreList.add(sc);

            sortScoreArray[i] = sc;
            //リストに直近スコア以外を格納
            scoreList.add(sortScoreArray[i]);
        }

        //直近スコアを追加。
        scoreList.add(recentScore);

        //リストの最前列の要素（worstスコア）を削除
        scoreList.remove(0);

        for (int i = 0; i >= 4; i++) {
            int rank = i+1;
            int sc = scoreList.get(i);
            editor.putInt(SC_KEY+rank,sc);
            editor.apply();
        }
    }

    private boolean appInstalledOrNot(String uri){
        PackageManager pm = getPackageManager();
        boolean app_installed = false;
        try{
            pm.getPackageInfo(uri, PackageManager.GET_ACTIVITIES);
            app_installed = true;
        }catch (Exception e){
        }
        return app_installed ;
    }

    @Override
    protected void onResume() {
        super.onResume();
        StartActivity.mp.start();
    }

    @Override
    protected void onPause() {
        super.onPause();
        StartActivity.mp.pause();
        finish();
    }
}
