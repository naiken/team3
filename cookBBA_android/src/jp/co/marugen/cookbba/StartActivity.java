package jp.co.marugen.cookbba;

import android.app.Activity;
import android.content.Intent;
import android.media.MediaPlayer;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;

public class StartActivity extends Activity {
    private ImageButton tutorialbtn;//説明ボタン
    private ImageButton scorebtn;//スコアボタン
    private ImageButton startbtn;//ゲームスタートボタン
    protected static MediaPlayer mp;

    //SharedPreferencesのキー
    private static final String PREF_KEY = "score_key";
    //スコアのテキストのキー
    private static final String SC_KEY = "score_";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_start);

        tutorialbtn = (ImageButton) findViewById(R.id.imageButton1);
        scorebtn = (ImageButton) findViewById(R.id.imageButton3);
        startbtn = (ImageButton) findViewById(R.id.imageButton2);

        //BGMをリソースファイルから再生
        mp = MediaPlayer.create(this, R.raw.bgm);
        mp.setLooping(true);

        tutorialbtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Intent intent = new Intent (StartActivity.this,
                        TutorialActivity.class);
                startActivity(intent);
            }
        });
        scorebtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Intent intent = new Intent (StartActivity.this,
                        ScoreActivity.class);
                startActivity(intent);
            }
        });
        startbtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                Intent intent = new Intent (StartActivity.this,
                        MainActivity1.class);
                startActivity(intent);
            }
        });
    }

    @Override
    protected void onResume() {
        super.onResume();
        mp.start();   
    }

    @Override
    protected void onPause() {
        super.onPause(); 
        mp.pause();
    }
    @Override
    protected void onDestroy() {
        super.onDestroy();
        mp.stop();    
    }
}
