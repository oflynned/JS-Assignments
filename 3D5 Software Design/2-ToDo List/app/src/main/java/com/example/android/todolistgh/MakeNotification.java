package com.example.android.todolistgh;

import android.app.NotificationManager;
import android.app.PendingIntent;
import android.app.TaskStackBuilder;
import android.content.Context;
import android.content.Intent;
import android.support.v4.app.NotificationCompat;

import java.text.SimpleDateFormat;
import java.util.Calendar;

/**
 * Created by Diarmuid on 30/11/2015.
 */
public class MakeNotification {
    Context context;

    public MakeNotification(Context context)
    {
        this.context = context;
    }

    /**
     * Creates the notification which directs you to Main Activity when clicked.
     * Notification is called only if a task is due the next day
     * @param pi the pending intent that will call the notification
     * @param date the date of the task being investigated
     * @param description The description of the task to be called in the notification
     * @param calendar the calander set to the time the function will be called at.
     *                 This will be compared to the date by changing it to a string in yyyyMMdd
     */
    public void createNotification (PendingIntent pi, String date, String description, Calendar calendar) {
        int mId = 1;
        Intent resultIntent = new Intent(context, MainActivity.class);
        SimpleDateFormat format1 = new SimpleDateFormat("yyyyMMdd");
        String date1 = format1.format(calendar);

        if(date == date1) {
            TaskStackBuilder stackBuilder = TaskStackBuilder.create(context);
            stackBuilder.addParentStack(MainActivity.class);
            stackBuilder.addNextIntent(resultIntent);

            NotificationCompat.Builder mBuilder = new NotificationCompat.Builder(context)
                    .setSmallIcon(R.mipmap.ic_launcher_new)
                    .setContentTitle("To Do List")
                    .setContentText("To do tomorrow: " + description);


            mBuilder.setContentIntent(pi);
            NotificationManager mNotificationManager =
                    (NotificationManager) context.getSystemService(Context.NOTIFICATION_SERVICE);

            mNotificationManager.notify(mId, mBuilder.build());
        }
    }
}
