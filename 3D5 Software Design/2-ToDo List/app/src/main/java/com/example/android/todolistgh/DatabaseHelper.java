package com.example.android.todolistgh;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

/**
 * Created by ed on 27/11/15.
 */
public class DatabaseHelper extends SQLiteOpenHelper {

    public static final int DATABASE_VERSION = 1;

    //fields
    public static final int COL_ID = 0;
    public static final int COL_CATEGORY = 1;
    public static final int COL_DESCRIPTION = 2;
    public static final int COL_TIME_ADDED = 3;
    public static final int COL_DUE_DATE = 4;
    public static final int COL_RAW_DATE = 5;
    public static final int COL_PRIORITY = 7;

    //queries
    public static final String CREATE_TABLE_QUERY =
            "CREATE TABLE " +
                    Database.TasksTable.TABLE_NAME + "(" +
                    Database.TasksTable.ID + " INTEGER PRIMARY KEY," +
                    Database.TasksTable.CATEGORY + " TEXT," +
                    Database.TasksTable.TASK + " TEXT," +
                    Database.TasksTable.TIME_ADDED + " INTEGER," +
                    Database.TasksTable.DUE_DATE + " TEXT," +
                    Database.TasksTable.RAW_DUE_DATE + " TEXT," +
                    Database.TasksTable.COMPLETED + " BOOLEAN," +
                    Database.TasksTable.PRIORITY + " BOOLEAN);";

    public static final String DELETE_TABLE_QUERY =
            "DROP TABLE IF EXISTS " + Database.TasksTable.TABLE_NAME + ";";

    public static final String SELECT_ALL_QUERY =
            "SELECT * FROM " + Database.TasksTable.TABLE_NAME + ";";

    public static final String SELECT_BY_DATE_DESCENDING =
            "SELECT * FROM " + Database.TasksTable.TABLE_NAME +
                    " ORDER BY DATE(" + Database.TasksTable.RAW_DUE_DATE + ") DESC;";

    public static final String SELECT_BY_DATE_ASCENDING =
            "SELECT * FROM " + Database.TasksTable.TABLE_NAME +
                    " ORDER BY DATE(" + Database.TasksTable.RAW_DUE_DATE + ") ASC;";

    public static final String SELECT_BY_CATEGORY_DESCENDING =
            "SELECT * FROM " + Database.TasksTable.TABLE_NAME +
                    " ORDER BY " + Database.TasksTable.CATEGORY + " DESC;";

    public static final String SELECT_BY_CATEGORY_ASCENDING =
            "SELECT * FROM " + Database.TasksTable.TABLE_NAME +
                    " ORDER BY " + Database.TasksTable.CATEGORY + " ASC;";

    public static final String SELECT_BY_DESCRIPTION_DESCENDING =
            "SELECT * FROM " + Database.TasksTable.TABLE_NAME +
                    " ORDER BY " + Database.TasksTable.TASK + " DESC;";

    public static final String SELECT_BY_DESCRIPTION_ASCENDING =
            "SELECT * FROM " + Database.TasksTable.TABLE_NAME +
                    " ORDER BY " + Database.TasksTable.TASK + " ASC;";

    public DatabaseHelper(Context context) {
        super(context, Database.DATABASE_NAME, null, DATABASE_VERSION);
    }

    /**
     * Executes table instantiation when no prior table exists
     * @param db database in question to be queried
     */
    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(CREATE_TABLE_QUERY);
    }

    /**
     * Override called when update is instantiated in version
     * @param db the current database in question
     * @param oldVersion the old version integer
     * @param newVersion the new version integer being updated to
     */
    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        // this must be modified in later additions as we
        // want to port the table over and not obliterate it
        // but for now this is okay
        db.execSQL(DELETE_TABLE_QUERY);
        onCreate(db);
    }

    /**
     * Inserts a new row into the table with respect to row
     * @param category category or subject name
     * @param task task to be done by user
     * @param due_date time in millis of task due date
     * @param raw_due_date the time in yyyyMMdd format to be compared for ordering by date
     * @param completed has the task been completed?
     */
    public void insertTask(String category, String task, String due_date,
                           String raw_due_date, boolean completed, boolean priority){
        SQLiteDatabase writeDb = this.getWritableDatabase();
        ContentValues contentValues = new ContentValues();

        Long time = System.currentTimeMillis();
        contentValues.put(Database.TasksTable.CATEGORY, category);
        contentValues.put(Database.TasksTable.TASK, task);
        contentValues.put(Database.TasksTable.TIME_ADDED, time);
        contentValues.put(Database.TasksTable.DUE_DATE, due_date);
        contentValues.put(Database.TasksTable.RAW_DUE_DATE, raw_due_date);
        contentValues.put(Database.TasksTable.COMPLETED, completed);
        contentValues.put(Database.TasksTable.PRIORITY, priority);
        writeDb.insert(Database.TasksTable.TABLE_NAME, null, contentValues);
        writeDb.close();
    }

    /**
     * Remove rows from the task table given the id which should be searchable and unique
     * @param id the index id of the row
     */
    public void removeTask(int id){
        SQLiteDatabase writeDb = this.getWritableDatabase();

        //query to remove row with given id
        String removeRow =
                "DELETE FROM " + Database.TasksTable.TABLE_NAME +
                        " WHERE " + Database.TasksTable.ID + "=" + id + ";";

        writeDb.execSQL(removeRow);
        writeDb.close();
    }

    /**
     * obliterates the entire table by remove all records from rows
     */
    public void removeAllTasks(){
        SQLiteDatabase writeDb = this.getWritableDatabase();

        //query to remove row with given id
        String removeAll =
                "DELETE FROM " + Database.TasksTable.TABLE_NAME + ";";

        writeDb.execSQL(removeAll);
        writeDb.close();
    }

    /**
     * Takes the id passed and modifies the columns for that row
     * @param id row id
     * @param category amended category
     * @param task amended task
     * @param due_date amended date due
     * @param raw_due_date amended raw due date for comparison of records wrt time
     * @param completed amended completion
     */
    public void editTask(int id, String category, String task, String due_date,
                         String raw_due_date, boolean completed, boolean priority){
        SQLiteDatabase writeDb = this.getWritableDatabase();

        ContentValues contentValues = new ContentValues();
        contentValues.put(Database.TasksTable.CATEGORY, category);
        contentValues.put(Database.TasksTable.TASK, task);
        contentValues.put(Database.TasksTable.DUE_DATE, due_date);
        contentValues.put(Database.TasksTable.RAW_DUE_DATE, raw_due_date);
        contentValues.put(Database.TasksTable.COMPLETED, completed);
        contentValues.put(Database.TasksTable.PRIORITY, priority);

        String[] whereArgs = {String.valueOf(id)};
        writeDb.update(Database.TasksTable.TABLE_NAME, contentValues,
                Database.TasksTable.ID + "=" + "?", whereArgs);
        writeDb.close();
    }

    /**
     * Notifies the row's col of modifying checked state for state and view invalidation
     * @param id the id of the chosen row
     * @param completed boolean value for tracking checked
     */
    public void editChecked(int id, boolean completed){
        SQLiteDatabase writeDb = this.getWritableDatabase();
        SQLiteDatabase readDb = this.getReadableDatabase();

        ContentValues contentValues = new ContentValues();
        contentValues.put(Database.TasksTable.COMPLETED, completed);

        String[] whereArgs = {String.valueOf(id)};
        writeDb.update(Database.TasksTable.TABLE_NAME, contentValues,
                Database.TasksTable.ID + "=" + "?", whereArgs);
        writeDb.close();
        readDb.close();
    }

    /**
     * Prints out the current values stored within the table in Sys
     * @param tableName the table to be printed out in monitor
     */
    public void printTableContents(String tableName){
        SQLiteDatabase sqLiteDatabase = this.getReadableDatabase();
        Cursor cursor = sqLiteDatabase.rawQuery(SELECT_ALL_QUERY, null);
        cursor.moveToFirst();

        int rowNum = cursor.getCount();
        int colNum = cursor.getColumnCount();

        System.out.println("# of rows in " + tableName + " is " + rowNum);
        System.out.println("# of columns in " + tableName + " is " + colNum);

        for (int r = 0; r < rowNum; r++){
            for(int c = 0; c < colNum; c++){
                System.out.println(c + ". " + cursor.getString(c) + "; ");
            }
            System.out.println("\n------------");
            cursor.moveToNext();
        }
        cursor.close();
        sqLiteDatabase.close();
    }
}
