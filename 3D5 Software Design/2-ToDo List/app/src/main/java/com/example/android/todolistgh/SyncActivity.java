package com.example.android.todolistgh;

import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class SyncActivity extends AppCompatActivity {

    Connectivity connectivity = new Connectivity(this);

    EditText memo, newTaskDate, newTaskDescription, sendEmailText;
    Button sendEmail;

    String date, message;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);

        memo = (EditText) findViewById(R.id.sendToEmail);
        sendEmail = (Button) findViewById(R.id.send_email);
        sendEmailText = (EditText) findViewById(R.id.sendEmailText);

        sendEmail.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(!sendEmailText.getText().toString().equals(null)){
                    connectivity.sendToEmail(sendEmailText.getText().toString());
                }
            }
        });

    }
}
