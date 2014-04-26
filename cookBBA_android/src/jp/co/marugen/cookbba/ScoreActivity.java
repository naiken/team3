package jp.co.marugen.cookbba;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import jp.co.cayto.appc.sdk.android.AppC;
import android.app.Activity;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;


public class ScoreActivity extends Activity {
    private ImageButton backbtn;
    private ImageButton appsbtn;
    private AppC mAppC;
    //SharedPreferencesのキー
    private static final String PREF_KEY = "score_key";

    //スコアのテキストのキー
    private static final String SC_KEY = "score_";

    //直近ゲームのスコアのテキストキー
    public static SharedPreferences pref;
    public static SharedPreferences.Editor editor;
    public static List<Integer> arrayScore = new ArrayList<Integer>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_score);
        pref = getSharedPreferences(PREF_KEY,MODE_PRIVATE);
        //        initBringScore();
        editor = pref.edit();
        backbtn = (ImageButton) findViewById(R.id.imageButton1);
        appsbtn = (ImageButton) findViewById(R.id.imageButton2);

        mAppC = new AppC(this);
        
        backbtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        });
//        appsボタンで広告表示
                appsbtn.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        int id = v.getId();
                        switch (id) {
                        case R.id.imageButton2:
                        mAppC.callCutin();
                        break;
                        }
                    }
                });


        getScore();

        TextView nowScore = (TextView) findViewById(R.id.textView1);
        TextView rankScore1 = (TextView) findViewById(R.id.textView2);
        TextView rankScore2 = (TextView) findViewById(R.id.textView3);
        TextView rankScore3 = (TextView) findViewById(R.id.textView4);
        TextView rankScore4 = (TextView) findViewById(R.id.textView5);
        TextView rankScore5 = (TextView) findViewById(R.id.textView6);

        nowScore.setTextColor(Color.parseColor("#932020"));
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
        nowScore.setText("今までのスコア");
        rankScore1.setText("第一位　" + arrayScore.get(0));
        rankScore2.setText("第二位　" + arrayScore.get(1));
        rankScore3.setText("第三位　" + arrayScore.get(2));
        rankScore4.setText("第四位　" + arrayScore.get(3));
        rankScore5.setText("第五位　" + arrayScore.get(4));

    }


    public static  void getScore(){

        arrayScore.clear();

        if(pref.getBoolean("score_BOOL",false) == false){
            //初回起動時の記憶
            editor.putInt(SC_KEY+1,0);
            editor.putInt(SC_KEY+2,0);
            editor.putInt(SC_KEY+3,0);
            editor.putInt(SC_KEY+4,0);
            editor.putInt(SC_KEY+5,0);
            editor.commit();

            editor.putBoolean("score_BOOL",true);
            editor.commit();

            arrayScore.add(0);
            arrayScore.add(0);
            arrayScore.add(0);
            arrayScore.add(0);
            arrayScore.add(0);
        } else {
            arrayScore.add(pref.getInt(SC_KEY+1,0));
            arrayScore.add(pref.getInt(SC_KEY+2,0));
            arrayScore.add(pref.getInt(SC_KEY+3,0));
            arrayScore.add(pref.getInt(SC_KEY+4,0));
            arrayScore.add(pref.getInt(SC_KEY+5,0));
        }

        Collections.sort(arrayScore);
        Collections.reverse(arrayScore);
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
        mAppC.initCutin();
    }

    @Override
    protected void onPause() {
        super.onPause();
        StartActivity.mp.pause();
        finish();
    }
}
