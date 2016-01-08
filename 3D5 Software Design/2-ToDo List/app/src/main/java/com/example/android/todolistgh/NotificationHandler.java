package com.example.android.todolistgh;

import android.app.AlarmManager;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;

import java.util.Calendar;
import java.util.Timer;
import java.util.TimerTask;
import java.util.concurrent.TimeUnit;

/**
 * Created by Diarmuid on 07/12/2015.
 */
public class NotificationHandler {

    Context context;
    MakeNotification n;

    NotificationHandler(Context context){
        this.context = context;
    }

    /**
     * Function which shows a notification at 9 am the day before a task is due.
     * @param date the date the task being investigated is due
     * @param description description of task due
     */
    public void showNotification(String date, String description)
    {
        final String fDate = date;
        final String fDescription = description;

        Calendar calendar = Calendar.getInstance();

        calendar.set(Calendar.HOUR_OF_DAY, 21); //Not setting
        calendar.set(Calendar.MINUTE, 50); //Not setting
        calendar.set(Calendar.SECOND, 0); //Not setting
        final Calendar fCalendar = calendar;
        final PendingIntent pi = PendingIntent.getService(context, 0,
                new Intent(context, MainActivity.class), PendingIntent.FLAG_UPDATE_CURRENT);
        AlarmManager am = (AlarmManager) context.getSystemService(Context.ALARM_SERVICE);
        am.setRepeating(AlarmManager.RTC_WAKEUP, calendar.getTimeInMillis(),
                AlarmManager.INTERVAL_DAY, pi);

        Timer timer = new Timer();
        TimerTask task = new TimerTask() {
            @Override
            public void run() {
                n.createNotification(pi, fDate, fDescription, fCalendar);
            }
        };
        timer.schedule(task, calendar.getTime(), TimeUnit.MILLISECONDS.convert(1, TimeUnit.DAYS));

    }

}
