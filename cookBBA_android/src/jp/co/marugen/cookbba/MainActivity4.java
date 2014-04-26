package jp.co.marugen.cookbba;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.media.AudioManager;
import android.media.SoundPool;
import android.os.Bundle;
import android.os.CountDownTimer;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ImageView;

public class MainActivity4 extends Activity {
    //ハンバーグ画面
    private ImageView ham;//ハンバーグ
    private ImageView revaluation;//評価（bad,good,grate）
    private ImageView touchview;//タッチイベント画像
    private CountDownTimer cdt;
    private CountDownTimer cdt2;
    private boolean cd2 = false;
    private int scorePoint = 20;

    private final int[] materialList = { R.drawable.ham100, 
            R.drawable.ham90, R.drawable.ham80, R.drawable.ham70, R.drawable.ham60, 
            R.drawable.ham40, R.drawable.ham30, R.drawable.ham00, 
            R.drawable.tawashi40, R.drawable.tawashi80, R.drawable.tawashi100 };
    private SoundPool mSoundPool;
    private int se_bad;//効果音・bad
    private int se_good;//効果音・good
    private int se_great;//効果音・great

    // タッチ有効フラグ
    private boolean canTouch = true;

    private SharedPreferences pref;   
    private static SharedPreferences.Editor editor;

    //SharedPreferencesのキー
    private static final String PREF_KEY = "score_key";
    //直近ゲームのスコアのテキストキー
    private static final String RECENT_SCORE_KEY = "recent_score";


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState); 
        setContentView(R.layout.activity_main4);
        pref = getSharedPreferences(PREF_KEY,MODE_PRIVATE);
        editor = pref.edit();
        //                initBringScore();
        ham = (ImageView) findViewById(R.id.imageView1); 
        revaluation = (ImageView) findViewById(R.id.imageView2);
        touchview = (ImageView) findViewById(R.id.imageView3);
        this.countdown();

        mSoundPool = new SoundPool(1, AudioManager.STREAM_MUSIC, 0);
        se_bad = mSoundPool.load(getApplicationContext(), R.raw.bad, 0);
        se_good = mSoundPool.load(getApplicationContext(), R.raw.good, 0);
        se_great = mSoundPool.load(getApplicationContext(), R.raw.great, 0);

        touchview.setOnTouchListener(new View.OnTouchListener() {
            // タップ時の処理
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                if(!canTouch) {
                    return false;
                }
                cdt.cancel();
                countdown2();
                cd2 = true;
                // 評価画像表示
                if (16 <= scorePoint && scorePoint <= 36) {
                    revaluation.setImageResource(R.drawable.bad);
                    mSoundPool.play(se_bad, 1.0F, 1.0F, 0, 0, 1.0F);
                } else if (10 <= scorePoint && scorePoint <= 15) {
                    revaluation.setImageResource(R.drawable.good);
                    mSoundPool.play(se_good, 1.0F, 1.0F, 0, 0, 1.0F);
                } else {
                    revaluation.setImageResource(R.drawable.great);
                    mSoundPool.play(se_great, 1.0F, 1.0F, 0, 0, 1.0F);
                }
                reflectionScore(scorePoint, pref);
                canTouch = false;
                return false;
            }
        });
    }

    //スコアの反映
    public void reflectionScore (int recentPoint, SharedPreferences pref) {

        //        SharedPreferences.Editor editor = pref.edit();
        //持ち点の取得
        int memorizedScore = pref.getInt(RECENT_SCORE_KEY,0);

        //持ち点の更新
        int takeOffPoint = memorizedScore - (recentPoint * 10);

        //再度記憶
        editor.putInt(RECENT_SCORE_KEY,takeOffPoint);
        editor.apply();
    }

    //スコアの持ち点初期反映
    public static void initBringScore() {

        //持ち点
        int bringScore = 1000;

        //持ち点の記憶
        editor.putInt(RECENT_SCORE_KEY,bringScore);
        editor.apply();
    }

    //アニメーション
    public void countdown() {
        if (null != cdt) {
            cdt.cancel();
        }
        cdt = new CountDownTimer(5000,500) {
            boolean anim;
            public void onTick(long time) {
                if ( scorePoint == 20 ) {
                    ham.setImageResource(materialList [7]);
                    anim = false;
                }

                else if ( scorePoint == 18 ) {
                    ham.setImageResource(materialList [6]);
                }
                else if ( scorePoint == 16 ) {
                    ham.setImageResource(materialList [5]);
                }
                else if ( scorePoint == 14 ) {
                    ham.setImageResource(materialList [4]);
                }
                else if ( scorePoint == 12 ) {
                    ham.setImageResource(materialList [3]);
                }
                else if ( scorePoint == 10 ) {
                    ham.setImageResource(materialList [2]);
                }
                else if ( scorePoint == 8 ) {
                    ham.setImageResource(materialList [1]);
                }
                else if ( scorePoint == 6 ) {
                    anim = true;
                    ham.setImageResource(materialList [0]);
                }
                else if ( scorePoint == 21 ) {
                    ham.setImageResource(materialList [9]);
                }
                else if ( scorePoint == 36 ) {
                    ham.setImageResource(materialList [10]);
                } 
                if ( anim ) {
                    scorePoint = scorePoint + 15;
                }
                else{
                    scorePoint = scorePoint - 2 ;
                }
            }

            public void onFinish() {
                cdt.cancel();
                reflectionScore(scorePoint,pref);
                revaluation.setImageResource(R.drawable.bad); 
                ham.setImageResource(materialList [10]);
                Intent intent = new Intent (MainActivity4.this,
                        ResultActivity.class);                
                startActivity(intent);
                finish();
            }
        };
        cdt.start();
    }

    public void countdown2() {
        if (null != cdt2) {
            cdt2.cancel();
        }
        cdt2 = new CountDownTimer(1000,1000) {
            public void onTick(long time) {
            }

            public void onFinish() {
                cdt2.cancel();
                canTouch = true;
                Intent intent = new Intent (MainActivity4.this,
                        ResultActivity.class);                
                startActivity(intent);
                finish();
            }
        };
        cdt2.start();
    }

    @Override
    protected void onResume() {
        super.onResume();
        StartActivity.mp.start();   
    }
    @Override
    protected void onPause() {
        super.onPause();
        cdt.cancel();
        if ( cd2 ) {
            cdt2.cancel();
        }
        // 効果音リリース
        mSoundPool.release();
        StartActivity.mp.pause();
        finish();
    }
}
