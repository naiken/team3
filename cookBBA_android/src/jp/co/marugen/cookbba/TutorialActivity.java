package jp.co.marugen.cookbba;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageButton;
import android.widget.ImageView;

public class TutorialActivity extends Activity {
    private ImageButton backbtn;
    private ImageButton textchangebtn;
    private ImageView tutorialview;
    private int i = 1;
    private final int tutolist[] = new int [] { R.drawable.tuto01,R.drawable.tuto02,R.drawable.tuto03, R.drawable.tuto04, 
            R.drawable.tuto05, R.drawable.tuto06,
            R.drawable.tuto07 };
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tutorial);

        backbtn = (ImageButton) findViewById(R.id.imageButton1);
        textchangebtn = (ImageButton) findViewById(R.id.imageButton2);


        //画面タップで説明切り替え
        textchangebtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                tutorialview = (ImageView) findViewById(R.id.imageView1);
                tutorialview.setImageResource(tutolist[i]);
                if (i == 6){
                    i = 0;
                }
                else {
                    i++;
                }         
            }
        });

        backbtn.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                finish();
            }
        });
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
    }
}
