package com.example.android.todolistgh;

import android.provider.BaseColumns;

/**
 * Created by ed on 27/11/15.
 */
public class Database {

    public static final String DATABASE_NAME = "to_do_db";

    public Database(){

    }

    public static abstract class TasksTable implements BaseColumns {
        //column names starting from 0

        //table name - string
        public static final String TABLE_NAME = "tasks_table";
        //id for each row - int
        public static final String ID = "id"; //col 0
        //category or subject encapsulated - string
        public static final String CATEGORY = "category"; //col 1
        //task description - string
        public static final String TASK = "task"; //col 2
        //time the task was added in millis - long
        public static final String TIME_ADDED = "time_added"; //col 3
        //time in format to be shown in string format
        public static final String DUE_DATE = "due_date"; //col 4
        //ordered time yyyyMMdd for comparison in string format
        public static final String RAW_DUE_DATE = "raw_due_date"; //col 5
        //has the task been completed? boolean
        public static final String COMPLETED = "completed"; //col 6

        public static final String PRIORITY = "priority";//col 7
        //priority level of the task
    }

}
