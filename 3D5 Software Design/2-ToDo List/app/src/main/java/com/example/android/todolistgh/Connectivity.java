package com.example.android.todolistgh;

import android.content.Context;
import android.content.Intent;
import android.net.Uri;
import android.widget.Toast;

/**
 * Created by ed on 27/11/15.
 */
public class Connectivity {

    Context context;

    public Connectivity(Context context){
        this.context = context;
    }

    public void sendToEmail(String memo) {

        if (memo.isEmpty()) {
            Toast.makeText(context, "Empty Memo", Toast.LENGTH_SHORT).show();
            return;
        }
        else {
            Intent sendEmailSummary = new Intent(Intent.ACTION_SENDTO);

            sendEmailSummary.setData(Uri.parse("mailto:")); // only email apps should handle this
            sendEmailSummary.putExtra(Intent.EXTRA_SUBJECT, ("MEMO- To-Do List App"));
            sendEmailSummary.putExtra(Intent.EXTRA_TEXT, memo);
            if (sendEmailSummary.resolveActivity(context.getPackageManager()) != null) {
                context.startActivity(sendEmailSummary);
            }
        }
    }
}
